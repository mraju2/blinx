<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand visible-xs" href="#">BLINX</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav nav-left">
                <li <?php echo ($_pageid == 3) ? 'class="active"' : '' ?>><a href="<?php echo URL_HOME ?>">Home</a></li>
                <li <?php echo ($_pageid == 5) ? 'class="active"' : '' ?>><a href="<?php echo URL_SEARCH ?>">Explore</a></li>
                <li <?php echo ($_pageid == 8) ? 'class="active"' : '' ?>><a href="<?php echo URL_REQUEST ?>">Request Assistance</a></li>
            </ul>
            <a href="#" class="logo visible-lg visible-md">
                <img src="resources/img/logo.jpg" alt="blinx">
            </a>
            <div id="brand" class="visible-lg visible-md">&nbsp;</div>
            <ul class="nav navbar-nav nav-right">
                <li <?php echo ($_pageid == 6) ? 'class="active"' : '' ?>><a href="<?php echo URL_SERVICE ?>">Services</a></li>
                <li><a href="<?php echo URL_SIGNIN ?>">Login</a></li>
                <li><a href="<?php echo URL_JOIN ?>">Join Us</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle <?php echo (($_pageid == 2) || ($_pageid == 1)) ? 'class="active"' : '' ?>" data-toggle="dropdown">ABOUT<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li <?php echo ($_pageid == 2) ? 'class="active"' : '' ?>><a href="<?php echo URL_HOW_IT_WORK ?>">How it works</a></li>
                        <li <?php echo ($_pageid == 1) ? 'class="active"' : '' ?>><a href="<?php echo URL_CONTACT ?>">Contact</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
