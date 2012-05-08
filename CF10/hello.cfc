<cfcomponent restPath="/hello">

	<cffunction name="useHTTPHeader" access="remote" returntype="struct" httpMethod="GET">

		<cfreturn { msg = "hello" } />

	</cffunction>

</cfcomponent>
