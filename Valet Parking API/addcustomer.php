<?php

require 'config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(empty($_POST["id_user"])||empty($_POST["car_type"])||empty($_POST["plate_number"])||empty($_POST["phone_number"])||empty($_POST["random_number"])){
        $data = array("status"=>"make sure data inserted");
        echo json_encode($data);
    }else{
        $id_user = $_POST["id_user"];
        $car_type = $_POST["car_type"];
        $plate_number = $_POST["plate_number"];
        $phone_number = $_POST["phone_number"];
        $random_number = $_POST["random_number"];
        
        $sql = "SELECT username FROM user WHERE username='$id_user'";
        $result = $conn->query($sql);

     if ($result->num_rows > 0) {
         
         $sql1 = "SELECT id_user FROM customer_details WHERE id_user='$id_user'";
        $result1 = $conn->query($sql1);
        if ($result1->num_rows > 0) {
            $data = array("status"=>"user already have");
            echo json_encode($data);
        }else{
            $sql2 = "INSERT INTO customer_details (id_user, car_type, plate_number,phone_number,random_number)
        VALUES ('".$id_user."', '".$car_type."', '".$plate_number."', '".$phone_number."', '".$random_number."')";

        if ($conn->query($sql2) === TRUE) {
            $data = array("status"=>"berjaya");
            echo json_encode($data);
            $id_user = '';
            $car_type = '';
            $plate_number = '';
            $phone_number = '';
            $random_number = '';
        } else {
            $data = array("status"=>"error insert");
            echo json_encode($data);
        }
        }

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