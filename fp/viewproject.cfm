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
			<div class="breadcrumb">You are here: <a href="showprojects.cfm">Projects</a>&nbsp> &nbspDetailed View<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.projid" default="" type="string">

			<cfquery name="getProject"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select projid, projtitle, projtype, estdays, to_char(projdate,'YYYY-MM-DD') fdate, projowner
					from tbproject
					where projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#">
			</cfquery>
			
			<cfif getProject.RecordCount GT 1>
				<h2>Invalid Project Id, unable to find project for detailed view</h2>
			<cfelse>
				<div class="inputform">
					<h2>Project Detailed View</h2>
					<table>
						<cfoutput>
							<tr>
								<td>ProjectId: </td>
								<td>#getProject.projid#</td>
							</tr>
							<tr>
								<td>Title: </td>
								<td>#getProject.projtitle#</td>
							</tr>
							<tr>
								<td>Type:</td>
								<td>#getProject.projtype#</td>
							</tr>
							<tr>
								<td>EstDays:</td>
								<td>#getProject.estdays#</td>
							</tr>
							<tr>
								<td>StartDate:</td>
								<td>#getProject.fdate#</td>
							</tr>
							<tr>
								<td>Owner:</td>
								<td>#getProject.projowner#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
				<div class="outputform">
					<cfquery name="getProjectSources"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select a.sourceid, a.sourcetitle, a.sourceauthor, to_char(a.datepublished,'YYYY-MM-DD') fdate, a.pubid, a.sourcetopic, a.enteredbyemp
							from tbsource a, tbusage b, tbproject c
							where c.projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#"> 
							and c.projid = b.projid
							and b.sourceid = a.sourceid							
							order by 1
					</cfquery>
					<table id="empsourcetable" class="tablesorter">
						<caption>Sources used in Project</caption>
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
							<cfoutput query="getProjectSources">
								<tr>
									<td>#getProjectSources.sourceid#</td>
									<td>#getProjectSources.sourcetitle#</td>
									<td>#getProjectSources.sourceauthor#</td>
									<td>#getProjectSources.fdate#</td>
									<td>#getProjectSources.pubid#</td>
									<td>#getProjectSources.sourcetopic#</td>
									<td>#getProjectSources.enteredbyemp#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</div>
			</cfif> <!--- ### getProject.RecordCount < 1 --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
