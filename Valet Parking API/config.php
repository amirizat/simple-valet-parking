<?php

define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'id16983971_mydatabase_01');
define('DB_PASSWORD', 'Valet_123456');
define('DB_NAME', 'id16983971_mydatabase');
 
$conn = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
 
if($conn === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
?>