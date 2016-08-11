<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Source</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a>&nbsp> &nbspAdd Source<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.sourceid" default="" type="string">
			<cfparam name="Form.sourcetitle" default ="" type="string">
			<cfparam name="Form.sourcecontent" default="" type="string">
			<cfparam name="Form.sourceauthor" default="" type="string">
			<cfparam name="Form.datepublished" default ="" type="string">
			<cfparam name="Form.enteredbyemp" default ="" type="string">
			<cfparam name="Form.sourcetopic" default ="" type="string">
			<cfparam name="Form.sourceurl" default ="" type="string">
			<cfparam name="Form.pubid" default ="" type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addSource"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				insert into tbsource values (
					seqsource.nextval,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcetitle#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcecontent#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceauthor#">,
					to_date(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.datepublished#">,'MM-DD-YYYY'),
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.enteredbyemp#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcetopic#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceurl#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">)
				</cfquery>

				<cflocation url="showsources.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getSource"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select sourceid, sourcetitle
						from tbsource
						where sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
				</cfquery>
				<cfquery name="getEmployees"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select empid, emplastname, empfirstname
						from tbemployee
						order by 2
				</cfquery>
				<cfquery name="getPublications"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select pubid, pubname, pubtype
						from tbpublication
						order by 2
				</cfquery>

				<div class="inputform">
					<cfif getSource.RecordCount > 0>
						<h2>Invalid Primary Key, unable to add a new source</h2>
					<cfelse>
						<h2>Insert a new source</h2>
						<cfform action="addsource.cfm" method="post">
							<table>
							<tr>
								<td>Source Title: </td>
								<td>
									<cfinput name="sourcetitle" type="text" size="50" maxlength="50" required="yes" message="You must enter a source title" validate="required">
								</td>
							</tr>
							<tr>
								<td>Content: </td>
								<td>
									<cfinput name="sourcecontent" type="text" size="250" maxlength="250" required="yes" message="You must enter some source content" validate="required">
								</td>
							</tr>
							<tr>
								<td>Author:</td>
								<td>
									<cfinput name="sourceauthor" type="text" size="40" maxlength="40" required="no">
								</td>
							</tr>
							<tr>
								<td>Source Published Date:</td>
								<td>
									<cfinput name="datepublished" type="dateField" mask="MM-DD-YYYY" validate="date,required"   message="Please enter valid date" required="no">
								</td>
							</tr>
							<tr>
								<td>Entered by (Employee):</td>
								<td>
									<cfselect name="enteredbyemp" required="yes"  message="You must enter a source owner" validate="required">
										<cfoutput query="getEmployees">
											<option value="#getEmployees.empid#"> #getEmployees.emplastname#,#getEmployees.empfirstname#</option>
										</cfoutput>
									</cfselect>
								</td>
							</tr>
							<tr>
								<td>Source Topic:</td>
								<td>
									<cfinput name="sourcetopic" type="text" size="20" maxlength="20" required="no">
								</td>
							</tr>
							<tr>
								<td>Source Link:</td>
								<td>
									<cfinput name="sourceurl" type="text" size="150" maxlength="150" required="yes" message="You must enter a link to the source" validate="required">
								</td>
							</tr>
							<tr>
								<td>Publication:</td>
								<td>
									<cfselect name="pubid" required="yes"  message="You must enter a source publication" validate="required">
										<cfoutput query="getPublications">
											<option value="#getPublications.pubid#">#getPublications.pubname# -- #getPublications.pubtype#</option>
										</cfoutput>
									</cfselect>
								</td>
							</tr>
							<tr>
								<td><cfinput name="add" type="submit" value="Add Source" class="positive"/></td>
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
