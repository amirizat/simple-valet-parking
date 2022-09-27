<?php

require 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(empty($_POST["id_user"])){
        $data = array("status"=>"make sure data inserted");
        echo json_encode($data);
    }else{
        $id_user = $_POST["id_user"];
        $sql = "SELECT id_user,random_number FROM customer_details WHERE id_user='$id_user'";
        //$sql = "SELECT id_user FROM customer_details WHERE id_user='abu'";
        //$sql = "SELECT * FROM customer_details";
        $result = $conn->query($sql);

        if(mysqli_num_rows($result) > 0 )
        { 
            $row = mysqli_fetch_array($result);
            $data = array("random_number"=>$row['random_number'],"status"=>"berjaya");
            echo json_encode($data);
        } else {
            $data = array("status"=>"no record found");
            echo json_encode($data);
        }
    }
}else{
    $data = array("status"=>"404");
    echo json_encode($data);
}

$conn->close();
?>