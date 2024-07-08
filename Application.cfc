<cfcomponent>
    <cfset this.name = "appTask">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 5, 0)>
    <cfset this.setClientCookies = true>
    

    <cffunction name="onApplicationStart">
        <cfset application.component = createObject("component", "component.component") />
    </cffunction>

    <cffunction name="onRequestStart" returntype="void" output="false">
        <cfargument name="targetPage" type="string" required="true">
        
        <cfif structKeyExists(url, "reset")>
            <cfset onApplicationStart()>
        </cfif>

        <cfif NOT structKeyExists(session, "userId") 
            AND (listLast(arguments.targetPage, "/") != "login.cfm")
            AND listLast(arguments.targetPage, "/") != "register.cfm"
            AND listLast(arguments.targetPage, "/") != "test2.cfm">

            <cflocation url="login.cfm">
        </cfif>
        
    </cffunction>

</cfcomponent>