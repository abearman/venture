<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="venture.Activity" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=no", target-densitydpi=device-dpi />
    <link href='http://fonts.googleapis.com/css?family=Codystar|Lobster|Londrina+Outline|Lato|Merriweather' rel='stylesheet' type='text/css'>
	<link href="public/icons/css/fontello.css" rel='stylesheet' type="text/css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <link rel="stylesheet" href="public/style.css" />
    <title>Venture</title>
    <script type="text/javascript">

        var loginBar;

        function toggleLoginBar() {
           loginBar.slideToggle(); 
        }

        window.onload = function() {
            // initialize here
            loginBar = $("#login-bar");
        }
    </script>

</head>
<body>

	<%
		Activity activity = (Activity)request.getAttribute("activity");	
		String modeOfTransit = (String)request.getAttribute("modeOfTransit");
		boolean isHungry = (request.getAttribute("isHungry") != null) ? true : false;
		boolean isMovie = (request.getAttribute("isMovie") != null) ? true : false;
		boolean isOutside = (request.getAttribute("isOutside") != null) ? true : false;
		boolean isArts = (request.getAttribute("isArts") != null) ? true : false;
		
		if (modeOfTransit == null) {
			modeOfTransit = "driving";
		}
		String imageSrc = "http://maps.googleapis.com/maps/api/streetview?size=600x300&location=" + activity.latitude + "," + activity.longitude + "&heading=151.78&pitch=-0.76&sensor=false";
	
		StringBuilder addressURL = new StringBuilder();
		for (int i = 0; i < activity.address.length(); i++) {
			if (activity.address.charAt(i) ==' ') {
				addressURL.append("+");
			} else {
				addressURL.append(activity.address.charAt(i));
			}
		}
	%>

	<div id="content-wrapper">
        <div id="header">
            <a href="index.html"><span id="hdr">Venture</span></a>
            <div onclick="toggleLoginBar();" id="login-icon" style="position: absolute; right: 12px; text-align: right; display: inline;">
                <div style="position: relative; top: -8px;" class="dropdown">
                    <span id="hdr"><i class="icon-cog"></i></span>
                </div>
            </div>
        </div>
        <div id="login-bar">
            <span id="icon-bar">
                <span id="category-group"><i class="icon-tree-1" id="unselected" title="Parks"></i> <i class="icon-bar"  id="unselected" title="Bars"></i> <i class="icon-restaurant" id="unselected" title="Food"></i> <i class="icon-cinema"  id="unselected" title="Movies"></i> <i class="icon-shop" id="unselected" title="Shopping"></i> <i class="icon-embassy"  id="unselected" title="Other"></i></span>
                <span id="transpo-group"><i class="icon-bicycle" id="unselected" title="Bike"></i> <i class="icon-bus" id="unselected" title="Public Transit"></i> <i class="icon-fuel" id="unselected" title="Drive"></i> <i class="icon-pitch"  id="unselected" title="Walk"></i></span>
            </span>
        </div>
		<div id="content" style="width: 100%">
            <div id="event-photo-container">
                <div id="event-photo-wrapper">
                    <img src=<%=imageSrc%> />
                </div>
            </div>
            <div id="event-title-container"><span id="event-title"><%=activity.title%></span></div>
            <div id="event-details-container">
                <span id="event-dist">2.6 miles | 4.2 minutes away</span><br />
               	<span id="event-details">
             		<% 
             			if (activity.website != null) {
             				%><a href="<%=activity.website%>"><%=activity.website%></a><br>
             			<%}
             		%>
             		<% 
             			if (activity.phoneNumber != null) {
             				%>| <a href="tel:+1<%=activity.phoneNumber%>"><%=activity.phoneNumber%></a><br>
             			<%}
             		%>
             	</span>
                <span id="event-addr"><%=activity.address%></span>
            </div>
            <div id="map-container">
                <iframe
				  width="600"
				  height="450"
				  frameborder="0" style="border:0"
				  src="https://www.google.com/maps/embed/v1/directions?key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg
				  &origin=<%=request.getAttribute("latitude")%>,<%=request.getAttribute("longitude")%>
				  &destination=<%=addressURL%>
				  &mode=<%=modeOfTransit%>" >
				</iframe>
            </div>
        </div>
        <div id="footer">&copy; Keenon, Jan, Amy, and Alanna</div>
	</div>
	
	<form name="Suggestion" action="GenerateSuggestionsServlet" method="post">
		<input type="hidden" id="latitude" name="latitude" value="<%=request.getAttribute("latitude")%>">	
		<input type="hidden" id="longitude" name="longitude" value="<%=request.getAttribute("longitude")%>">
		<input type="submit" value="Nah, meh"><br>
		
		<input type="radio" name="transport" value="walk" <%if (modeOfTransit.equals("walking")) { %>checked <%}%> >I'm walking<br>
		<input type="radio" name="transport" value="bike" <%if (modeOfTransit.equals("bicycling")) { %>checked <%}%>>I'm biking<br>
		<input type="radio" name="transport" value="car" <%if (modeOfTransit.equals("driving")) { %>checked <%}%>>I'm driving<br>
		<input type="radio" name="transport" value="bus" <%if (modeOfTransit.equals("transit")) { %>checked <%}%>>I'm taking the bus<br>
		
		<input type="checkbox" name="hungry" value="hungry" <%if (isHungry) { %>checked <%}%>>I'm hungry<br>
		<input type="checkbox" name="movie" value="movie" <%if (isMovie) { %>checked <%}%>>I want to see a movie<br>
		<input type="checkbox" name="outside" value="outside" <%if (isOutside) { %>checked <%}%>>I want to go outside<br>
		<input type="checkbox" name="arts" value="arts" <%if (isArts) { %>checked <%}%>>I'm cultured<br>
		
	</form>
	
	<form name="logout" action="LogoutServlet" method="post">
		<input type="submit" value="Log Out">
	</form>

</body>
</html>