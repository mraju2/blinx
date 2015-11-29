<?php

/**
 * 
 * @return array
 */
function run_query() {

    // including db connection details into search backend
    include_once 'dbconnection.php';

    $_id = $_GET["id"];

    $conn = mysqli_connect($host, $user, $pass, $database) or die("Error " . mysqli_error($link));
    $query = "SELECT   *  FROM  t_help_request req, m_user u , f_help h  where req.userId = u.user_id and req.id = $_id;";

    $result = mysqli_query($conn, $query);
    if (!$result) {
        echo "Could not successfully run query ($query) from DB: " . mysql_error();
        exit;
    }
    //
    $data["request"] = array();
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        array_push($data["request"], $row);
        break; //only one request.
    }
    return $data;
}

/**
 * 
 * @return array
 */
function getAllList($_id) {

    // including db connection details into search backend
    include_once 'dbconnection.php';

    $conn = mysqli_connect($host, $user, $pass, $database) or die("Error " . mysqli_error($link));
    $query = "SELECT   *  FROM  t_help_request req, m_user u , f_help h  where req.userId = u.user_id and req.userId = $_id;";

    $result = mysqli_query($conn, $query);
    if (!$result) {
        echo "Could not successfully run query ($query) from DB: " . mysql_error();
        exit;
    }
    //
    $data["request"] = array();
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        array_push($data["request"], $row);
    }
    return $data;
}
