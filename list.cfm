<cftry>
<cfinvoke component="component.component" method="logout" returnvariable="logout">
<cfinvoke component="component.component" method="title" returnvariable="title">
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
                <li><a href="excelNew.cfm">Excel</a></li>
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
                <p id="createPop"><cfinclude template="create.cfm"></p>
            </div>
        </div>

        <div id="myModal2" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <form id="editForm" action="editAction.cfm" method="post" enctype="multipart/form-data">
                    <p id="label1">Fill All Inputs. And try again....</p>
                    <fieldset>
                        <legend>Personal Details</legend>
                        <div class="form-group">
                            <label for="title">Title <span>*</span></label>
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
                            <input type="text" class="fname" id="fname" name="fname" value="">
                        </div>

                        <div class="form-group">
                            <label for="lname">Last Name <span>*</span></label>
                            <input type="text" class="lname" id="lname" name="lname" value="">
                        </div>

                        <div class="form-group">
                            <label for="gender">Gender <span>*</span></label>
                            <select class="gender" id="gender" name="gender">
                                <option value=""></option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="dob">Date of Birth <span>*</span></label>
                            <input type="date" class="dob" id="dob" name="dob" value="" required>
                        </div>

                        <div class="form-group">
                            <label for="photo">Photo <span>*</span></label>
                            <input type="file" class="photo1" id="photo" name="photo" value="" accept="image/*" >
                        </div>
                    </fieldset>
    
                    <fieldset>
                        <legend>Contact Details</legend>
                        <div class="form-group">
                            <label for="phone">Phone No <span>*</span></label>
                            <input type="text" class="phone" id="phone" name="phone" value="">
                        </div>

                        <div class="form-group">
                            <label for="address">Address <span>*</span></label>
                            <input type="text" class="address" id="addres" name="address" value="">
                        </div>

                        <div class="form-group">
                            <label for="street">Street <span>*</span></label>
                            <input type="text" class="street" id="stree" name="street" value="">
                        </div>
                    </fieldset>

                    <input type="hidden" class="userid" name="userid" value="">

                    <button id="submitId" class="btn2" type="submit" name="submit">Update</button>
                </form>
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

        <script src="js/jquery.min.js"></script>
        <script src="js/modal.js"></script>

    </body>
</html>
<cfcatch type="any">
<cfdump  var="#cfcatch#">
</cfcatch>
</cftry>