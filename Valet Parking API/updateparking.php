<?php
require'config.php';
if(isset($_POST["id"], $_POST["username"])) 
{ 
    $id = $_POST["id"]; 
    $username = $_POST["username"]; 
    $sql = "UPDATE parking SET id_customer_details='$username',status='Locked' WHERE id='$id'";

    if ($conn->query($sql) === TRUE) {
        $data = array("status"=>"berjaya");
        echo json_encode($data);
    } else {
        $data = array("status"=>"failed");
        echo json_encode($data);
    }
}else{
    $data = array("status"=>"failed");
    echo json_encode($data);
}
$conn->close();
?>