<cftry>
    <cfinvoke component="component.component" method="fullContacts" returnVariable="mailData">
        <cfinvokeargument name="getBirthdayOnly"  value="1">
    </cfinvoke>
    
    <cfloop array="#mailData[1]#" index="mailData">
        <cfmail 
            to="#mailData.contactEmail#" 
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