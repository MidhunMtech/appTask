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
        <cfif structKeyExists(form, "submit")>
            <cfset pathDir = expandPath("uploads") />
            <cffile  action="upload"
                destination="#pathDir#" 
                fileField="form.photo" 
                nameConflict="makeunique">

            <cfif structKeyExists(form, "epublic")>
                <cfset isPublic = "YES" />
            <cfelse>
                <cfset isPublic = "NO" />
            </cfif>
                
            <cfset result = application.component.updateDetails(form = #form#, photo = cffile.serverfile, isPublic = isPublic) />
            <cflocation  url="list.cfm">
        </cfif>
    <cfcatch>
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfif>