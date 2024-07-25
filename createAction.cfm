<cfif NOT len(form.title)
    OR NOT len(form.fname)
    OR NOT len(form.lname)
    OR NOT len(form.gender)
    OR NOT len(form.dob)
    OR NOT len(form.phone)
    OR NOT len(form.address)
    OR NOT len(form.street)
    OR NOT len(form.contactEmail)>
    <cflocation  url="list.cfm?error=create">
<cfelse>
    <cftry>
        <cfif structKeyExists(form, "submit")>
            <cfset pathDir = expandPath("uploads") />

            <cfif structKeyExists(form, "userid")>
                <cfif NOT len(form.photo)>
                    <cfset photo = form.image>
                <cfelse>
                    <cffile  action="upload"
                        destination="#pathDir#" 
                        fileField="form.photo" 
                        nameConflict="makeunique">

                    <cfset photo = cffile.serverfile />
                </cfif>
            <cfelse>
                <cffile  action="upload"
                    destination="#pathDir#" 
                    fileField="form.photo" 
                    nameConflict="makeunique">

                <cfset photo = cffile.serverfile />
            </cfif>
            <cfif structKeyExists(form, "public")>
                <cfset isPublic = "YES" />
            <cfelse>
                <cfset isPublic = "NO" />
            </cfif>
                
            <cfset result = application.component.createAndUpdateContact(
                form = form, 
                photo = photo, 
                isPublic = isPublic) />
            <cftry>
            <!--- <cfdump  var="#result#"> --->
                <cflocation  url="/list.cfm">
                <!--- <cfif result.success EQ 1 AND result.message EQ "created" OR result.message EQ "updated">
                    <cflocation  url="list.cfm">
                <cfelseif result.success EQ 0 AND result.message EQ "create failed">
                    <cflocation  url="list.cfm?error=email">
                <cfelseif result.success EQ 0 AND result.message EQ "update failed">
                    <cflocation  url="list.cfm?errorEmail=#form.userid#">
                <cfelse>
                    <cflocation  url="list.cfm?error=ue">
                </cfif> ---> 
            <cfcatch type="any">
                <cfdump  var="#cfcatch#">
            </cfcatch>
            </cftry>
                
        </cfif>
    <cfcatch >
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>
</cfif>