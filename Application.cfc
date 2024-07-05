<cfcomponent>
    <cfset this.component = createObject("component", "component.component") />
    <cfset this.name = "appTask">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 5, 0)>
    <cfset this.setClientCookies = true>
    

    <cffunction name="onRequestStart" returntype="void" output="false">
        <cfargument name="targetPage" type="string" required="true">
        
        <!--- Check if the user is logged in and the request is not for login.cfm --->
        <cfif NOT structKeyExists(session, "userId") 
            AND (listLast(arguments.targetPage, "/") != "login.cfm")
            AND listLast(arguments.targetPage, "/") != "register.cfm"
            AND listLast(arguments.targetPage, "/") != "test2.cfm">

            <cflocation url="login.cfm">
        </cfif>
    </cffunction>

</cfcomponent>


<!--- component {
    this.name = "appTask"; // Replace with your application name
    this.sessionManagement = true; // Enable session management
    this.sessionTimeout = createTimeSpan(0, 0, 5, 0); // Optional: set session timeout (20 minutes)
    // this.sessionStorage = "memory"; // Optional: specify session storage method

    function onApplicationStart() {
        // Code to run when the application starts
        return true;
    }

    function onRequestStart(requestContext) {
        // Code to run at the start of each request
        if (NOT structKeyExists(session, "userId")) {
            // Redirect to login page if not logged in
            cflocation(url="login.cfm");
        }
    }

    function onRequestEnd() {
        // Code to run at the end of each request
    }

    function onSessionStart() {
        // Code to run when a session starts
    }

    function onSessionEnd() {
        // Code to run when a session ends
    }
} --->

component {
    // Define application settings and methods

    // Application settings
    this.name = "appTask";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 5, 0); // 30 minutes session timeout
    this.setClientCookies = true;

    // Method that runs at the start of each request
    function onRequestStart(string targetPage) {
        // Check if the user is logged in
        if (NOT structKeyExists(session, "userId")) {
            // Redirect to login page if not logged in
            cflocation(url="login.cfm");
        }
    }

    // Other methods like onApplicationStart, onSessionStart, etc.
}




