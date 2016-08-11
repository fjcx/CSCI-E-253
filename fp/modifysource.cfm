<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Modify Source</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a>&nbsp> &nbspModify<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.sourceid" default="AAA" type="string">
			<cfparam name="Form.sourcetitle" default ="AA" type="string">
			<cfparam name="Form.sourcecontent" default ="" type="string">
			<cfparam name="Form.sourceauthor" default ="" type="string">
			<cfparam name="Form.datepublished" default ="" type="string">
			<cfparam name="Form.enteredbyemp" default ="" type="string">
			<cfparam name="Form.sourcetopic" default ="" type="string">
			<cfparam name="Form.sourceurl" default ="" type="string">
			<cfparam name="Form.pubid" default ="" type="string">

			<cfif IsDefined("Form.update")>

				<!--- ### Action Code Starts Here --->

				<cfquery name="updateSource"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					update tbsource set
						sourcetitle = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcetitle#">,
						sourcecontent = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcecontent#">,
						sourceauthor = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceauthor#">,
						datepublished = to_date(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.datepublished#">,'MM-DD-YYYY'),
						enteredbyemp = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.enteredbyemp#">,
						sourcetopic = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcetopic#">,
						sourceurl = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceurl#">,
						pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
						where sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
				</cfquery>

				<cflocation url="showsources.cfm">

			<cfelse>

				<!--- ### Form Code Starts Here --->

				<cfquery name="getSource"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
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

				<cfif getSource.RecordCount GT 1>
					<h2>Invalid SourceId, unable to find source to modify</h2>
				<cfelse>
					<h2>Modify Source</h2>
					<cfform action="modifysource.cfm" method="post">
						<table>
							<cfoutput>
								<tr>
									<td>SourceId: </td>
									<td>
										<input type="hidden" name="sourceid" value="#getSource.sourceid#">
										#getSource.sourceid#
									</td>
								</tr>
								<tr>
									<td>Source Title: </td>
									<td>
										<cfinput name="sourcetitle" type="text" size="50" maxlength="50" required="yes" message="You must enter a source title" validate="required" value=#getSource.sourcetitle#>
									</td>
								</tr>
								<tr>
									<td>Content:</td>
									<td>
										<cfinput name="sourcecontent" type="text" size="250" maxlength="250" required="yes" message="You must enter some source content" validate="required" value=#getSource.sourcecontent#>
									</td>
								</tr>
								<tr>
									<td>Author:</td>
									<td>
										<cfinput name="sourceauthor" type="text" size="40" maxlength="40" required="no" value=#getSource.sourceauthor#>
									</td>
								</tr>
								<tr>
									<td>Source Published Date:</td>
									<td>
										<cfinput name="datepublished" type="dateField" mask="MM-DD-YYYY" validate="date,required"   message="Please enter valid date" required="no">
									</td>
								</tr>
							</cfoutput>
								<tr>
									<td>Entered by (Employee): </td>
									<td>
										<cfselect name="enteredbyemp" required="yes"  message="You must enter a source owner" validate="required">
											<cfoutput query="getEmployees">
												<cfif #getSource.enteredbyemp# EQ #getEmployees.empid#>
													<option value="#getEmployees.empid#" selected>#getEmployees.emplastname#, #getEmployees.empfirstname#</option>
												<cfelse>
													<option value="#getEmployees.empid#">#getEmployees.emplastname#, #getEmployees.empfirstname#</option>
												</cfif>
											</cfoutput>
										</cfselect>
									</td>
								</tr>
							<cfoutput>
								<tr>
									<td>Source Topic:</td>
									<td>
										<cfinput name="sourcetopic" type="text" size="20" maxlength="20" required="no" value=#getSource.sourcetopic#>
									</td>
								</tr>
								<tr>
									<td>Source Link:</td>
									<td>
										<cfinput name="sourceurl" type="text" size="150" maxlength="150" required="yes" message="You must enter a link to the source" validate="required" value=#getSource.sourceurl#>
									</td>
								</tr>
							</cfoutput>
								<tr>
									<td>Publication:</td>
									<td>
										<cfselect name="pubid" required="yes"  message="You must enter a source publication" validate="required">
											<cfoutput query="getPublications">
												<cfif #getSource.pubid# EQ #getPublications.pubid#>
													<option value="#getPublications.pubid#" selected>#getPublications.pubname# -- #getPublications.pubtype#</option>
												<cfelse>
													<option value="#getPublications.pubid#">#getPublications.pubname# -- #getPublications.pubtype#</option>
												</cfif>
											</cfoutput>
										</cfselect>
									</td>
								</tr>
								<tr>
									<td><input name="update" type="submit" value="Save Changes"  class="positive"/></td>
									<td><input name="reset" type="reset" value="Reset" class="negative"/></td>
								</tr>
						</table>
					</cfform>			
				</cfif> <!--- ### getSource.RecordCount < 1 --->
			</cfif> <!--- ### IsDefined("Form.update") --->

			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
