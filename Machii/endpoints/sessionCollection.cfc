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

		<cfset local.sessions = variables.sessionModel.getAllSessionsWithSpeakers() />

		<cfscript>
			arrayEach(local.sessions, function(sess) {
				sess["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/sessions/" & sess["slug"];
				arrayEach(sess["speakers"], function(speaker){
					speaker["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/speakers/" & speaker["slug"];
				});
			});
		</cfscript>

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

		<cfset local.session = variables.sessionModel.getSession(local.slug) />

		<cfscript>
			local.session["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/sessions/" & local.session["slug"];
			arrayEach(local.session["speakers"], function(speaker){
				speaker["url"] = "http://localhost/presentations/getting_rest/machii/index.cfm/speakers/" & speaker["slug"];
			});
		</cfscript>

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
