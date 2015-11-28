<?php
include_once './libs/const.php';
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <?php
        $_TITLE = "Blinx Home page";
        include_once './tags/common/head.php';
        ?>
    </head>
    <body>
        <?php include_once './tags/global_header/header.php'; ?>
        <!-- begin:slider -->
        <?php include_once './tags/home/billbord.php'; ?>
        <div id="tagline">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2>You don't want to die to donate your vision</h2>
                        <p>Some good text comes here </p>
                    </div>
                </div>
            </div>
        </div>
        <?php include_once './tags/home/service.php'; ?>
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <?php include_once './tags/home/testimonials.php'; ?>
                </div>
                <div class="col-sm-6">
                    <?php include_once './tags/home/twitter.php'; ?>
                </div>
            </div>
        </div>
        <!-- end:tagline -->
        <?php include_once './tags/global_header/footer.php'; ?>
        <!-- end:copyright -->
        <?php include_once './tags/common/scripts.php'; ?>
    </body>
</html>