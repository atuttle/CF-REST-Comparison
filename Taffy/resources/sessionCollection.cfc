// http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions

component
extends="taffy.core.resource"
taffy_uri="/sessions"
{

	variables.sessionModel = createObject("model.sessions");

	function get()
	{
		local.sessions = variables.sessionModel.getAllSessionsWithSpeakers();

		//inject api-framework-specific url elements
		arrayEach(local.sessions, function(session){

			//add url for current session
			session["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/" & session.slug;

			//also link each speaker for each session
			arrayEach(session.speakers, function(speaker){

				speaker["url"] = "http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/" & speaker.slug;

			});

		});

		return representationOf( local.sessions );
	}

	//speakers must exist before their sessions can be inserted
	function post(title,desc,startDate,slug,speakerSlugs)
	{
		local.addResult = variables.sessionModel.create(
			arguments.title,
			arguments.desc,
			arguments.startDate,
			arguments.slug,
			arguments.speakerSlugs
		);

		if (local.addResult == true){

			return noData().withStatus(201, "Session Created");

		} else {

			return noData().withStatus(500, "Unable to create session");

		}
	}

}
