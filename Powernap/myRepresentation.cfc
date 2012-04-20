component
extends="powernap.core.Representation"
{

	function init(){
		return this;
	}

	function getAsJson(){
		return serializeJson( getObject() );
	}

}