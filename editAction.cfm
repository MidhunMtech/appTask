<cfif NOT len(form.title)
    OR NOT len(form.fname)
    OR NOT len(form.lname)
    OR NOT len(form.gender)
    OR NOT len(form.dob)
    OR NOT len(form.phone)
    OR NOT len(form.address)
    OR NOT len(form.street)>
    <cflocation  url="list.cfm?error=update">
<cfelse>
    <cftry>
        <cfif structKeyExists(form, "submit")>
            <cfset pathDir = expandPath("uploads") />
    
            <cfif structKeyExists(form, "epublic")>
                <cfset isPublic = "YES" />
            <cfelse>
                <cfset isPublic = "NO" />
            </cfif>

            <cfif NOT len(form.photo)>
                <cfset photo = form.image>
            <cfelse>
                <cffile  action="upload"
                    destination="#pathDir#" 
                    fileField="form.photo" 
                    nameConflict="makeunique">

                <cfset photo = cffile.serverfile />
            </cfif>
                
            <cfset result = application.component.updateDetails(form = #form#,
                photo = photo, 
                isPublic = isPublic) />

            <cflocation  url="list.cfm">
        </cfif>
    <cfcatch>
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfif>