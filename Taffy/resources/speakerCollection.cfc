// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers

component
extends="taffy.core.resource"
taffy_uri="/speakers"
{

	variables.speakerModel = createObject("model.speakers");

	function get()
	{
		local.speakers = variables.speakerModel.getAllSpeakersWithSessions();

		//inject api-framework-specific url elements
		arrayEach(local.speakers, function(speaker){

			//add url for current session
			speaker["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/" & speaker.slug;

			//also link each speaker for each session
			arrayEach(speaker.sessions, function(session){

				session["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/" & session.slug;

			});

		});

		return representationOf( local.speakers );
	}

}
