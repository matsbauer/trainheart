<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$userid = $_GET['userid'];

$result = mysqli_query($conn, "SELECT MAX(trainingdate) AS lasttraining FROM performance WHERE userid = '".$userid."'");

if (mysqli_num_rows($result) == 1) {
    $response['error'] = "correct";
    while($row = $result->fetch_assoc()) {
    	$lastdate = $row["lasttraining"];
    	$last = date('d.m.Y',strtotime($lastdate));
    	$response['result'] = $last;
    	$response['fp'] = $row["fitpoints"];
    	$response['nextdate'] = date('d.m.Y',strtotime($lastdate) + 3 * 86400);
    }
}
else{
    $response['result'] = "Noch kein Training";
}

$result = mysqli_query($conn, "SELECT fitpoints FROM users WHERE userid = '".$userid."'");

if (mysqli_num_rows($result) == 1) {
    $response['error'] = "correct";
    while($row = $result->fetch_assoc()) {
    	$response['fp'] = $row["fitpoints"];
    }
}

echo json_encode($response);

?>
