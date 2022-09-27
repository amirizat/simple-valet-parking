<?php
require 'config.php';

$result1 = mysqli_query($conn,"SELECT * from parking");

if(mysqli_num_rows($result1) > 0 )
{ 
    $arr = [];
    $increment = 0;
    while ($row = $result1->fetch_assoc()) {
     $jsonArrayObject = (array('id' => $row["id"], 'Customer' => $row["id_customer_details"], 'Parking_Number' => $row["parking_number"],'Status' => $row["status"]));
                $arr[$increment] = $jsonArrayObject;
                $increment++;
    }
    $json_array = json_encode($arr);
    echo $json_array;
} else {
    $data = array("status"=>"check username/password");
    echo json_encode($data);
}
$conn->close();
?>