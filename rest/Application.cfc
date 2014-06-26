<cfcomponent extends="taffy.core.api">

	<cfset this.name = "angularjsstore">
	<cfset this.datasource = this.name>

	<cfset variables.framework = {
		reloadKey = "reload",
		reloadPassword = "password",
		reloadOnEveryRequest = TRUE
	}>

</cfcomponent>
