<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Modify Project</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part3">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showprojects.cfm">Projects</a>&nbsp> &nbspModify<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.projid" default="AAA" type="string">
			<cfparam name="Form.projtitle" default ="AA" type="string">
			<cfparam name="Form.projtype" default ="" type="string">
			<cfparam name="Form.estdays" default ="" type="string">
			<cfparam name="Form.projdate" default ="" type="string">
			<cfparam name="Form.projowner" default ="" type="string">

			<cfif IsDefined("Form.update")>

				<!--- ### Action Code Starts Here --->
				<cfquery name="updateProject"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					update tbproject set
						projtitle = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projtitle#">,
						projtype = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projtype#">,
						estdays = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.estdays#">,
						projdate = to_date(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projdate#">,'MM-DD-YYYY'),
						projowner = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projowner#">
						where projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#">
				</cfquery>

				<cflocation url="showprojects.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getProject"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
						from tbproject
						where projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#">
				</cfquery>
				
				<cfquery name="getEmployees"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select empid, emplastname, empfirstname
					from tbemployee
					order by 2
				</cfquery>

				<cfif getProject.RecordCount GT 1>
					<h2>Invalid Project Id, unable to find project to modify</h2>
				<cfelse>
					<h2>Modify Project</h2>
					<cfform action="modifyproject.cfm" method="POST">
						<table>
							<cfoutput>
								<tr>
									<td>ProjectId: </td>
									<td>
										<input type="hidden" name="projid" value="#getProject.projid#">
										#getProject.projid#
									</td>
								</tr>
								<tr>
									<td>Project Title: </td>
									<td>
										<cfinput name="projtitle" type="text" size="50" maxlength="50" required="yes" message="You must enter a project title" validate="required" value=#getProject.projtitle#>
									</td>
								</tr>
								<tr>
									<td>Proj Type:</td>
									<td>
										<cfinput name="projtype" type="text" size="20" maxlength="20" required="no" value=#getProject.projtype#>
									</td>
								</tr>
								<tr>
									<td>Est Days:</td>
									<td>
										<cfinput name="estdays" type="text" size="20" maxlength="20" required="no" value=#getProject.estdays#>
									</td>
								</tr>
								<tr>
									<td>Proj Date:</td>
									<td>
										<cfinput name="projdate" type="dateField" mask="MM-DD-YYYY" validate="date,required" message="Please enter valid date" required="no">
									</td>
								</tr>
							</cfoutput>
								<tr>
									<td>Proj Owner:</td>
									<td>
										<cfselect name="projowner" required="yes"  message="You must enter a project owner" validate="required">
											<cfoutput query="getEmployees">
												<cfif #getProject.projowner# EQ #getEmployees.empid#>
													<option value="#getEmployees.empid#" selected>#getEmployees.emplastname#, #getEmployees.empfirstname#</option>
												<cfelse>
													<option value="#getEmployees.empid#">#getEmployees.emplastname#, #getEmployees.empfirstname#</option>
												</cfif>
											</cfoutput>
										</cfselect>							
									</td>
								</tr>
								<tr>
									<td>
										<input name="update" type="submit" value="Save Changes"  class="positive"/>
									</td>
									<td>
										<input name="reset" type="reset" value="Reset" class="negative"/>
									</td>
								</tr>
						</table>
					</cfform>			
				</cfif> <!--- ### getProject.RecordCount < 1 --->
			</cfif> <!--- ### IsDefined("Form.update") --->

			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
