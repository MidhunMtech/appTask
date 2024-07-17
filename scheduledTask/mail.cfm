<cftry>
    <cfinvoke component="component.component" method="mailData" returnVariable="mailData">
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>


<cfmail 
    to="#mailData.email#" 
    from="midhun@gmail.com"
    subject="Happy Birthday #mailData.fullname#">

    <p>Happyy Birthday!!!!!!!!</p>

</cfmail>


<!--- <cfdump var="1" format="html" output="e:\logs\test.html"> --->