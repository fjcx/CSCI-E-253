<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Employees</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part2">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showemployees.cfm">Employees</a><div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>
			
			<cfparam name="rvar" default="none">
			<cfscript> 
				if (IsUserInRole("all")) {
					rvar="admin";
				}else if(IsUserInRole("restrict")){
					rvar="restrict";
				}
			</cfscript> 
			
			<cfif IsDefined("Form.view")>
				<cfform action="viewemployee.cfm" name="viewform" method="post">
					<cfoutput>
						<input type="hidden" name="empid" value=#Form.empid#>
					</cfoutput>
				</cfform>
				<script>document.viewform.submit();</script>
			<cfelseif IsDefined("Form.modify")>
				<cfform action="modifyemployee.cfm" name="modifyform" method="post">
					<cfoutput>
						<input type="hidden" name="empid" value=#Form.empid#>
					</cfoutput>
				</cfform>
				<script>document.modifyform.submit();</script>
			<cfelseif IsDefined("Form.new")>
				<cflocation url="addemployee.cfm">
			<cfelseif IsDefined("Form.delete")>
				<cfstoredproc procedure="delete_employee" 
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					<!--- There is one input parameter empid --->
					<cfprocparam type="IN" value="#Form.empid#" cfsqltype="CF_SQL_CHAR">
					<!--- One resultset is returned called "NEW_OWNER" --->
					<cfprocparam type="OUT" cfsqltype="CF_SQL_CHAR" variable="NEW_OWNER">
				</cfstoredproc>
				<cfoutput>
					Employee '#NEW_OWNER#' is the new owner for the deleted employees projects<br>
				</cfoutput>
			</cfif> <!--- ### IsDefined("Form.delete") --->
			
			<!--- ### Form Code Starts Here --->
			<cfquery name="getEmployees"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbemployee
					order by 1
			</cfquery>
			<div class="inputform">	
				<h2>Employees</h2>
				<cfform action="showemployees.cfm" method="post">
					<input name="view" type="submit" value="Detailed View" class="view"/>
					<!--- only allow admin users to modify, add or delete employees --->
					<cfif rvar EQ "admin">
						<input name="modify" type="submit" value="Modify" class="edit"/>
						<input name="new" type="submit" value="New" class="add"/>
						<input name="delete" type="submit" value="Delete" class="negative"/>
					</cfif> <!--- ### rvar EQ "admin" --->	
					<table id="employeetable" class="tablesorter">
						<caption>Employees hired by the company</caption>
						<thead>
							<tr>
								<th>EmployeeId</th>
								<th>First Name</th>
								<th>Last Name</th>
								<th>Email</th>
								<th>Phone</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getEmployees">		
								<tr>
									<td><cfinput type="radio" name="empid" value=#empid# required="yes" validate="required" message="You must select an employee">#empid#</td>
									<td>#empfirstname#</td>
									<td>#emplastname#</td>
									<td>#empemailemail#</td>
									<td>#empphone#</td>
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
