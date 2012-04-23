<cfcomponent displayname="SessionsEndpoint"
             extends="MachII.endpoints.rest.BaseEndpoint"
             output="false"
             hint="RESTful endpoint for Sessions">

	<cfset variables.speakerModel = createObject( "shared.speakers" )/>

	<cffunction name="getAllSpeakers"
	            access="public"
	            output="false"
	            rest:uri="/speakers"
	            rest:method="GET">
		<cfargument name="event"
		            type="MachII.framework.Event"
		            required="true"/>

		<cfset local.speakers = variables.speakerModel.getAllSpeakersWithSessions() />

		<cfreturn serializeJson( local.speakers ) />

	</cffunction>

	<cffunction name="getSpeaker"
	            access="public"
	            output="false"
	            rest:uri="/speakers/{slug}"
	            rest:method="GET">
		<cfargument name="event"
		            type="MachII.framework.Event"
		            required="true"/>

		<cfset local.slug = event.getArg( "slug" )/>

		<cfset local.speaker = variables.speakerModel.getSpeaker(local.slug) />

		<cfreturn serializeJson( local.speaker ) />

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
