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

$passwordi = md5($pass);

$result = mysqli_query($conn, "SELECT userid, username, password, firstname FROM users WHERE username = '".$username."' AND password = '".$passwordi."'");

if (mysqli_num_rows($result) == 1) {
    $response['error'] = "correct";
    while($row = $result->fetch_assoc()) {
    	$response['userid'] = $row["userid"];
    	$response['name'] = $row["firstname"];
    }
    $response['message'] = 'User exists';
}
else{
    $response['error'] = "failed";
    $response['message'] = 'User doesnt exist or password is wrong';
}

echo json_encode($response);

?>
