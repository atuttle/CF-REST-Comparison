component
extends="taffy.core.resource"
taffy_uri="/speakers/{speakerSlug}"
{

	variables.speakerModel = createObject("model.speakers");

	function get(speakerSlug)
	{
		local.speaker = variables.speakerModel.getSpeaker(arguments.speakerSlug, "http://localhost/presentations/getting_rest/taffy/index.cfm");

		if (isSimpleValue(local.speaker) && local.speaker == false){

			return noData().withStatus(404, "Not Found");

		}else{

			return representationOf( local.speaker );

		}
	}

}
