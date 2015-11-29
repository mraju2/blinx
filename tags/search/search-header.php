<div class="row">
    <div class="col-xs-12 sr-tagline">
        <div class="input-group">
            <form id="frmSearch" action="<?php echo URL_SEARCH ?>" method="GET">
                <input class="form-control" id="my-address" autocomplete="off" spellcheck="false" placeholder="I'm looking for..." >
                <input type="hidden" name="long" value="" />
                <input type="hidden" name="lat" value="" />
                <input type="hidden" name="action" value="get_app" />
            </form>
            <span class="input-group-btn">
                <button class="btn btn-primary" type="submit" value="search" onClick="doSearch();" >
                    <b>
                        <span class="offshowtext">search</span>
                    </b>
                </button>
            </span>
        </div>
    </div>
</div>
