<!DOCTYPE html>
<%@ page import="venture.Activity" import="venture.Movie" import="venture.MinuteTime" %>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=no", target-densitydpi=device-dpi />
    <link href='http://fonts.googleapis.com/css?family=Codystar|Lobster|Londrina+Outline|Lato|Merriweather' rel='stylesheet' type='text/css'>
	<link href="icons/css/fontello.css" rel='stylesheet' type="text/css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <link rel="stylesheet" href="public/style.css" />
    <title>Venture</title>

    <style>
        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
        body, html, #content-wrapper {
            height: 100%;
            overflow: hidden;
        }
        div#content:after {
            display:block;
            content:"";
        }
    </style>
</head>

<body>
    <div id="content-wrapper">
        <div id="header">
            <a href="index.html"><span id="hdr">Venture</span></a>
            <div onclick="toggleLoginBar();" id="login-icon" style="position: absolute; right: 12px; text-align: right; display: inline;">
                <div style="position: relative; top: -8px;" class="dropdown">
                    <span id="hdr"><i class="icon-cog"></i></span>
                </div>
            </div>
        </div>
		<div id="content" style="width: 100%; min-height: 100%; margin-bottom: -80px;">
            <h1>Don't worry.</h1>
            <h1>We'll still be here when you get back.</h1>
            	<%
		String modeOfTransit = (String)request.getParameter("transport");
		
		if (modeOfTransit == null) {
			modeOfTransit = "driving";
		}
	
		String address = (String)request.getParameter("address");
		StringBuilder addressURL = new StringBuilder();
		for (int i = 0; i < address.length(); i++) {
			if (address.charAt(i) ==' ') {
				addressURL.append("+");
			} else {
				addressURL.append(address.charAt(i));
			}
		}
	%>
	
            <div id="map-container">
                <iframe
                  id="map-frame"
				  width="600"
				  height="450"
				  frameborder="0" style="border:0"
				  src="https://www.google.com/maps/embed/v1/directions?key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg
				  &origin=<%=request.getAttribute("latitude")%>,<%=request.getAttribute("longitude")%>
				  &destination=<%=addressURL%>
				  &mode=<%=modeOfTransit%>" >
				</iframe>
            </div>
            <div id="footer" style="position: absolute; bottom:0px; height: 75px;">&copy; Keenon, Jan, Amy, and Alanna</div>
        </div>
	</div>
</body>
</html>