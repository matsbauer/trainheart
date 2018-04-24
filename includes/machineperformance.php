<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$userid = $_GET['userid'];
$machid = $_GET['machineid'];

$result = mysqli_query($conn, "SELECT weight, reps, trainingdate FROM `performance` WHERE `weight`*`reps` = (SELECT MAX(`reps`*`weight`) FROM `performance` WHERE `userid` = '".$userid."' AND machineid = '".$machid."') AND DAY(`trainingdate`) = (SELECT MAX(DAY(`trainingdate`)) FROM `performance` WHERE `userid` = '".$userid."' AND machineid = '".$machid."') ORDER BY `trainingdate`");

if (mysqli_num_rows($result) > 0) {
    while($row = $result->fetch_assoc()) {
    	$response["maxweight"] = $row["weight"];
    	$response["withthisrep"] = $row["reps"];
    	$lastdate = $row["trainingdate"];
    	$response["lasttraining"] = date('d.m.Y',strtotime($lastdate));
    }
}
else{
    $response['result'] = "Keine Maschine gefunden";
}

echo json_encode($response);

?>


