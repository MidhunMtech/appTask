<cfquery name="getData" datasource="cfTask2">
    SELECT 
        t1.nameID AS ID,
        t2.userId,
        concat(t2.title, " ", t2.fname, " ", t2.lname) as fullname,
        t1.email,
        t2.gender,
        t2.DOB,
        t2.photoName,
        t2.phone,
        t2.address,
        t2.street
    FROM 
        registerForm AS t1
    INNER JOIN 
        contacts AS t2
    ON 
        t2.nameId_fk = t1.nameId
    WHERE
        t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    ORDER BY ID
</cfquery>
<cfdump  var="#getData#">

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
                    <th>Phone</th>
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
                        <td>#email#</td>
                        <td>#gender#</td>
                        <td>#DOB#</td>
                        <td>#photoName#</td>
                        <td>#phone#</td>
                        <td>#address#</td>
                        <td>#street#</td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </cfoutput>
</cfdocument>
<cflocation  url="list.cfm">

<!--- <cfheader name="Content-Disposition" value="attachment;filename=addressBook1.pdf"> 
<cfcontent type="application/pdf" variable="#toBinary(pdfDoc)#">--->