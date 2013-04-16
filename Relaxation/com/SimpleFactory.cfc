component displayname="Stupid Simple Factory" hint="I am a super simple factory (just to make the example work)." output="false" {

	public component function init() {
		return this;
	}
	
	public component function getBean( required string BeanName ) {
		return CreateObject("component", "model.#arguments.BeanName#");
	}

}