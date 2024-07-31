<cfinclude  template="createAction.cfm">
<cftry>
    <cfinvoke component="component.component" method="logout" returnvariable="logout">
    <cfif logout EQ "1">
        <cflocation  url="login.cfm">
    </cfif>
    <cfinvoke component="component.component" method="title" returnvariable="title">
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>List Page</title>
            <link rel="stylesheet" href="css/styles3.css">
            <link rel="stylesheet" href="css/bootstrap.min.css">
            <script src="js/jquery.min.js"></script>
            <script src="js/modal.js" defer></script>
        </head>
        <body>
            <nav>
                <ul>
                    <li><a href="list.cfm?logout=true">Logout</a></li>
                </ul>
            </nav>

            <header>
                <ul>
                    <li><a id="printBtn">Print</a></li>
                    <li><a id="excelBtn">Excel</a></li>
                    <li><a id="pdfBtn">Pdf</a></li>
                </ul>
            </header>
            <div class="messages" >
                <p id="pdf" class="downloadMessage">PDF downloaded Successfully....</p>
                <p id="print" class="downloadMessage">Print done Successfully....</p>
                <p id="excel" class="downloadMessage">Excel downloaded Successfully....</p>
                <!---<p id="update" class="downloadMessage update">Update failed. Try again....</p>
                <p id="create" class="downloadMessage update">Create contact failed. Try again....</p>
                <p id="ue" class="downloadMessage update"><b>Failed due to unexpected error</b>. Try again....</p> --->
                
                <cfif structKeyExists(variables, "result")>
                    <p class="downloadMessage <cfif result.success EQ 1>noerror<cfelse>yeserror</cfif>">
                        <cfoutput>
                            <b>#result.message#</b>
                        </cfoutput>
                    </p>
                    <!--- <cfset structDelete(session, "returnStruct") /> --->
                </cfif>
            </div>
            
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-3 lft">
                        <section class="left-section">
                            <cfoutput>
                                <h2>#session.userName#</h2>
                            </cfoutput>
                            <ul class="btn">
                                <li><a id="createId">Create Contact</a></li>
                            </ul>
                            <ul class="btn">
                                <li><a id="updateId" class="bg-primary">Upload File</a></li>
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
                    <p id="createPop" class="to-print"><cfinclude template="create.cfm"></p>
                </div>
            </div>

            <div id="myModal2" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <div class="container1">
                        <h1>Update Details</h1>
                        <form id="editForm" action="" method="post" enctype="multipart/form-data">
                            <fieldset>
                                <p id="l1_email" class="error email"><b>Email Id Exists</b>. Try again with another email...</p>
                                <legend>Personal Details</legend>
                                <div class="form-group">
                                    <label for="title">Title <span>*</span></label>
                                    <p id="l1_title" class="error1">Invalid title. Try again...</p>
                                    <select name="title">
                                        <option class="title" value=""></option>
                                        <cfloop query="title">
                                            <cfoutput>
                                                <option value="#title.title_id#">#title.title#</option>
                                            </cfoutput>
                                        </cfloop>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="fname">First Name <span>*</span></label>
                                    <p id="l1_fname" class="error1">Invalid first name. Try again...</p>
                                    <input type="text" class="fname" id="efname" name="fname" value="">
                                </div>

                                <div class="form-group">
                                    <label for="lname">Last Name <span>*</span></label>
                                    <p id="l1_lname" class="error1">Invalid last name. Try again...</p>
                                    <input type="text" class="lname" id="elname" name="lname" value="">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Gender <span>*</span></label>
                                    <p id="l1_gender" class="error1">Invalid gender. Try again...</p>
                                    <select class="gender" id="egender" name="gender">
                                        <option value=""></option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="dob">Date of Birth <span>*</span></label>
                                    <p id="l1_dob" class="error1">Date of Birth is Mandatory!. Try again...</p>
                                    <input type="date" class="dob" id="edob" name="dob" value="" required>
                                </div>

                                <div class="form-group">
                                    <label for="photo">Photo <span>*</span></label>
                                    <p id="l1_file" class="error1">File Upload is Mandatory!. Try again...</p>
                                    <input type="file" class="photo1" id="ephoto" name="photo" value="" accept="image/*" >
                                    <p><span class="image"></span></p>
                                    <input type="hidden" name="image" class="imageName" >
                                </div>

                                <div class="form-group">
                                    <label for="hobby">Hobbies <span>*</span></label>
                                    <p id="l1_hobbie" class="error1">Select minimum 3. Try again...</p>
                                    <select class="hobbie" name="hobbie" multiple>
                                        <cfloop query="hobbies">
                                            <cfoutput>
                                                <option value="#hobbies.Id#">#hobbies.hobbies#</option>
                                                <!--- <input type="hidden" class="hobbieUserId" name="hobbieUserId" value=""> --->
                                            </cfoutput>
                                        </cfloop>
                                    </select>
                                </div>
                            </fieldset>
            
                            <fieldset>
                                <legend>Contact Details</legend>
                                <div class="form-group">
                                    <label for="phone">Phone No <span>*</span></label>
                                    <p id="l1_phone" class="error1">Invalid phone number. Try again...</p>
                                    <input type="text" class="phone" id="ephone" name="phone" value="">
                                </div>

                                <div class="form-group">
                                    <label for="econtactEmail">Email <span>*</span></label>
                                    <p id="l1_contactEmail" class="error1">Invalid Email Address. Try again...</p>
                                    <input type="text" class="contactEmail" id="econtactEmail" name="contactEmail" value="">
                                </div>

                                <div class="form-group">
                                    <label for="address">Address <span>*</span></label>
                                    <p id="l1_address" class="error1">Invalid address. Try again...</p>
                                    <input type="text" class="address" id="eaddress" name="address" value="">
                                </div>

                                <div class="form-group">
                                    <label for="street">Street <span>*</span></label>
                                    <p id="l1_street" class="error1">Invalid street. Try again...</p>
                                    <input type="text" class="street" id="estreet" name="street" value="">
                                </div>

                                <div class="check">
                                    <label class="checkBoxL" for="epublic">Make as Public: </label>
                                    <input class="checkBox" type="checkbox" id="epublic" name="public" value="YES">
                                </div>
                            </fieldset>

                            <input type="hidden" class="userid" name="userid" value="">

                            <button id="submitId" class="btn2" type="submit" name="submit">Update</button>
                        </form>
                    </div>
                </div>
            </div>

            <div id="myModal3" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                        <div class="contact-card">
                            <img class="viewImg profile-pic" src="" alt="Profile Picture" >
                            <div class="contact-info">
                                <h1 class="fullnameView"></h1>
                                <p>Email: <span class="viewEmail"></span></p>
                                <p>Phone: <span class="phoneView"></span></p>
                                <p>Gender: <span class="genderView"></span></p>
                                <p>Address: <span class="addressView"></span></p>
                                <p>Street: <span class="streetView"></span></p>
                            </div>
                        </div>
                </div>
            </div>

            <div id="myModal4" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                        <div class="container2">
                            <form class="fileUploadForm" action="/upload" method="post" enctype="multipart/form-data">
                                <div class="header-buttons">
                                    <button class="bg-primary" id="dataTemplate">
                                        <a href="dataTemplate.cfm">Template With Data</a>
                                    </button>
                                    <button id="plainTemplate">
                                        <a href="plainTemplate.cfm">Plain Template</a>
                                    </button>
                                </div>
                                <label for="fileUpload">Upload Excel file:</label>
                                <input type="file" id="excelFileUpload" name="excelFileUpload" accept=".xls,.xlsx" required>
                                <input type="submit" value="Upload">
                            </form>
                        </div>
                </div>
            </div>

        </body>
    </html>
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>