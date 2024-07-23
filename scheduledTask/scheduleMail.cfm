<cftry>
    <cfset today = DateFormat(now(), "yyyy-mm-dd")>
    <cfinvoke component="component.component" method="fullContacts" returnVariable="mailData">
        <cfinvokeargument  name="birthDay"  value="#today#">
    </cfinvoke>
    
    <cfloop array="#mailData#" index="mailData">
        <cfmail 
            to="#mailData.email#" 
            from="midhun@gmail.com"
            subject="Happy Birthday #mailData.fullname#">

            <p>Happyy Birthday!!!!!!!!</p>

        </cfmail>
    </cfloop>
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<!--- <cfdump var="1" format="html" output="e:\logs\test.html"> --->