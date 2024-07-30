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


    ScheduledTask Function
    
    <!--- <cffunction  name="scheduleData" access="public" returnType="query" hint="Data for scheduling mail">
        <cfquery name="local.scheduleData" datasource="#application.db#">
            SELECT 
                DOB,
                concat(fname, " ", lname) AS fullname,
                userId,
                is_delete
            FROM
                contacts
        </cfquery>

        <cfreturn local.scheduleData>
    </cffunction> --->


schedule
    <!--- <cftry>
    <cfinvoke component="component.component" method="mailData" returnVariable="scheduleData">
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>

<cfset num = 1>
<cfloop query="scheduleData">
    <cfset date="#scheduleData.DOB#">
    <cfset day = day(date)> 
    <cfset month = month(date)>
    <cfset year = year(now())>
    <cfset myDate = DateFormat(CreateDate(year, month, day), "yyyy-mm-dd")>
    <cfset today = DateFormat(now(), "yyyy-mm-dd")>
    
    <cftry>
        <cfif myDate EQ today>
            <cfset name = "sendEmailTask#num#" >
            <cfschedule action="update"
                task="#name#"
                operation="HTTPRequest"
                url="http://appTask.local.com/scheduledTask/mail.cfm?id=#scheduleData.userId#"
                startDate="#myDate#"
                startTime="11:00 AM"
                interval="once">
            <cfset num += 1>
        </cfif>
    <cfcatch type="any">
        <cfdump  var="#cfcatch#">
    </cfcatch>
    </cftry>

</cfloop> --->


