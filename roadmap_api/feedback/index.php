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
$db = new Database;
$db->conn($config);

try {
    // Insert new feedback into tasks table
    $sql = "INSERT INTO tasks (title, description, project_id, column_id, date_creation) 
            VALUES (?, ?, 1, 5, ?)";
    $params = [$title, $description, time()];
    $taskId = $db->query($sql, 'insert', $params);

    // Add tags if provided
    if (!empty($tags)) {
        foreach ($tags as $tag) {
            // First check if tag exists
            $sql = "SELECT id FROM tags WHERE name = ?";
            $result = $db->query($sql, 'row', [$tag]);
            
            $tagId = null;
            if ($result) {
                $tagId = $result['id'];
            } else {
                // Create new tag
                $sql = "INSERT INTO tags (name) VALUES (?)";
                $tagId = $db->query($sql, 'insert', [$tag]);
            }

            // Link tag to task
            if ($tagId) {
                $sql = "INSERT INTO task_has_tags (task_id, tag_id) VALUES (?, ?)";
                $db->query($sql, 'insert', [$taskId, $tagId]);
            }
        }
    }

    $return['status'] = 'ok';
    $return['message'] = 'Feedback added successfully';
    $return['data'] = ['id' => $taskId];
} catch (Exception $e) {
    $return['message'] = 'Failed to add feedback: ' . $e->getMessage();
}

echo json_encode($return);