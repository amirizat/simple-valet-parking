<?php
require'config.php';
if(isset($_POST["id"])) 
{ 
    $id = $_POST["id"]; 
    $sql = "UPDATE parking SET id_customer_details='none',status='free' WHERE id='$id'";

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