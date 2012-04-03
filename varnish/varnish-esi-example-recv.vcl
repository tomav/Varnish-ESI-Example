# Compatiblity with Apache log
remove req.http.X-Forwarded-For;
set    req.http.X-Forwarded-For = client.ip;

# Post requests will not be cached
if (req.request == "POST") {
	return (pass);
}

# Normalize encoding/compression
if (req.http.Accept-Encoding) {
	if (req.http.Accept-Encoding ~ "gzip") { set req.http.Accept-Encoding = "gzip";     }
		elsif (req.http.Accept-Encoding ~ "deflate") { set req.http.Accept-Encoding = "deflate"; }
	else { remove req.http.Accept-Encoding; }
}

# Serve the page
unset req.http.vary;

if (req.url ~ "\.(jpeg|jpg|png|gif|ico|js|css|txt|gz|zip|lzma|bz2|tgz|tbz|html|htm)$") {
	# Remove the cookie and make the request static
	unset req.http.cookie;
	return (lookup);
}
# Try to lookup in the cache
return (lookup);

# Cookie ? Not cacheable by default
if (req.http.Authorization || req.http.Cookie) {
	return (pass);
}