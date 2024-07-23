<cftry>
    <cfinvoke  component="component.component" method="fullContacts" returnvariable="getData">
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>
<!--- 
<link rel="stylesheet" href="#expandPath('../css/')#styles7.css">
<cfset pdfPath = expandPath("./downloads/pdf/addressBook.pdf")> 
--->
<cfdocument format="PDF"
    <!--- filename="#pdfPath#" ---> 
    name="pdfDoc" 
    overwrite="yes" 
    pagetype="legal" 
    marginbottom="1.0" 
    margintop="1.0" 
    marginleft="0.5" 
    marginright="0.5">

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
                <cfoutput>
                    <cfloop array="#getData#" index="getData">
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
                </cfoutput>
            </tbody>
        </table>
    </cfoutput>

</cfdocument>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.pdf">
<cfcontent type="application/pdf" variable="#toBinary(pdfDoc)#">
<cfcontent reset="true">
<!--- <cfcontent type="application/pdf" file="#pdfPath#" deleteFile="false"> ---> <!--- deleteFile="false" is for not to delete file in server side" --->