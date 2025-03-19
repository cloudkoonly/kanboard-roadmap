<?php
$method = $_SERVER['REQUEST_METHOD'];
$return = [
    'status' => 'error',
    'message' => 'Invalid request',
    'data' => []
];

if ('POST' !== $method) {
    echo json_encode($return);
    exit;
}

include_once __DIR__.'/../../config.php';
include_once __DIR__.'/../db.class.php';

// Get POST data
$input = json_decode(file_get_contents('php://input'), true);
$title = $input['title'] ?? '';
$description = $input['description'] ?? '';
$tags = $input['tags'] ?? [];

if (empty($title)) {
    $return['message'] = 'Title is required';
    echo json_encode($return);
    exit;
}

// Initialize database connection
$config['db_user'] = DB_USERNAME ?: 'root';
$config['db_pass'] = DB_PASSWORD ?: '123456';
$config['db_host'] = DB_HOSTNAME ?: 'mysql';
$config['db_database'] = DB_NAME ?: 'kanboard';
$db = Database::getInstance();
$db->conn($config);

try {
    // Insert new feedback into tasks table
    $db->beginTransaction();
    $sql = "INSERT INTO tasks (title, `description`, swimlane_id, project_id, column_id, date_creation) 
            VALUES (:title, :description, 1, 1, 5, :time)";
    $params = [':title' => $title, ':description' => $description, ':time' => time()];
    $taskId = $db->query($sql, $params, 'id');

    // Add tags if provided
    if (!empty($tags)) {
        foreach ($tags as $tag) {
            // First check if tag exists
            $sql = "SELECT id FROM tags WHERE name = :tag";
            $result = $db->query($sql, [':tag' => $tag], 'row');
            
            $tagId = null;
            if ($result) {
                $tagId = $result['id'];
            } else {
                // Create new tag
                $sql = "INSERT INTO tags (name) VALUES (:tag)";
                $tagId = $db->query($sql,  [':tag' => $tag], 'id');
            }

            // Link tag to task
            if ($tagId) {
                $sql = "INSERT INTO task_has_tags (task_id, tag_id) VALUES (:taskId, :tagId)";
                $db->query($sql, [':taskId' => $taskId, ':tagId' => $tagId], '');
            }
        }
    }

    $db->commit();
    $return['status'] = 'ok';
    $return['message'] = 'Feedback added successfully';
    $return['data'] = ['id' => $taskId];
} catch (Exception $e) {
    $return['message'] = 'Failed to add feedback: ' . $e->getMessage();
    $db->rollback();
}

echo json_encode($return);