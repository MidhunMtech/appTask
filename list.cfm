<cfinvoke component="component.component" method="logout" returnvariable="logout">
<cfinclude  template="schedule.cfm">
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
        <script src="js/modal.js"></script>
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
            <p id="update" class="downloadMessage update">Update failed. Try again....</p>
            <p id="create" class="downloadMessage update">Create contact failed. Try again....</p>
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
                    <form id="editForm" action="editAction.cfm" method="post" enctype="multipart/form-data">
                        <fieldset>
                            <legend>Personal Details</legend>
                            <div class="form-group">
                                <label for="title">Title <span>*</span></label>
                                <p id="l1_title" class="error1">Invalid title. try again...</p>
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
                                <p id="l1_fname" class="error1">Invalid first name. try again...</p>
                                <input type="text" class="fname" id="efname" name="fname" value="">
                            </div>

                            <div class="form-group">
                                <label for="lname">Last Name <span>*</span></label>
                                <p id="l1_lname" class="error1">Invalid last name. try again...</p>
                                <input type="text" class="lname" id="elname" name="lname" value="">
                            </div>

                            <div class="form-group">
                                <label for="gender">Gender <span>*</span></label>
                                <p id="l1_gender" class="error1">Invalid gender. try again...</p>
                                <select class="gender" id="egender" name="gender">
                                    <option value=""></option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="dob">Date of Birth <span>*</span></label>
                                <p id="l1_dob" class="error1">Date of Birth is Mandatory!. try again...</p>
                                <input type="date" class="dob" id="edob" name="dob" value="" required>
                            </div>

                            <div class="form-group">
                                <label for="photo">Photo <span>*</span></label>
                                <p id="l1_file" class="error1">File Upload is Mandatory!. try again...</p>
                                <input type="file" class="photo1" id="ephoto" name="photo" value="" accept="image/*" >
                                <span class="image"></span>
                                <input type="hidden" name="image" class="imageName" >
                            </div>
                        </fieldset>
        
                        <fieldset>
                            <legend>Contact Details</legend>
                            <div class="form-group">
                                <label for="phone">Phone No <span>*</span></label>
                                <p id="l1_phone" class="error1">Invalid phone number. try again...</p>
                                <input type="text" class="phone" id="ephone" name="phone" value="">
                            </div>

                            <div class="form-group">
                                <label for="address">Address <span>*</span></label>
                                <p id="l1_address" class="error1">Invalid address. try again...</p>
                                <input type="text" class="address" id="eaddress" name="address" value="">
                            </div>

                            <div class="form-group">
                                <label for="street">Street <span>*</span></label>
                                <p id="l1_street" class="error1">Invalid street. try again...</p>
                                <input type="text" class="street" id="estreet" name="street" value="">
                            </div>

                            <div class="check">
                                <label class="checkBoxL" for="epublic">Make as Public: </label>
                                <input class="checkBox" type="checkbox" id="epublic" name="epublic" value="True">
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

    </body>
</html>