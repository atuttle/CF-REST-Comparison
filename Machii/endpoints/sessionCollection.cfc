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

		<cfreturn serializeJson( variables.sessionModel.getAllSessionsWithSpeakers() )/>

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

		<cfset local.session = variables.sessionModel.getSession(local.slug) />

		<cfreturn serializeJson(local.session) />

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