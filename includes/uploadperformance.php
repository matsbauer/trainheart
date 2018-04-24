<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$userid = $_GET['userid'];
$machineid = $_GET['machineid'];
$reps = $_GET['reps'];
$weight = $_GET['weight'];

$passwordi = md5($pass);

$result = mysqli_query($conn, "INSERT INTO `performance`(`userid`, `machineid`, `reps`, `weight`) VALUES ('".$userid."', '".$machineid."', '".$reps."', '".$weight."')");

if ($result) {
    $response['error'] = false;
    $response['message'] = 'User created successfully';
}
else{
    $response['error'] = true;
    $response['message'] = 'Error';
}

echo json_encode($response);

?>
