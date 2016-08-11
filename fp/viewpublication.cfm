<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>View Publication</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part4">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showpublications.cfm">Publications</a>&nbsp> &nbspDetailed View<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.pubid" default="" type="string">

			<cfquery name="getPublication"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbpublication
					where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">
			</cfquery>
			
			<cfif getPublication.RecordCount GT 1>
				<h2>Invalid PublicationId, unable to find publication for detailed view</h2>
			<cfelse>
				<div class="inputform">
					<h2>Publication Detailed View</h2>
					<table>
						<cfoutput>
							<tr>
								<td>ProjectId: </td>
								<td>#getPublication.pubid#</td>
							</tr>
							<tr>
								<td>Title: </td>
								<td>#getPublication.pubname#</td>
							</tr>
							<tr>
								<td>Type:</td>
								<td>#getPublication.pubtype#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
				<div class="outputform">
					<cfquery name="getPublicationSources"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select a.sourceid, a.sourcetitle, a.sourceauthor, to_char(a.datepublished,'YYYY-MM-DD') fdate, a.pubid, a.sourcetopic, a.enteredbyemp
							from tbsource a
							where pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#">						
							order by 1
					</cfquery>
					<cfquery name="getPublicationProjects"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select distinct c.projid, c.projtitle, c.projtype, to_char(c.projdate,'YYYY-MM-DD') fdate, c.projowner
							from tbsource a, tbusage b, tbproject c
							where a.pubid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubid#"> 
							and b.sourceid = a.sourceid	
							and c.projid = b.projid						
							order by 1
					</cfquery>
					<table id="pubsourcetable" class="tablesorter">
						<caption>Sources referenced from Publication</caption>
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
							<cfoutput query="getPublicationSources">
								<tr>
									<td>#getPublicationSources.sourceid#</td>
									<td>#getPublicationSources.sourcetitle#</td>
									<td>#getPublicationSources.sourceauthor#</td>
									<td>#getPublicationSources.fdate#</td>
									<td>#getPublicationSources.pubid#</td>
									<td>#getPublicationSources.sourcetopic#</td>
									<td>#getPublicationSources.enteredbyemp#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
					<table id="pubprojtable" class="tablesorter">
						<caption>Projects referencing Sources from Publication</caption>
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
							<cfoutput query="getPublicationProjects">
								<tr>
									<td>#getPublicationProjects.projid#</td>
									<td>#getPublicationProjects.projtitle#</td>
									<td>#getPublicationProjects.projtype#</td>
									<td>#getPublicationProjects.fdate#</td>
									<td>#getPublicationProjects.projowner#</td>
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
