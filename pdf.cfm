<cftry>
    <cfinvoke  component="component.component" method="fullContacts" returnvariable="getData">
<!---     <cfdump  var="#getdata#" abort> --->
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>
<!--- 
<link rel="stylesheet" href="css/styles7.css">
<cfset pdfPath = expandPath("./downloads/pdf/addressBook.pdf")> 
--->
<cftry>

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
                    <!--- <th>ID</th> --->
                    <th>user Id</th>
                    <th>fullname</th>
                    <th>Email Id</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Photo Name</th>
                    <th>Phone No</th>
                    <th>Address</th>
                    <!--- <th>Street</th> --->
                    <th>Hobbies</th>
                </tr>
            </thead>
            <tbody>
                <cfloop array="#getData[1]#" index="data">
                    <tr>
                        <cfset hobbiesList = []>
                        <cfloop array="#getData[2]#" index="hobbie">
                            <cfif data.userId EQ hobbie.contactHobbieUserid>
                                <cfset ArrayAppend(hobbiesList, hobbie.hobbieName)>
                            </cfif>
                        </cfloop>
                        <!--- <td>#getData.ID#</td> --->
                        <td>#data.userId#</td>
                        <td>#data.fullname#</td>
                        <td>#data.contactEmail#</td>
                        <td>#data.gender#</td>
                        <td>#data.DOB#</td>
                        <td>#data.photoName#</td>
                        <td>#data.phone#</td>
                        <td>#data.address#</td>
                        <!--- <td>#getdata.street#</td> --->
                        <td>#ArrayToList(hobbiesList, ", ")#</td>
                    </tr>
                </cfloop>     
            </tbody>
        </table>
    </cfoutput>

</cfdocument>

<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<cfheader name="Content-Disposition" value="attachment; filename=AddressBook.pdf">
<cfcontent type="application/pdf" variable="#toBinary(pdfDoc)#">
<cfcontent reset="true">
<!--- <cfcontent type="application/pdf" file="#pdfPath#" deleteFile="false"> ---> <!--- deleteFile="false" is for not to delete file in server side" --->