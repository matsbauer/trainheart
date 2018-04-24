<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$userid = $_GET['userid'];

$result = mysqli_query($conn, "SELECT SUM(weight*reps) AS totalweight, COUNT(*) AS counter FROM performance WHERE userid = '".$userid."' AND DATE(`trainingdate`) = CURDATE()");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$response['exercises'] = $row["counter"];
    	$response['totalweight'] = $row["totalweight"];
    }
}
else{
    $response['result'] = "Noch kein Training";
}

$result = mysqli_query($conn, "SELECT * FROM performance WHERE userid = '".$userid."' AND DATE(`trainingdate`) = CURDATE() GROUP BY machineid");

if (mysqli_num_rows($result) > 0) {
    $response['error'] = "correct";
    while($row = $result->fetch_assoc()) {
        $response['machines'] = "".mysqli_num_rows($result);
    }
}
else{
    $response['error'] = "no";
}

echo json_encode($response);

?>