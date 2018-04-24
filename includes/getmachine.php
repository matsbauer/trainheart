<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$machid = $_GET['machineid'];

$result = mysqli_query($conn, "SELECT name FROM machines WHERE machine_code = '".$machid."'");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$name = $row["name"];
    	$response['result'] = $row["name"];
    }
}
else{
    $response['result'] = "Keine Maschine gefunden";
}

echo json_encode($response);

?>
