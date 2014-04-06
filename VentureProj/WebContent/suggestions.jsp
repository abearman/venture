<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="venture.Activity" import="venture.Movie" import="venture.MinuteTime" import="org.json.*" import="venture.JSONUtil"%>
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
    
	<%
		Activity activity = (Activity)request.getAttribute("activity");	
		request.setAttribute("activity", activity);
		double lat = Double.parseDouble((String)request.getAttribute("latitude"));
		double lng = Double.parseDouble((String)request.getAttribute("longitude"));
		
		String modeOfTransit = (String)request.getAttribute("modeOfTransit");
		
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
    
    <script type="text/javascript">
        var loginBar;

        function toggleLoginBar() {
           loginBar.slideToggle(); 
        }
        
        var selectedId = "<%=request.getAttribute("modeOfTransit") %>";
        var isParks = <%=request.getAttribute("isParks").equals("YES")%>;
        var isBars = <%=request.getAttribute("isBars").equals("YES")%>;
        var isFood = <%=request.getAttribute("isFood").equals("YES")%>;
        var isMovies = <%=request.getAttribute("isMovies").equals("YES")%>;
        var isShopping = <%=request.getAttribute("isShopping").equals("YES")%>;
        var isOther = <%=request.getAttribute("isOther").equals("YES")%>;
        
        // radio for modes of transportation
        $(document).ready(function() {
            $('.tg').on('click',function() {
                $('#transpo-group > .tg > i').removeClass('selected').addClass('unselected');
                $(this).children('i').toggleClass('unselected selected');
                selectedId = $(this).children('i').attr('id');
                
                document.getElementById('map-frame').src = "https://www.google.com/maps/embed/v1/directions?key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg"
				  +"&origin=<%=request.getAttribute("latitude")%>,<%=request.getAttribute("longitude")%>"
				  +"&destination=<%=addressURL.toString()%>"
				  +"&mode="+selectedId;
            });
        });

        // Toggle for categories
        $(document).ready(function() {
            $('.cat-i').on('click',function() {
                $(this).children('i').toggleClass('unselected selected');
                var selected = $(this).children('i').hasClass('selected');
                var selectedCategory = $(this).children('i').attr('id');
                console.log(selectedCategory);
                if (selectedCategory === "parks") {
                	isParks = selected;
                }
				if (selectedCategory === "bars") {
                	isBars = selected;
                } 
				if (selectedCategory === "food") {
                	isFood = selected;
                } 
				if (selectedCategory === "movies") {
                	isMovies = selected;
                }
				if (selectedCategory === "shopping") {
                	isShopping = selected;
                } 
				if (selectedCategory === "other") {
                	isOther = selected;
                } 
            });
        });

    </script>
    
    <script>
    	var suggestionForm;
    	var acceptanceForm;
    	
    	function rejectSuggestion() {
    		document.getElementById('transport').value = selectedId;
    		document.getElementById('parksInput').value = isParks ? "YES" : "NO";
    		document.getElementById('barsInput').value = isBars ? "YES" : "NO";
    		document.getElementById('foodInput').value = isFood ? "YES" : "NO";
    		document.getElementById('moviesInput').value = isMovies ? "YES" : "NO";
    		document.getElementById('shoppingInput').value = isShopping ? "YES" : "NO";
    		document.getElementById('otherInput').value = isOther ? "YES" : "NO";
    		suggestionForm.submit();
    	}
    	
    	function acceptSuggestion() {
    		document.getElementById('accept-transport').value = selectedId;
    		acceptanceForm.submit();
    	}
    	
	    window.onload = function() {
	    	loginBar = $("#login-bar");
			suggestionForm = document.getElementById("suggestion");
			acceptanceForm = document.getElementById("accept");
		}
    
    </script>

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
                
       	<div id="login-bar">
            <span id="icon-bar">
                <span id="category-group">
                
                    <span class="cat-i"><i class="icon-tree-1 <%= ((String)request.getAttribute("isParks")).equals("YES") ? "selected" : "unselected" %>" title="Parks" id="parks"></i> </span>
                    <span class="cat-i"><i class="icon-bar <%= ((String)request.getAttribute("isBars")).equals("YES") ? "selected" : "unselected" %>" title="Bars" id="bars"></i> </span>
                    <span class="cat-i"><i class="icon-restaurant <%= ((String)request.getAttribute("isFood")).equals("YES") ? "selected" : "unselected" %>" title="Food" id="food"></i> </span>
                    <span class="cat-i"><i class="icon-cinema <%= ((String)request.getAttribute("isMovies")).equals("YES") ? "selected" : "unselected" %>" title="Movies" id="movies"></i> </span>
                    <span class="cat-i"><i class="icon-shop <%= ((String)request.getAttribute("isShopping")).equals("YES") ? "selected" : "unselected" %>" title="Shopping" id="shopping"></i> </span>
                    <span class="cat-i"><i class="icon-embassy <%= ((String)request.getAttribute("isOther")).equals("YES") ? "selected" : "unselected" %>" title="Other" id="other"></i></span>
                </span>
                <span id="transpo-group">
                    <span class="tg"><i class="icon-bicycle <%= ((String)request.getAttribute("modeOfTransit")).equals("bicycling") ? "selected" : "unselected" %>" title="Bike" id="bicycling"></i> </span>
                    <span class="tg"><i class="icon-bus <%= ((String)request.getAttribute("modeOfTransit")).equals("transit") ? "selected" : "unselected" %>" title="Public Transit" id="transit"></i> </span>
                    <span class="tg"><i class="icon-fuel <%= ((String)request.getAttribute("modeOfTransit")).equals("driving") ? "selected" : "unselected" %>" title="Drive" id="driving"></i> </span>
                    <span class="tg"><i class="icon-pitch <%= ((String)request.getAttribute("modeOfTransit")).equals("walking") ? "selected" : "unselected" %>" title="Walk" id="walking"></i></span>
                </span>
            </span>
        </div>
        
        <div id="content" style="width: 100%; position: relative;">
            <div id="event-photo-container">
                <div id="event-photo-wrapper">
                    <img src=<%=imageSrc%> />
                </div>
                <table id="vote-under" style="position: absolute; width: 100%; bottom: -30px;">
                    <tr>
                        <td><div class="circular-button" style="align:left" onclick="rejectSuggestion()"></div></td>
                        <td><div class="circular-button" style="align:right" onclick="acceptSuggestion()"></div></td>
                    </tr>
                </table>
                <table id="vote-wrapper" style="pointer-events: none; bottom: 45px;">
                    <tr>
                        <td><!--span id="vote-words-row">Meh...</span><br /--><i class="icon-thumbs-down"></i></td>
                        <td><!--span id="vote-words-row">Let's go!</span><br /--><i class="icon-thumbs-up"></i></td>
                    </tr>
                </table>
            </div>
            
            <%
            	//String url = "http://maps.googleapis.com/maps/api/distancematrix/json?origins=" + lat +"," + lng + "&destinations=" + addressURL + "&mode=" + modeOfTransit + "&sensor=false&key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg";	
            	String url = "http://maps.googleapis.com/maps/api/distancematrix/json?origins=" + lat + "," + lng + "&destinations=" + addressURL + "%20%20%20%20%20%20%20%20%20%20%20%20&mode=" + modeOfTransit + "&sensor=false&%20%20%20%20%20%20%20%20%20%20%20%20key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg";
            	System.out.println(url);
            	JSONObject jsonObj = JSONUtil.readJsonFromUrl(url);
            	System.out.println(jsonObj);
            	String distance = null;
            	String duration = null;
            	try {
            		distance = jsonObj.getJSONArray("rows").getJSONObject(0).getJSONArray("elements").getJSONObject(0).getJSONObject("distance").getString("text");
            		duration = jsonObj.getJSONArray("rows").getJSONObject(0).getJSONArray("elements").getJSONObject(0).getJSONObject("duration").getString("text");
            		System.out.println(distance);
            		System.out.println(duration);
            	}
            	catch (JSONException e) {
            		e.printStackTrace();
            	}
            	
            %>
            
            <div id="event-info">
	            <div id="event-title-container"><span id="event-title"><%=activity.title%></span></div>
	            <div id="event-details-container">
	                <span id="event-dist">
	                	<%
	                		if ((duration != null) && (distance != null)) {%>
	                			<%=duration%> | <%= distance%> away
	                		<%}
	                	%>
	                </span><br />
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
	        </div> 
	        
	        <% if (activity instanceof Movie && ((Movie)activity).trailer.length() > 0) { %>
	        <h1><%= ((Movie)activity).starttime.toString() %></h1>
	        <h3><%=(new MinuteTime()).toString() %> - Leave in <%= ((Movie)activity).starttime.minute - (new MinuteTime()).minute %> minutes</h3>
	        <iframe width="560" height="315" style="padding-bottom:20px;" src="<%=((Movie)activity).trailer%>" frameborder="0" allowfullscreen></iframe>
	        <% } %>
            
            <div id="map-container">
                <iframe
                  id="map-frame"
				  width="600"
				  height="450"
				  frameborder="0" style="border:0"
				  src="https://www.google.com/maps/embed/v1/directions?key=AIzaSyCwehTkiWGttVWmKbBYm-V0Lj1UvWCyzXg
				  &origin=<%=request.getAttribute("latitude")%>,<%=request.getAttribute("longitude")%>
				  &destination=<%=addressURL.toString()%>
				  &mode=<%=modeOfTransit%>" >
				</iframe>
            </div>
            
        </div>
        <div id="footer">&copy; Keenon, Jan, Amy, and Alanna</div>
      </div>
        <form style="display:none" name="Suggestion" id="suggestion" action="GenerateSuggestionsServlet" method="post">
			<input type="hidden" id="latitude" name="latitude" value="<%=request.getAttribute("latitude")%>">	
			<input type="hidden" id="longitude" name="longitude" value="<%=request.getAttribute("longitude")%>">
			<input type="hidden" id="rejectedid" name="rejectedid" value="<%=((Activity)request.getAttribute("activity")).id%>">
			<input type="hidden" name="transport" id="transport" value="drive"><br>
			<input type="hidden" name="parks" id="parksInput" value="NO"><br>
			<input type="hidden" name="bars" id="barsInput" value="NO"><br>
			<input type="hidden" name="food" id="foodInput" value="NO"><br>
			<input type="hidden" name="movies" id="moviesInput" value="NO"><br>
			<input type="hidden" name="shopping" id="shoppingInput" value="NO"><br>
			<input type="hidden" name="other" id="otherInput" value="NO"><br>	
		</form>
		<form style="display:none" name="Accept" id="accept" action="VentureOnServlet" method="post">
			<input type="hidden" id="latitude" name="latitude" value="<%=request.getAttribute("latitude")%>">	
			<input type="hidden" id="longitude" name="longitude" value="<%=request.getAttribute("longitude")%>">
			<input type="hidden" id="address" name="address" value="<%=((Activity)request.getAttribute("activity")).address%>">
			<input type="hidden" name="transport" id="accept-transport" value="drive">
			<input type="hidden" id="acceptedid" name="acceptedid" value="<%=((Activity)request.getAttribute("activity")).id%>">
		</form>
</body>
</html>