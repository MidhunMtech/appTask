<cfinvoke  component="component.component" method="getContacts" returnvariable="contacts">
<cftry>
    <cfinvoke component="component.component" method="deleteUser" returnvariable="delete">
<cfcatch>
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
                <th class="photo">Photo</th>
                <th>Name</th>
                <th>Phone Number</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <cftry>
                <cfoutput query="contacts">
                    <tr>
                        <td class="photo"><img src="uploads/#contacts.photoName#" alt="Photo"></td>
                        <td>#contacts.fullname#</td>
                        <td>#contacts.phone#</td>
                        <td><a class="edit editPop" data-userid="#contacts.userId#" >Edit</a></td>
                        <td><a class="edit" href="list.cfm?userid=#contacts.userId#&delete=true">Delete</a></td>
                        <td><a class="edit viewPop" data-userid="#contacts.userId#">View</a></td>
                    </tr>
                </cfoutput>
            <cfcatch>
                <cfdump  var="#cfcatch#">
            </cfcatch>
            </cftry>
        </tbody>
    </table>
</body>



<script src="js/jquery.min.js"></script>
<script src="js/modal.js"></script>