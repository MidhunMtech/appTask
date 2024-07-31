<cfif structKeyExists(form, "submit")>
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
            <!--- <cfif structKeyExists(form, "public")>
                <cfset isPublic = "YES" />
            <cfelse>
                <cfset isPublic = "NO" />
            </cfif> --->

            <cfparam  name="form.public" default="NO">
            <cftry>  
                <cfset variables.result = application.component.createAndUpdateContact(
                    form = form, 
                    photo = photo<!--- , 
                    isPublic = isPublic --->) />
            
                <!--- <cfdump  var="#result#"> --->
                <!--- <cflocation  url="/list.cfm"> --->
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
</cfif>