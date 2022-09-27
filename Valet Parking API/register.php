<?php

require 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(empty($_POST["username"])||empty($_POST["password"])){
        $data = array("status"=>"make sure data inserted");
        echo json_encode($data);
    }else{
        $username = $_POST["username"];
        $password = $_POST["password"];
        $role = "customer";
        
        $sql = "SELECT username FROM user WHERE username='$username'";
        $result = $conn->query($sql);

     if ($result->num_rows > 0) {
         $data = array("status"=>"failed","token"=>"none");
         echo json_encode($data);
     }else{
         $sql2 = "INSERT INTO user (username, password, role)
        VALUES ('".$username."', '".$password."', '".$role."')";

        if ($conn->query($sql2) === TRUE) {
            $data = array("status"=>"berjaya","token"=>$role);
            echo json_encode($data);
            $username = '';
            $password = '';
        } else {
            $data = array("status"=>"error insert");
            echo json_encode($data);
        }
     }
    }
}else{
    $data = array("status"=>"failed");
    echo json_encode($data);
}

$conn->close();
?>