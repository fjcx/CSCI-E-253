<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Publications</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body>
		<!--- include header --->
		<div id="header">
			<h1 id="headerTitle">Final Project</h1>
			<div id="subhead">Student: Frank O'Connor <br/>Email: fjo.con@gmail.com <br/> 11/29/12<br/></div>
		</div>
		<div class="accent"></div>
		<div class="mainBody">
			<div class="breadcrumb">You are here: Logout</div>
			<div class="inputform">
				<!--- Show user BEFORE logout --->
				<h3><cfoutput>Before Logout: #getAuthUser()#</cfoutput></h3>
				<cflogout>

				<!--- Show user AFTER logout --->
				<h3><cfoutput>After logout: #getAuthUser()#</cfoutput></h3>
				<h3><a href="login.cfm">Back to Login Page</a></h3>
			</div>
			<!--- Nav back to home section --->
			<p class="lowernav">
				<a href="index.cfm">Index</a>
			</p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>