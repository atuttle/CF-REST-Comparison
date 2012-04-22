<cfcomponent extends="MachII.mach-ii">

	<cfset this.name = "cfobjective_rest_machii" />
	<cfset this.sessionManagement = true />
	<cfset this.datasource = "cfobjective12_rest" />
	<cfset this.mappings = {} />
	<cfset this.mappings["/shared"] = expandPath( '../_model' ) />

	<cfset MACHII_CONFIG_MODE = 1 />

</cfcomponent>
