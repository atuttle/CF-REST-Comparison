component
extends="powernap.core.Resource"
{

	variables.sessionModel = createObject("model.sessions");

	function getSession(sessionSlug){

		local.result = variables.sessionModel.getSession(arguments.sessionSlug, "http://localhost/presentations/getting_rest/powernap/index.cfm");

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

	function getAllSessionsWithSpeakers(){

		local.result = variables.sessionModel.getAllSessionsWithSpeakers( "http://localhost/presentations/getting_rest/powernap/index.cfm" );

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

}
