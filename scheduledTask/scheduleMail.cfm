<cftry>
    <cfinvoke component="component.component" method="mailData" returnVariable="mailData">
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<cfloop query="mailData">
    <cfset date="#mailData.DOB#">
    <cfset day = day(date)> 
    <cfset month = month(date)>
    <cfset year = year(now())>
    <cfset myDate = DateFormat(CreateDate(year, month, day), "yyyy-mm-dd")>
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
hyyy

<!--- <cfdump var="1" format="html" output="e:\logs\test.html"> --->