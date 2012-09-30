component{

	this.allowedMethods = {
		read = "GET"
	};

	variables.speakerModel = createObject("component", "model.speakers");

	function read(event,rc,prc){
		//default the format value for this method
		event.paramValue("format", "json");

		//courtesy of cfscript community components
		new header(name="X-COLDBOX-HANDLER",value="speakerMember");

		event.renderData(
			data=variables.speakerModel.getSpeaker(rc.speakerSlug, "http://localhost/presentations/getting_rest/coldbox/index.cfm"),
			type=rc.format
		);
	}

}
