// http://localhost/presentations/getting_rest/powernap/api.cfm/speakers/Ben-Nadel

component
extends="powernap.core.Resource"
{

	variables.speakerModel = createObject("model.speakers");

	function getSpeaker(speakerSlug){

		local.result = variables.speakerModel.getSpeaker(arguments.speakerSlug);

		//inject api-framework-specific url elements
		local.result["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/speakers/" & local.result.slug;

		//also link each speaker for each session
		arrayEach(local.result.sessions, function(sess){
			sess["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/sessions/" & sess.slug;
		});

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

	function getAllSpeakersWithSessions(){

		local.result = variables.speakerModel.getAllSpeakersWithSessions();

		//inject api-framework-specific url elements
		arrayEach(local.result, function(speaker){

			//add url for current session
			speaker["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/speakers/" & speaker.slug;

			//also link each speaker for each session
			arrayEach(speaker.sessions, function(sess){

				sess["url"] = "http://localhost/presentations/getting_rest/powernap/api.cfm/sessions/" & sess.slug;

			});

		});

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

}
