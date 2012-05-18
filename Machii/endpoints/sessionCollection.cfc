<cfcomponent displayname="SessionsEndpoint"
             extends="MachII.endpoints.rest.BaseEndpoint"
             output="false"
             hint="RESTful endpoint for Sessions">

	<cfset variables.sessionModel = createObject( "shared.sessions" )/>

	<cffunction name="getAllSessions"
	            access="public"
	            output="false"
	            rest:uri="/sessions"
	            rest:method="GET">
		<cfargument name="event"
		            type="MachII.framework.Event"
		            required="true"/>

		<cfset local.sessions = variables.sessionModel.getAllSessionsWithSpeakers( "http://localhost/presentations/getting_rest/machii/index.cfm" ) />

		<cfreturn serializeJson( local.sessions )/>

	</cffunction>

	<cffunction name="getSingleSession"
	            access="public"
	            output="false"
	            rest:uri="/sessions/{slug}"
	            rest:method="GET">
		<cfargument name="event"
		            type="MachII.framework.Event"
		            required="true"/>

		<cfset local.slug = event.getArg( "slug" )/>

		<cfset local.session = variables.sessionModel.getSession(local.slug, "http://localhost/presentations/getting_rest/machii/index.cfm") />

		<cfreturn serializeJson(local.session) />

	</cffunction>

	<cffunction name="createSession"
				access="public"
				output="false"
				returnType="void"
				rest:uri="/sessions"
				rest:method="POST">
		<cfargument name="event"
					type="MachII.framework.event"
					required="true" />

		<cfswitch expression="#isJson(event._requestBody)#">
			<cfcase value="true">
				<cfset local.args = deserializeJSON(event._requestBody) />
			</cfcase>
			<cfcase value="false">
				<cfset local.args = event.getArgs() />
			</cfcase>
		</cfswitch>

		<cfset local.addResult = variables.sessionModel.create(
			local.args.title,
			local.args.desc,
			local.args.startDate,
			local.args.slug,
			local.args.speakerSlugs
		) />

		<cfif local.addResult eq true>
			<cfheader statuscode="201" statustext="Success" />
		<cfelse>
			<cfheader statuscode="500" statustext="Unable to create session" />
		</cfif>

	</cffunction>


	<cffunction name="onException"
	            output="false">
		<cfargument name="event"
		            type="MachII.framework.Event"
		            required="true"/>
		<cfargument name="cfcatch"
		            type="any"
		            required="true"/>

		<cfdump var="#cfcatch.getMessage()#"/>
		<cfdump var="#cfcatch.getDetail()#"/>
		<cfabort/>

	</cffunction>

</cfcomponent>
