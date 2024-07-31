<cfinvoke component="component.component" method="title" returnvariable="title">
<cfinvoke component="component.component" method="hobbies" returnvariable="hobbies">
<cfinvoke component="component.component" method="logout" returnvariable="logout">
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Contact Details</title>
        <link rel="stylesheet" href="css/styles4.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/create.js" defer></script>
    </head>
    <body>
        <nav>
            <ul>
                <li><a href="create.cfm?logout=true">Logout</a></li>
                <li><a href="list.cfm">List</a></li>
            </ul>
        </nav>
        <div class="container1">
            <h1>Contact Details</h1>
            <form id="createForm" action="" method="post" enctype="multipart/form-data">
                <fieldset>
                    <p id="l_email" class="error email"><b>Email Id Exists</b>. Try again with another email...</p>
                    <legend>Personal Details</legend>
                    <div class="form-group">
                        <label for="title">Title <span>*</span></label>
                        <p id="l_title" class="error">Invalid title. Try again...</p>
                        <select id="title" name="title">
                            <option value=""></option>
                            <cfloop query="title">
                                <cfoutput>
                                    <option value="#title.title_id#">#title.title#</option>
                                </cfoutput>
                            </cfloop>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="fname">First Name <span>*</span></label>
                        <p id="l_fname" class="error">Invalid first name. Try again...</p>
                        <input type="text" id="fname" name="fname" >
                    </div>

                    <div class="form-group">
                        <label for="lname">Last Name <span>*</span></label>
                        <p id="l_lname" class="error">Invalid last name. Try again...</p>
                        <input type="text" id="lname" name="lname" >
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Gender <span>*</span></label>
                        <p id="l_gender" class="error">Invalid gender. Try again...</p>
                        <select id="gender" name="gender">
                            <option value=""></option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="dob">Date of Birth <span>*</span></label>
                        <p id="l_dob" class="error">Date of Birth is Mandatory!. Try again...</p>
                        <input type="date" id="dob" name="dob" >
                    </div>

                    <div class="form-group">
                        <label for="photo">Photo <span>*</span></label>
                        <p id="l_file" class="error">File Upload is Mandatory!. Try again...</p>
                        <input type="file" id="photo" name="photo" accept="image/png, image/jpeg, image/jpg">
                    </div>

                    <div class="form-group">
                        <label for="hobby">Hobbies <span>*</span></label>
                        <p id="l_hobbie" class="error">Select minimum 3. Try again...</p>
                        <select id="hobbie" name="hobbie" multiple>
                            <cfloop query="hobbies">
                                <cfoutput>
                                    <option value="#hobbies.Id#">#hobbies.hobbies#</option>
                                </cfoutput>
                            </cfloop>
                        </select>
                    </div>
                </fieldset>

                <fieldset>

                    <legend>Contact Details</legend>
                    
                    <div class="form-group">
                        <label for="phone">Phone No <span>*</span></label>
                        <p id="l_phone" class="error">Invalid phone number. Try again...</p>
                        <input type="text" id="phone" name="phone" >
                    </div>

                    <div class="form-group">
                        <label for="contactEmail">Email <span>*</span></label>
                        <p id="l_contactEmail" class="error">Invalid Email Address. Try again...</p>
                        <input type="text" id="contactEmail" name="contactEmail" >
                    </div>

                    <div class="form-group">
                        <label for="address">Address <span>*</span></label>
                        <p id="l_address" class="error">Invalid address. Try again...</p>
                        <input type="text" id="address" name="address" >
                    </div>

                    <div class="form-group">
                        <label for="street">Street <span>*</span></label>
                        <p id="l_street" class="error">Invalid street. Try again...</p>
                        <input type="text" id="street" name="street" >
                    </div>
                    
                    <div class="check">
                        <label class="checkBoxL" for="publicl">Make as Public: </label>
                        <input class="checkBox" type="checkbox" id="publicl" name="public" value="YES">
                    </div>
                </fieldset>
                <button id="createSubmit" type="submit" name="submit">Submit</button>
            </form>
        </div>
    </body>
</html>