USERDETAILS FUNCTCION WITH QUERY
<!--- <cffunction name="userDetails" access="remote" returnformat="json" hint="datas to show for update">
        <cfargument name="userid" type="any" required="false">

        <cfif structKeyExists(arguments, "userid")>
            <cfif isNumeric(arguments.userid)>
                <cfset local.decryptedUserId = "#arguments.userid#" />
            <cfelse>
                <cfset local.encryptionKey = "oK455VMW4Cx55FvtTF5vWg==">  <!---<cfset encryptionKey = GenerateSecretKey("AES")> --->
                <cfset local.decryptedUserId = Decrypt(#arguments.userid#, local.encryptionKey, "AES", "Base64")>
            </cfif>
        </cfif>

<!---         <cfset local.userStruct = {}> --->
        <cfquery name="local.getUser" datasource="#application.db#">
            SELECT 
                T1.title AS title_name,
                T2.fname AS fname, 
                T2.lname AS lname, 
                concat(T2.fname , " ", T2.lname) AS fullname,
                T2.gender AS gender, 
                T2.DOB AS DOB, 
                T2.photoName AS photoName, 
                T2.phone AS phone, 
                T2.address AS address, 
                T2.street AS street,
                T2.userId AS userId,
                T1.title_id AS title_id,
                T2.public AS public,
                T3.email AS email,
                T2.nameId_fk AS nameId_fk
            FROM 
                title_names AS T1
            INNER JOIN
                contacts AS T2
                ON 
                    T1.title_id = T2.title_id
            INNER JOIN 
                registerForm as T3
                ON
                    T2.nameId_fk = T3.nameId
            WHERE
                1=1
                <cfif structKeyExists(arguments, "userid")>
                    AND userId = <cfqueryparam value="#local.decryptedUserId#" cfsqltype="cf_sql_integer">
                </cfif>
        </cfquery>

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
        <cfset local.userStruct['email'] = local.getUser.email/>
        <cfset local.userStruct['nameId_fk'] = local.getUser.nameId_fk/>
        <cfset local.userStruct['fullname'] = local.getUser.fullname/>
        
        <cfreturn local.userStruct />
    </cffunction> --->



MAILDATA FUNCTION
   <!---  <cffunction  name="mailData" access="public" returnType="query" hint="Data for mail content according to url userId">
        <cfquery name="local.mailData" datasource="#application.db#">
            SELECT 
                concat(t2.fname, " ", t2.lname) AS fullname,
                t1.email AS email,
                t2.DOB AS DOB
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
            ON 
                t2.nameId_fk = t1.nameId
            WHERE
                t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn local.mailData />
    </cffunction> --->


    some more function 
    <!--- <cffunction name="userDetails" access="remote" returnformat="json" hint="datas for update and view using ajax">
        <cfargument name="userid" type="any" required="true">

        <cfif structKeyExists(arguments, "userid")>
            <cfif isNumeric(arguments.userid)>
                <cfset local.decryptedUserId = arguments.userid />
            <cfelse>
                <cfset local.encryptionKey = "oK455VMW4Cx55FvtTF5vWg==">  <!---<cfset encryptionKey = GenerateSecretKey("AES")> --->
                <cfset local.decryptedUserId = Decrypt(arguments.userid, local.encryptionKey, "AES", "Base64")>
            </cfif>
        </cfif>

        <cfset local.getUser = userDetailsQuery(userid = local.decryptedUserId)>

        <cfset local.userStruct = structNew() />
        <cfset local.userStruct["title_name"] = local.getUser.title_name />
        <cfset local.userStruct["fname"] = local.getUser.fname />
        <cfset local.userStruct["lname"] = local.getUser.lname />
        <cfset local.userStruct["gender"] = local.getUser.gender />
        <cfset local.userStruct["DOB"] = local.getUser.DOB />
        <cfset local.userStruct["photoName"] = local.getUser.photoName />
        <cfset local.userStruct["phone"] = local.getUser.phone />
        <cfset local.userStruct["address"] = local.getUser.address />
        <cfset local.userStruct["street"] = local.getUser.street />
        <cfset local.userStruct["userId"] = local.getUser.userId />
        <cfset local.userStruct["title_id"] = local.getUser.title_id />
        <cfset local.userStruct["public"] = local.getUser.public/>
        <cfset local.userStruct["email"] = local.getUser.email/>
        <cfset local.userStruct["nameId_fk"] = local.getUser.nameId_fk/>
        <cfset local.userStruct["fullname"] = local.getUser.fullname/>
        
        <cfreturn local.userStruct>
    </cffunction>


    <cffunction name="userDetailsQuery" access="public" returnType="query" hint="datas for schedule, and userDetails() function">
        <cfargument name="userid" type="any" required="false">

        <cfquery name="local.getUser" datasource="#application.db#">
            SELECT 
                T1.title AS title_name,
                T2.fname AS fname, 
                T2.lname AS lname, 
                concat(T2.fname , " ", T2.lname) AS fullname,
                T2.gender AS gender, 
                T2.DOB AS DOB, 
                T2.photoName AS photoName, 
                T2.phone AS phone, 
                T2.address AS address, 
                T2.street AS street,
                T2.userId AS userId,
                T1.title_id AS title_id,
                T2.public AS public,
                T3.email AS email,
                T2.nameId_fk AS nameId_fk
            FROM 
                title_names AS T1
            INNER JOIN
                contacts AS T2
                ON 
                    T1.title_id = T2.title_id
            INNER JOIN 
                registerForm as T3
                ON
                    T2.nameId_fk = T3.nameId
            WHERE
                <cfif structKeyExists(arguments, "userid")>
                    userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
                <cfelse>
                    T2.is_delete = 0
                </cfif>
        </cfquery>

        <cfreturn local.getUser />
    </cffunction> --->


ajax editpop
 <!---
    $(".editPop").click(function() {
        var userid = $(this).data('userid');
        $.ajax({
            url: '../component/component.cfc?method=fullContacts',
            method: 'POST',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                console.log(userData);
                $('#myModal2').show();

                $('.title').val(userData[0].title_id);
                $('.title').text(userData[0].title_name);
                $('.fname').val(userData[0].fname);
                $('.lname').val(userData[0].lname);
                $('.gender').val(userData[0].gender);
                $('.image').text(userData[0].photoName);
                $('.imageName').val(userData[0].photoName);
                $('.phone').val(userData[0].phone);
                $('.address').val(userData[0].address);
                $('.street').val(userData[0].street);
                $('.userid').val(userData[0].userId);
                // $('.title').val(userData.DATA[0][10]);
                // changing format of DOB.
                var dateString = userData[0].DOB;
                var dateObj = new Date(dateString);
                var formattedDate = dateObj.getFullYear() + '-' + ('0' + (dateObj.getMonth() + 1)).slice(-2) + '-' + ('0' + dateObj.getDate()).slice(-2);
                $('.dob').val(formattedDate);
                if (userData[0].public === "YES") {
                    $('.checkBox').prop('checked', true);
                } else {
                    $('.checkBox').prop('checked', false);   
                }
            },
            error: function(xhr, status, error) {
                console.error("Error fetching user details:", error);
            }
        });
    }); --->



