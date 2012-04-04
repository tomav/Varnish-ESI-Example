# Varnish configuration file

# Define here the hostname and port of you backend (website), where Varnish should grab the page when cache expires.
backend varnish_origin {
	.host = "varnish-esi-example";
	.port = "80";
}

# ACL to allow cache Purge
acl purge {
	"localhost";
}

## RECEIVE
sub vcl_recv {
	
	# check acl purge at the top and purges
  if (req.request == "PURGE") {
    if (!client.ip ~ purge) {
      error 405 "Not allowed.";
    }
    return (lookup);
  }
  
	if (! req.http.Host)
	{
		error 404 "Your query need a host header !";
	}

	# Let's define a configuration per backend, based on request host
	if (req.http.Host ~ "varnish-esi-example")
	{
		set req.backend = varnish_origin;
		include "/this/should/be/replaced/to/match/Varnish-ESI-Example/varnish/varnish-esi-example-recv.vcl";
	}
	else
	{
		# This shoud be something else than varnish_origin
		error 404 "No Varnish configuration for your host header.";
	}
}

## FETCH
sub vcl_fetch {
	if (req.http.Host ~ "varnish-esi-example")
	{
		include "/this/should/be/replaced/to/match/Varnish-ESI-Example/varnish/varnish-esi-example-fetch.vcl";
	}
	else
	{
		return (deliver);
	}
}

# HIT
sub vcl_hit {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged.";
	}
}

# MISS
sub vcl_miss {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged.";
	}
}


## DELIVER
sub vcl_deliver {
	# Secure the header
	# remove resp.http.Via;
	# remove resp.http.X-Varnish;
	# remove resp.http.Server;
	# remove resp.http.X-Powered-By;
}
