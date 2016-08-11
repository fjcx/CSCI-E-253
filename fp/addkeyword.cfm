<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Keyword</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part5">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showkeywords.cfm">Keywords</a>&nbsp> &nbspAdd Keyword<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.keywordid" default="AAA" type="string">
			<cfparam name="Form.keyword" default ="" type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addKeyword"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					insert into tbkeyword values (
						seqkeyword.nextval,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keyword#">)
				</cfquery>

				<cflocation url="showkeywords.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getKeyword"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select keywordid, keyword
						from tbkeyword
						where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
				</cfquery>
				
				<div class="inputform">
					<cfif getKeyword.RecordCount > 0>
						<h2>Invalid Primary Key, unable to add a new keyword</h2>
					<cfelse>
						<h2>Insert a new keyword</h2>
						<cfform action="addkeyword.cfm" method="post">
							<table>
								<tr>
									<td>Keyword: </td>
									<td>
										<cfinput name="keyword" type="text" size="40" maxlength="40" required="yes" message="You must enter a keyword value" validate="required">
									</td>
								</tr>
								<tr>
									<td>
										<input name="add" type="submit" value="Add Keyword" class="positive"/>
									</td>
									<td>
										<input name="reset" type="reset" value="Clear" class="negative"/>
									</td>
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
