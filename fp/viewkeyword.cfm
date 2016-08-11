<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>View Keyword</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part5">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showkeywords.cfm">Keywords</a>&nbsp> &nbspDetailed View<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.keywordid" default="" type="string">

			<cfquery name="getKeyword"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbkeyword
					where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
			</cfquery>
			
			<cfif getKeyword.RecordCount GT 1>
				<h2>Invalid KeywordId, unable to find keyword for detailed view</h2>
			<cfelse>
				<div class="inputform">
					<h2>Keyword Detailed View</h2>
					<table>
						<cfoutput>
							<tr>
								<td>KeywordId: </td>
								<td>#getKeyword.keywordid#</td>
							</tr>
							<tr>
								<td>Keyword: </td>
								<td>#getKeyword.keyword#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
				<div class="outputform">
					<cfquery name="getKeywordSources"
						datasource="#Request.DSN#"
						username="#Request.username#"
						password="#Request.password#">
						select *
							from tbsource s, tbsourcekeyassociation a
							where a.keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
							and s.sourceid = a.sourceid
							order by 1
					</cfquery>
					<table id="keywordsourcetable" class="tablesorter">
						<caption>Sources associated with Keyword</caption>
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
							<cfoutput query="getKeywordSources">
								<tr>
									<td>#getKeywordSources.sourceid#</td>
									<td>#getKeywordSources.sourcetitle#</td>
									<td>#getKeywordSources.sourceauthor#</td>
									<td>#getKeywordSources.datepublished#</td>
									<td>#getKeywordSources.keywordid#</td>
									<td>#getKeywordSources.sourcetopic#</td>
									<td>#getKeywordSources.enteredbyemp#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</div>
			</cfif> <!--- ### getKeyword.RecordCount < 1 --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
