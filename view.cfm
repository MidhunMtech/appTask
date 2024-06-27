<cfinvoke  component="component.component" method="viewUser" returnvariable="viewUser">

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Details</title>
        <link rel="stylesheet" type="text/css" href="css/styles6.css" />
    </head>
    <body>
        <nav>
            <ul>
                <li><a href="list.cfm?logout=true">Logout</a></li>
            </ul>
        </nav>
        <cfoutput>
            <div class="contact-card">
                <img src="uploads/#viewUser.photoName#" alt="Profile Picture" class="profile-pic">
                <div class="contact-info">
                    <h1>#viewUser.fullname#</h1>
                    <p>Email: <span>#viewUser.email#</span></p>
                    <p>Phone: <span>#viewUser.phone#</span></p>
                    <p>Gender: <span>#viewUser.gender#</span></p>
                    <p>Address: <span>#viewUser.address#</span></p>
                    <p>Street: <span>#viewUser.street#</span></p>
                </div>
                <a href="list.cfm">Back</a>
            </div>
        </cfoutput>
    </body>
</html>