<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$username = $_GET['username'];
$pass = $_GET['password'];
$email = $_GET['email'];
$name = $_GET['name'];
$deviceid = $_GET['deviceid'];

$passwordi = md5($pass);

$result = mysqli_query($conn, "INSERT INTO `users`(`username`, `password`, `email`, `firstname`, `deviceid`) VALUES ('".$username."', '".$passwordi."', '".$email."', '".$name."', '".$deviceid."')");

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
