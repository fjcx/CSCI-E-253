<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Modify Publication</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part4">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showpublications.cfm">Publications</a>&nbsp> &nbspModify<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.pubid" default="AAA" type="string">
			<cfparam name="Form.pubname" default ="AA" type="string">
			<cfparam name="Form.pubtype" default ="" type="string">

			<cfif IsDefined("Form.update")>

				<!--- ### Action Code Starts Here --->

				<cfquery name="updatePublication"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					update tbpublication set
						pubname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubname#">,
						pubtype = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubtype#">
						where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
				</cfquery>

				<cflocation url="showpublications.cfm">

			<cfelse>

				<!--- ### Form Code Starts Here --->

				<cfquery name="getPublication"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
						from tbpublication
						where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
				</cfquery>

				<cfif getPublication.RecordCount GT 1>
					<h2>Invalid PublicationId, unable to find publication to modify</h2>
				<cfelse>
					<h2>Modify Publication</h2>
					<cfform action="modifypublication.cfm" method="post">
						<table>
							<cfoutput>
								<tr>
									<td>PublicationId: </td>
									<td>
										<input type="hidden" name="pubid" value="#getPublication.pubid#">
										#getPublication.pubid#
									</td>
								</tr>
								<tr>
									<td>Publication Name: </td>
									<td>
										<cfinput name="pubname" type="text" size="50" maxlength="50" required="yes" message="You must enter a publication name" validate="required" value=#getPublication.pubname#>
									</td>
								</tr>
								<tr>
									<td>Publication Type:</td>
									<td>
										<cfinput name="pubtype" type="text" size="30" maxlength="30" required="no" value=#getPublication.pubtype#>
									</td>
								</tr>
								<tr>
									<td><input name="update" type="submit" value="Save Changes"  class="positive"/></td>
									<td><input name="reset" type="reset" value="Reset" class="negative"/>
									</td>
								</tr>
							</cfoutput>
						</table>
					</cfform>			
				</cfif> <!--- ### getPublication.RecordCount < 1 --->
			</cfif> <!--- ### IsDefined("Form.update") --->

			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
