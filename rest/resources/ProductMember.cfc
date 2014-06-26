<cfcomponent extends="taffy.core.resource" taffy:uri="/products/{productId}">

	<!--- PUBLIC METHODS --->

	<cffunction name="get" returntype="any" output="false" hint="I get a product from the database">
		<cfargument name="productId" type="numeric" required="true" hint="The product id">

		<cfquery name="local.product">
			SELECT *
			FROM products
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.productId#">
		</cfquery>

		<cfif local.product.recordCount EQ 0>
			<cfreturn noData().withStatus(404, "Not Found")>
		</cfif>

		<cfset local.product = queryToArray(local.product)>

		<cfreturn representationOf(local.product)>
	</cffunction>

	<cffunction name="post" returntype="any" output="false" hint="I insert a product into the database">
		<cfargument name="productId" type="any" required="false" hint="The product id">
		<cfargument name="name" type="any" required="false" hint="The product name">
		<cfargument name="description" type="any" required="false" hint="The product description">
		<cfargument name="shine" type="any" required="false" hint="The product shine">
		<cfargument name="price" type="any" required="false" hint="The produce price">
		<cfargument name="rarity" type="any" required="false" hint="The product rarity">
		<cfargument name="color" type="any" required="false" hint="The product color">
		<cfargument name="faces" type="any" required="false" hint="The number of faces on the product">

		<cfset local.validationResult = validateProduct(argumentCollection = arguments)>
		<cfif arraylen(local.validationResult)>
			<cfreturn representationOf(local.validationResult).withStatus(400, "Invalid Data")>
		</cfif>

		<cfquery result="local.result">
			INSERT INTO products (
				name,
				description,
				shine,
				rarity,
				color,
				faces
			) VALUES (
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#">,
				<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.description#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.shine#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.rarity#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.color#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.faces#">
			)
		</cfquery>

		<cfreturn representationOf(local.result.generatedKey)>
	</cffunction>

	<cffunction name="put" returntype="any" output="false" hint="I update a product in the database">
		<cfargument name="productId" type="any" required="false" hint="The product id">
		<cfargument name="name" type="any" required="false" hint="The product name">
		<cfargument name="description" type="any" required="false" hint="The product description">
		<cfargument name="shine" type="any" required="false" hint="The product shine">
		<cfargument name="price" type="any" required="false" hint="The produce price">
		<cfargument name="rarity" type="any" required="false" hint="The product rarity">
		<cfargument name="color" type="any" required="false" hint="The product color">
		<cfargument name="faces" type="any" required="false" hint="The number of faces on the product">

		<cfset local.validationResult = validateProduct(argumentCollection = arguments)>
		<cfif arraylen(local.validationResult)>
			<cfreturn representationOf(local.validationResult).withStatus(400, "Invalid Data")>
		</cfif>

		<cfif NOT (productExists(productId = argument.productId))>
			<cfreturn noData().withStatus(404, "Not Found")>
		</cfif>

		<cfquery>
			UPDATE products
			SET name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#">,
				description = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.description#">,
				shine = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.shine#">,
				rarity = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.rarity#">,
				color = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.color#">,
				faces = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.faces#">
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.productId#">
		</cfquery>

		<cfreturn representationOf(arguments.productId)>
	</cffunction>

	<cffunction name="delete" returntype="any" output="false" hint="I delete a product from the database">
		<cfargument name="productId" type="numeric" required="true" hint="The product id">

		<cfif NOT (productExists(productId = argument.productId))>
			<cfreturn noData().withStatus(404, "Not Found")>
		</cfif>

		<cfquery>
			DELETE FROM products
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.productId#">
		</cfquery>

		<cfreturn noData()>
	</cffunction>

	<!--- PRIVATE METHODS --->

	<cffunction name="productExists" access="private" returntype="boolean" output="false" hint="I return true if the product exists">
		<cfargument name="productId" type="numeric" required="true" hint="The product id">

		<cfquery name="local.checkProductExists">
			SELECT count(productId)
			FROM products
			WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.productId#">
		</cfquery>

		<cfreturn local.checkProductExists.count NEQ 0>
	</cffunction>

	<cffunction name="validateProduct" access="private" returntype="array" output="false" hint="I validate a product">
		<cfargument name="productId" type="any" required="false" hint="The product id">
		<cfargument name="name" type="any" required="false" hint="The product name">
		<cfargument name="description" type="any" required="false" hint="The product description">
		<cfargument name="shine" type="any" required="false" hint="The product shine">
		<cfargument name="price" type="any" required="false" hint="The produce price">
		<cfargument name="rarity" type="any" required="false" hint="The product rarity">
		<cfargument name="color" type="any" required="false" hint="The product color">
		<cfargument name="faces" type="any" required="false" hint="The number of faces on the product">

		<cfset local.result = []>

		<cfif NOT structkeyexists(arguments, "productId") OR NOT isnumeric(arguments.productId)>
			<cfset local.result.productId = "Product id should be a number.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "name") OR len(trim(arguments.name)) EQ 0>
			<cfset local.result.name = "Product name is required.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "description") OR len(trim(arguments.description)) EQ 0>
			<cfset local.result.description = "Product description is required.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "shine") OR NOT isnumeric(arguments.shine)>
			<cfset local.result.shine = "Product shine should be a number.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "price") OR NOT isnumeric(arguments.price)>
			<cfset local.result.price = "Product price should be a number.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "rarity") OR NOT isnumeric(arguments.rarity)>
			<cfset local.result.rarity = "Product rarity should be a number.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "color") OR len(trim(arguments.color)) EQ 0>
			<cfset local.result.color = "Product color is required.">
		</cfif>
		<cfif NOT structkeyexists(arguments, "faces") OR NOT isnumeric(arguments.faces)>
			<cfset local.result.faces = "Product faces should be a number.">
		</cfif>

		<cfreturn local.result>
	</cffunction>

</cfcomponent>
