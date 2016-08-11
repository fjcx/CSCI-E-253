<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Project</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part3">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showprojects.cfm">Projects</a>&nbsp> &nbspAdd Project<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.projid" default="" type="string">
			<cfparam name="Form.projtitle" default ="" type="string">
			<cfparam name="Form.projtype" default="" type="string">
			<cfparam name="Form.estdays" default="" type="string">
			<cfparam name="Form.projdate" default ="" type="string">
			<cfparam name="Form.projowner" default =" " type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addProject"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				insert into tbproject values (
					seqproj.nextval,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projtitle#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projtype#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.estdays#">,
					to_date(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projdate#">,'MM-DD-YYYY'),
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projowner#">)
				</cfquery>

				<cflocation url="showprojects.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getProject"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select projid, projtitle
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

				<div class="inputform">
					<cfif getProject.RecordCount > 0>
						<h2>Invalid Primary Key, unable to add a new project</h2>
					<cfelse>
						<h2>Insert a new project</h2>
						<cfform action="addproject.cfm" method="post">
							<table>
							<tr>
								<td>Project Title: </td>
								<td>
									<cfinput name="projtitle" type="text" size="50" maxlength="50" required="yes" message="You must enter a project title" validate="required">
								</td>
							</tr>
							<tr>
								<td>Proj Type:</td>
								<td>
									<cfinput name="projtype" type="text" size="20" maxlength="20" required="no">
								</td>
							</tr>
							<tr>
								<td>Estimated Days:</td>
								<td>
									<cfinput name="estdays" type="text" size="3" maxlength="3" required="no">
								</td>
							</tr>
							<tr>
								<td>Proj Date:</td>
								<td>
									<cfinput name="projdate" type="dateField" mask="MM-DD-YYYY" validate="date,required"   message="Please enter valid date" required="no">
								</td>
							</tr>
							<tr>
							<td>Proj Owner:</td>
								<td>
									<cfselect name="projowner" required="yes"  message="You must enter a project owner" validate="required">
										<cfoutput query="getEmployees">
											<option value="#getEmployees.empid#">#getEmployees.emplastname#,#getEmployees.empfirstname#</option>
										</cfoutput>
									</cfselect>
								</td>
							</tr>
							<tr>
								<td><cfinput name="add" type="submit" value="Add Project" class="positive"/></td>
								<td><cfinput name="reset" type="reset" value="Clear" class="negative"/></td>
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
