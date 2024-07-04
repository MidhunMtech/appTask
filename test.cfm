<cftry>
<cfset plainPassword = "yourPassword">
<cfset username = "test1"/>
<cfset hashedPassword = hash(plainPassword, "SHA-256")>

<cfquery datasource="cfTask2">
    INSERT INTO Users (username, password)
    VALUES (<cfqueryparam value="#username#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">)
</cfquery>
<cfcatch type="any">
<cfdump  var="#cfcatch#">
</cfcatch>
</cftry>


