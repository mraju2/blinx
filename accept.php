<?php
include_once './libs/const.php';
$_pageid = 112;
?>
<!DOCTYPE html>
<html lang="en">
    <head>   
        <?php
        $_TITLE = "Request Service";
        include_once './tags/common/head.php';
        ?>
    </head>

    <body>
        <?php include_once './tags/global_header/header.php'; ?>
        <div class="heads" style="background: url(resources/img/bag-banner-1.jpg) center center;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2><span>//</span> Accept Service Request.</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <ol class="breadcrumb">
                            <li><a href="<?php echo URL_HOME ?>">Home</a></li>
                            <li class="active">Accept Request</li>
                        </ol>
                    </div>
                </div>

                <div class="row padd20-top-btm">
                    <div class="col-md-12 text-center">
                        <h4>
                            <?php echo $request["first_name"] . " " . $request["last_name"] ?>
                        </h4>
                        <p>
                            Type of service <b>Type comes here</b> 
                            <?php (isset($request["duration"]) ? " for " . $request["duration"] . "Hrs" : "") ?> on 
                            <code><?php echo $request["Requesteddate"] ?></code>
                            <?php if (isset($request["Location"])) { ?>
                                at <a target="_blank" href="https://www.google.com/maps/place/<?php echo $request["latitude"] ?>,<?php echo $request["longitude"] ?>"><?php echo $request["Location"] ?></a>
                                <?php
                            }
                            echo $request["Message"]
                            ?>
                        </p>
                    </div>
                </div>

            </div>
        </div>
        <!-- end:tagline -->
        <?php include_once './tags/global_header/footer.php'; ?>
        <!-- end:copyright -->
        <?php include_once './tags/common/scripts.php'; ?>
    </body>
</html>