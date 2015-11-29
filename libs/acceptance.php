<?php

// This is the API, 2 possibilities: show the app list or show a specific app by id.
// This would normally be pulled from a database but for demo purposes, I will be hardcoding the return values.

function update_request() {
    $status = $_POST["status"];
    $vid = $_POST["vid"];
    $helpid = $_POST["helpid"];
    $query = "UPDATE t_help_request set status = '$status', volunteer_id = $vid where Id = $helpid ";
    return update_query($query);
}

function insert_ratings() {

    $user_id = $_POST["user_id"];
    $help_request_id = $_POST["help_request_id"];
    $comments = $_POST["comments"];
    $rating = $_POST["rating"];
    $query = "INSERT  into ratings (user_id,help_request_id,comments,rating) values ($user_id,$help_request_id,'$comments', $rating) ";

    return update_query($query);
}

function update_query($query) {
    include './dbconnection.php';
    
    $conn = mysqli_connect($host, $user, $pass, $database) or die("Error " . mysqli_error($link));


    echo $query;

    $result = mysqli_query($conn, $query);
    if (!$result) {
        echo "Could not successfully run query ($query) from DB: " . mysql_error();
        exit;
    }
    mysqli_close($conn);
    return $query;
}

$possible_url = array("update_request", "put_ratings");

$value = "An error has occurred";
//$value = update_ratings();
//return JSON array
if (isset($_POST["action"]) && in_array($_POST["action"], $possible_url)) {
    switch ($_POST["action"]) {
        case "update_request":
            update_request();
            break;
        case "put_ratings" :
            insert_ratings();
            break;
    }
}

//exit(json_encode($value));	
exit;
?>