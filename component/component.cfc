<cfcomponent>

    <cffunction  name="registerForm" returnType="string" access="public" hint="For register">
        <cfargument name="form" type="any" required="true">
        <cfquery name="local.getRegister" datasource="#application.db#">
            SELECT 
                username
            FROM 
                registerForm
            WHERE 
                username = <cfqueryparam value="#arguments.form.username#" cfsqltype="cf_sql_varchar">
        </cfquery> 
        
        <cfif queryRecordCount(local.getRegister) EQ "0">
            <cfif arguments.form.password EQ arguments.form.Cpassword>
                <cfset local.salt = createUUID()>
                <cfset local.saltedPassword = arguments.form.password & local.salt />
                <cfset local.hashedPassword = hash(local.saltedPassword, "SHA-256")> <!--- for password hashing --->
                <cfquery name="local.register" datasource="#application.db#"> 
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
        <cfquery name="local.checkUser" datasource="#application.db#">
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
        <cfargument name="isPublic" type="string" required="true">
        
        <cfquery name="local.contactInsert" datasource="#application.db#">
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
                    nameId_fk,
                    public
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
                <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#arguments.isPublic#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
    </cffunction>


    <cffunction  name="getContacts" returnType="query" access="public" hint="To fetch the contacts table to show in the list">
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
    </cffunction>


    <cffunction name="userDetails1" access="remote" returnformat="json" hint="datas to show for update">
        <cfargument name="userid" type="numeric" required="true">

        <cfset local.userStruct = structNew() />
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

        <cfset local.userStruct.title_name = local.getUser.title_name />
        <cfset local.userStruct.fname = local.getUser.fname />
        <cfset local.userStruct.lname = local.getUser.lname />
        <cfset local.userStruct.gender = local.getUser.gender />
        <cfset local.userStruct.DOB = local.getUser.DOB />
        <cfset local.userStruct.photoName = local.getUser.photoName />
        <cfset local.userStruct.phone = local.getUser.phone />
        <cfset local.userStruct.address = local.getUser.address />
        <cfset local.userStruct.street = local.getUser.street />
        <cfset local.userStruct.userId = local.getUser.userId />
        <cfset local.userStruct.title_id = local.getUser.title_id />
        <cfset local.userStruct.public = local.getUser.public/>
        <cfreturn local.userStruct />
    </cffunction>


    <cffunction name="updateDetails" returnType="void" access="public" hint="To update the contact details">
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
        </cfquery>
    </cffunction>


    <cffunction name="deleteUser" returnformat="json" access="remote" hint="This is for deleting contacts">
        <cfargument name="userid" type="numeric" required="true">
        
        <cfquery name="local.deleteUser" datasource="#application.db#">
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
    </cffunction>


    <cffunction  name="getData" returnType="query" access="public" hint="Fetching contacts table for pdf, print, and excel download">
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
    </cffunction>

    
    <cffunction  name="title" access="public" returnType="query">
        <cfquery name="local.title" datasource="#application.db#">
            SELECT
                title_id,
                title
            FROM
                title_names
        </cfquery>

        <cfreturn local.title>
    </cffunction>


    <cffunction  name="scheduleData" access="public" returnType="query" hint="Data for scheduling mail">
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
    </cffunction>


    <cffunction  name="mailData" access="public" returnType="query" hint="Data for mail content according to url userId">
        <cfquery name="local.mailData" datasource="#application.db#">
            SELECT 
                t2.userId AS userId,
                concat(t2.fname, " ", t2.lname) AS fullname,
                t1.email AS email,
                t2.userId AS userId
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
            ON 
                t2.nameId_fk = t1.nameId
            WHERE
                t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                AND userId = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn local.mailData />
    </cffunction>

</cfcomponent>