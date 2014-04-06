<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=no", target-densitydpi=device-dpi />
	<link href='http://fonts.googleapis.com/css?family=Codystar|Lobster|Londrina+Outline' rel='stylesheet' type='text/css'>
	<link href="icons/css/fontello.css" rel='stylesheet' type="text/css">
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="public/style.css" />
    <title>Venture</title>

	<script>
		var lat;
		var lng;
		var form;
		function getLocation() {
		 	if (navigator.geolocation) { 
				navigator.geolocation.getCurrentPosition(showPosition);
		  	}
		}
		function showPosition(position) {
			lat.value = position.coords.latitude;
			lng.value = position.coords.longitude;
			form.submit();
		}
		window.onload = function() {
			lat = document.getElementById("latitude");
			lng = document.getElementById("longitude");
			form = document.getElementById("form");
		}
		
	</script>

</head>
<body>
	
	<div id="content-wrapper">
		<div id="content" style="" class="container">
		    <span id="index">Venture</span>
		    
            <div id="button-container">
            	<form action="GenerateSuggestionsServlet" id="form" method="post">
					<input type="hidden" id="latitude" name="latitude">	
					<input type="hidden" id="longitude" name="longitude">
				</form>	
				<button id="main1" onclick="getLocation()" class="btn btn-success btn-lg btn-block" > Give me an adventure </button>
            	<button id="main2" class="btn btn-info btn-lg btn-block">Track my adventure</button>
			</div>
			<div id="icon-container">
				<span id="index"><i class="icon-info-circled"></i><i class="icon-user"></i></span>
			</div>
		</div>
	</div>
	
	
</body>
</html>