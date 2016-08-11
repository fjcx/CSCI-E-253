<cfcomponent output="false">

   <!--- ########## Oracle Variables ########## --->

	<cfparam name="Request.DSN" default="cscie253">
	<cfparam name="Request.username" default="foconnor">
	<cfparam name="Request.password" default="4522">

   <!--- ########## Name this application ########## --->
   
   <cfset this.name="SourceSearch">
   
   <!--- ########## Turn on Session Management ########## --->

   <cfset this.sessionManagement=true>
  
   <!--- ########## Set Application Variables ########## --->

   <cffunction name="onApplicationStart" output="false" returnType="void">
      <cfset APPLICATION.dataSource = "cscie253">
	  <cfset APPLICATION.username="foconnor">
	  <cfset APPLICATION.password="4522">
      <cfset APPLICATION.companyName = "Final Project">
   </cffunction>

   <!--- ########## Protect the whole application --->

   <cffunction name="onRequestStart" output="false" returnType="void">
      <cfinclude template="forceUserLogin.cfm">
   </cffunction>

</cfcomponent>
