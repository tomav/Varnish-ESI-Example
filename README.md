# Varnish ESI Example

This bunch of files should help you to setup _Proof of Concept (POC)_ about Varnish cache and ESI.

## Prerequisite

You need to install :

* Apache2  
* PHP5  
* Varnish  

## Install

1. Edit your /etc/hosts  
Add a new line `127.0.0.1  varnish-esi-example`

2. Edit `Varnish-ESI-Example/apache/varnish-esi-example.conf`  
Adapt the `DocumentRoot` to match `Varnish-ESI-Example/www` folder located in the package.

3. Load de configuration of the test backend in Apache  
`sudo ln -s /this/should/be/replaced/to/match/Varnish-ESI-Example/apache/varnish-esi-example.conf /etc/sites-enabled/`  
`sudo apachectl restart`

4. Edit Varnish configuration file `Varnish-ESI-Example/varnish/varnish-esi-example.vcl`  
Adapt `/this/should/be/replaced/to/match/` to match `Varnish-ESI-Example/varnish` folder

5. Start Varnish (but adapt the command line before)  
`sudo varnishd -a varnish-esi-example:8080 -T localhost:6082 -f /this/should/be/replaced/to/match/Varnish-ESI-Example/varnish/varnish-esi-example.vcl -s file,/opt/local/var/varnish/varnish-esi-example.bin,10M`

## Play

Your static website should be available at [http://varnish-esi-example/](http://varnish-esi-example/) and the content should not appear because nor Apache nor your browser understand ESI tags.

Your cached website should be available at [http//varnish-esi-example:8080](http//varnish-esi-example:8080) and the content should appear. As you can see, the ESI tag is processced and the content cached for 5 seconds (this can be changed in varnish-esi-example-fetch.vcl). There is a `sleep(1)` to simulate a 1 second _Time To First Byte (TTFB)_