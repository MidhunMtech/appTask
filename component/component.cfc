<cfcomponent>

    <cffunction  name="registerForm" returnType="string" access="public" hint="For register">
    
        <cfargument  name="form" type="any" required="true">
        <cfquery name="local.getRegister" datasource="cfTAsk2">
            SELECT 
                username
            FROM 
                registerForm
            WHERE 
                username = <cfqueryparam value="#arguments.form.username#" cfsqltype="#cf_sql_varchar#">
        </cfquery> 
        
        <cfif queryRecordCount(local.getRegister) EQ "0">
            <cfif arguments.form.password EQ arguments.form.Cpassword>
                <cfset local.salt = createUUID()>
                <cfset local.saltedPassword = arguments.form.password & local.salt />
                <cfset local.hashedPassword = hash(local.saltedPassword, "SHA-256")> <!--- for password hashing --->
                <cfquery name="local.register" datasource="cfTask2"> 
                    INSERT INTO
                        registerForm(
                            fullname,
                            email,
                            username,
                            password,
                            salt
                        )
                    VALUES (
                        <cfqueryparam value="#arguments.form.fullname#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.form.email#" cfsqltype="cf_sql_varchar" />,
                        <cfqueryparam value="#arguments.form.username#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#local.hashedPassword#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#local.salt#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                <cfset local.return = "1" />
            </cfif>
        <cfelse>
            <cfset local.return = "0" />
        </cfif>

        <cfreturn local.return />
    </cffunction>


    <cffunction name="login" returnType="string" access="public" hint="For login">
        <cfargument name="Lform" type="any" required="true">
        <cfquery name="local.checkUser" datasource="cfTask2">
            SELECT 
                nameID,
                username,
                salt,
                password
            FROM 
                registerForm
            WHERE
                username = <cfqueryparam value="#arguments.Lform.username#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfset local.saltedPassword = arguments.Lform.password & local.checkUser.salt />
        <cfset local.hashedPassword = hash(local.saltedPassword, "SHA-256")> <!--- for password hashing --->

        <cfif local.hashedPassword EQ local.checkUser.password>
            <cfset session.userId = local.checkUser.nameID />
            <cfset session.userName = local.checkUser.username />
            <cfset local.return = "1">
        <cfelse>
            <cfset local.return = "0">
        </cfif>

        <cfreturn local.return>
    </cffunction>


    <cffunction  name="logout" returnType="string" access="public" hint="For logout">
        <cfset local.return = "0" />
        <cfif structKeyExists(url, "logout") AND url.logout EQ "true">
            <cfset structClear(session) />
            <cfset local.return = "1" />
        </cfif>
        <cfreturn local.return />
    </cffunction>

    
    <cffunction name="Addcontact" returnType="void" access="public" hint="To create new contacts in the contact table">
        <cfargument name="form" type="any" required="true" >
        <cfargument name="photo" type="any" required="true" >

        <cfquery name="local.contactInsert" datasource="cfTask2">
            INSERT INTO 
                contacts(
                    title_id,
                    fname,
                    lname,
                    gender,
                    DOB,
                    PhotoName,
                    phone,
                    address,
                    street,
                    nameId_fk
                )
            VALUES (
                <cfqueryparam value="#arguments.form.title#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#arguments.form.fname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.lname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.gender#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#arguments.photo#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.phone#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.address#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
            )
        </cfquery>
        
    </cffunction>


    <cffunction  name="getContacts" returnType="query" access="public" hint="To fetch the contacts table to show in the list">

        <cfquery name="local.getContacts" datasource="cfTask2">
            SELECT 
                concat(fname," ",lname) AS fullname,
                title_id,
                phone,
                photoName,
                userId,
                is_delete
            FROM 
                contacts
            WHERE
                is_delete = 0
        </cfquery>

        <cfreturn local.getContacts>
    </cffunction>


    <cffunction name="userDetails1" access="remote" returnformat="json" hint="datas to show for update">
        <cfargument name="userid" type="numeric" required="true">

        <cfquery name="local.getUser" datasource="cfTask2">
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
                T1.title_id AS title_id
            FROM 
                title_names AS T1
            INNER JOIN
                contacts AS T2
            ON 
                T1.title_id = T2.title_id
            WHERE 
                userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn local.getUser>
    </cffunction>


    <cffunction name="updateDetails" returnType="void" access="public" hint="To update the contact details">
        <cfargument  name="form" type="any" required="true">
        <cfargument  name="photo" type="any" required="true">

        <cfquery name="local.contactInsert" datasource="cfTask2">
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
                street = <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">
            WHERE
                userId = <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>


    <cffunction name="deleteUser" returnformat="json" access="remote" hint="This is for deleting contacts">
        <cfargument name="userid" type="numeric" required="true">
        
        <cfquery name="local.deleteUser" datasource="cfTask2">
            UPDATE 
                contacts
            SET 
                is_delete = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
            WHERE 
                userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
        </cfquery>
    </cffunction>


    <cffunction  name="viewUser" access="remote" returnformat="json" hint="this to view contact details for each user">
        <cfargument name="userid" type="numeric" required="true"> 
        <cftry>
            <cfquery name="local.viewUser" datasource="cfTask2">
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
        <cfcatch>
            <cfdump  var="#cfcatch#">
        </cfcatch>
        </cftry>
           
        <cfreturn local.viewUser/>
    </cffunction>


    <cffunction  name="getData" returnType="query" access="public" hint="Fetching contacts table for pdf and excel download">
        
        <cfquery name="local.pdfData" datasource="cfTask2">
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
                t2.street AS street
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
            ON 
                t2.nameId_fk = t1.nameId
            WHERE
                t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn local.pdfData />
    </cffunction>

    
    <cffunction  name="title" access="public" returnType="query">
        <cfquery name="local.title" datasource="cfTask2">
            SELECT
                title_id,
                title
            FROM
                title_names
        </cfquery>

        <cfreturn local.title>
    </cffunction>


    <cffunction  name="errorMessageList" returnType="string" access="public" hint="All the Error messages in the list page">
        <cfset local.error = ""/>
        <cfif structKeyExists(url, "error") AND url.error EQ "2">
            <cfset local.error = "<p style='color: red;'>Username exists. try again..</p>" />
        </cfif>
        <cfif structKeyExists(url, "error") AND url.error EQ "1">
            <cfset local.error = "<p style='color: red;'>Username or Password not valid. try again..</p>" />
        </cfif>
            <cfreturn local.error />
    </cffunction>

</cfcomponent>