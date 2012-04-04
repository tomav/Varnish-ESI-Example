<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Refresh" content="1">
    <title>Varnish ESI Example</title>
    <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" charset="utf-8">
  </head>
  <body>
    <div id="layout">
      <div id="header">
        <h1>Varnish ESI Example</h1>
      </div>
      <div id="left">
        <!-- ESI tag -->
        <esi:include src="lorem.php" />
        <!-- / ESI tag -->
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
        This is a perfect footer
      </div>
    </div>
  </body>
</html>