updateContactDetails function
    <!---
<cffunction name="updateContactDetails" returnType="void" access="public" hint="To update the contact details">
        <cfargument  name="form" type="any" required="true">
        <cfargument  name="photo" type="any" required="true">
        <cfargument  name="isPublic" type="string" required="true">

        <cfquery name="local.contactInsert" datasource="#application.db#">
            UPDATE 
                contacts
            SET 
                title_id = <cfqueryparam value="#arguments.form.title#" cfsqltype="cf_sql_integer">,
                fname = <cfqueryparam value="#arguments.form.fname#" cfsqltype="cf_sql_varchar">,
                lname = <cfqueryparam value="#arguments.form.lname#" cfsqltype="cf_sql_varchar">,
                gender = <cfqueryparam value="#arguments.form.gender#" cfsqltype="cf_sql_varchar">,
                DOB = <cfqueryparam value="#arguments.form.dob#" cfsqltype="cf_sql_date">,
                PhotoName = <cfqueryparam value="#arguments.photo#" cfsqltype="cf_sql_varchar">,
                phone = <cfqueryparam value="#arguments.form.phone#" cfsqltype="cf_sql_varchar">,
                address = <cfqueryparam value="#arguments.form.address#" cfsqltype="cf_sql_varchar">,
                street = <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">,
                public = <cfqueryparam value="#arguments.isPublic#" cfsqltype="cf_sql_varchar">
            WHERE
                userId = <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">
                AND nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>
    --->



