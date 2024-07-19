Inside "getContacts" method
<!--- Query for checking user details exists in the contacts table, If not exists redirect to create.cfm --->
<!---<cfquery name="local.contactCheck" datasource="cfTask2">
    SELECT 
        T1.nameID,
        T2.nameId_fk
    FROM
        registerForm AS T1
    INNER JOIN 
        contacts AS T2
    ON 
        T1.nameID = T2.nameId_fk
    WHERE
        T1.nameID = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
        AND T2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
</cfquery>
    <cfif queryRecordCount(local.contactCheck) EQ "0"> <!--If user details not exists redirect to create.cfm -->
    <cflocation  url="create.cfm">
</cfif> --->



Inside "Login" method
<!-- Query for checking user details exists in the contacts table, If exists redirect to list.cfm -->
<!--- <cfquery name="local.userCheck" datasource="cfTask2">    
    SELECT 
        T1.nameId_fk,
        T2.nameID
    FROM 
        contacts as T1
    INNER JOIN 
        registerForm as T2
    ON 
        T1.nameId_fk = T2.nameID
    WHERE
        T1.nameId_fk = <cfqueryparam value="#local.checkUser.nameID#" cfsqltype="cf_sql_integer">
        AND T1.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
</cfquery>
<cfif queryRecordCount(local.userCheck) EQ "0"> <!-- If user exists redirect to list.cfm -->
    <cflocation url="create.cfm" />
<cfelse> 
<cflocation  url="list.cfm">
</cfif>  
--->


"UserDetails" method earlier
<!---<cffunction  name="userDetails" access="public" returnType="query" hint="This is for Edit the contact details">
    <cfif NOT structKeyExists(session, "userId")>
        <cflocation  url="login.cfm">
    </cfif>
    <cfquery name="local.userDetails" datasource="cfTask2">
        SELECT * 
        FROM contacts
        WHERE
            userId = <cfqueryparam value="#url.userid#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn local.userDetails />
</cffunction> --->



Error Messages
<!--- <cfif structKeyExists(url, "pdf") AND url.pdf EQ "true">
    <cfset local.error = "<p style='color: green; text-align:center;'>PDF download Successfully....</p>" />
</cfif>
<cfif structKeyExists(url, "print") AND url.print EQ "true">
    <cfset local.error = "<p style='color: green; text-align:center;'>Print done Successfully....</p>" />
</cfif>
<cfif structKeyExists(url, "excel") AND url.excel EQ "true">
    <cfset local.error = "<p style='color: green; text-align:center;'>Excel download Successfully....</p>" />
</cfif> --->



PASSWORD check condition
<!--- <cfquery name="local.checkUser" datasource="cfTask2">
    SELECT 
        nameID,
        username,
        password,
        salt
    FROM
        registerForm
    WHERE
        username = <cfqueryparam value="#arguments.Lform.username#" cfsqltype="cf_sql_varchar">
        AND password = <cfqueryparam value="#local.hashedPassword#" cfsqltype="cf_sql_varchar">
</cfquery>
<cfif queryRecordCount(local.checkUser) EQ "1">
    <cfset session.userId = local.checkUser.nameID />
    <cfset session.userName = local.checkUser.username />
    <cfset local.return = "1">
<cfelse>
    <cfset local.return = "0">
</cfif> --->

SESSIO TIMEOUT
<!--- <cfif NOT structKeyExists(session, "userId")>
    <cflocation  url="login.cfm">
</cfif> --->


for ajax 
<!---     <cffunction name="checkUsernameExists" access="remote" returnformat="json">
    <cfargument name="username" type="string" required="true">

    <cfquery name="local.checkUser" datasource="cfTask2">
        SELECT 
            COUNT(*) AS userCount
        FROM 
            registerForm
        WHERE 
            username = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfreturn local.checkUser>
</cffunction> --->


application.cfc   
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
} 

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
}--->

