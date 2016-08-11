<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Add Source Keyword Association</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a>&nbsp> &nbspAdd Source-Keyword Association<div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>

			<cfparam name="Form.keywordid" default="" type="string">
			<cfparam name="Form.sourceid" default ="" type="string">

			<cfif IsDefined("Form.add")>
				<!--- ### Action Code Starts Here --->
				<cfquery name="addSrcKeyAssoc"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					insert into tbsourcekeyassociation values (
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">)
				</cfquery>

				<cflocation url="showsources.cfm">
			<cfelse>
				<!--- ### Form Code Starts Here --->
				<cfquery name="getKeywords"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select *
					from tbkeyword 
					where not exists( 
						select k.keywordid, k.keyword
							from tbkeyword k, tbsourcekeyassociation a
							where k.keywordid = a.keywordid
							and a.sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">)
					order by 1
				</cfquery>
				
				<cfquery name="getSrcKeyAssoc"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select keywordid, sourceid
						from tbsourcekeyassociation
						where keywordid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.keywordid#">
						and sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
				</cfquery>
				
				<cfquery name="getSources"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					select sourceid, sourcetitle
						from tbsource
						order by 2
				</cfquery>
				
				<div class="inputform">
					<cfif getKeywords.RecordCount LT 1>
						<!--- case where all possible keywords are already associated with the source --->
						<h2>Unable to find keywords to associate, please create some more</h2>
					<cfelse>
						<h2>Insert a new Source-Keyword Association</h2>
					</cfif>

					<cfform action="addsrckeyassoc.cfm" method="post">
						<table>
							<tr>
								<td>KeywordId: </td>
								<td>								
									<cfselect name="keywordid" type="text" required="yes" message="You must select a keyword" validate="required">
										<cfoutput query="getKeywords">
											<option value=#getKeywords.keywordid#>#keyword#</option>
										</cfoutput>
									</cfselect>
								</td>
							</tr>
							<tr>
								<td>SourceId: </td>
								<td>
									<cfif #Form.sourceid# NEQ "">
										<cfoutput>
											<input type="hidden" name="sourceid" value=#Form.sourceid#>#Form.sourceid#
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
								<td><input name="add" type="submit" value="Add SrcKeyAssoc" class="positive"/></td>
								<td><input name="reset" type="reset" value="Clear" class="negative"/></td>
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
