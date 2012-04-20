// http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/StampingScrapping-Designs-Stamps-Dies

component
extends="taffy.core.resource"
taffy_uri="/sessions/{sessionSlug}"
{

	variables.sessionModel = createObject("model.sessions");

	function get(sessionSlug){

		local.session = variables.sessionModel.getSession(arguments.sessionSlug, true);

		if ( isSimpleValue(local.session) && local.session == false){

			return noData().withStatus(404, "Not Found");

		}else{

			//inject api-framework-specific url elements
			local.session["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/" & local.session.slug;

			//also link each speaker for each session
			arrayEach(local.session.speakers, function(speaker){

				speaker["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/" & speaker.slug;

			});

			return representationOf( local.session );

		}
	}

}
