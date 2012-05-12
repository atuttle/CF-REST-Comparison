component
extends="taffy.core.resource"
taffy_uri="/sessions/{sessionSlug}"
{

	variables.sessionModel = createObject("model.sessions");

	function get(sessionSlug)
	{

		local.session = variables.sessionModel.getSession(arguments.sessionSlug, "http://localhost/presentations/getting_rest/Taffy/index.cfm");

		if ( isSimpleValue(local.session) && local.session == false){

			return noData().withStatus(404, "Not Found");

		}else{

			return representationOf( local.session );

		}
	}

}
