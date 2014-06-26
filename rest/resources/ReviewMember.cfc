<cfcomponent extends="taffy.core.resource" taffy:uri="/reviews/{reviewId}">

	<!--- PUBLIC METHODS --->

	<cffunction name="post" returntype="any" output="false" hint="I insert a review into the database">
		<cfargument name="reviewId" type="any" required="false" hint="The review id">
		<cfargument name="stars" type="any" required="false" hint="The review stars">
		<cfargument name="body" type="any" required="false" hint="The review body">
		<cfargument name="author" type="any" required="false" hint="The review author">
		<cfargument name="productId" type="any" required="false" hint="The product id">

		<cfset local.validationResult = validateReview(argumentCollection = arguments)>
		<cfif arraylen(local.validationResult)>
			<cfreturn representationOf(local.validationResult).withStatus(400, "Invalid Data")>
		</cfif>

		<cfquery result="local.result">
			INSERT INTO productreviews (
				stars,
				body,
				author,
				product_id
			) VALUES (
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.stars#">,
				<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.body#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.author#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.productId#">
			)
		</cfquery>

		<cfreturn representationOf(local.result.generatedKey)>
	</cffunction>

	<!--- PRIVATE METHODS --->

	<cffunction name="validateReview" access="private" returntype="array" output="false" hint="I validate a review">
		<cfargument name="reviewId" type="any" required="false" hint="The review id">
		<cfargument name="stars" type="any" required="false" hint="The review stars">
		<cfargument name="body" type="any" required="false" hint="The review body">
		<cfargument name="author" type="any" required="false" hint="The review author">
		<cfargument name="productId" type="any" required="false" hint="The product id">

		<cfset local.result = []>

		<cfif NOT structkeyexists(arguments, "reviewId") OR NOT isnumeric(arguments.reviewId)>
			<cfset arrayappend(local.result, "Review id should be a number.")>
		</cfif>
		<cfif NOT structkeyexists(arguments, "stars") OR NOT isnumeric(arguments.stars)>
			<cfset arrayappend(local.result, "Review stars should be a number.")>
		</cfif>
		<cfif NOT structkeyexists(arguments, "body") OR len(trim(arguments.body)) EQ 0>
			<cfset arrayappend(local.result, "Review body is required.")>
		</cfif>
		<cfif NOT structkeyexists(arguments, "author") OR len(trim(arguments.author)) EQ 0>
			<cfset arrayappend(local.result, "Review author is required.")>
		</cfif>
		<cfif NOT structkeyexists(arguments, "productId") OR NOT isnumeric(arguments.productId)>
			<cfset arrayappend(local.result, "Product id should be a number.")>
		</cfif>

		<cfreturn local.result>
	</cffunction>

</cfcomponent>
