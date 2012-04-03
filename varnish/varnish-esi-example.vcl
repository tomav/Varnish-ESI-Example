backend varnish_origin {
	.host = "varnish-esi-example";
	.port = "80";
}

## RECEIVE
sub vcl_recv {
	if (! req.http.Host)
	{
		error 404 "Need a host header";
	}

	if (req.http.Host ~ "varnish-esi-example")
	{
		set req.backend = varnish_origin;
		include "/this/should/be/replaced/to/match/Varnish-ESI-Example/varnish/varnish-esi-example-recv.vcl";
	}
	else
	{
		set req.backend = varnish_origin;
		return (lookup);
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

## DELIVER
sub vcl_deliver {
	# Secure the header
	# remove resp.http.Via;
	# remove resp.http.X-Varnish;
	# remove resp.http.Server;
	# remove resp.http.X-Powered-By;
}
