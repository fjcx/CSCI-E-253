<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Show Sources</title>
		<cfinclude template = "style.css">
		<cfinclude template = "tableStyle.cfm">
	</head>
	<body id="part1">
		<!--- include header --->
		<cfinclude template = "header.cfm">
		<div class="mainBody">
			<div class="breadcrumb">You are here: <a href="showsources.cfm">Sources</a><div id="logoutbtn"><a href="logout.cfm">Logout</a><cfoutput><br/>User: #GetAuthUser()#</cfoutput></div></div>
			<!--- all users can access, modify sources as part of their day to day job --->
			
			<cfparam name="Form.search" default="yes" type="string">
			<cfparam name="Form.empid" default="" type="string">
			<cfparam name="Form.projid" default="" type="string">
			<cfparam name="Form.sourcetopic" default="" type="string">
			<cfparam name="Form.pubtype" default="" type="string">
			
			<cfif IsDefined("Form.view")>
				<cfform action="viewsource.cfm" name="viewform" method="post">
					<cfoutput>
						<input type="hidden" name="sourceid" value=#Form.sourceid#>
					</cfoutput>
				</cfform>
				<script>document.viewform.submit();</script>
			<cfelseif IsDefined("Form.modify")>
				<cfform action="modifysource.cfm" name="modifyform" method="post">
					<cfoutput>
						<input type="hidden" name="sourceid" value=#Form.sourceid#>
					</cfoutput>
				</cfform>
				<script>document.modifyform.submit();</script>
			<cfelseif IsDefined("Form.addusage")>
				<cfform action="addusage.cfm" name="addusageform" method="post">
					<cfoutput>
						<input type="hidden" name="sourceid" value=#Form.sourceid#>
					</cfoutput>
				</cfform>
				<script>document.addusageform.submit();</script>
			<cfelseif IsDefined("Form.addkeyword")>
				<cfform action="addsrckeyassoc.cfm" name="addassocform" method="post">
					<cfoutput>
						<input type="hidden" name="sourceid" value=#Form.sourceid#>
					</cfoutput>
				</cfform>
				<script>document.addassocform.submit();</script>
			<cfelseif IsDefined("Form.new")>
				<cflocation url="addsource.cfm">
			<cfelseif IsDefined("Form.delete")>
				<cfquery name="deleteSource"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					delete from tbsource
						where sourceid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourceid#">
				</cfquery>
			</cfif> <!--- ### IsDefined("Form.delete") --->
			
			<!--- ### Form Code Starts Here --->
			<cfquery name="getProjects"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select projid, projtitle
					from tbproject
					order by 2
			</cfquery>
			<cfquery name="getEmployees"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select empid, emplastname, empfirstname
					from tbemployee
					order by 2
			</cfquery>
			<cfquery name="getTopics"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select distinct sourcetopic
					from tbsource
					order by 1
			</cfquery>
			<cfquery name="getPubsTypes"
				datasource="#Request.DSN#"
				username="#Request.username#"
				password="#Request.password#">
					select distinct pubtype
					from tbpublication
					order by 1
			</cfquery>
			<div class="inputform">
				<h2>Sources</h2>
				<form action="showsources.cfm" method="post">
					<table id="filtertable">
						<tr>
							<td>
								<strong>Entered by: </strong>
								<select name="empid">
										<option value=""></option>
									<cfoutput query="getEmployees">
										<cfif Form.empid EQ #empid#>
											<option value="#empid#" selected>#emplastname#, #empfirstname#</option>
										<cfelse>
											<option value="#empid#">#emplastname#, #empfirstname#</option>
										</cfif>
									</cfoutput>
								</select>
							</td>
							<td>
								<strong>Used in Project: </strong>
								<select name="projid">
										<option value=""></option>
									<cfoutput query="getProjects">
										<cfif Form.projid EQ #projid#>
											<option value="#projid#" selected>#projtitle#</option>
										<cfelse>
											<option value="#projid#">#projtitle#</option>
										</cfif>
									</cfoutput>
								</select>
							<td/>
						</tr>
						<tr>
							<td>
								<strong>Topic: </strong>
								<select name="sourcetopic">
										<option value=""></option>
									<cfoutput query="getTopics">
										<cfif Form.sourcetopic EQ #sourcetopic#>
											<option value="#sourcetopic#" selected>#sourcetopic#</option>
										<cfelse>
											<option value="#sourcetopic#">#sourcetopic#</option>
										</cfif>
									</cfoutput>
								</select>
							</td>
							<td>
								<strong>Pub Type: </strong>
								<select name="pubtype">
										<option value=""></option>
									<cfoutput query="getPubsTypes">
										<cfif Form.pubtype EQ #pubtype#>
											<option value="#pubtype#" selected>#pubtype#</option>
										<cfelse>
											<option value="#pubtype#">#pubtype#</option>
										</cfif>
									</cfoutput>
								</select>
							<td/>
						</tr>
						<tr>
							<td>
								<input type="hidden" name="search" value="yes" />
								<input name="submit" type="submit" Value="Filter Sources" class="view"/>
							<td/>
						</tr>
					</table>
				</form>
			</div>
			
	<cfif Form.search NEQ "no">
			<div class="ouputreport">
				<cfquery name="getSources"
					datasource="#Request.DSN#"
					username="#Request.username#"
					password="#Request.password#">
					
					select pubq.sourceid, pubq.sourcetitle, pubq.sourceauthor, to_char(pubq.datepublished,'YYYY-MM-DD') fdate, pubq.sourcetopic, pubq.enteredbyemp, pubq.pubname, le.empfirstname, le.emplastname
					from tbemployee le
					RIGHT OUTER JOIN
						(select jq.sourceid, jq.sourcetitle, jq.sourceauthor, jq.datepublished, jq.pubid, jq.sourcetopic, jq.enteredbyemp, ld.pubname
						from tbpublication ld
							RIGHT OUTER JOIN 
							(select a.sourceid, a.sourcetitle, a.sourceauthor, a.datepublished, a.pubid, a.sourcetopic, a.enteredbyemp
							from tbsource a
							<cfif Form.projid NEQ "">
							, tbusage b, tbproject c
							</cfif>
							<cfif Form.pubtype NEQ "">
							, tbpublication d
							</cfif>
							where
							<cfif Form.empid NEQ "">
								a.enteredbyemp = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.empid#"> and
							</cfif>
							<cfif Form.projid NEQ "">
								c.projid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.projid#"> 
								and c.projid = b.projid
								and b.sourceid = a.sourceid and
							</cfif>
							<cfif Form.sourcetopic NEQ "">
								a.sourcetopic = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.sourcetopic#"> and
							</cfif>
							<cfif Form.pubtype NEQ "">
								d.pubtype = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.pubtype#"> and d.pubid = a.pubid and
							</cfif>
								a.sourceid = a.sourceid) jq
							ON
							ld.pubid = jq.pubid) pubq
						ON
						le.empid = pubq.enteredbyemp
						order by 1
				</cfquery>
				<h2>Sources</h2>
				<cfform action="showsources.cfm" method="post">
					<input name="view" type="submit" value="Detailed View" class="view"/>
					<input name="new" type="submit" value="New" class="add"/>
					<input name="modify" type="submit" value="Modify" class="edit"/>
					<input name="delete" type="submit" value="Delete" class="negative"/>
					<input name="addusage" type="submit" value="Use Source" class="add"/>
					<input name="addkeyword" type="submit" value="Add Keyword" class="add"/>
					
					<table id="sourcestable" class="tablesorter">
						<caption>Sources used by the company</caption>
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
							<cfoutput query="getSources">
								<tr>
									<td><cfinput type="radio" name="sourceid" value=#sourceid# required="yes" validate="required" message="You must select a source">#sourceid#</td>
									<td>#sourcetitle#</td>
									<td>#sourceauthor#</td>
									<td>#fdate#</td>
									<td>#pubname#</td>
									<td>#sourcetopic#</td>
									<td>#emplastname#, #empfirstname#</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</cfform>
			</div>

		</cfif> <!--- ### Form.search NEQ "no" --->
			<!--- Nav back to home section --->
			<p class="lowernav"></p>
		</div>
		<!--- include footer --->
		<cfinclude template = "footer.cfm">
	</body>
</html>
