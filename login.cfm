<cfif structKeyExists(session, "userId")>
    <cflocation  url="list.cfm" addToken="false">
</cfif>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/styles.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/login.js" defer></script>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            <p id="userNameMsg">Username or Password not valid. Try again..</p>
            <form action="" method="POST">
                <div class="input-group">
                    <label for="username">Username</label>
                    <p id="l_username" class="error">Invalid username. Try again...</p>
                    <input type="text" id="username" name="username">
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <p id="l_password" class="error">Invalid Password. Try again...</p>
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
        <cfset result = application.component.login(Lform=form) />

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