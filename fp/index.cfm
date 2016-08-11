<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>FinalProject - Index Page</title>
	<cfinclude template = "style.css">
  </head>
  <body>
  <cfinclude template = "header.cfm">
	<div class="mainBody">
	<h2>Index Page</h2>
		<ul>
			<li><a href="./showemployees.cfm">Show Employees</a></li>
			<li><a href="./showpublications.cfm">Show Publications</a></li>
			<li><a href="./showprojects.cfm">Show Projects</a></li>
			<li><a href="./showsources.cfm">Show Sources</a></li>
			<li><a href="./showusages.cfm">Show Usages</a></li>
			<li><a href="./showpotentialuses.cfm">Show Potential Uses</a></li>
			<li><a href="./showkeywords.cfm">Show Keyword</a></li>
			<li><a href="./searchprojsource.cfm">Search Source by Project</a></li>
			<li><a href="./searchempsource.cfm">Search Source by Employee</a></li>
			<li><a href="./addemployee.cfm">Add Employee</a></li>
			<li><a href="./addpublication.cfm">Add Publication</a></li>
			<li><a href="./addproject.cfm">Add Project</a></li>
			<li><a href="./addsource.cfm">Add Source</a></li>
			<li><a href="./addusage.cfm">Add Usage</a></li>
			<li><a href="./addpotentialuse.cfm">Add Potential Use</a></li>
			<li><a href="./addkeyword.cfm">Add Keyword</a></li>
		</ul>

		<p class="lowernav"></p>		
	</div>
	<cfinclude template = "footer.cfm">
    </body>
</html>
