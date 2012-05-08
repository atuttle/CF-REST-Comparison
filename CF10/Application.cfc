component {

	this.name = "cfobjective_rest_cf10";
	this.datasource = "cfobjective12_rest";

	/*
		YOU DEFINITELY WANT THIS SETTING TURNED ON!
	*/

	this.restsettings.skipCFCWithError = true;

	/*
		NOTE: YOU MAY NOT USE APPLICATION-SPECIFIC MAPPINGS IN CF10 REST CFC'S!

	this.mappings = {};
	this.mappings["/model"] = expandPath('../_model');
	*/

}