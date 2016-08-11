<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Publications</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part4">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showpublications.cfm">Publications</a><div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>
			
			<cfparam name="rvar" default="none">
			<cfscript> 
				if (IsUserInRole("all")) {
					rvar="admin";
				}else if(IsUserInRole("restrict")){
					rvar="restrict";
				}
			</cfscript>
			<cfif IsDefined("Form.view")>
				<cfform action="viewpublication.cfm" name="viewform" method="post">
					<cfoutput>
						<input type="hidden" name="pubid" value=#Form.pubid#>
					</cfoutput>
				</cfform>
				<script>document.viewform.submit();</script>
			<cfelseif IsDefined("Form.modify")>
				<cfform action="modifypublication.cfm" name="modifyform" method="post">
					<cfoutput>
						<input type="hidden" name="pubid" value=#Form.pubid#>
					</cfoutput>
				</cfform>
				<script>document.modifyform.submit();</script>
			<cfelseif IsDefined("Form.new")>
				<cflocation url="addpublication.cfm">
			<cfelseif IsDefined("Form.delete")>
				<cfquery name="deletePublication"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					delete from tbpublication
						where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
				</cfquery>
			</cfif> <!--- ### IsDefined("Form.delete") --->
			
			<!--- ### Form Code Starts Here --->
			<cfquery name="getPubs"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbpublication
					order by 1
			</cfquery>
			<div class="inputform">
				<h2>Publications</h2>
				<cfform action="showpublications.cfm" method="post">
					<input name="view" type="submit" value="Detailed View" class="view"/>
					<!--- only allow admin users to modify, add or delete employees --->
					<cfif rvar EQ "admin">
						<input name="modify" type="submit" value="Modify" class="edit"/>
						<input name="new" type="submit" value="New" class="add"/>
						<input name="delete" type="submit" value="Delete" class="negative"/>
					</cfif> <!--- ### rvar EQ "admin" --->
					<table id="publicationstable" class="tablesorter">
						<caption>Verified publications used by the company</caption>
						<thead>
							<tr>
								<th>PublicationId</th>
								<th>Name</th>
								<th>Type</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getPubs">
								<tr>
									<td><cfinput type="radio" name="pubid" value=#pubid# required="yes" validate="required" message="You must select a publication">#pubid#</td>
									<td>#pubname#</td>
									<td>#pubtype#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</cfform>
			</div>
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
