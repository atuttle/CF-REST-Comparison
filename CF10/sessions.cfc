<cfcomponent restPath="/sessions">

	<!---
		NOTE: YOU MAY NOT USE APPLICATION-SPECIFIC MAPPINGS IN CF10 REST CFC'S!
	--->

	<cfset variables.sessionModel = createObject("component", "presentations.getting_rest._model.sessions") />

	<cffunction name="getAllSessions"
				access="remote"
				produces="application/json"
				returnType="array"
				httpMethod="GET">

		<cfset local.sessions = variables.sessionModel.getAllSessionsWithSpeakers() />
		<cfreturn local.sessions />

	</cffunction>

	<cffunction name="getSingleSession"
				access="remote"
				returntype="any"
				produces="application/json"
				httpMethod="GET"
				restPath="/{sessionSlug}"><!--- implies /sessions/{sessionSlug} --->
		<cfargument name="sessionSlug" />

		<cfset local.session = variables.sessionModel.getSession(arguments.sessionSlug, true) />

		<cfif isBoolean(local.session) and local.session eq false>
			<cfthrow errorCode="404" />
		</cfif>

		<cfreturn local.session />

	</cffunction>

</cfcomponent>
