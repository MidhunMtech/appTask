
<cfquery name="getData" datasource="cfTask">
    SELECT firstname, lastname FROM person
</cfquery>
<cfdump var="#getData#">
<!--- Step 2: Generate the PDF Content --->
<cfset pdfPath = expandPath("./downloads/pdf/personTable.pdf")>
<cfdocument format="PDF" filename="#pdfPath#" name="pdfDoc" overwrite="yes">
    <cfoutput>
    <html>
    <head>
        <title>Person Table</title>
    </head>
    <body>
        <h1>Person Table</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                </tr>
            </thead>
            <tbody>
                <cfloop query="getData">
                    <tr>
                        <td>#getData.firstname#</td>
                        <td>#getData.lastname#</td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </body>
    </html>
    </cfoutput>
</cfdocument>

<!--- Step 3: Serve the PDF for Download --->
<cfheader name="Content-Disposition" value="attachment;filename=personTable.pdf">
<cfcontent type="application/pdf" variable="#toBinary(pdfDoc)#">
