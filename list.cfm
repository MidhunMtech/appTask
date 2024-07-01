<cfinvoke component="component.component" method="logout" returnvariable="logout">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Page</title>
    <link rel="stylesheet" href="css/styles3.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
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
        <cfinvoke  component="component.component" method="errorMessageList" returnvariable="errorMsg">
        <cfoutput>#errorMsg#</cfoutput>

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3">
                    <section class="left-section">
                        <cfoutput>
                            <h2>#session.userName#</h2>
                        </cfoutput>
                        
                        <ul class="btn">
                            <li><a id="createId">Create Contact</a></li>
                        </ul>
                    </section>
                    </div>
                    <div class="col-sm-9">
                    <section class="right-section">
                        <cfinclude  template="listDetails.cfm">
                    </section>
                </div>
            </div>
        </div>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <cfinclude template="create.cfm">
            </div>
        </div>

        <script src="js/jquery.min.js"></script>
        <script src="js/modal.js"></script>

    </body>
</html>
