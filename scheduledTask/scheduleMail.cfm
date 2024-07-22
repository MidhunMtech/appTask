<cftry>
    <cfinvoke component="component.component" method="userDetailsQuery" returnVariable="mailData"></cfinvoke>

    <cfloop query="mailData">
        <cfset date="#mailData.DOB#">
        <cfset myDate = DateFormat(CreateDate(year(now()), month(date), day(date)), "yyyy-mm-dd")>
        <cfset today = DateFormat(now(), "yyyy-mm-dd")>

        <cfif myDate EQ today>
            <cfmail 
                to="#mailData.email#" 
                from="midhun@gmail.com"
                subject="Happy Birthday #mailData.fullname#">

                <p>Happyy Birthday!!!!!!!!</p>

            </cfmail>
        </cfif>
    </cfloop>
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<!--- <cfdump var="1" format="html" output="e:\logs\test.html"> --->