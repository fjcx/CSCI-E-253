<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Modify Employee</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part2">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showemployees.cfm">Employees</a>&nbsp> &nbspModify<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.empid" default="" type="string">
			<cfparam name="Form.empfirstname" default ="" type="string">
			<cfparam name="Form.emplastname" default ="" type="string">
			<cfparam name="Form.empemailemail" default ="" type="string">
			<cfparam name="Form.empphone" default ="" type="string">

			<cfif IsDefined("Form.update")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="updateEmployee"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					update tbemployee set
						empfirstname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empfirstname#">,
						emplastname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.emplastname#">,
						empemailemail = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empemailemail#">,
						empphone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empphone#">
						where empid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
				</cfquery>

				<cflocation url="showemployees.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getEmployee"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
						from tbemployee
						where empid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
				</cfquery>

				<cfif getEmployee.RecordCount GT 1>
					<h2>Invalid Employee Id, unable to find employee to modify</h2>
				<cfelse>
					<h2>Modify Employee</h2>
					<cfform action="modifyemployee.cfm" method="POST">
						<table>
							<cfoutput>
								<tr>
									<td>Emp Id: </td>
									<td>
										<input type="hidden" name="empid" value="#getEmployee.empid#">
										#getEmployee.empid#
									</td>
								</tr>
								<tr>
									<td>First Name: </td>
									<td>
										<cfinput name="empfirstname" type="text" size="40" maxlength="40" required="yes" message="You must enter a first name" validate="required" value=#getEmployee.empfirstname#>
									</td>
								</tr>
								<tr>
									<td>Last Name:</td>
									<td>
										<cfinput name="emplastname" type="text" size="40" maxlength="40" required="yes" message="You must enter a last name" validate="required" value=#getEmployee.emplastname#>
									</td>
								</tr>
								<tr>
									<td>Email:</td>
									<td>
										<cfinput name="empemailemail" type="text" size="50" maxlength="50" validate="email" required="no" message="You must enter a valid e-mail address" value=#getEmployee.empemailemail#>
									</td>
								</tr>
								<tr>
									<td>Phone:</td>
									<td>
										<cfinput name="empphone" type="text" size="20" maxlength="20" validate="telephone" required="no" message="Please enter a standard U.S. telephone number in the format 555-55-5555" value=#getEmployee.empphone#>
									</td>
								</tr>
								<tr>
									<td><input name="update" type="submit" value="Save Changes"  class="positive"/></td>
									<td><input name="reset" type="reset" value="Reset" class="negative"/></td>
								</tr>
							</cfoutput>
						</table>
					</cfform>			
				</cfif> <!--- ### getEmployee.RecordCount < 1 --->
			</cfif> <!--- ### IsDefined("Form.update") --->

			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
