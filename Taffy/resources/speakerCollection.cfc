// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers

component
extends="taffy.core.resource"
taffy_uri="/speakers"
{

	variables.speakerModel = createObject("model.speakers");

	function get()
	{
		local.speakers = variables.speakerModel.getAllSpeakersWithSessions();

		return representationOf( local.speakers );
	}

}
