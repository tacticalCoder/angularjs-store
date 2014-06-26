<cfcomponent extends="taffy.core.resource" taffy:uri="/products">

	<!--- PUBLIC METHODS --->

	<cffunction name="get">
		<cfset local.products = getProducts()>
		<cfset local.productImages = getProductImages()>
		<cfset local.productReviews = getProductReviews()>

		<!--- convert products query to an array of structures so we can serialise the JSON in an AngularJS friendly format --->

		<cfset local.products = querytoarray(local.products)>

		<!--- append product images and reviews to the products array --->

		<cfloop array="#local.products#" index="local.product">
			<cfquery name="local.currentProductImages" dbtype="query">
				SELECT *
				FROM [local].productImages
				WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.product.id#">
			</cfquery>

			<cfset local.product["images"] = querytoarray(local.currentProductImages)>

			<cfquery name="local.currentProductReviews" dbtype="query">
				SELECT *
				FROM [local].productReviews
				WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.product.id#">
			</cfquery>

			<cfset local.product["reviews"] = querytoarray(local.currentProductReviews)>
		</cfloop>

		<cfreturn representationOf(local.products)>
	</cffunction>

	<!--- PRIVATE METHODS --->

	<cffunction name="getProducts" access="private" returntype="query" output="false" hint="I return products">
		<cfquery name="local.products">
			SELECT *
			FROM products
		</cfquery>
		<cfreturn local.products>
	</cffunction>

	<cffunction name="getProductImages" access="private" returntype="query" output="false" hint="I return product images">
		<cfquery name="local.productimages">
			SELECT *
			FROM productimages
		</cfquery>
		<cfreturn local.productimages>
	</cffunction>

	<cffunction name="getProductReviews" access="private" returntype="query" output="false" hint="I return product reviews">
		<cfquery name="local.productreviews">
			SELECT *
			FROM productreviews
		</cfquery>
		<cfreturn local.productreviews>
	</cffunction>

</cfcomponent>
