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
$config['db_user'] = DB_USERNAME?:'root';
$config['db_pass'] = DB_PASSWORD?:'123456';
$config['db_host'] = DB_HOSTNAME?:'mysql';
$config['db_database'] = DB_NAME?:'kanboard';
$db = new Database;
$db->conn($config);
$sql = "update tasks set score=score+1 where id=".$itemId;
$res = $db->query($sql, '');
$likes = 0;
if ($res) {
    $sql = "select score from tasks where id=".$itemId;
    $likes = $db->query($sql, 'row')['score']??0;
}
if ($likes) {
    $return = [
        'status' => 'ok',
        'message' => 'ok',
        'data' => ['likes'=>$likes]
    ];
}
echo json_encode($return);

class Database
{
    //version 1.0.2
    public $db = null;

    public function conn($config)
    {
        if ($this->db !== null) {
            return $this->db;
        }

        $_db = $config['db_database'];
        $host = $config['db_host'];
        $user = $config['db_user'];
        $pass = $config['db_pass'];

        $this->db = new mysqli($host, $user, $pass, $_db);
        if ($this->db->connect_errno) {
            echo "Failed to connect to MySQL: (" . $this->db->connect_errno . ") " . $this->db->connect_error;
            exit;
        }
        $this->db->query('set names utf8');
        $this->db->query("set sql_mode = ''");
        return $this->db;
    }

    public function query($sql, $type = 'row')
    {
        $return = NULL;
        $data = array();
        $result = $this->db->query($sql);
        if (!$result) {
            echo "Error: Our query failed to execute and here is why: \n";
            echo "Query: " . $sql . "\n";
            echo "Errno: " . $this->db->errno . "\n";
            echo "Error: " . $this->db->error . "\n";
            exit;
        }

        switch ($type) {
            case 'row':
                $return = $result->fetch_assoc();
                break;

            case 'rows':
                while ($actor = $result->fetch_assoc()) {
                    $data[] = $actor;
                }
                $return = $data;
                break;

            case 'id':
                $return = $this->db->insert_id;
                break;

            default:
                $return = $result;
                break;
        }
        return $return;
    }
}