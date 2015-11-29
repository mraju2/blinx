<?php

function get_app_by_id() {
    return run_query();
}

/**
 * 
 * @return array
 */
function run_query() {

    // including db connection details into search backend
    include_once 'dbconnection.php';

    $long = $_GET["long"];
    $lat = $_GET["lat"];
    $distanceFilter = isset($_GET["distance"]) ? $_GET["distance"] : 4;

    $conn = mysqli_connect($host, $user, $pass, $database) or die("Error " . mysqli_error($link));
    $query = "SELECT  h.Id, h.Description, u.first_name, u.last_name, u.mobile_number, u.gender, u.user_id, req.Id, req.Message,req.Address,req.Location,req.Createddate,req.Requesteddate,req.latitude,req.longitude,req.duration FROM  t_help_request req, m_user u , f_help h where req.userId = u.user_id and h.Id = req.helpId";


    $longitude_low = $long - ($distanceFilter / 100);
    $longitude_high = $long + ($distanceFilter / 100);
    $latitude_low = $lat - ($distanceFilter / 100);
    $latitude_high = $lat + ($distanceFilter / 100);
    $where = " and req.longitude between " . $longitude_low . " and " . $longitude_high . " and req.latitude between " . $latitude_low . " and " . $latitude_high;

    if (isset($_GET["help"]) && $_GET["help"] != '') {
        $where = $where . " and req.helpId in ( " . $_GET["help"] . ") ";
    }

    if (isset($_GET["help_date"]) && $_GET["help_date"] != '') {
        $help_dates = explode(",", $_GET["help_date"]);
        $multipleDatesPresent = false;
        $datequery = "";
        foreach ($help_dates as $filter_date) {
            if ($multipleDatesPresent) {
                $datequery = $datequery . " OR ";
            } else {
                $where = $where . " and ( ";
                $multipleDatesPresent = true;
            }
            switch ($filter_date) {
                case 1 :
                    $current_date = date('Y-m-d', time());
                    $datequery = $datequery . " (req.Requesteddate  >= STR_TO_DATE('$current_date', '%Y-%m-%d')
							and req.Requesteddate < DATE_ADD(STR_TO_DATE('$current_date', '%Y-%m-%d'), INTERVAL 1 DAY ))";

                    break;
                case 2 :
                    $current_date = date('Y-m-d', time());
                    $current_date = new DateTime($current_date);
                    $current_date->modify('+1 day');
                    $tommorow_date = $current_date->format('Y-m-d');
                    $datequery = $datequery . " (req.Requesteddate  >= STR_TO_DATE('$tommorow_date', '%Y-%m-%d')
							and req.Requesteddate < DATE_ADD(STR_TO_DATE('$tommorow_date', '%Y-%m-%d'), INTERVAL 1 DAY ))";
                    break;
                case 3 :
                    $current_date = date('Y-m-d', time());
                    $current_date = new DateTime($current_date);
                    $current_date->modify('+2 day');
                    $tommorow_date = $current_date->format('Y-m-d');
                    $datequery = $datequery . " (req.Requesteddate  > STR_TO_DATE('$tommorow_date', '%Y-%m-%d'))";

                    break;
            }
        }
        $where = $where . $datequery . ")";
    } else {
        $current_date = date('Y-m-d', time());
        $where = $where . "and  req.Requesteddate  >= STR_TO_DATE('$current_date', '%Y-%m-%d')";
    }
    //
    if (isset($_GET["duration_low"]) && $_GET["duration_low"] != '') {
        $where = $where . " and req.duration >= " . $_GET["duration_low"];
    }
    if (isset($_GET["duration_high"]) && $_GET["duration_high"] != '') {
        $where = $where . " and req.duration <= " . $_GET["duration_high"];
    }
    if (isset($_GET["mode"]) && $_GET["mode"] != '') {
        $where = $where . " and req.mode in ( " . $_GET["help_mode"] . ") ";
    }
    if (isset($_GET["status"]) && $_GET["status"] != '') {
        $where = $where . " and req.status in ( " . $_GET["status"] . ") ";
    }
    //sort order comes here
    if (isset($_GET["order"]) && isset($_GET["order"]) != '') {
        if (isset($_GET["order"]) == 'asc') {
            $order = " order by req.requesteddate asc";
        }
        $order = " order by req.requesteddate desc";
    } else {
        $order = " order by req.requesteddate desc";
    }

    $sql_final = $query . $where . $order;

    $result = mysqli_query($conn, $sql_final);
    if (!$result) {
        echo "Could not successfully run query ($sql_final) from DB: " . mysql_error();
        exit;
    }
    $data['requests'] = array();
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        array_push($data['requests'], $row);
    }
    //service type
    $data['service_type'] = array(
        array("screen_name" => "Reading", "id" => 1),
        array("screen_name" => "Writing", "id" => 2),
        array("screen_name" => "Scanning Books", "id" => 3),
        array("screen_name" => "Audio Books", "id" => 4),
        array("screen_name" => "Filling Application", "id" => 5)
    );
    $data['date_range'] = array(
        array("screen_name" => "Today", "id" => 1),
        array("screen_name" => "Tomorrow", "id" => 2),
        array("screen_name" => "More than 2 days", "id" => 3)
    );
    $data['distance_range'] = array(
        array("screen_name" => "1Km", "id" => 1),
        array("screen_name" => "2Km", "id" => 2),
        array("screen_name" => "3Km", "id" => 3),
        array("screen_name" => "4Km", "id" => 4)
    );
    $data['duration_range'] = array(
        array("screen_name" => "1Hr", "id" => 1),
        array("screen_name" => "2Hr", "id" => 2),
        array("screen_name" => "3Hr", "id" => 3),
        array("screen_name" => "4Hr", "id" => 4),
        array("screen_name" => "5Hr", "id" => 5),
        array("screen_name" => "6Hr", "id" => 6),
        array("screen_name" => "7Hr", "id" => 7)
    );
    //
    mysqli_close($conn);
    return $data;
}

$possible_url = array("get_app_list", "get_app", "get_locations", "filter_by");

$value = "An error has occurred";
$_empty_call = true;

if (isset($_GET["action"]) && in_array($_GET["action"], $possible_url)) {
    $_empty_call = false;

    switch ($_GET["action"]) {
        case "get_app_list":
            $value = get_app_list();
            break;
        case "get_app":
            if (isset($_GET["long"]) && isset($_GET["lat"]))
                $value = get_app_by_id();
            else
                $value = "Missing argument";
            break;
        case "get_locations":
            if (isset($_GET["loc"]))
                $value = get_location_autofill($_GET["loc"]);
            else
                $value = "Missing argument";
            break;
        case "filter_by":
            if (isset($_GET["distance"]) && isset($_GET["service"]))
                $value = get_location_autofill($_GET["loc"]);
            else
                $value = "Missing argument";
            break;
    }
}