Full CONTACTS
    <!--- <cffunction  name="fullContacts" returnformat="json" access="remote" hint="For listDetails, Pdf, Excel, Scheduled Task, Edit and View">
        <cfargument name="userid" type="numeric" required="false">
        <cfargument  name="getBirthdayOnly" type="numeric" required="false">

        <cfset local.returnArray = [] >
        <cfset local.contactsArray = [] >
        <cfset local.hobbieArray = [] >
        <cfquery name="local.getContactDetails" datasource="#application.db#">
            SELECT
                t3.title AS title_name,
                t1.nameID AS ID,
                t2.userId AS userId,
                concat(t2.fname, " ", t2.lname) AS fullname,
                t2.fname AS fname,
                t2.lname As lname,
                t1.email AS email,
                t2.gender AS gender,
                t2.DOB AS DOB,
                t2.photoName AS photoName,
                t2.phone AS phone,
                t2.address AS address,
                t2.street AS street,
                t2.nameId_fk AS nameId_fk,
                t2.public AS public,
                t2.is_delete AS is_delete,
                t2.title_id AS title_id,
                t2.emailAddress AS contactEmail<!---,
                t4.hobbie_id AS hobbieNumber,
                t4.contact_userId AS contactHobbieUserid,
                t4.user_hobbie_id AS hobbieUniqueId,
                t5.hobbies AS hobbies--->
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
                ON 
                    t2.nameId_fk = t1.nameId
            INNER JOIN
                title_names AS t3
                ON 
                    t3.title_id = t2.title_id
            <!---INNER JOIN 
                User_Hobbies As t4
                ON
                    t4.contact_userId = t2.userId
            INNER JOIN 
                hobbies As t5
                ON
                    t4.hobbie_id = t5.Id--->
            WHERE
                is_delete = 0
                <cfif structKeyExists(arguments, "userid")>
                    AND userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
                <cfelseif structKeyExists(arguments, "getBirthdayOnly") AND arguments.getBirthdayOnly EQ 1>
                    AND CURDATE() = str_to_date(CONCAT(YEAR(NOW()), '-', MONTH(DOB), '-', DAY(DOB)), "%Y-%m-%d")
                <cfelse>
                    AND (
                        nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                        OR public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                    )
                </cfif>
        </cfquery>

        <cfloop query="local.getContactDetails">
            <cfset local.structContacts = {
                "ID" : local.getContactDetails.ID,
                "userId" : local.getContactDetails.userId,
                "fullname" : local.getContactDetails.fullname,
                "email" : local.getContactDetails.email,
                "gender" : local.getContactDetails.gender,
                "DOB" : local.getContactDetails.DOB,
                "address" : local.getContactDetails.address,
                "street" : local.getContactDetails.street,
                "title_id" : local.getContactDetails.title_id,
                "phone" : local.getContactDetails.phone,
                "photoName" : local.getContactDetails.photoName,
                "is_delete" : local.getContactDetails.is_delete,
                "nameId_fk" : local.getContactDetails.nameId_fk,
                "public" : local.getContactDetails.public,
                "title_name" : local.getContactDetails.title_name,
                "fname" : local.getContactDetails.fname,
                "lname" : local.getContactDetails.lname,
                "contactEmail" : local.getContactDetails.contactEmail<!---,
                "hobbieNumber" : local.getContactDetails.hobbieNumber,
                "contactHobbieUserid" : local.getContactDetails.contactHobbieUserid,
                "hobbieUniqueId" : local.getContactDetails.hobbieUniqueId,
                "hobbies" : local.getContactDetails.hobbies--->

            } >

            <cfset arrayAppend(local.contactsArray, local.structContacts)>

            <!--- <cfif structKeyExists(arguments, "userid")>
                <cfset local.structHobbie = {
                    "hobbieNumber" : local.getContactDetails.hobbieNumber,
                    "contactHobbieUserid" : local.getContactDetails.contactHobbieUserid,
                    "hobbieUniqueId" : local.getContactDetails.hobbieUniqueId,
                    "hobbies" : local.getContactDetails.hobbies
                }>
    
                <cfset arrayAppend(local.returnArray, local.structHobbie)>
            </cfif>  --->
        </cfloop>

        <!--- <cfloop query="local.getContactDetails">
            <cfset local.structHobbie = {
                "hobbieNumber" : local.getContactDetails.hobbieNumber,
                "contactHobbieUserid" : local.getContactDetails.contactHobbieUserid,
                "hobbieUniqueId" : local.getContactDetails.hobbieUniqueId,
                "hobbies" : local.getContactDetails.hobbies
            }>

            <cfset arrayAppend(local.returnArray, local.structHobbie)>
        </cfloop> --->

        <cfset arrayAppend(local.returnArray, local.contactsArray)>

        <cfquery name="local.getHobbieDetails" datasource="#application.db#">
            SELECT 
                T1.Id AS hobbieId,
                T1.hobbies AS hobbieName,
                T2.hobbie_id AS T2hobbieId,
                T2.contact_userId AS contactHobbieUserid,
                T2.user_hobbie_id AS hobbieUniqueId,
                T3.is_delete AS is_delete
            FROM
                hobbies AS T1
            INNER JOIN
                User_Hobbies AS T2
                ON
                    T1.Id = T2.hobbie_id
            INNER JOIN
                contacts AS T3
                ON
                    T3.userId = T2.contact_userId
            WHERE
                is_delete = 0
                <cfif structKeyExists(arguments, "userid")>
                    AND T2.contact_userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
                <cfelseif NOT structKeyExists(arguments, "getBirthdayOnly")>
                    AND (
                        T3.nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                        OR T3.public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                    )
                </cfif>
        </cfquery>

        <cfloop query="local.getHobbieDetails">
            <cfset local.structHobbie = {
                "hobbieId" : local.getHobbieDetails.hobbieId,
                "hobbieName" : local.getHobbieDetails.hobbieName,
                "T2hobbieId" : local.getHobbieDetails.T2hobbieId,
                "contactHobbieUserid" : local.getHobbieDetails.contactHobbieUserid,
                "hobbieUniqueId" : local.getHobbieDetails.hobbieUniqueId
            }> 

            <!--- <cfset arrayAppend(local.hobbieArray, local.getHobbieDetails.T2hobbieId)> --->
            <cfset arrayAppend(local.hobbieArray, local.structHobbie)>
        </cfloop>
        <cfset arrayAppend(local.returnArray, local.hobbieArray)>
        
        <cfreturn local.returnArray />
    </cffunction> --->


    CREATE AND UPDATE FUNCTION
