<cfif NOT len(form.title)
    OR NOT len(form.fname)
    OR NOT len(form.lname)
    OR NOT len(form.gender)
    OR NOT len(form.dob)
    OR NOT len(form.phone)
    OR NOT len(form.address)
    OR NOT len(form.street)
    OR NOT len(form.userid)>
    <!--- <cfdump  var="#form#"> --->
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
                
            <cfset result = application.component.createAndUpdateContact(
                form = form,
                photo = photo, 
                isPublic = isPublic) />

            <cfif result EQ 0>
                <cflocation  url="list.cfm?errorEmail=#form.userid#">
            <cfelse>
                <cflocation  url="list.cfm">
            </cfif>
        </cfif>
    <cfcatch>
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfif>