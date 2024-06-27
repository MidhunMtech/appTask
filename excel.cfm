<!--- Query the database to retrieve data from the person table --->
<cfquery name="personData" datasource="cfTask">
    SELECT firstname, lastname
    FROM person
</cfquery>

<!--- Initialize the CSV string --->
<cfset csvData = "">

<!--- Add headers to CSV string --->
<cfset csvData = "firstname,lastname" & chr(13) & chr(10)>

<!--- Loop over query results to build CSV data --->
<cfloop query="personData">
    <cfset csvData &= #firstname# & "," & #lastname# & chr(13) & chr(10)>
</cfloop>

<!--- Set headers for Excel file download --->
<cfheader name="Content-Disposition" value="attachment; filename=person_data.xlsx">
<cfheader name="Content-Type" value="text/xlsx; charset=utf-8">

<!--- Output the CSV data --->
<cfoutput>#csvData#</cfoutput>
