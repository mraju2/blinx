<?php for ($x = 0; $x <= 10; $x++) { ?>
    <div class="panel-group sr-accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title" toggle-btn="refine-<?php echo $x ?>" data-toggle="collapse" data-parent="#accordion" >
                    Title
                </h4>
            </div>
            <div pannel="refine-<?php echo $x ?>" class="panel-collapse">
                <div class="panel-body">
                    <ul>
                        <li>1 - collapse</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
<?php
}