<?php

function get_app_by_id() {
    return run_query();
}

function run_query() {
    $host = "localhost";
    $user = "root";
    $pass = "";
    $database = "blinx";
    $conn = mysqli_connect($host, $user, $pass, $database) or die("Error " . mysqli_error($link));
    $query = "SELECT  u.first_name, u.last_name, u.mobile_number, u.gender, u.user_id, req.Id, req.Message,req.Address,req.Location,req.Createddate,req.Requesteddate,req.latitude,req.longitude,req.duration FROM  t_help_request req, m_user u where req.userId = u.user_id ";

    $long = $_GET["long"];
    $lat = $_GET["lat"];
    $distanceFilter = $_GET["distance"];

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
    }
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

    $order = " order by req.requesteddate";

    $sql_final = $query . $where . $order;

    $result = mysqli_query($conn, $sql_final);
    if (!$result) {
        echo "Could not successfully run query ($sql_final) from DB: " . mysql_error();
        exit;
    }
    $data['data'] = array();
    while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        array_push($data['data'], $row);
    }
    mysqli_close($conn);
    return $data;
}

$possible_url = array("get_app_list", "get_app", "get_locations", "filter_by");

$value = "An error has occurred";

if (isset($_GET["action"]) && in_array($_GET["action"], $possible_url)) {
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
//return JSON array
exit(json_encode($value));
