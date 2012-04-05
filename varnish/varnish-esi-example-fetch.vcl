# This is the Varnish Fetch configuration at VCL format (included by varnish-esi-example.vcl)

# Enable ESI
set beresp.do_esi = true;
# Don't cache anything, we'll only cache "/lorem.php"
set beresp.ttl = 0s;

# Defining TTL for specific URLs
if (req.url ~ "\.(ico|js|css)$") {
	set beresp.ttl = 24h;
}

if (req.url == "/lorem.php") {
	set beresp.ttl = 10s;
}
if (req.url == "/footer.php") {
	set beresp.ttl = 24h;
}
if (req.url == "/?full") {
	set beresp.ttl = 10s;
}

return (deliver);
