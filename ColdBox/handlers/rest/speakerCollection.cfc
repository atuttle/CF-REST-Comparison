component{

	this.allowedMethods = {
		index = "GET"
	};

	variables.speakerModel = createObject("component", "model.speakers");

	function preHandler(event,action,rc,prc){
		//default format for all methods in this handler
		event.paramValue("format", "json");
	}

	function index(event,rc,prc){

		//courtesy of cfscript community components
		new header(name="X-COLDBOX-HANDLER",value="speakerCollection");

		event.renderData(
			data=variables.speakerModel.getAllSpeakersWithSessions(),
			type=rc.format
		);

	}

}
