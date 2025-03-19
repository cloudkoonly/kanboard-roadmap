<?php
/*
 * Database class usage example
 try {
    $db = Database::getInstance();
    $db->conn($config);

    // Simple query with parameters
    $user = $db->query(
        "SELECT * FROM users WHERE id = ?",
        [$userId],
        'row'
    );

    // Insert data
    $id = $db->insert('users', [
        'name' => 'John',
        'email' => 'john@example.com'
    ]);

    // Transaction example
    $db->beginTransaction();
    try {
        $db->insert('orders', ['user_id' => $userId]);
        $db->update('users', 
            ['order_count' => $newCount],
            'id = ?',
            [$userId]
        );
        $db->commit();
    } catch (Exception $e) {
        $db->rollback();
        throw $e;
    }

} catch (Exception $e) {
    // Handle error
    error_log($e->getMessage());
}
 */
class Database
{
    //version 2.0.0
    private $pdo = null;
    private static $instance = null;
    private $inTransaction = false;

    /**
     * Get database instance (Singleton)
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Connect to database using PDO
     */
    public function conn($config)
    {
        if ($this->pdo !== null) {
            return $this->pdo;
        }

        try {
            $dsn = sprintf("mysql:host=%s;dbname=%s;charset=utf8mb4",
                $config['db_host'],
                $config['db_database']
            );
            
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci"
            ];

            $this->pdo = new PDO($dsn, $config['db_user'], $config['db_pass'], $options);
            
            // Set SQL mode
            $this->pdo->query("SET sql_mode = ''");
            
            return $this->pdo;
        } catch (PDOException $e) {
            throw new Exception("Connection failed: " . $e->getMessage());
        }
    }

    /**
     * Execute a query and return results based on type
     */
    public function query($sql, $params = [], $type = 'row')
    {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);

            switch ($type) {
                case 'row':
                    return $stmt->fetch();
                
                case 'rows':
                    return $stmt->fetchAll();
                
                case 'id':
                    return $this->pdo->lastInsertId();
                
                default:
                    return $stmt;
            }
        } catch (PDOException $e) {
            throw new Exception("Query failed: " . $e->getMessage());
        }
    }

    /**
     * Begin a transaction
     */
    public function beginTransaction()
    {
        if (!$this->inTransaction) {
            $this->pdo->beginTransaction();
            $this->inTransaction = true;
        }
    }

    /**
     * Commit a transaction
     */
    public function commit()
    {
        if ($this->inTransaction) {
            $this->pdo->commit();
            $this->inTransaction = false;
        }
    }

    /**
     * Rollback a transaction
     */
    public function rollback()
    {
        if ($this->inTransaction) {
            $this->pdo->rollBack();
            $this->inTransaction = false;
        }
    }

    /**
     * Execute a query with named parameters
     */
    public function execute($sql, $params = [])
    {
        try {
            $stmt = $this->pdo->prepare($sql);
            return $stmt->execute($params);
        } catch (PDOException $e) {
            throw new Exception("Execute failed: " . $e->getMessage());
        }
    }

    /**
     * Get single value from query
     */
    public function getValue($sql, $params = [])
    {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchColumn();
        } catch (PDOException $e) {
            throw new Exception("GetValue failed: " . $e->getMessage());
        }
    }

    /**
     * Insert data into table
     */
    public function insert($table, $data)
    {
        try {
            $fields = array_keys($data);
            $values = array_values($data);
            $placeholders = str_repeat('?,', count($fields) - 1) . '?';
            
            $sql = sprintf(
                "INSERT INTO %s (%s) VALUES (%s)",
                $table,
                implode(', ', $fields),
                $placeholders
            );
            
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($values);
            return $this->pdo->lastInsertId();
        } catch (PDOException $e) {
            throw new Exception("Insert failed: " . $e->getMessage());
        }
    }

    /**
     * Update data in table
     */
    public function update($table, $data, $where, $whereParams = [])
    {
        try {
            $fields = array_keys($data);
            $values = array_values($data);
            
            $set = implode('=?, ', $fields) . '=?';
            
            $sql = sprintf(
                "UPDATE %s SET %s WHERE %s",
                $table,
                $set,
                $where
            );
            
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute(array_merge($values, $whereParams));
            return $stmt->rowCount();
        } catch (PDOException $e) {
            throw new Exception("Update failed: " . $e->getMessage());
        }
    }
}