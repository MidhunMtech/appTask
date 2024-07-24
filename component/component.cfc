<cfcomponent>

    <cffunction  name="signUp" returnType="string" access="public" hint="For register">
        <cfargument name="form" type="any" required="true">
        <cfquery name="local.toCheckUsernameExists" datasource="#application.db#">
            SELECT 
                username
            FROM 
                registerForm
            WHERE 
                username = <cfqueryparam value="#arguments.form.username#" cfsqltype="cf_sql_varchar">
        </cfquery> 
        
        <cfif queryRecordCount(local.toCheckUsernameExists) EQ "0">
            <cfif arguments.form.password EQ arguments.form.Cpassword>
                <cfset local.salt = createUUID()>
                <cfset local.saltedPassword = arguments.form.password & local.salt />
                <cfset local.hashedPassword = hash(local.saltedPassword, "SHA-256")> <!--- for password hashing --->
                <cfquery name="local.registerUser" datasource="#application.db#"> 
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
        <cfquery name="local.checkUserExists" datasource="#application.db#">
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

        <cfset local.saltedPassword = arguments.Lform.password & local.checkUserExists.salt />
        <cfset local.hashedPassword = hash(local.saltedPassword, "SHA-256")> <!--- for password hashing --->

        <cfif local.hashedPassword EQ local.checkUserExists.password>
            <cfset session.userId = local.checkUserExists.nameID />
            <cfset session.userName = local.checkUserExists.username />
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

    
    <cffunction name="createAndUpdateContact" returnType="numeric" access="public" hint="function for Create and Update contacts">
        <cfargument name="form" type="any" required="true" >
        <cfargument name="photo" type="any" required="true" >
        <cfargument name="isPublic" type="string" required="true">
        
        <cfquery name="local.checkEmailExists" datasource="#application.db#">
            SELECT 
                emailAddress
            FROM 
                contacts
            WHERE 
                emailAddress = <cfqueryparam value="#arguments.form.contactEmail#" cfsqltype="cf_sql_varchar">
                AND is_delete = 0
                <cfif structKeyExists(arguments.form, "userid")>
                    AND userId != <cfqueryparam value="#arguments.form.userid#" cfsqltype="cf_sql_integer">
                </cfif>
        </cfquery>

        <cfif queryRecordCount(local.checkEmailExists) EQ 0>
            <cfif structKeyExists(arguments.form, "userid")>
                <cfquery name="local.contactUpdate" datasource="#application.db#">
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
                        public = <cfqueryparam value="#arguments.isPublic#" cfsqltype="cf_sql_varchar">,
                        emailAddress = <cfqueryparam value="#arguments.form.contactEmail#" cfsqltype="cf_sql_varchar">
                    WHERE
                        userId = <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">
                        AND nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
                </cfquery>

                <cfset local.isCreated = 1>
            <cfelse>
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
                            emailAddress,
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
                        <cfqueryparam value="#arguments.form.contactEmail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.form.address#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.isPublic#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>

                <cfset local.isCreated = 1>
            </cfif>
        <cfelse>
            <cfset local.isCreated = 0>
        </cfif>
        
        <cfreturn local.isCreated>
    </cffunction>


    <cffunction name="deleteUser" returnformat="json" access="remote" hint="This is for deleting contacts">
        <cfargument name="userid" type="numeric" required="true">
        
        <cfquery name="local.deleteUser" datasource="#application.db#">
            UPDATE 
                contacts
            SET 
                is_delete = 1
            WHERE 
                userId = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
                AND nameId_fk = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_integer">
        </cfquery>
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

 
    <cffunction  name="fullContacts" returnformat="json" access="remote" hint="For listDetails, Pdf, Excel, Scheduled Task, Edit and View">
        <cfargument name="userid" type="numeric" required="false">
        <cfargument  name="getBirthdayOnly" type="numeric" required="false">

        <cfset local.structContacts = {}>
        <cfset local.returnArray = [] >
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

            <cfset arrayAppend(local.returnArray, local.structContacts)> 
        </cfloop>
        <cfreturn local.returnArray />
    </cffunction>

</cfcomponent>