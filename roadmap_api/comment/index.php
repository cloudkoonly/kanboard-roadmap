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
$text = $vars['text']??0;
if (empty($itemId) || empty($text)) {
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
$sql = "insert into comments set task_id=:itemId,
                                 user_id=2,
                                 date_creation='".time()."',
                                 comment='".addslashes($text)."',
                                 date_modification='".time()."'";
$res = $db->query($sql, ['itemId'=>$itemId], '');
$commentsNew = [];
if ($res) {
    $sql = "select * from comments where task_id=:itemId and user_id=2";
    $comments = $db->query($sql, ['itemId'=>$itemId], 'rows');
    foreach ($comments as $key => $comment) {
        $commentsNew[$key]['date'] = date('Y-m-d',$comment['date_creation']);
        $commentsNew[$key]['text'] = $comment['comment'];
    }
}
if ($commentsNew) {
    $return = [
        'status' => 'ok',
        'message' => 'ok',
        'data' => ['comments'=>$commentsNew]
    ];
}
echo json_encode($return);
