<cfinvoke component="component.component" method="getData" returnvariable="getData">

<cfset pdfPath = expandPath("./downloads/pdf/addressBook.pdf")>
<cfdocument format="PDF" filename="#pdfPath#" name="pdfDoc" overwrite="yes">
    <cfoutput>
        <h1>Address Book</h1>
        <table border="2">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>user Id</th>
                    <th>fullname</th>
                    <th>Email Id</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Photo Name</th>
                    <th>Phone No</th>
                    <th>Address</th>
                    <th>Street</th>
                </tr>
            </thead>
            <tbody>
                <cfloop query="getData">
                    <tr>
                        <td>#getData.ID#</td>
                        <td>#getData.userId#</td>
                        <td>#getdata.fullname#</td>
                        <td>#getdata.email#</td>
                        <td>#getdata.gender#</td>
                        <td>#getdata.DOB#</td>
                        <td>#getdata.photoName#</td>
                        <td>#getdata.phone#</td>
                        <td>#getdata.address#</td>
                        <td>#getdata.street#</td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </cfoutput>
</cfdocument>

<cflocation  url="list.cfm?pdf=true">
