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

	function createSession(title,desc,startDate,slug,speakerSlugs){

		local.addResult = variables.sessionModel.create(
			arguments.title,
			arguments.desc,
			arguments.startDate,
			arguments.slug,
			arguments.speakerSlugs
		);

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();

		switch (local.addResult){
			case false:
				local.representation.withStatus( 500 );
				break;
			default:
				local.representation.withStatus( 201 );
		}

		return local.representation;

	}

}
