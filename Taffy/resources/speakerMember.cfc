// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/ben-nadel

component
extends="taffy.core.resource"
taffy_uri="/speakers/{speakerSlug}"
{

	variables.speakerModel = createObject("model.speakers");

	function get(speakerSlug)
	{
		local.result = variables.speakerModel.getSpeaker(arguments.speakerSlug);

		if (isSimpleValue(local.result) && local.result == false){

			return noData().withStatus(404, "Not Found");

		}else{

			return representationOf( local.result );

		}
	}

}
