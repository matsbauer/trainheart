<?php
 
/**
 * Created by PhpStorm.
 * User: Belal
 * Date: 04/02/17
 * Time: 7:51 PM
 */
class DbOperation
{
    private $conn;
 
    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Constants.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    //Function to create a new user
    public function createUser($username, $pass, $email, $name, $lastname)
    {
        if (!$this->isUserExist($username, $email, $lastname)) {
            $password = md5($pass);
            $stmt = $this->conn->prepare("INSERT INTO users (username, password, email, firstname, lastname) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss", $username, $password, $email, $name, $lastname);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }
 
 
    private function isUserExist($username, $email, $lastname)
    {
        $stmt = $this->conn->prepare("SELECT userid FROM users WHERE username = ? OR email = ? OR lastname = ?");
        $stmt->bind_param("sss", $username, $email, $lastname);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
}