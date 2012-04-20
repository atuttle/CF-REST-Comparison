component extends="taffy.core.api" {

	this.name = "cfobjective_rest_taffy";
	this.datasource = "cfobjective12_rest";
	this.mappings = {};

	this.mappings["/model"] = expandPath('../_model');

}