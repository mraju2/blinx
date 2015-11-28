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
        <?php include './tags/search/search-scripts.php'; ?>
    </head>
    <body>
        <?php include_once './tags/global_header/header.php'; ?>
        <!-- begin:slider -->
        <div class="sr-topbar"></div>
        <!-- begin:tagline -->
        <div class="container">
            <?php include './tags/search/search-header.php'; ?>
            <div class="sr-topbar2"></div>
            <?php include './tags/search/search-tool.php'; ?>
            <div class="row">
                <div class="col-sm-4 hidden-xs">
                    <div  class="sr-refine">
                        <?php include './tags/search/search-refine.php'; ?>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-8">
                    <div>
                        <?php include './tags/search/search-listing.php'; ?>
                    </div>
                </div>
            </div>
        </div>
        <div class="sr-topbar2"></div>
        <!-- end:tagline -->
        <?php include_once './tags/global_header/footer.php'; ?>
        <!-- end:copyright -->
        <?php include_once './tags/common/scripts.php'; ?>
        <script type="text/javascript">
            $(document).ready(function () {
                $("[toggle-btn]").click(function () {
                    $('[pannel=' + $(this).attr('toggle-btn') + ']').collapse('toggle');
                });
            });
        </script>
    </body>
</html>