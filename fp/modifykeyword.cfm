<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Modify Keyword</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part5">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showkeywords.cfm">Keyword</a>&nbsp> &nbspModify<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.keywordid" default="AAA" type="string">
			<cfparam name="Form.keyword" default ="" type="string">

			<cfif IsDefined("Form.update")>

				<!--- ### Action Code Starts Here --->

				<cfquery name="updateKeyword"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					update tbkeyword set
						keyword = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keyword#">
						where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
				</cfquery>

				<cflocation url="showkeywords.cfm">

			<cfelse>

				<!--- ### Form Code Starts Here --->
				<cfquery name="getKeyword"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
						from tbkeyword
						where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
				</cfquery>

				<cfif getKeyword.RecordCount GT 1>
					<h2>Invalid KeywordId, unable to find keyword to modify</h2>
				<cfelse>
					<h2>Modify Keyword</h2>
					<cfform action="modifykeyword.cfm" method="post">
						<table>
							<cfoutput>
								<tr>
									<td>KeywordId: </td>
									<td>
										<input type="hidden" name="keywordid" value="#getKeyword.keywordid#">
										#getKeyword.keywordid#
									</td>
								</tr>
								<tr>
									<td>Keyword: </td>
									<td>
										<cfinput name="keyword" type="text" size="40" maxlength="40" required="yes" message="You must enter a keyword" validate="required" value=#getKeyword.keyword#>
									</td>
								</tr>
								<tr>
									<td><input name="update" type="submit" value="Save Changes" class="positive"></td>
									<td><input name="reset" type="reset" value="Reset" class="negative"></td>
								</tr>
							</cfoutput>
						</table>
					</cfform>			
				</cfif> <!--- ### getKeyword.RecordCount < 1 --->
			</cfif> <!--- ### IsDefined("Form.update") --->

			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
