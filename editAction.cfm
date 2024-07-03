<cfdump  var="#form#">
<cfif NOT structKeyExists(session, "userId")>
    <cflocation  url="login.cfm">
</cfif>
<cfif NOT len(form.title)
    OR NOT len(form.fname)
    OR NOT len(form.lname)
    OR NOT len(form.gender)
    OR NOT len(form.dob)
    OR NOT len(form.phone)
    OR NOT len(form.address)
    OR NOT len(form.street)
    OR NOT len(form.photo)>
    <cflocation  url="list.cfm?error=30">
<cfelse>
    <cftry>
            <cfset updateCFC = createObject("component", "component.component") />
            <cfset result = updateCFC.updateDetails(form = #form#) />
    <cfcatch>
        <cfdump  var="#cfcatch#" abort>
    </cfcatch>
    </cftry>
</cfif>