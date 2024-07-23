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
            <p id="userNameMsg">Username exists. Try again..</p>
            <p id="registerMsg">Registration failed. Try again...</p>
            <form action="" method="post">
                <label for="fullname">Full Name</label>
                <p id="l_fullname" class="error">Invalid fullname. Try again...</p>
                <input type="text" id="fullname" name="fullname" placeholder="Your name..">

                <label for="email">Email</label>
                <p id="l_email" class="error">Invalid email. Try again...</p>
                <input type="email" id="email" name="email" placeholder="Your email..">

                <label for="username">Username</label>
                <p id="l_username" class="error">Invalid username. Try again...</p>
                <p id="l_username2" class="error">Username exists. Try again...</p>
                <input type="text" id="username" name="username" placeholder="Your username.." >

                <label for="psw">Password</label>
                <p id="l_password" class="error">Password must contain 8 characters!. Try again...</p>
                <input type="password" id="password" name="password" placeholder="Your password.." >

                <label for="Cpsw">Confirm Password</label>
                <p id="l_confirmPassword" class="error">password and confirm password not matching. Try again...</p>
                <input type="password" id="confirmPassword" name="Cpassword" placeholder="Your password.." >

                <button type="submit" name="submit" id="registerForm">Register</button>
            </form>
        </div>
    </body>
</html>

<cftry>
    <cfif structKeyExists(form, "submit")>
        <cfif NOT len(form.fullname)
            OR NOT len(form.email)
            OR NOT len(form.username)
            OR NOT len(form.password)
            OR NOT len(form.Cpassword)>
            
            <cflocation  url="register.cfm?error=register">
        <cfelse>
            <cfset result = application.component.signUp(form = form)>
            <cfif result EQ "1">
                <cflocation  url="login.cfm">
            <cfelse>
                <cflocation  url="register.cfm?error=2">
            </cfif>
        </cfif>
    </cfif>
<cfcatch>
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>