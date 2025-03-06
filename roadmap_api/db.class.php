<?php
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