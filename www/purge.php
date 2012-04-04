<?php

# Purge the given path
$curl = curl_init("http://varnish-esi-example:8080".$_GET['path']);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "PURGE");
curl_exec($curl);

?>