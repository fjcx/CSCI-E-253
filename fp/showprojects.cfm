<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Projects</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part3">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showprojects.cfm">Projects</a><div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>
			
			<cfparam name="rvar" default="none">
			<cfscript> 
				if (IsUserInRole("all")) {
					rvar="admin";
				}else if(IsUserInRole("restrict")){
					rvar="restrict";
				}
			</cfscript> 
			
			<cfif IsDefined("Form.view")>
				<cfform action="viewproject.cfm" name="viewform" method="post">
					<cfoutput>
						<input type="hidden" name="projid" value=#Form.projid#>
					</cfoutput>
				</cfform>
				<script>document.viewform.submit();</script>
			<cfelseif IsDefined("Form.modify")>
				<cfform action="modifyproject.cfm" name="modifyform" method="post">
					<cfoutput>
						<input type="hidden" name="projid" value=#Form.projid#>
					</cfoutput>
				</cfform>
				<script>document.modifyform.submit();</script>
			<cfelseif IsDefined("Form.new")>
				<cflocation url="addproject.cfm">
			<cfelseif IsDefined("Form.delete")>
				<cfquery name="deleteProject"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					delete from tbproject
						where projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#">
				</cfquery>
			</cfif> <!--- ### IsDefined("Form.delete") --->	
			
			<!--- ### Form Code Starts Here --->
			<cfquery name="getProjects"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select p.projid, p.projtitle, p.projtype, to_char(p.projdate,'YYYY-MM-DD') fdate, p.estdays, e.emplastname, e.empfirstname
					from tbproject p
					LEFT JOIN tbemployee e
					ON p.projowner = e.empid
					order by 1
			</cfquery>
			<div class="inputform">
				<h2>Projects</h2>
				<cfform action="showprojects.cfm" method="post">
					<input name="view" type="submit" value="Detailed View" class="view"/>
					<!--- only allow admin users to modify, add or delete employees --->
					<cfif rvar EQ "admin">
						<input name="modify" type="submit" value="Modify" class="edit"/>
						<input name="new" type="submit" value="New" class="add"/>
						<input name="delete" type="submit" value="Delete" class="negative"/>
					</cfif> <!--- ### rvar EQ "admin" --->	
					
					<table id="projectstable" class="tablesorter">
						<caption>Company Projects</caption>
						<thead>
							<tr>
								<th>ProjectId</th>
								<th>Title</th>
								<th>Type</th>
								<th>EstDays</th>
								<th>StartDate</th>
								<th>Owner</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getProjects">
								<tr>
									<td><cfinput type="radio" name="projid" value=#projid# required="yes" validate="required" message="You must select a project">#projid#</td>
									<td>#projtitle#</td>
									<td>#projtype#</td>
									<td>#estdays#</td>
									<td>#fdate#</td>
									<td>#emplastname#, #empfirstname#</td>
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
