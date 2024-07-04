<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Page</title>
        <link rel="stylesheet" href="css/styles2.css" type="text/css">
        <script src="js/jquery.min.js"></script>
        <script src="js/register.js"></script>
    </head>
    <body>

        <div class="navbar">
            <a href="">ADDRESS BOOK</a>
            <div class="right">
                <a href="login.cfm">Login</a>
                <a href="register.cfm">Signup</a>
            </div>
        </div>
        <div class="container">
            <h2>Signup Form</h2>
            <cfinvoke  component="component.component" method="errorMessage" returnvariable="errorMsg">
            <cfoutput>#errorMsg#</cfoutput>
            <form action="" method="post">
                <label for="fullname">Full Name</label>
                <p id="l_fullname" class="error">Invalid fullname. try again...</p>
                <input type="text" id="fullname" name="fullname" placeholder="Your name..">

                <label for="email">Email</label>
                <p id="l_email" class="error">Invalid email. try again...</p>
                <input type="email" id="email" name="email" placeholder="Your email..">

                <label for="username">Username</label>
                <p id="l_username" class="error">Invalid username. try again...</p>
                <p id="l_username2" class="error">Username exists. try again...</p>
                <input type="text" id="username" name="username" placeholder="Your username.." >

                <label for="psw">Password</label>
                <p id="l_password" class="error">Password must contain 8 characters!. try again...</p>
                <input type="password" id="password" name="password" placeholder="Your password.." >

                <label for="Cpsw">Confirm Password</label>
                <p id="l_confirmPassword" class="error">password and confirm password not matching. try again...</p>
                <input type="password" id="confirmPassword" name="Cpassword" placeholder="Your password.." >

                <button type="submit" name="submit" id="registerForm">Register</button>
            </form>
        </div>
    </body>
</html>

<cftry>
    <cfif structKeyExists(form, "submit")>
        <cfset registerCFC = createObject("component", "component.component") />
        <cfset result = registerCFC.registerForm(form = #form#)>
    </cfif>
<cfcatch><cfdump  var="#cfcatch#"></cfcatch>
</cftry>



