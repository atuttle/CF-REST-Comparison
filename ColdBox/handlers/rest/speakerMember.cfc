component{

	this.allowedMethods = {
		read = "GET"
	};

	function read(event,rc,prc){
		//default the format value for this method
		event.paramValue("format", "json");

		//courtesy of cfscript community components
		new header(name="X-COLDBOX-HANDLER",value="speakerMember");

		event.renderData(
			data=variables.speakerModel.getSpeaker(rc.speakerSlug),
			type=rc.format
		);
	}



}
