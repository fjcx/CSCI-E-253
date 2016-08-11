<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Publication</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part4">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showpublications.cfm">Publications</a>&nbsp> &nbspAdd Keyword<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.pubid" default="AAA" type="string">
			<cfparam name="Form.pubname" default ="AA" type="string">
			<cfparam name="Form.pubtype" default =" " type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addPublication"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				insert into tbpublication values (
					seqpub.nextval,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubname#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubtype#">)
				</cfquery>

				<cflocation url="showpublications.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getPublication"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select pubid, pubname
						from tbpublication
						where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
				</cfquery>

				<div class="inputform">
					<cfif getPublication.RecordCount > 0>
						<h2>Invalid Primary Key, unable to add a new publication</h2>
					<cfelse>
						<h2>Insert a new publication</h2>
						<cfform action="addpublication.cfm" method="post">
							<table>
								<tr>
									<td>Publication Name: </td>
									<td>
										<cfinput name="pubname" type="text" size="50" maxlength="50" required="yes" message="You must enter a publication name" validate="required">
									</td>
								</tr>
								<tr>
									<td>Pub Type:</td>
									<td>
										<cfinput name="pubtype" type="text" size="30" maxlength="30" required="no">
									</td>
								</tr>
								<tr>
									<td><input name="add" type="submit" value="Add Publication" class="positive"/></td>
									<td><input name="reset" type="reset" value="Clear" class="negative"/></td>
								</tr>
							</table>
						</cfform>
					</cfif>
				</div>
			</cfif> <!--- ### IsDefined("Form.add") --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
