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
                        <h2>You don't want to die to donate your Eyes</h2>
                        <p>Eyes are the windows to the world’. This saying brings out the importance of the healthy vision. Only healthy eyes can serve as a clean, clear windows, through which people can acquire immense knowledge. But, unfortunately, some vision defects completely close this window to the world. We are talking about the blind and severely visually impaired persons, for whom the options to open the windows are very limited.<br><br>

Blindness may happen to anyone, at any time and at any place. People become blind due to accidents, wrong treatment, optical imbalance or a genetic defect. 
</p>
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