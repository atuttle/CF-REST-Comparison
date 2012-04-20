component
extends="powernap.core.Engine"
{

	function init(){

		//define formats
		format().withExtension("application/json").willRespondWith("application/json").calls("getAsJson");

		//default format
		defaultFormat(".json");

		//define resources
		newResource("sessions").isA("res.sessions");
		newResource("speakers").isA("res.speakers");

		//define URI paths

		map().get().uri("/sessions").to("sessions").calls("getAllSessionsWithSpeakers");
		map().get().uri("/sessions/{sessionSlug}").to("sessions").calls("getSession");

		map().get().uri("/speakers").to("speakers").calls("getAllSpeakersWithSessions");
		map().get().uri("/speakers/{speakerSlug}").to("speakers").calls("getSpeaker");


		return this;
	}

}
