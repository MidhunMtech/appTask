<cftry>
    <cfinvoke  component="component.component" method="fullContacts" returnvariable="contacts">
    <!--- <cfdump  var="#contacts#">
    <cfdump  var="#contacts[1]#" abort> --->
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<head>
    <link rel="stylesheet" type="text/css" href="css/styles5.css">
</head>
<body>
    <table>
        <thead>
            <tr>
                <th class="photo to-print">Photo</th>
                <th class="to-print">Name</th>
                <th class="to-print">Phone Number</th>
                <th class="not-print"></th>
                <th class="not-print"></th>
                <th class="not-print"></th>
            </tr>
        </thead>
        <tbody>
            <cftry>     
                <cfoutput>
                    <cfloop array="#contacts[1]#" index="contacts">
                        <cfif #contacts.public# EQ "YES" AND #contacts.nameId_fk# NEQ #session.userId#>
                            <cfset element = "disable">
                            <!--- <cfset encryptionKey = "oK455VMW4Cx55FvtTF5vWg==">  ---<cfset encryptionKey = GenerateSecretKey("AES")> ---
                            <cfset encryptedUserId = Encrypt(contacts.userId, encryptionKey, "AES", "Base64")> --->
                        <cfelse>
                            <cfset element = "">
                            <!--- <cfset encryptedUserId ="#contacts.userId#"> --->
                        </cfif>
                        
                        <tr>
                            <td class="photo to-print"><img src="uploads/#contacts.photoName#" alt="Photo"></td>
                            <td class="to-print">#contacts.fullname#</td>
                            <td class="to-print">#contacts.phone#</td>
                            <td class="not-print"><a class="edit editPop #element#" data-userid="#contacts.userId#" >Edit</a></td>
                            <td class="not-print"><a class="edit deletePop #element#"  data-userid="#contacts.userId#">Delete</a></td>
                            <td class="not-print"><a class="edit viewPop" data-userid="#contacts.userId#">View</a></td>
                        </tr>
                    </cfloop>
                </cfoutput>
            <cfcatch>
                <cfdump  var="#cfcatch#">
            </cfcatch>
            </cftry>
        </tbody>
    </table>
</body>