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
			data=variables.sessionModel.getAllSessionsWithSpeakers( "http://localhost/presentations/getting_rest/coldbox/index.cfm" ),
			type="json"
		);

	}

	function create(event,rc,prc){

		local.body = deserializeJson(event.getHttpContent());

		local.addResult = variables.sessionModel.create(
			local.body.title,
			local.body.desc,
			local.body.startDate,
			local.body.slug,
			local.body.speakerSlugs
		);

		if (local.addResult eq true){
			event.renderData(
				type=rc.format,
				statusCode=201
			);
		} else {
			event.renderData(
				data='"Unable to create session"',
				type=rc.format,
				statusCode = 500
			);
		}
	}

}
