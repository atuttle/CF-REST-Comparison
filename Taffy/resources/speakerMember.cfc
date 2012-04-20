// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/ben-nadel

component
extends="taffy.core.resource"
taffy_uri="/speakers/{speakerSlug}"
{

	variables.speakerModel = createObject("model.speakers");

	function get(speakerSlug)
	{
		local.speaker = variables.speakerModel.getSpeaker(arguments.speakerSlug);

		if (isSimpleValue(local.speaker) && local.speaker == false){

			return noData().withStatus(404, "Not Found");

		}else{

			//inject api-framework-specific url elements
			local.speaker["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/" & speaker.slug;

			//also link each speaker for each session
			arrayEach(local.speaker.sessions, function(session){

				session["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/" & session.slug;

			});

			return representationOf( local.speaker );

		}
	}

}
