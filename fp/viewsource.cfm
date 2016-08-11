<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>View Source</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a>&nbsp> &nbspDetailed View<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.empid" default="" type="string">

			<cfquery name="getSource"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbsource
					where sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
			</cfquery>
			
			<cfif getSource.RecordCount GT 1>
				<h2>Invalid Source Id, unable to find source for detailed view</h2>
			<cfelse>
				<div class="inputform">
					<h2>Source Detailed View</h2>
					<table>
						<cfoutput>
							<tr>
								<td>SourceId: </td>
								<td>#getSource.sourceid#</td>
							</tr>
							<tr>
								<td>SourceTitle: </td>
								<td>#getSource.sourcetitle#</td>
							</tr>
							<tr>
								<td>Content:</td>
								<td>#getSource.sourcecontent#</td>
							</tr>
							<tr>
								<td>Author:</td>
								<td>#getSource.sourceauthor#</td>
							</tr>
							<tr>
								<td>DatePublished:</td>
								<td>#getSource.datepublished#</td>
							</tr>
							<tr>
								<td>Entered by (Employee):</td>
								<td>#getSource.enteredbyemp#</td>
							</tr>
							<tr>
								<td>Topic:</td>
								<td>#getSource.sourcetopic#</td>
							</tr>
							<tr>
								<td>Source URL:</td>
								<td>#getSource.sourceurl#</td>
							</tr>
							<tr>
								<td>Publication:</td>
								<td>#getSource.pubid#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
				<div class="outputform">
					<cfquery name="getAssocKeywords"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select k.keywordid, k.keyword
							from tbsourcekeyassociation a, tbkeyword k
							where a.sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
							and k.keywordid = a.keywordid
							order by 1
					</cfquery>
					<cfquery name="getSourceUsage"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select a.useid, a.howused, to_char(a.dateused,'YYYY-MM-DD') fdate, b.projtitle
							from tbusage a, tbproject b
							where a.sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
							and a.projid = b.projid
							order by 1
					</cfquery>
					
					<table id="keysourcetable" class="tablesorter">
						<caption>Keywords associated with Source</caption>
						<thead>
							<tr>
								<th>KeywordId</th>
								<th>Keyword</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getAssocKeywords">
								<tr>
									<td>#getAssocKeywords.keywordid#</td>
									<td>#getAssocKeywords.keyword#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
					<table id="sourceusagetable" class="tablesorter">
						<caption>Uses of this Source</caption>
						<thead>
							<tr>
								<th>UseId</th>
								<th>Project</th>
								<th>Howused</th>
								<th>DateUsed</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getSourceUsage">
								<tr>
									<td>#getSourceUsage.useid#</td>
									<td>#getSourceUsage.projtitle#</td>
									<td>#getSourceUsage.howused#</td>
									<td>#getSourceUsage.fdate#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</div>
			</cfif> <!--- ### getSource.RecordCount < 1 --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
