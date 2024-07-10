<cftry>
    <cfif structKeyExists(form, "create")>
    <cfset pathDir = expandPath("uploads") />
        <cffile  action="upload"
            destination="#pathDir#" 
            fileField="form.photo" 
            nameConflict="makeunique">

        <cfif structKeyExists(form, "public")>
            <cfset isPublic = "YES" />
        <cfelse>
            <cfset isPublic = "NO" />
        </cfif>
            
        <cfset result = application.component.Addcontact(form = #form#, photo = cffile.serverfile, isPublic = isPublic) />
<!---         <cfdump  var="#result#"> --->
        <cflocation  url="list.cfm">
    </cfif>
<cfcatch >
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>