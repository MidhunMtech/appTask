<cfinvoke component="component.component" method="logout" returnvariable="logout">
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Contact Details</title>
        <link rel="stylesheet" href="css/styles4.css">
    </head>
    <body>
        <nav>
            <ul>
                <li><a href="create.cfm?logout=true">Logout</a></li>
                <li><a href="list.cfm">List</a></li>
            </ul>
        </nav>
        <div class="container">
            <h1>Contact Details</h1>
            <cfinvoke  component="component.component" method="errorMessage" returnvariable="errorMsg">
            <cfoutput>#errorMsg#</cfoutput>
            <form action="" method="post" enctype="multipart/form-data">
                <fieldset>
                    <legend>Personal Details</legend>
                    <div class="form-group">
                        <label for="title">Title <span>*</span></label>
                        <select id="title" name="title">
                            <option value=""></option>
                            <option value="Mr.">Mr.</option>
                            <option value="Ms.">Ms.</option>
                            <option value="Mrs.">Mrs.</option>
                            <option value="Dr.">Dr.</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="fname">First Name <span>*</span></label>
                        <input type="text" id="fname" name="fname" >
                    </div>
                    <div class="form-group">
                        <label for="lname">Last Name <span>*</span></label>
                        <input type="text" id="lname" name="lname" >
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender <span>*</span></label>
                        <select id="gender" name="gender">
                            <option value=""></option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="dob">Date of Birth <span>*</span></label>
                        <input type="date" id="dob" name="dob" >
                    </div>
                    <div class="form-group">
                        <label for="photo">Photo <span>*</span></label>
                        <input type="file" id="photo" name="photo" accept="image/*">
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Contact Details</legend>
                    <div class="form-group">
                        <label for="phone">Phone No <span>*</span></label>
                        <input type="text" id="phone" name="phone" >
                    </div>
                    <div class="form-group">
                        <label for="address">Address <span>*</span></label>
                        <input type="text" id="address" name="address" >
                    </div>
                    <div class="form-group">
                        <label for="street">Street <span>*</span></label>
                        <input type="text" id="street" name="street" >
                    </div>
                </fieldset>

                <button type="submit" name="submit">Submit</button>
            </form>
        </div>
    </body>
</html>

<cftry>
    <cfif structKeyExists(form, "submit")>
        <cfset contactCFC = createObject("component", "component.component") />
        <cfset result = contactCFC.Addcontact(form = #form#) />
    </cfif>
<cfcatch >
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>