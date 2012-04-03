# Enable ESI
set beresp.do_esi = true;
set beresp.ttl = 0s;

# Defining TTL for specific URLs
if (req.url == "/lorem.php") {
     set beresp.ttl = 5s;
  }
return (deliver);
