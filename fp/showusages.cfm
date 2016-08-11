<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Show Projects</title>
	<cfinclude template = "style.css">
  </head>
  <body>
  <!--- include header --->
  <cfinclude template = "header.cfm">
	<div class="mainBody">
		<!--- ### Form Code Starts Here --->
		<cfquery name="getUsages"
				 datasource="#Request.DSN#"
				 username="#Request.username#"
				 password="#Request.password#">
		  select *
			 from tbusage
			 order by 1
		</cfquery>
		<div class="inputform">
			<h2>Usages</h2>
			
			<ul>
				<cfoutput query="getUsages">		
					<li>#useid#--#sourceid#--#projid#--#howused#--#dateused#</li>
				</cfoutput>
			</ul>
			
		</div>
		
		<!--- Nav back to home section --->
		<p class="lowernav">
			<a href="index.cfm">Index</a>
		</p>
	</div>
	<!--- include footer --->
	<cfinclude template = "footer.cfm">
    </body>
</html>
