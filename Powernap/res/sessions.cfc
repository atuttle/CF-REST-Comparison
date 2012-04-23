component
extends="powernap.core.Resource"
{

	variables.sessionModel = createObject("model.sessions");

	function getSession(sessionSlug){

		local.result = variables.sessionModel.getSession(arguments.sessionSlug);

		//inject api-framework-specific url elements
		local.result["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/sessions/" & local.result.slug;

		//also link each speaker for each session
		arrayEach(local.result.speakers, function(speaker){
			speaker["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/speakers/" & speaker.slug;
		});

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

	function getAllSessionsWithSpeakers(){

		local.result = variables.sessionModel.getAllSessionsWithSpeakers();

		//inject api-framework-specific url elements
		arrayEach(local.result, function(sess){

			//add url for current session
			sess["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/sessions/" & sess.slug;

			//also link each speaker for each session
			arrayEach(sess.speakers, function(speaker){

				speaker["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/speakers/" & speaker.slug;

			});

		});

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

}
