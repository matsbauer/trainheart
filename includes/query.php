<?php 

$response = array();

$servername = "localhost";
$username = "d02a302e";
$password = "ger11918";
$dbname = "d02a302e";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname); 

$query = $_GET['query'];

$result = mysqli_query($conn, $query);

$response['return'] = 'User exists';

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
