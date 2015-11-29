<?php
/*
  Array
  (
  [first_name] => raju
  [last_name] => Mani
  [mobile_number] => 9538088668
  [gender] => Male
  [user_id] => 1
  [Id] => 13
  [Message] =>
  [Address] => 1
  [Location] =>
  [Createddate] => 2015-11-28 22:04:33
  [Requesteddate] => 2015-11-29 12:00:00
  [latitude] => 12.9591722
  [longitude] => 77.69741899999997
  [duration] => 1
  )
 */
?>
<div class="bs-callout bs-callout-info">
    <h4  style="padding-right: 70px;">
        <?php echo $request["first_name"] . " " . $request["last_name"] ?>
        <a href="accept.php?id=<?php echo $request["Id"]?>"class="btn btn-success pull-right" style="margin-right: -70px;margin-top: -14px;">Accept</a>
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