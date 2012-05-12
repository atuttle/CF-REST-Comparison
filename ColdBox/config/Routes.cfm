<cfscript>
	setUniqueURLS(false);
	setExtensionDetection(true);
	setValidExtensions('xml,json');
	setThrowOnInvalidExtension(false);
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}
	function PathInfoProvider(Event){
		return CGI.PATH_INFO;
	}


	/* IMPORTANT STUFF IS BELOW THIS LINE */


	// Route Definitions -- order is important: most specific above least specific
	addRoute(pattern="/sessions/:sessionSlug",handler="rest.sessionMember",action={GET="read"});
	addRoute(pattern="/sessions",handler="rest.sessionCollection",action={POST="create",GET="index"});
	addRoute(pattern="/speakers/:speakerSlug",handler="rest.speakerMember",action={GET="read"});
	addRoute(pattern="/speakers",handler="rest.speakerCollection",action={GET="index"});

	// VERY important that you put your routes ABOVE this line!
	addRoute(pattern=":handler/:action?");


</cfscript>