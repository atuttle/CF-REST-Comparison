<cfcomponent restPath="/sessions">

	<!---
		NOTE: YOU MAY NOT USE APPLICATION-SPECIFIC MAPPINGS IN CF10 REST CFC'S!
	--->

	<cfset variables.sessionModel = createObject("component", "presentations.getting_rest._model.sessions") />

	<!---
		COLLECTION
	--->

	<cffunction name="getAllSessions"
				access="remote"
				produces="application/json"
				returnType="array"
				httpMethod="GET">

		<cfset local.sessions = variables.sessionModel.getAllSessionsWithSpeakers( "http://localhost/rest/getting_rest_preso" ) />
		<cfreturn local.sessions />

	</cffunction>

	<!---
		MEMBER
	--->

	<cffunction name="getSingleSession"
				access="remote"
				returntype="any"
				produces="application/json"
				httpMethod="GET"
				restPath="/{sessionSlug}"><!--- implies /sessions/{sessionSlug} --->

		<cfargument name="sessionSlug" restArgSource="path" />

		<cfset local.session = variables.sessionModel.getSession(arguments.sessionSlug, "http://localhost/rest/getting_rest_preso") />

		<cfif isBoolean(local.session) and local.session eq false>
			<cfthrow errorCode="404" />
		</cfif>

		<cfreturn local.session />

	</cffunction>

	<!---
		POST: JSON
	--->

	<cffunction name="createSessionFromJson"
				access="remote"
				produces="application/json"
				consumes="application/json"
				returnType="void"
				httpMethod="POST">

		<!---
			With Content-Type: application/json and the following <cfargument> tag,
			CF deserializes the body and stores the result in the argument.
		--->
		<cfargument name="body" />

		<cfset local.addResult = variables.sessionModel.create(
			arguments.body.title,
			arguments.body.desc,
			arguments.body.startDate,
			arguments.body.slug,
			arguments.body.speakerSlugs
		) />

		<cfif local.addResult eq true>
			<!---
				Using restSetResponse instead of returning a value?
				Make sure your function has returnType="void"!
			--->
			<cfset restSetResponse({
				status: 201,
				content: '"success"' <!--- notice both quotes: returning json! --->
			}) />
		<cfelse>
			<cfset restSetResponse({
				status: 500,
				content: '"Unable to create session"'
			}) />
		</cfif>

	</cffunction>

	<!---
		POST: FORM
	--->

	<cffunction name="createSessionFromForm"
				access="remote"
				produces="application/json"
				consumes="application/x-www-form-urlencoded"
				returnType="void"
				httpMethod="POST">

		<cfargument name="title" restArgSource="form" />
		<cfargument name="desc" restArgSource="form" />
		<cfargument name="startDate" restArgSource="form" />
		<cfargument name="slug" restArgSource="form" />
		<cfargument name="speakerSlugs" restArgSource="form" />

		<!--- split slugs from comma-delimited list to array --->
		<cfset arguments.speakerSlugs = listToArray(arguments.speakerSlugs) />

		<cfset local.addResult = variables.sessionModel.create(
			arguments.title,
			arguments.desc,
			arguments.startDate,
			arguments.slug,
			arguments.speakerSlugs
		) />

		<cfif local.addResult eq true>
			<cfset restSetResponse({
				status: 201,
				content: '"success"'
			}) />
		<cfelse>
			<cfset restSetResponse({
				status: 500,
				content: '"Unable to create session"'
			}) />
		</cfif>

	</cffunction>

</cfcomponent>
