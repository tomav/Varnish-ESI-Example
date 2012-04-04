# This is the Varnish Fetch configuration at VCL format (included by varnish-esi-example.vcl)

# Enable ESI
set beresp.do_esi = true;
# Don't cache anything, we'll only cache "/lorem.php"
set beresp.ttl = 0s;

# Defining TTL for specific URLs
if (req.url == "/lorem.php") {
	set beresp.ttl = 5s;
}
return (deliver);
