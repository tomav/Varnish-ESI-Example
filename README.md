# Varnish ESI Example

This bunch of files should help you to setup a _Proof of Concept (POC)_ about Varnish cache and ESI.  
It has been tested with `varnish-3.0.2` on Mac OSX 10.7.

## Prerequisites

You need to install :

* Apache2
* PHP5
* Varnish 

## Setup

1. Clone the project !  
`git clone git@github.com:tomav/Varnish-ESI-Example.git`

2. Edit your `/etc/hosts`  
Add a new line `127.0.0.1  varnish-esi-example`

3. Edit `Varnish-ESI-Example/apache/varnish-esi-example.conf`  
Adapt the `DocumentRoot` to match `Varnish-ESI-Example/www` folder located in the package.

4. Load the backend configuration in Apache  
`sudo ln -s /this/should/be/replaced/to/match/Varnish-ESI-Example/apache/varnish-esi-example.conf /etc/apache2/sites-enabled/`  
`sudo apache2ctl restart`

5. Edit Varnish configuration file `Varnish-ESI-Example/varnish/varnish-esi-example.vcl`  
Adapt `/this/should/be/replaced/to/match/` occurrences to match `Varnish-ESI-Example/varnish` folder

6. Start Varnish (but adapt the command line before, like in previous step)  
`sudo varnishd -a varnish-esi-example:8080 -T localhost:6082 -f /this/should/be/replaced/to/match/Varnish-ESI-Example/varnish/varnish-esi-example.vcl -s file,/opt/local/var/varnish/varnish-esi-example.bin,10M`

## Play

Your static website should be available at [http://varnish-esi-example/](http://varnish-esi-example/) and the content should not appear because nor Apache nor your browser understand ESI tags (Varnish is not used at this time, so no cache).

Your proxied website should be available at [http://varnish-esi-example:8080/](http://varnish-esi-example:8080). Same as above, but received by Varnish, and processed by Apache. PHP includes are used, not ESI. Again, no cache at this time. (not really useful at this time)

Your cached website should be available at [http://varnish-esi-example:8080/?esi](http://varnish-esi-example:8080/?esi). Here, ESI is used and cache is  used on `lorem.php` and `footer.php` files. The first file contains a `sleep(1)` PHP instruction to simulate a 1 second _[Time To First Byte (TTFB)](http://en.wikipedia.org/wiki/Time_To_First_Byte)_. 

Your full cached website should be available at [http://varnish-esi-example:8080/?full](http://varnish-esi-example:8080/?full). Here, ESI is used and cache is  used on all page includes. 

The `ìndex.php` file contains :

* a `meta-refresh` to let you see what is changing every 2 seconds
* the date appear in the center and right column. You will see that `/lorem.php` is cached 10 seconds via ESI.  
* the `/footer.php` file is cached 24 hours but you can purge it manually via a link which call `/purge.php` (modify the text of the file, then click "pruge").

Note : The cache _Time To Live (TTL)_ is configurable in `varnish-esi-example-fetch.vcl` for both `lorem.php` and `footer.php` files.

## Results

    # No cache and 1s TTFB every page load  
    ab -n 1000 -c 10 http://varnish-esi-example/  
    Requests per second:    9.97 [#/sec] (mean) (5 fails)

    # ESI tag, cache on lorem.php for 10s (except first hit), layout served by Apache   
    ab -n 1000 -c 10 http://varnish-esi-example:8080/\?esi  
    Requests per second:    622.81 [#/sec] (mean) (no fail)

    # ESI tag, full page cached and served by Varnish (except first hit)  
    ab -n 1000 -c 10 http://varnish-esi-example:8080/\?full  
    Requests per second:    892.39 [#/sec] (mean) (no fail)

