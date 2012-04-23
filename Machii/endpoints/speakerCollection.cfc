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

		<cfscript>
			arrayEach(local.speakers, function(speaker) {
				speaker["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/speakers/" & speaker["slug"];
				arrayEach(speaker["sessions"], function(sess){
					sess["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/sessions/" & sess["slug"];
				});
			});
		</cfscript>

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

		<cfscript>
			local.speaker["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/speakers/" & local.speaker["slug"];
			arrayEach(local.speaker["sessions"], function(sess){
				sess["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/sessions/" & sess["slug"];
			});
		</cfscript>

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
