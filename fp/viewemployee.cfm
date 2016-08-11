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
			<div class="breadcrumb">You are here: <a href="showemployees.cfm">Employees</a>&nbsp> &nbspDetailed View<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.empid" default="" type="string">

			<cfquery name="getEmployee"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbemployee
					where empid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
			</cfquery>
			
			<cfif getEmployee.RecordCount GT 1>
				<h2>Invalid Employee Id, unable to find employee for detailed view</h2>
			<cfelse>
				<div class="inputform">
					<h2>Employee Detailed View</h2>
					<table>
						<cfoutput>
							<tr>
								<td>Emp Id: </td>
								<td>
									#getEmployee.empid#
								</td>
							</tr>
							<tr>
								<td>First Name: </td>
								<td>
									#getEmployee.empfirstname#
								</td>
							</tr>
							<tr>
								<td>Last Name:</td>
								<td>
									#getEmployee.emplastname#
								</td>
							</tr>
							<tr>
								<td>Email:</td>
								<td>
									#getEmployee.empemailemail#
								</td>
							</tr>
							<tr>
								<td>Phone:</td>
								<td>
									#getEmployee.empphone#
								</td>
							</tr>
						</cfoutput>
					</table>
				</div>
				<div class="outputform">
					<cfquery name="getEmployeeProjects"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select projid, projtitle, projtype, to_char(projdate,'YYYY-MM-DD') fdate, projowner
							from tbproject
							where projowner = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
							order by 1
					</cfquery>
					<cfquery name="getEmployeeSources"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select a.sourceid, a.sourcetitle, a.sourceauthor, to_char(a.datepublished,'YYYY-MM-DD') fdate, a.pubid, a.sourcetopic, a.enteredbyemp
							from tbsource a
							where enteredbyemp = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#">
							order by 1
					</cfquery>
					<table id="empprojtable" class="tablesorter">
						<caption>Projects owned by employee</caption>
						<thead>
							<tr>
								<th>ProjectId</th>
								<th>Title</th>
								<th>Type</th>
								<th>StartDate</th>
								<th>Owner</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getEmployeeProjects">
								<tr>
									<td>#getEmployeeProjects.projid#</td>
									<td>#getEmployeeProjects.projtitle#</td>
									<td>#getEmployeeProjects.projtype#</td>
									<td>#getEmployeeProjects.fdate#</td>
									<td>#getEmployeeProjects.projowner#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
					<table id="empsourcetable" class="tablesorter">
						<caption>Sources entered by employee</caption>
						<thead>
							<tr>
								<th>SourceId</th>
								<th>Title</th>
								<th>Author</th>
								<th>DatePublished</th>
								<th>Publication</th>
								<th>Topic</th>
								<th>EnteredBy</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getEmployeeSources">
								<tr>
									<td>#getEmployeeSources.sourceid#</td>
									<td>#getEmployeeSources.sourcetitle#</td>
									<td>#getEmployeeSources.sourceauthor#</td>
									<td>#getEmployeeSources.fdate#</td>
									<td>#getEmployeeSources.pubid#</td>
									<td>#getEmployeeSources.sourcetopic#</td>
									<td>#getEmployeeSources.enteredbyemp#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</div>
			</cfif> <!--- ### getEmployee.RecordCount < 1 --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