<!--- <cfloop query="local.checkHobbies">
                <cfset arrayAppend(local.hobbiesIdArray, local.checkHobbies.Id)>
            </cfloop> --->

            <!--- <cfset local.hobbieArray = listToArray(arguments.form.hobbie)> --->
    <!--- <cfloop query="local.getHobbiesOfUser">
                        <cfset arrayAppend(local.arrayCheckHobbie, local.getHobbiesOfUser.hobbie_id)>
                    </cfloop> --->

                    <!--- <cfloop array="#local.arrayCheckHobbie#" index="local.hobbie">
                        <cfif NOT arrayFind(local.hobbieArray, local.hobbie)>
                            <cfquery name="local.deleteHobbie" datasource="#application.db#">
                                DELETE FROM 
                                    User_Hobbies
                                WHERE 
                                    contact_userId = <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">
                                    AND hobbie_id = <cfqueryparam value="#local.hobbie#" cfsqltype="cf_sql_integer">
                            </cfquery>
                        </cfif>
                    </cfloop> --->
                    
                    <!--- <cfloop array="#local.hobbieArray#" index="local.hobbie">
                        <cfif NOT arrayFind(local.arrayCheckHobbie, local.hobbie) AND arrayFind(local.hobbiesIdArray, local.hobbie)>
                            <cfquery name="local.insertHobbieEdit" datasource="#application.db#">
                                INSERT INTO
                                    User_Hobbies (
                                        contact_userId,
                                        hobbie_id
                                    )
                                VALUES
                                    (
                                        <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">,
                                        <cfqueryparam value="#local.hobbie#" cfsqltype="cf_sql_integer">
                                    )
                            </cfquery>
                        </cfif>
                    </cfloop> --->
                        <!--- <cfloop array="#local.hobbieArray#" index="local.hobbie">
                        <cfif arrayFind(local.hobbiesIdArray, local.hobbie)>
                            <cfquery name="local.addHobbie" datasource="#application.db#">
                                INSERT INTO
                                    User_Hobbies (
                                        contact_userId,
                                        hobbie_id
                                    )
                                VALUES
                                    (
                                        <cfqueryparam value="#local.lastInsertedID#" cfsqltype="cf_sql_integer">,
                                        <cfqueryparam value="#local.hobbie#" cfsqltype="cf_sql_integer">
                                    )
                            </cfquery>
                        </cfif>
                    </cfloop> --->

