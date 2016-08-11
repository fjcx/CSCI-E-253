<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Usage</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a>&nbsp> &nbspAdd Usage<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.useid" default="" type="string">
			<cfparam name="Form.sourceid" default ="" type="string">
			<cfparam name="Form.projid" default="" type="string">
			<cfparam name="Form.howused" default ="" type="string">
			<cfparam name="Form.dateused" default ="" type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="tbusage"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				insert into tbusage values (
					sequsage.nextval,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.howused#">,
					to_date(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.dateused#">,'MM-DD-YYYY'))
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
						order by 2
				</cfquery>
				<cfquery name="getSources"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select sourceid, sourcetitle
						from tbsource
						order by 2
				</cfquery>
				<cfquery name="getProjects"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select projid, projtitle
						from tbproject
						order by 2
				</cfquery>

				<div class="inputform">
					<h2>Insert a new usage</h2>
					<cfform action="addusage.cfm" method="post">
						<table>
							<tr>
								<td>SourceId: </td>
								<td>
									<cfif #Form.sourceid# NEQ "">
										<cfoutput>
											<input type="hidden" name="sourceid" value=#Form.sourceid#>#Form.sourceid# -- #getSource.sourcetitle#
										</cfoutput>
									<cfelse>
										<cfselect name="sourceid" type="text" required="yes" message="You must enter a source id" validate="required">
											<cfoutput query="getSources">
												<option value=#getSources.sourceid#>#getSources.sourceid#  -- #getSources.sourcetitle#</option>
											</cfoutput>
										</cfselect>
									</cfif>
								</td>
							</tr>
							<tr>
							<td>ProjId: </td>
							<td>
								<cfselect name="projid" type="text" required="yes" message="You must enter a project id" validate="required">
									<cfoutput query="getProjects">
										<option value=#getProjects.projid#>#getProjects.projid# -- #getProjects.projtitle#</option>
									</cfoutput>
								</cfselect>
							</td>
							</tr>
							<tr>
								<td>How Used: </td>
								<td>
									<cfinput name="howused" type="text" size="20" maxlength="20" required="yes" message="You must enter how source was used" validate="required">
								</td>
							</tr>
							<tr>
								<td>Date Used:</td>
								<td>
									<cfinput name="dateused" type="dateField" mask="MM-DD-YYYY" validate="date,required"   message="Please enter valid date" required="no">
								</td>
							</tr>
							<tr>
								<td><cfinput name="add" type="submit" value="Add Usage" class="positive"/></td>
								<td><cfinput name="reset" type="reset" value="Clear" class="negative"/></td>
							</tr>
						</table>
					</cfform>
				</div>
			</cfif> <!--- ### IsDefined("Form.add") --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
