<cfcomponent output="false">
<cfscript>

	// I save the location of this CFC path to use resources located here
	variables.dirPath = getDirectoryFromPath( getMetadata(this).path );

	function configure(){

		this.relax = {
			title = "CFObjective REST: ColdBox",
			description = "Exposing Ben Nadel's secret hobbies",
			entryPoint = {
				dev  = "http://localhost/presentations/getting_rest/coldbox/index.cfm",
				production = "http://localhost/presentations/getting_rest/coldbox/index.cfm"
			},
			extensionDetection = true,
			validExtensions = "xml,json",
			throwOnInvalidExtension = false
		};

		/************************************** GLOBAL PARAMS +  HEADERS *********************************************/

		// Global API Headers
		//globalHeader(name="apikey",description="The apikey needed for request authentication.",required=true);

		// Global API Parameters
		//globalParam(name="paramKey",description="The parameter key needed for request authentication.",required=true);

		/************************************** RESOURCES *********************************************/


		resource(pattern="/sessions",handler="rest.sessionCollection",action={
			GET="index", POST="create"
		});
		resource(pattern="/sessions/:sessionSlug",handler="rest.sessionMember",action={
			GET="read"
		});

		resource(pattern="/speakers",handler="rest.speakerCollection",action={
			GET="index"
		});
		resource(pattern="/speakers/:speakerSlug",handler="rest.speakerMember",action={
			GET="read"
		});


	}
</cfscript>
</cfcomponent>