<?php
$method = $_SERVER['REQUEST_METHOD'];
$return = [
    'status' => 'error',
    'message' => 'error',
    'data' => []
];
if ('GET'!==$method) {
    echo json_encode($return);
}
include_once __DIR__.'/../config.php';
include_once __DIR__.'/db.class.php';
$config['db_user'] = DB_USERNAME?:'root';
$config['db_pass'] = DB_PASSWORD?:'123456';
$config['db_host'] = DB_HOSTNAME?:'mysql';
$config['db_database'] = DB_NAME?:'kanboard';
$db = Database::getInstance();
$db->conn($config);
$sql = "select * from tasks where project_id=1";
$tasks = $db->query($sql, [], 'rows');
$data = [];
$column = [
    1=>'in-review',
    2=>'planned',
    3=>'in-progress',
    4=>'complete',
    5=>'feedback',
    6=>'changelog',
];
$priority = [
    'Critical',
    'High',
    'Medium',
    'Low'
];
foreach ($tasks as $key => $task) {
    $index = $column[$task['column_id']]??'';
    if (empty($index)) continue;
    $sql = "select * from comments where task_id=:taskId";
    $params = ['taskId'=>$task['id']];
    $res = $db->query($sql, $params, 'rows');
    $comments = [];
    foreach ($res as $k=>$c) {
        $comments[$k]['author'] = $c['user_id'];
        $comments[$k]['date'] = date('Y-m-d',$c['date_creation']);
        $comments[$k]['text'] = $c['comment'];
    }

    $sql = "select t.name from tags t,task_has_tags tt where t.id=tt.tag_id and tt.task_id=:taskId";
    $params = ['taskId'=>$task['id']];
    $res = $db->query($sql, $params, 'rows');
    $tags = [];
    foreach ($res as $k=>$t) {
        $tags[$k] = $t['name'];
    }
    $item['id'] = $task['id'];
    $item['title'] = $task['title'];
    $item['description'] = $task['description'];
    $item['launchDate'] = date('Y-m-d',$task['date_started']);
    $item['progress'] = $task['time_estimated']>0 ? round($task['time_spent']/$task['time_estimated']*100) : 0;
    $item['likes'] = $task['score'];
    $item['tags'] = $tags;
    $item['assignee'] = 'admin';
    $item['priority'] = $priority[$task['priority']];
    $item['comments'] = $comments;
    $data[$index][] = $item;
}
if ($data) {
    $return = [
        'status' => 'ok',
        'message' => 'ok',
        'data' => $data
    ];
}
header('Content-Type: application/json');
echo json_encode($return);
