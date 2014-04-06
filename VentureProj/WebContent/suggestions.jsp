<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="venture.Activity" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

	<%
		Activity activity = (Activity)request.getAttribute("activity");
		System.out.println(request.getAttribute("latitude"));
		System.out.println(request.getAttribute("longitude"));
	%>

	<%= activity.title %>
	<%= activity.address %>
	<%= activity.phoneNumber %>
	<%= activity.latitude %>
	<%= activity.longitude %>
	<%= activity.website %>
	<%= activity.metadata %>
	
	<form name="Suggestion" action="GenerateSuggestionsServlet" method="post">
		<input type="hidden" id="latitude" name="latitude" value="<%=request.getAttribute("latitude")%>">	
		<input type="hidden" id="longitude" name="longitude" value="<%=request.getAttribute("longitude")%>">
		<input type="submit" value="Nah, meh">
	</form>
	
	<form name="logout" action="LogoutServlet" method="post">
		<input type="submit" value="Log Out">
	</form>

</body>
</html>