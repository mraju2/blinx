<?php
include_once './libs/const.php';
$_pageid = 1;
?>
<!DOCTYPE html>
<html lang="en">
    <head>   
        <?php
        $_TITLE = "Contact us";
        include_once './tags/common/head.php';
        ?>
    </head>

    <body>
        <?php include_once './tags/global_header/header.php'; ?>
        <div class="heads" style="background: url(resources/img/bag-banner-2.jpg) center center;">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2><span>//</span> contact us</h2>
                    </div>
                </div>
            </div>
        </div>
        <!-- begin:tagline -->
        <div class="page-content contact">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <ol class="breadcrumb">
                            <li><a href="#">Home</a></li>
                            <li class="active">Contact Us</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <h3>Address</h3>
                        <p>
                           # 6, 3rd H Street, Markham Road, Ashoknagar, Bangalore -560025<br>

						   pH: 9538088668

                        </p>
                    </div>
                </div>
                <div class="row padd20-top-btm">
                    <?php
                    //TODO : email integration need to be done
                    ?>
                    <form method="post" action="contact.html">
                        <div class="col-md-5 col-sm-5">
                            <h3>Send us message, we love to hear from you </h3>
							

                            <input type="text" name="name" class="form-control" placeholder="Enter your name" required="">
                            <input type="email" name="email" class="form-control" placeholder="Enter your mail" required="">
                            <input type="text" name="subject" class="form-control" placeholder="Enter your subject" required="">
                        </div>
                        <div class="col-md-7 col-sm-7">
                            <textarea name="message" class="form-control" rows="7" placeholder="Type your message" required=""></textarea>
                            <input type="submit" name="submit" value="Send Message" class="btn btn-warning btn-block btn-lg">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- end:tagline -->
        <?php include_once './tags/global_header/footer.php'; ?>
        <!-- end:copyright -->
        <?php include_once './tags/common/scripts.php'; ?>
    </body>
</html>