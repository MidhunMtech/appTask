<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/styles.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/login.js"></script>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            <cfinvoke  component="component.component" method="errorMessageList" returnvariable="errorMsg">
            <cfoutput>#errorMsg#</cfoutput>
            <form action="" method="POST">
                <div class="input-group">
                    <label for="username">Username</label>
                    <p id="l_username" class="error">Invalid username. try again...</p>
                    <input type="text" id="username" name="username">
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <p id="l_password" class="error">Invalid Password. try again...</p>
                    <input type="password" id="password" name="password">
                </div>

                <button id="registerForm" type="submit" name="submit">Login</button>
            </form>
            
            <p class="register">Don't have an account? <a href="register.cfm">Register here</a></p>
        </div>
    </body>
</html>

<cftry>
    <cfif structKeyExists(form, "submit")>
        <cfset result = application.component.login(Lform=#form#) />

        <cfif result EQ "1">
            <cflocation url="list.cfm" />
        <cfelse>
            <cflocation url="login.cfm?error=1" />
        </cfif>
    </cfif>
<cfcatch>
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>