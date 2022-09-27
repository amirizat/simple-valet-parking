<?php
require 'config.php';
$username=$password="";

if(isset($_POST["username"], $_POST["password"])) 
    {     
        $username = $_POST["username"]; 
        $password = $_POST["password"]; 

        $result1 = mysqli_query($conn,"SELECT * from user WHERE username = '".$username."' AND  password = '".$password."'");

        if(mysqli_num_rows($result1) > 0 )
        { 
            $row = mysqli_fetch_array($result1);
            $data = array("username"=>$row['username'],"token"=>$row['role'],"status"=>"berjaya");
            echo json_encode($data);
		} else {
		    $data = array("token"=>"none","status"=>"invalid credentials");
            echo json_encode($data);
		}
	}else{
	        $data = array("status"=>"failed");
            echo json_encode($data);
	}
	$conn->close();
?>