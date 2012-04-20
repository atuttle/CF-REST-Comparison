component
extends="powernap.core.Resource"
{

	variables.sessionModel = createObject("model.sessions");

	function getSession(sessionSlug){

		local.result = variables.sessionModel.getSession(arguments.sessionSlug);

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

	function getAllSessionsWithSpeakers(){

		local.result = variables.sessionModel.getAllSessionsWithSpeakers();

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

}