FULL CONTACTS <cfloop array="#<!--- <cffunction  name="fullContacts" returnformat="json" access="remote" hint="For listDetails, Pdf, Excel, Scheduled Task, Edit and View">
        <cfargument name="userid" type="numeric" required="false">
        <cfargument  name="getBirthdayOnly" type="numeric" required="false">

        <cfset local.returnArray = [] >
        <cfset local.contactsArray = [] >
        <cfset local.hobbieArray = [] >
        <cfquery name="local.getContactDetails" datasource="#application.db#">
            SELECT
                t3.title AS title_name,
                t1.nameID AS ID,
                t2.userId AS userId,
                concat(t2.fname, " ", t2.lname) AS fullname,
                t2.fname AS fname,
                t2.lname As lname,
                t1.email AS email,
                t2.gender AS gender,
                t2.DOB AS DOB,
                t2.photoName AS photoName,
                t2.phone AS phone,
                t2.address AS address,
                t2.street AS street,
                t2.nameId_fk AS nameId_fk,
                t2.public AS public,
                t2.is_delete AS is_delete,
                t2.title_id AS title_id,
                t2.emailAddress AS contactEmail
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
                ON 
                    t2.nameId_fk = t1.nameId
            INNER JOIN
                title_names AS t3
                ON 
                    t3.title_id = t2.title_id
            WHERE
                is_delete = 0
                <cfif structKeyExists(arguments, "userid")>
                    AND userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
                <cfelseif structKeyExists(arguments, "getBirthdayOnly") AND arguments.getBirthdayOnly EQ 1>
                    AND CURDATE() = str_to_date(CONCAT(YEAR(NOW()), '-', MONTH(DOB), '-', DAY(DOB)), "%Y-%m-%d")
                <cfelse>
                    AND (
                        nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                        OR public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                    )
                </cfif>
        </cfquery>

        <cfloop query="local.getContactDetails">
            <cfset local.structContacts = {
                "ID" : local.getContactDetails.ID,
                "userId" : local.getContactDetails.userId,
                "fullname" : local.getContactDetails.fullname,
                "email" : local.getContactDetails.email,
                "gender" : local.getContactDetails.gender,
                "DOB" : local.getContactDetails.DOB,
                "address" : local.getContactDetails.address,
                "street" : local.getContactDetails.street,
                "title_id" : local.getContactDetails.title_id,
                "phone" : local.getContactDetails.phone,
                "photoName" : local.getContactDetails.photoName,
                "is_delete" : local.getContactDetails.is_delete,
                "nameId_fk" : local.getContactDetails.nameId_fk,
                "public" : local.getContactDetails.public,
                "title_name" : local.getContactDetails.title_name,
                "fname" : local.getContactDetails.fname,
                "lname" : local.getContactDetails.lname,
                "contactEmail" : local.getContactDetails.contactEmail
            } >

            <cfset arrayAppend(local.contactsArray, local.structContacts)>
        </cfloop>

        <cfset arrayAppend(local.returnArray, local.contactsArray)>

        <cfquery name="local.getHobbieDetails" datasource="#application.db#">
            SELECT 
                T1.Id AS hobbieId,
                T1.hobbies AS hobbieName,
                T2.hobbie_id AS T2hobbieId,
                T2.contact_userId AS contactHobbieUserid,
                T2.user_hobbie_id AS hobbieUniqueId,
                T3.is_delete AS is_delete
            FROM
                hobbies AS T1
            INNER JOIN
                User_Hobbies AS T2
                ON
                    T1.Id = T2.hobbie_id
            INNER JOIN
                contacts AS T3
                ON
                    T3.userId = T2.contact_userId
            WHERE
                is_delete = 0
                <cfif structKeyExists(arguments, "userid")>
                    AND T2.contact_userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
                <cfelseif NOT structKeyExists(arguments, "getBirthdayOnly")>
                    AND (
                        T3.nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                        OR T3.public = <cfqueryparam value="YES" cfsqltype="cf_sql_varchar">
                    )
                </cfif>
        </cfquery>

        <cfloop query="local.getHobbieDetails">
            <cfset local.structHobbie = {
                "hobbieId" : local.getHobbieDetails.hobbieId,
                "hobbieName" : local.getHobbieDetails.hobbieName,
                "T2hobbieId" : local.getHobbieDetails.T2hobbieId,
                "contactHobbieUserid" : local.getHobbieDetails.contactHobbieUserid,
                "hobbieUniqueId" : local.getHobbieDetails.hobbieUniqueId
            }> 

            <cfset arrayAppend(local.hobbieArray, local.structHobbie)>
        </cfloop>
        <cfset arrayAppend(local.returnArray, local.hobbieArray)>
        
        <cfreturn local.returnArray />
    </cffunction> --->#" index="index">
</cfloop>