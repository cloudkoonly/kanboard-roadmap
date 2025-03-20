<?php
header('Content-Type: application/json');
$method = $_SERVER['REQUEST_METHOD'];
$return = [
    'status' => 'error',
    'message' => 'error',
    'data' => []
];
if ('POST'!==$method) {
    echo json_encode($return);
}
$json_data = file_get_contents('php://input');
$vars = json_decode($json_data,true);
$itemId = $vars['itemId']??0;
if (empty($itemId)) {
    echo json_encode($return);
    exit;
}
include_once __DIR__.'/../../config.php';
include_once __DIR__.'/../db.class.php';
$config['db_user'] = DB_USERNAME?:'root';
$config['db_pass'] = DB_PASSWORD?:'123456';
$config['db_host'] = DB_HOSTNAME?:'mysql';
$config['db_database'] = DB_NAME?:'kanboard';
$db = Database::getInstance();
$db->conn($config);
$sql = "update tasks set score=GREATEST(score - 1, 0) where id=:itemId";
$params = ['itemId'=>$itemId];
$res = $db->query($sql, $params, '');
$likes = 0;
if ($res) {
    $sql = "select score from tasks where id=:itemId";
    $params = ['itemId'=>$itemId];
    $likes = $db->query($sql, $params, 'row')['score']??0;
}
if ($likes) {
    $return = [
        'status' => 'ok',
        'message' => 'ok',
        'data' => ['likes'=>$likes]
    ];
}
echo json_encode($return);
