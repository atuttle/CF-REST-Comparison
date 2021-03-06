﻿<!-----------------------------------------------------------------------
Author 	 :	Luis Majano
Date     :	September 25, 2005
Description :
	Unit Tests integration for the ehGeneral Handler.

----------------------------------------------------------------------->
<cfcomponent extends="coldbox.system.testing.BaseTestCase" appMapping="/coldbox/ApplicationTemplates/Advanced">

	<cffunction name="setUp" returntype="void" output="false">
		<cfscript>
		// Call the super setup method to setup the app.
		super.setup();
		
		// Any preparation work will go here for this test.
		</cfscript>
	</cffunction>
	
	<cffunction name="testindex" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//URL.name = "luis"
		event = execute("general.index");
		
		debug(event.getCollection());
		
		//Do your asserts below
		assertEquals("Welcome to ColdBox!", event.getValue("welcomeMessage",""), "Failed to assert welcome message");
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testdoSomething" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//URL.name = "luis"
		event = execute("general.doSomething");
		debug(event.getCollection());
		//Do your asserts below for setnextevent you can test for a setnextevent boolean flag
		assertEquals("general.index", event.getValue("setnextevent",""), "Relocation Test");
		</cfscript>
	</cffunction>
	
</cfcomponent>