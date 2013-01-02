<?php

ini_set('display_errors','no');
ini_set('register_globals','yes');
ini_set('short_open_tag','yes');

function parse_amportal_conf($filename) {
	$file = file($filename);
	foreach ($file as $line) {
		if (preg_match("/^\s*([a-zA-Z0-9]+)\s*=\s*(.*)\s*([;#].*)?/",$line,$matches)) { 
			$conf[ $matches[1] ] = $matches[2];
		}
	}
	return $conf;
}

$amp_conf = parse_amportal_conf("/etc/amportal.conf");

if ($amp_conf["AMPWEBADDRESS"] == "")
	{$amp_conf["AMPWEBADDRESS"] = $_SERVER["HTTP_HOST"];}
	
if ($_SERVER["HTTP_HOST"] != $amp_conf["AMPWEBADDRESS"]) {
	$proto = ((isset($_SERVER["HTTPS"]) && ($_SERVER["HTTPS"] == "on")) ? "https" : "http");
	header("Location: ".$proto."://".$amp_conf["AMPWEBADDRESS"].$_SERVER["REQUEST_URI"]);
	exit;
}

?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>AJAX Operator Panel</title>
<style>
<!--
html,body {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
}

-->
</style>

<link rel="stylesheet" href="../welcome/style.css" />
</head>
<body bgcolor="#ffffff">
      <div class="header">
          <a href="http://www.lynks.ru/"><img src="images/logo_lynks.png" alt="" /></a>
          <a href="../index.php">
                <?php if ($ver == "3") { ?><img src="images/logo_digium.gif" alt="" />
                <?php } else { ?><img src="images/logo_digium.gif" alt="" /><?php } ?></a>
      </div>
      <div class="message">AJAX Operator Panel</div>
      <div>
        

            <div align="center">
<div id="panelframe">
	<iframe width="99%" height="1600" frameborder="0" align="top" src="extensions-realtime.php?show=list"></iframe>
        </div>
				</div>
		  </div>

</body>
</html>
