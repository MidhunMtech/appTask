<cfcomponent>
    <cfset this.name = "appTask">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 5, 0)>
</cfcomponent>

<!---component {
    this.name = "appLogin"; // Replace with your application name
    this.sessionManagement = true; // Enable session management
    this.sessionTimeout = createTimeSpan(0, 0, 5, 0); // Optional: set session timeout (20 minutes)
    // this.sessionStorage = "memory"; // Optional: specify session storage method

    function onApplicationStart() {
        // Code to run when the application starts
        return true;
    }

    function onRequestStart(requestContext) {
        // Code to run at the start of each request
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
}--->





