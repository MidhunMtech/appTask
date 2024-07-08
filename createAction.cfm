<cftry>
    <cfif structKeyExists(form, "create")>
        <cffile  action="upload"
            destination="C:\ColdFusion2021\cfusion\wwwroot\appTask\uploads" 
            fileField="form.photo" 
            nameConflict="makeunique">
            
        <cfset result = application.component.Addcontact(form = #form#, photo = cffile.serverfile) />
        <cflocation  url="list.cfm">
    </cfif>
<cfcatch >
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>