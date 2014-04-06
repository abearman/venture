<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=no", target-densitydpi=device-dpi />
    <link href='http://fonts.googleapis.com/css?family=Codystar|Lobster|Londrina+Outline|Lato|Merriweather' rel='stylesheet' type='text/css'>
	<link href="public/icons/css/fontello.css" rel='stylesheet' type="text/css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <link rel="stylesheet" href="public/style.css" />
    <title>Venture | Create Account</title>

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
    
    <script type="text/javascript">
        function checkForm()//error checking to make sure fields are filled out properly
        {
        if(document.frm.username.value == "") {
            alert("Please enter a username.");
        }
        else if(document.frm.password.value == "") {
            alert("Please enter a password.");
        }
        if (document.frm.username.value.length > 255) {
            alert("Please make sure your username is less than 255 characters.");
        }
        else if(document.frm.password.value.length > 255) {
            alert("Please make sure your password is less than 255 characters.");
        }
        else {
            document.frm.submit();
        }
        }
    </script>
</head>

<body>
    <div id="content-wrapper">
        <div id="header">
            <a href="index.html"><span id="hdr">Venture</span></a>
            <div onclick="toggleLoginBar();" id="login-icon" style="position: absolute; right: 12px; text-align: right; display: inline;">
                <div style="position: relative; top: -8px;" class="dropdown">
                    <span id="hdr"></span>
                </div>
            </div>
        </div>
		<div id="content" style="width: 100%; min-height: 100%; margin-bottom: -80px;">
            <div class="form-signin container" style="max-width: 500px; padding: 20px 30px; margin: 0 auto;">
                <form role="form" name="frm" class="form-signin" action="AccountCreationServlet" method="post">
                    <div class="form-group">
                        <h3>Username already exists. <br />Try a different one.</h3><br />
                        <div><input name="username" type="text" class="input-block-level form-control" placeholder="User Name"></div>
                        <div><input name="email" type="text" class="input-block-level form-control" placeholder="Email" ></div>
                        <div><input name="password" type="password" class="input-block-level form-control" placeholder="Password"></div>
                        <input type="button" class="btn btn-large btn-primary btn-block" value="Submit" onclick="checkForm()">
                        <div><br /><a href="login.html">Log in</a></div>
                    </div>
                </form>
            </div>
            <div id="footer" style="position: absolute; bottom:0px; height: 75px;">&copy; Keenon, Jan, Amy, and Alanna</div>
        </div>
	</div>
</body>
</html>
