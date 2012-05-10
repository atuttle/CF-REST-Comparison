<cfcomponent restPath="/speakers">

	<!---
		NOTE: YOU MAY NOT USE APPLICATION-SPECIFIC MAPPINGS IN CF10 REST CFC'S!
	--->

	<cfset variables.speakerModel = createObject("component", "presentations.getting_rest._model.speakers") />

	<!---
		COLLECTION
	--->

	<cffunction name="getAllSpeakers"
				returntype="array"
				access="remote"
				produces="application/json"
				httpMethod="GET">

		<cfset local.speakers = variables.speakerModel.getAllSpeakersWithSessions() />
		<cfreturn local.speakers />

	</cffunction>

	<!---
		MEMBER
	--->

	<cffunction name="getSingleSpeaker"
				returntype="any"
				access="remote"
				produces="application/json"
				httpMethod="GET"
				restPath="/{speakerSlug}">

		<cfargument name="speakerSlug" restArgSource="path" />

		<cfset local.speaker = variables.speakerModel.getSpeaker(arguments.speakerSlug) />
		<cfreturn local.speaker />

	</cffunction>

</cfcomponent>
