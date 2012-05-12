component{

	this.allowedMethods = {
		index = "GET"
		,create = "POST"
	};

	variables.sessionModel = createObject("component", "model.sessions");

	function preHandler(event,action,rc,prc){
		//default format for all methods in this handler
		event.paramValue("format", "json");
	}

	function index(event,rc,prc){

		//courtesy of cfscript community components
		new header(name="X-COLDBOX-HANDLER",value="sessionCollection");

		event.renderData(
			data=variables.sessionModel.getAllSessionsWithSpeakers(),
			type="json"
		);

	}

	function create(event,rc,prc){

		local.body = deserializeJson(event.getHttpContent());
	}

}
