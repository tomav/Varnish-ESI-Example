<!DOCTYPE html>
<html>
  <head>
    <!-- <meta http-equiv="Refresh" content="1"> -->
    <title>Varnish ESI Example</title>
    <style type="text/css" media="screen">
      #layout {
        width:800px;
        margin:auto;
      }
      #left {
        width:600px;
        float:left;
      }
      #right {
        margin-left:620px;
      }
      #footer {
        clear:both;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <div id="layout">
      <div id="header">
        <h1>Varnish ESI Example</h1>
      </div>
      <div id="left">
        <esi:include src="lorem.php" />
      </div>
      <div id="right">
        <h3>No cache !</h3>
        <p><?php echo date("s"); ?></p>
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
        This is a perfect footer
      </div>
    </div>
  </body>
</html>