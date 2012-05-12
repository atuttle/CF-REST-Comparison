<cfcomponent extends="coldbox.system.Coldbox" output="false">
	<cfsetting enablecfoutputonly="yes">
	<cfset this.name = hash(getCurrentTemplatePath())>
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<cfset this.setClientCookies = true>



	<!--- presentation-specific --->
	<cfset this.datasource = "cfobjective12_rest" />
	<cfset this.mappings = {} />
	<cfset this.mappings["/model"] = expandPath('../_model') />




	<cfset COLDBOX_APP_ROOT_PATH = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset COLDBOX_APP_MAPPING   = "">
	<cfset COLDBOX_CONFIG_FILE   = "">
	<cfset COLDBOX_APP_KEY       = "">

	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<cfargument name="targetPage" type="string" required="true" />
		<cfif findNoCase('index.cfm', listLast(arguments.targetPage, '/'))>
			<cfset reloadChecks()>
			<cfset processColdBoxRequest()>
		</cfif>
		<cfreturn true>
	</cffunction>

</cfcomponent>
