<cfinvoke  component="component.component" method="fullContacts" returnvariable="getData">
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Print</title>
        <script src="js/jquery.min.js"></script>
        <script src="js/print.js"></script>
        <link rel="stylesheet" href="css/styles7.css">    
    </head>
    <body>
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
        <div>
            <button id="print">Print</button>
        </div>
    </body>
<html>


