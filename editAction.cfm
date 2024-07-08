<cfdump  var="#form#">
<cfif NOT len(form.title)
    OR NOT len(form.fname)
    OR NOT len(form.lname)
    OR NOT len(form.gender)
    OR NOT len(form.dob)
    OR NOT len(form.phone)
    OR NOT len(form.address)
    OR NOT len(form.street)
    OR NOT len(form.photo)>
    <cflocation  url="list.cfm?error=update">
<cfelse>
    <cftry>
            <cffile  action="upload"
                destination="C:\ColdFusion2021\cfusion\wwwroot\appTask\uploads" 
                fileField="form.photo" 
                nameConflict="makeunique">
                
            <cfset result = application.component.updateDetails(form = #form#, photo = cffile.serverfile) />
            <cflocation  url="list.cfm">
    <cfcatch>
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfif>