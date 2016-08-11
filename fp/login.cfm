<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Publications</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body onload="document.login.userLogin.focus();">
		<!--- include header --->
		<div id="header">
			<h1 id="headerTitle">Final Project</h1>
			<div id="subhead">Student: Frank O'Connor <br/>Email: fjo.con@gmail.com <br/> 11/29/12<br/></div>
		</div>
		<div class="accent"></div>
		<div class="mainBody">
			<div class="breadcrumb">You are here: Login</div>

			<cfset myaction="showsources.cfm">
			<div class="inputform">
				<cfform action="#myaction#" id="login" method="post" preservedata="yes">
					<table>
					<tr><th colspan="2" class="highlight">Please Log In</th></tr>
					<tr>
						<td>Username:</td>
						<td>
							<cfinput type="text" name="userLogin" size="20" value="" maxlength="100" required="yes" message="Please enter your USERNAME">
							<input type="hidden" name="userLogin_required"/>
						</td>
					</tr>
						<tr>
							<td>Password:</td>
							<td>
								<cfinput type="password" name="userPassword" size="20" value="" maxlength="100" required="yes" message="Please enter your PASSWORD">
								<input type="hidden" name="userPassword_required"/>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="submit" name="login" value="Login" /></td>
					</tr>
					</table>
				</cfform>
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
