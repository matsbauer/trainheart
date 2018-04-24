<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$userid = $_GET['userid'];

$result = mysqli_query($conn, "SELECT SUM(weight*reps) AS totalweight FROM performance WHERE userid = '".$userid."' AND DAY(`trainingdate`) = (SELECT MAX(DAY(`trainingdate`)) FROM `performance` WHERE `userid` = '".$userid."')");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$lastdate = $row["totalweight"]; //3454
    }
}
else{
    $response['result'] = "Noch kein Training";
}

$result = mysqli_query($conn, "SELECT AVG(weight*reps) AS 30dayweight FROM performance WHERE userid = '".$userid."' AND trainingdate BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$thirtydayweight = $row["30dayweight"]; //866
    }
}
else{
    
}

$result = mysqli_query($conn, "SELECT AVG(weight*reps) AS 90dayweight FROM performance WHERE userid = '".$userid."' AND trainingdate BETWEEN CURDATE() - INTERVAL 90 DAY AND CURDATE()");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$ninteyweight = $row["90dayweight"];
    }
}
else{
    
}

$result = mysqli_query($conn, "SELECT AVG(weight*reps) AS allchange FROM performance WHERE userid = '".$userid."'");

if (mysqli_num_rows($result) == 1) {
    while($row = $result->fetch_assoc()) {
    	$allchange = $row["allchange"];
    }
}
else{
    
}

$secondlast = 2839;

$thirtydays = round((($lastdate / $thirtydayweight) - 1) * 100);
if($thirtydays > 0){
	$response['30daychange'] = "+ " . $thirtydays;
}
else{
	$response['30daychange'] = " " . $thirtydays;
}

$ninetydays = round((($lastdate / $ninteyweight) - 1) * 100);
if($ninetydays > 0){
	$response['90daychange'] = "+ " . $ninetydays;
}
else{
	$response['90daychange'] = " " . $ninetydays;
}

$all = round((($lastdate / $allchange) - 1) * 100);
if($all > 0){
	$response['allchange'] = "+ " . $all;
}
else{
	$response['allchange'] = " " . $all;
}

$last = round((($lastdate / $secondlast) - 1) * 100);
if($last > 0){
	$response['last'] = "+ " . $last;
}
else{
	$response['last'] = " " . $last;
}


echo json_encode($response);

?>