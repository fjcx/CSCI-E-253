<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Employee</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part2">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showemployees.cfm">Employees</a>&nbsp> &nbspAdd Employee<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.empid" default="" type="string">
			<cfparam name="Form.empfirstname" default ="" type="string">
			<cfparam name="Form.emplastname" default ="" type="string">
			<cfparam name="Form.empemailemail" default ="" type="string">
			<cfparam name="Form.empphone" default ="" type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addEmployee"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				insert into tbemployee values (
				seqemp.nextval,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empfirstname#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.emplastname#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empemailemail#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empphone#">)
				</cfquery>

				<cflocation url="showemployees.cfm">
			<cfelse>

				<!--- ### Form Code Starts Here --->
				<cfquery name="getEmployee"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select empid
						from tbemployee
						where empid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
				</cfquery>

				<div class="inputform">
					<cfif getEmployee.RecordCount > 0>
						<h2>Invalid Primary Key, unable to add a new employee</h2>
					<cfelse>
						<h2>Insert a new employee</h2>
						<cfform action="addemployee.cfm" method="post">
							<table>
								<tr>
									<td>First Name: </td>
									<td>
									<cfinput name="empfirstname" type="text" size="40" maxlength="40" required="yes" message="You must enter a first name" validate="required">
									</td>
								</tr>
								<tr>
									<td>Last Name:</td>
									<td>
									<cfinput name="emplastname" type="text" size="40" maxlength="40" required="yes" message="You must enter a last name" validate="required">
									</td>
								</tr>
								<tr>
									<td>Email:</td>
									<td>
									<cfinput name="empemailemail" type="text" size="50" maxlength="50" validate="email" required="no" message="You must enter a valid e-mail address">
									</td>
								</tr>
								<tr>
									<td>Phone:</td>
									<td>
									<cfinput name="empphone" type="text" size="20" maxlength="20" validate="telephone" required="no" message="Please enter a standard U.S. telephone number in the format 555-55-5555">
									</td>
								</tr>
								<tr>
									<td>
										<input name="add" type="submit" value="Add Employee" class="positive"/>
									</td>
									<td>
										<input name="reset" type="reset" value="Clear" class="negative"/>
									</td>
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
