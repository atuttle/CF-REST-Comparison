component
extends="powernap.core.Resource"
{

	variables.speakerModel = createObject("model.speakers");

	function getSpeaker(speakerSlug){

		local.result = variables.speakerModel.getSpeaker(arguments.speakerSlug);

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

	function getAllSpeakersWithSessions(){

		local.result = variables.speakerModel.getAllSpeakersWithSessions();

		local.representation = createObject("presentations.getting_rest.powernap.myRepresentation").init();
		local.representation.represents( local.result ).withStatus( 200 );

		return local.representation;

	}

}