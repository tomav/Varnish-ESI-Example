<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Refresh" content="2">
    <title>Varnish ESI Example</title>
    <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" charset="utf-8">
    <script type="text/javascript" charset="utf-8" src="/js/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8">
      function purge(path) {
        $.ajax({
          type: 'POST',
          url: "purge.php?path="+path,
          success: function(data) {
              location.reload(true);
          }
        })
      }
    </script>
  </head>
  <body>
    <div id="layout">
      <div id="header">
        <h1>Varnish ESI Example</h1>
      </div>
      <div id="left">
        <?php
        if (isset($_GET['esi'])) {
          echo "<p>Only first Hit every 10 seconds has a TTFB = 1 second</p>";
        	echo "<esi:include src=\"lorem.php\" />";
        } else {
          echo "<p>Each Hit has a TTFB = 1 second</p>";
          include("lorem.php");
        }
        ?>
      </div>
      <div id="right">
        <h3>No cache !</h3>
        <p><?php echo date("h:m:s"); ?></p>
        <ul>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
          <li>Lorem ipsum</li>
        </ul>
      </div>
      <div id="footer">
        <p>
          <?php
          if (isset($_GET['esi'])) {
            echo "Cached 24 hours <br />";
          	echo "<esi:include src=\"footer.php\" />";
            echo "<a href=\"javascript:;\" onclick=\"purge('/footer.php');\">Purge footer cache</a>";
          } else {
            echo "No cache <br />";
            include("footer.php");
          }
          ?>          
        </p>
      </div>
    </div>
  </body>
</html>