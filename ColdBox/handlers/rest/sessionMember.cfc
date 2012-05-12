component{

	this.allowedMethods = {
		read = "GET"
	};

	variables.sessionModel = createObject("component", "model.sessions");

	function read(event,rc,prc){

		//courtesy of cfscript community components
		new header(name="X-COLDBOX-HANDLER",value="sessionMember");

		//default the format value for this method
		event.paramValue("format", "json");

		event.renderData(
			data=variables.sessionModel.getSession(rc.sessionSlug),
			type=rc.format
		);
	}

}
