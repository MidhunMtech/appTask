<cftry>
    <cfinvoke  component="component.component" method="getContacts" returnvariable="contacts">
    <cfinvoke  component="component.component" method="getPublicContacts" returnvariable="publicContacts">
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
                <cfoutput query="contacts">
                    <tr>
                        <td class="photo to-print"><img src="uploads/#contacts.photoName#" alt="Photo"></td>
                        <td class="to-print">#contacts.fullname#</td>
                        <td class="to-print">#contacts.phone#</td>
                        <td class="not-print"><a class="edit editPop" data-userid="#contacts.userId#" >Edit</a></td>
                        <td class="not-print"><a class="edit deletePop"  data-userid="#contacts.userId#">Delete</a></td>
                        <td class="not-print"><a class="edit viewPop" data-userid="#contacts.userId#">View</a></td>
                    </tr>
                </cfoutput>
                <cfoutput query="publicContacts">
                    <tr>
                        <td class="photo to-print"><img src="uploads/#publicContacts.photoName#" alt="Photo"></td>
                        <td class="to-print">#publicContacts.fullname#</td>
                        <td class="to-print">#publicContacts.phone#</td>
                        <td class="not-print"><a class="edit editPop disable" data-userid="#publicContacts.userId#" >Edit</a></td>
                        <td class="not-print"><a class="edit deletePop disable"  data-userid="#publicContacts.userId#" >Delete</a></td>
                        <td class="not-print"><a class="edit viewPop" data-userid="#publicContacts.userId#" >View</a></td>
                    </tr>
                </cfoutput>
            <cfcatch>
                <cfdump  var="#cfcatch#">
            </cfcatch>
            </cftry>
        </tbody>
    </table>
</body>