<cftry>
    <cfif structKeyExists(form, "submit")>
        <cfset loginCFC = createObject("component", "component.component") />
        <cfset result = loginCFC.login(Lform=#form#) />
    </cfif>
<cfcatch>
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            <cfinvoke  component="component.component" method="errorMessage" returnvariable="errorMsg">
            <cfoutput>#errorMsg#</cfoutput>
            <form action="" method="POST">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username">
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password">
                </div>

                <button type="submit" name="submit">Login</button>
            </form>
            
            <p class="register">Don't have an account? <a href="register.cfm">Register here</a></p>
        </div>
    </body>
</html>

