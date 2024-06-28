<cfinvoke component="component.component" method="logout" returnvariable="logout">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Page</title>
    <link rel="stylesheet" href="css/styles3.css">
</head>
    <body>
        <nav>
            <ul>
                <li><a href="list.cfm?logout=true">Logout</a></li>
            </ul>
        </nav>

        <header>
            <ul>
                <li><a href="print.cfm">Print</a></li>
                <li><a href="excel.cfm">Excel</a></li>
                <li><a href="pdf.cfm">Pdf</a></li>
            </ul>
        </header>
        <cfinvoke  component="component.component" method="errorMessage" returnvariable="errorMsg">
        <cfoutput>#errorMsg#</cfoutput>

        <div class="container">
            <section class="left-section">
                <cfoutput>
        <!---<img src="uploads/#session.photo#" width="50" height="50" shape="poly">--->
                    <h2>#session.userName#</h2>
                </cfoutput>
                <ul class="btn">
                    <li><a href="create.cfm">Create Contact</a></li>
                </ul>
            </section>
            <section class="right-section">
                <cfinclude  template="listDetails.cfm">
            </section>
        </div>
    </body>
</html>