getdata function
<!--- <cffunction  name="getData" returnType="query" access="public" hint="Fetching contacts table for pdf, print, and excel download">
        <cfquery name="local.pdfData" datasource="#application.db#">
            SELECT 
                t1.nameID AS ID,
                t2.userId AS userId,
                concat(t2.fname, " ", t2.lname) AS fullname,
                t1.email AS email,
                t2.gender AS gender,
                t2.DOB AS DOB,
                t2.photoName AS photoName,
                t2.phone AS phone,
                t2.address AS address,
                t2.street AS street,
                t2.nameId_fk AS nameId_fk,
                t2.public AS public
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
            ON 
                t2.nameId_fk = t1.nameId
            WHERE
                t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                AND (
                    t2.nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                    OR t2.public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                )
        </cfquery>

        <cfreturn local.pdfData />
    </cffunction> --->

    <!--- <cffunction  name="getContacts" returnType="query" access="public" hint="To fetch the contacts table to show in the list">
        <cfquery name="local.getContacts" datasource="#application.db#">
            SELECT 
                concat(fname," ",lname) AS fullname,
                title_id,
                phone,
                photoName,
                userId,
                is_delete,
                nameId_fk
            FROM 
                contacts
            WHERE
                is_delete = 0
                AND nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn local.getContacts>
    </cffunction>


    <cffunction  name="getPublicContacts" returnType="query" access="public" hint="To fetch the contacts table to show in the list">
        <cfquery name="local.getPublicContacts" datasource="#application.db#">
            SELECT 
                concat(fname," ",lname) AS fullname,
                title_id,
                phone,
                photoName,
                userId,
                is_delete,
                nameId_fk,
                public
            FROM 
                contacts
            WHERE
                is_delete = 0
                AND public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                AND nameId_fk != <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn local.getPublicContacts>
    </cffunction> --->


    ERROR MESSAGE EXAMPLE
    <!--- <cfset local.retStruct = {
            "error" : false,
            "message" : "",
            "result" : {}
        }> 

    <cftry>
        <cfset local.retStruct.result = local.userArray>
    <cfcatch>
        <cfdump  var="#cfcatch#">
        <cfset local.retStruct.error = true>
        <cfset local.retStruct.message = "Unexpected error!!! Try again later">
    </cfcatch>
    </cftry>
    <cfreturn local.retStruct/>
    --->


    userDetails Function
    <!--- <cffunction name="userDetails" access="remote" returnformat="json" hint="datas to show for update">
        <cfargument name="userid" type="numeric" required="true">
        
        <!--- <cfset local.userStruct = {}> --->
        <cfquery name="local.getUser" datasource="#application.db#">
            SELECT 
                T1.title AS title_name,
                T2.fname AS fname, 
                T2.lname AS lname, 
                T2.gender AS gender, 
                T2.DOB AS DOB, 
                T2.photoName AS photoName, 
                T2.phone AS phone, 
                T2.address AS address, 
                T2.street AS street,
                T2.userId AS userId,
                T1.title_id AS title_id,
                T2.public AS public
            FROM 
                title_names AS T1
            INNER JOIN
                contacts AS T2
            ON 
                T1.title_id = T2.title_id
            WHERE 
                userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
        </cfquery>
    <!--- <cfloop query="local.getUser"> --->
        <cfset local.userStruct = structNew() />
        <cfset local.userStruct["title_name"] = local.getUser.title_name />
        <cfset local.userStruct["fname"] = local.getUser.fname />
        <cfset local.userStruct["lname"] = local.getUser.lname />
        <cfset local.userStruct["gender"] = local.getUser.gender />
        <cfset local.userStruct["DOB"] = local.getUser.DOB />
        <cfset local.userStruct["photoName"] = local.getUser.photoName />
        <cfset local.userStruct["phone"] = local.getUser.phone />
        <cfset local.userStruct["address"] = local.getUser.address />
        <cfset local.userStruct['street'] = local.getUser.street />
        <cfset local.userStruct['userId'] = local.getUser.userId />
        <cfset local.userStruct['title_id'] = local.getUser.title_id />
        <cfset local.userStruct['public'] = local.getUser.public/>
        <!--- <cfset local.userStruct = {
            "title_name" : local.getUser.title_name,
            "fname" : local.getUser.fname,
            
        }> --->
        <!--- <cfset arrayAppend(local.returnArray, local.userStruct)>
        <cfset arrayAppend(local.returnArray, {
            "title_name" : local.getUser.title_name,
            "fname" : local.getUser.fname,
            
})>
    </cfloop> --->
        <cfreturn local.userStruct />
        <!--- <cfreturn local.returnArray /> --->
    </cffunction> --->


    viewuser Function
    <!--- <cffunction  name="viewUser" access="remote" returnformat="json" hint="this to view contact details for each user">
        <cfargument name="userid" type="numeric" required="true"> 

        <cftry>
            <cfset local.userArray = structNew() />
            <cfquery name="local.viewUser" datasource="#application.db#">
                SELECT 
                    t1.email AS email,
                    t2.userId AS userId,
                    concat(t2.fname," ",t2.lname) AS fullname,
                    t2.gender AS gender,
                    t2.DOB AS DOB,
                    t2.photoName AS PhotoName,
                    t2.phone AS phone,
                    t2.address AS address,
                    t2.street AS street
                FROM
                    registerForm AS t1
                INNER JOIN 
                    contacts AS t2
                ON 
                    t2.nameId_fk = t1.nameId
                WHERE
                    t2.userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
            </cfquery>

            <cfset local.userArray.email = local.viewUser.email />
            <cfset local.userArray.userId = local.viewUser.userId />
            <cfset local.userArray.fullname = local.viewUser.fullname />
            <cfset local.userArray.gender = local.viewUser.gender />
            <cfset local.userArray.DOB = local.viewUser.DOB />
            <cfset local.userArray.PhotoName = local.viewUser.PhotoName />
            <cfset local.userArray.phone = local.viewUser.phone />
            <cfset local.userArray.address = local.viewUser.address />
            <cfset local.userArray.street = local.viewUser.street />
        <cfcatch>
            <cfdump  var="#cfcatch#">
        </cfcatch>
        </cftry>
        <cfreturn local.userArray/>
    </cffunction> --->