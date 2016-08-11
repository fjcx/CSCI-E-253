<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Keywords</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part5">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showkeywords.cfm">Keywords</a><div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>
			<!--- all users can access, modify keywords as part of their day to day job --->
			
			<cfif IsDefined("Form.view")>
				<cfform action="viewkeyword.cfm" name="viewform" method="post">
					<cfoutput>
						<input type="hidden" name="keywordid" value=#Form.keywordid#>
					</cfoutput>
				</cfform>
				<script>document.viewform.submit();</script>
			<cfelseif IsDefined("Form.modify")>
				<cfform action="modifykeyword.cfm" name="modifyform" method="post">
					<cfoutput>
						<input type="hidden" name="keywordid" value=#Form.keywordid#>
					</cfoutput>
				</cfform>
				<script>document.modifyform.submit();</script>
			<cfelseif IsDefined("Form.new")>
				<cflocation url="addkeyword.cfm">
			<cfelseif IsDefined("Form.delete")>
				<cfquery name="deleteKeyword"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					delete from tbkeyword
						where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
				</cfquery>
			</cfif> <!--- ### IsDefined("Form.delete") --->

			<!--- ### Form Code Starts Here --->
			<cfquery name="getKeywords"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
				select *
					from tbkeyword
					order by 2
			</cfquery>
			<div class="inputform">
				<h2>Keywords</h2>
				<cfform action="showkeywords.cfm" method="post">
					<input name="view" type="submit" value="Detailed View" class="view"/>
					<input name="modify" type="submit" value="Modify" class="edit"/>
					<input name="new" type="submit" value="New" class="add"/>
					<input name="delete" type="submit" value="Delete" class="negative"/>
					<table id="keywordstable" class="tablesorter">
						<caption>Keywords associated with sources</caption>
						<thead>
							<tr>
								<th>KeywordId</th>
								<th>Keyword</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="getKeywords">
								<tr>
									<td><cfinput type="radio" name="keywordid" value=#keywordid# required="yes" validate="required" message="You must select a keyword">#keywordid#</td>
									<td>#keyword#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</cfform>
			</div>
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
