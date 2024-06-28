<cfcomponent>
    <cffunction  name="registerForm" returnType="void" access="public" hint="For register">
        <cfargument  name="form" type="any" required="true">
        <cfdump  var="#form#">
        <cfquery name="local.getRegister" datasource="cfTAsk2">
            SELECT 
                username
            FROM 
                registerForm
            WHERE 
                username = <cfqueryparam value="#arguments.form.username#">
        </cfquery>
        <cfif NOT len(form.fullname) 
            OR NOT len(form.email) 
            OR NOT len(form.username)
            OR NOT len(form.password) 
            OR NOT len(form.Cpassword)>
                <cflocation  url="register.cfm?error=3">
        <cfelse>
             <cfif queryRecordCount(local.getRegister) EQ "0">
                <cfif arguments.form.password EQ arguments.form.Cpassword>
                    <cfquery name="local.register" datasource="cfTask2">
                        INSERT INTO
                            registerForm(
                                fullname,
                                email,
                                username,
                                password
                            )
                        VALUES (
                            <cfqueryparam value="#arguments.form.fullname#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.form.email#" cfsqltype="cf_sql_varchar" />,
                            <cfqueryparam value="#arguments.form.username#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.form.password#" cfsqltype="cf_sql_varchar">
                        )
                    </cfquery>
                    <cflocation  url="login.cfm">
                <cfelseif arguments.form.password NEQ arguments.form.Cpassword>
                    <cflocation  url="register.cfm?error=1">
                </cfif>
            <cfelse>
                <cflocation  url="register.cfm?error=2">
            </cfif>
        </cfif>
       
    </cffunction>

    <cffunction  name="errorMessage" returnType="string" access="public" hint="All the Error messages">
        <cftry>
            <cfset local.error = ""/>
            <cfif structKeyExists(url, "error") AND url.error EQ "3" >
                <cfset local.error = "<p style='color: red;'>Fill All Inputs. Try again....</p>" />
            </cfif>
            <cfif structKeyExists(url, "error") AND url.error EQ "1" >
                <cfset local.error = "<p style='color: red;'>Confirm password not matching.</p>" />
            </cfif>
            <cfif structKeyExists(url, "error") AND url.error EQ "2">
                <cfset local.error = "<p style='color: red;'>username exists. try again..</p>" />
            </cfif>
            <cfif structKeyExists(url, "error") AND url.error EQ "4">
                <cfset local.error = "<p style='color: red;'>username or password not valid. try again..</p>" />
            </cfif>
            <cfif structKeyExists(url, "error") AND url.error EQ "5">
                <cfset local.error = "<p style='color: red;'>Email already exists. try again..</p>" />
            </cfif>
            <cfif structKeyExists(url, "error") AND url.error EQ "6">
                <cfset local.error = "<p style='color: red;'>Need to fill USERNAME and PASSWORD. try again..</p>" />
            </cfif>
            <cfif structKeyExists(url, "pdf") AND url.pdf EQ "true">
                <cfset local.error = "<p style='color: green; text-align:center;'>PDF download Successfully....</p>" />
            </cfif>
            <cfif structKeyExists(url, "print") AND url.print EQ "true">
                <cfset local.error = "<p style='color: green; text-align:center;'>Print done Successfully....</p>" />
            </cfif>
            <cfif structKeyExists(session, "excel") AND session.excel EQ "true">
                <cfset local.error = "<p style='color: green; text-align:center;'>Excel download Successfully....</p>" />
            </cfif>
        <cfreturn local.error />
        <cfcatch>
            <cfdump  var="#cfcatch#">
        </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="login" returnType="void" access="public" hint="For login">
        <cfargument name="Lform" type="any" required="true">

        <cfquery name="local.checkUser" datasource="cfTask2">
            SELECT 
                nameID,
                username,
                password
            FROM
                registerForm
            WHERE
                username = <cfqueryparam value="#arguments.Lform.username#" cfsqltype="cf_sql_varchar">
                AND password = <cfqueryparam value="#arguments.Lform.password#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif NOT len(arguments.Lform.username)
            OR NOT len(arguments.Lform.password)>
            <cflocation  url="login.cfm?error=6">
        <cfelse>
            <cfif queryRecordCount(local.checkUser) EQ "1">
                <cfset session.userId = local.checkUser.nameID />
                <cfset session.userName = local.checkUser.username />
        <!-- Query for checking user details exists in the contacts table, If exists redirect to list.cfm -->
                <cfquery name="local.userCheck" datasource="cfTask2">    
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
            <cfelse>
                <cflocation  url="login.cfm?error=4">
            </cfif>
        </cfif>
    </cffunction>


    <cffunction  name="logout" returnType="void" access="public" hint="For logout">

        <cfif NOT structKeyExists(session, "userId")>
            <cflocation  url="login.cfm">
        </cfif>
        <cfif structKeyExists(url, "logout") AND url.logout EQ "true">
            <cfset structClear(session) />
            <cflocation  url="login.cfm">
        </cfif>
    </cffunction>

    
    <cffunction name="Addcontact" returnType="void" access="public" hint="To create new contacts in the contact table">
        <cfargument name="form" type="any" required="true" >

        <cfif NOT len(arguments.form.title)
            OR NOT len(arguments.form.fname)
            OR NOT len(arguments.form.lname)
            OR NOT len(arguments.form.gender)
            OR NOT len(arguments.form.dob)
            OR NOT len(arguments.form.phone)
            OR NOT len(arguments.form.address)
            OR NOT len(arguments.form.street)
            OR NOT len(arguments.form.photo)>
            <cflocation  url="create.cfm?error=3">
        <cfelse>
            <cffile  action="upload"
                destination="C:\ColdFusion2021\cfusion\wwwroot\appTask\uploads" 
                fileField="form.photo" 
                nameConflict="makeunique">
            <cfset local.photoName = cffile.serverfile />

            <cfquery name="local.contactInsert" datasource="cfTask2">
                INSERT INTO 
                    contacts(
                        title,
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
                    <cfqueryparam value="#arguments.form.title#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.fname#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.lname#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.gender#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.dob#" cfsqltype="cf_sql_date">,
                    <cfqueryparam value="#local.photoName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.phone#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.address#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
                )
            </cfquery>
            <cflocation  url="list.cfm">
        </cfif>
    </cffunction>

    <cffunction  name="getContacts" returnType="query" access="public" hint="To fetch the contacts table to show in the list">
        <cfif NOT structKeyExists(session, "userId")>
            <cflocation  url="login.cfm">
        </cfif>
        <cfquery name="local.getContacts" datasource="cfTask2">
            SELECT 
                concat(fname," ",lname) AS fullname,
                phone,
                photoName,
                userId,
                is_delete
            FROM 
                contacts
            WHERE
                is_delete = 0
        </cfquery>
        <cfset session.photo = local.getContacts.photoName />

<!-- Query for checking user details exists in the contacts table, If not exists redirect to create.cfm -->
        <cfquery name="local.contactCheck" datasource="cfTask2">
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
        </cfif>
        <cfreturn local.getContacts>
    </cffunction>

    <cffunction  name="userDetails" access="public" returnType="query" hint="This is for Edit the contact details">
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
    </cffunction>

    <cffunction name="updateDetails" returnType="void" access="public" hint="To update the contact details">
        <cfargument  name="form" type="any" required="true">
        <cfif NOT structKeyExists(session, "userId")>
            <cflocation  url="login.cfm">
        </cfif>
        <cfif NOT len(arguments.form.title)
            OR NOT len(arguments.form.fname)
            OR NOT len(arguments.form.lname)
            OR NOT len(arguments.form.gender)
            OR NOT len(arguments.form.dob)
            OR NOT len(arguments.form.phone)
            OR NOT len(arguments.form.address)
            OR NOT len(arguments.form.street)
            OR NOT len(arguments.form.photo)>
            <cflocation  url="create.cfm?error=3">
        <cfelse> 
            <cffile  action="upload"
                destination="C:\ColdFusion2021\cfusion\wwwroot\appTask\uploads" 
                fileField="form.photo" 
                nameConflict="makeunique">
            <cfset local.photoName = cffile.serverfile />

            <cfquery name="local.contactInsert" datasource="cfTask2">
                UPDATE 
                    contacts
                SET 
                    title = <cfqueryparam value="#arguments.form.title#" cfsqltype="cf_sql_varchar">,
                    fname = <cfqueryparam value="#arguments.form.fname#" cfsqltype="cf_sql_varchar">,
                    lname = <cfqueryparam value="#arguments.form.lname#" cfsqltype="cf_sql_varchar">,
                    gender = <cfqueryparam value="#arguments.form.gender#" cfsqltype="cf_sql_varchar">,
                    DOB = <cfqueryparam value="#arguments.form.dob#" cfsqltype="cf_sql_date">,
                    PhotoName = <cfqueryparam value="#local.photoName#" cfsqltype="cf_sql_varchar">,
                    phone = <cfqueryparam value="#arguments.form.phone#" cfsqltype="cf_sql_varchar">,
                    address = <cfqueryparam value="#arguments.form.address#" cfsqltype="cf_sql_varchar">,
                    street = <cfqueryparam value="#arguments.form.street#" cfsqltype="cf_sql_varchar">
                WHERE
                    userId = <cfqueryparam value="#arguments.form.userId#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cflocation  url="list.cfm">
        </cfif>
    </cffunction>

    <cffunction  name="deleteUser" returnType="void" access="public" hint="This is for delete contacts">
            <cfif structKeyExists(url, "delete") AND url.delete EQ "true" AND structKeyExists(url, "userid")>
                <cfquery name="local.deleteUser" datasource="cfTask2">
                    UPDATE 
                        contacts
                    SET 
                        is_delete = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
                    WHERE 
                        userId = <cfqueryparam value="#url.userid#" cfsqltype="cf_sql_integer" />
                </cfquery>
                <cflocation url="list.cfm">
            </cfif>
    </cffunction>

    <cffunction  name="viewUser" returnType="query" access="public" hint="this to view contact deatils for each user">
        <cfif NOT structKeyExists(session, "userId")>
            <cflocation  url="login.cfm">
        </cfif>
        <cfif structKeyExists(url, "userid")>
            <cftry>
<!--This is to fetech email from registerForm table  and other details from contacts table -->
                <cfquery name="local.viewUser" datasource="cfTask2">
                    SELECT 
                        t1.email,
                        t2.userId,
                        concat(t2.fname," ",t2.lname) as fullname,
                        t2.gender,
                        t2.DOB,
                        t2.photoName,
                        t2.phone,
                        t2.address,
                        t2.street
                    FROM 
                        registerForm AS t1
                    INNER JOIN 
                        contacts AS t2
                    ON 
                        t2.nameId_fk = t1.nameId
                    WHERE
                        t2.userId = <cfqueryparam value="#url.userid#" cfsqltype="cf_sql_integer">
                </cfquery>
            <cfcatch>
                <cfdump  var="#cfcatch#">
            </cfcatch>
            </cftry>
           
        <cfelse>
            <cflocation  url="list.cfm">
        </cfif>
        <cfreturn local.viewUser/>
    </cffunction>


    <cffunction  name="getData" returnType="query" access="public" hint="Fetching contacts table for pdf and excel download">
        <cfif NOT structKeyExists(session, "userId")>
            <cflocation  url="login.cfm">
        </cfif>
        
        <cfquery name="local.pdfData" datasource="cfTask2">
            SELECT 
                t1.nameID AS ID,
                t2.userId,
                concat(t2.title, " ", t2.fname, " ", t2.lname) as fullname,
                t1.email,
                t2.gender,
                t2.DOB,
                t2.photoName,
                t2.phone,
                t2.address,
                t2.street
            FROM 
                registerForm AS t1
            INNER JOIN 
                contacts AS t2
            ON 
                t2.nameId_fk = t1.nameId
            WHERE
                t2.is_delete = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
            ORDER BY ID
        </cfquery>

        <cfreturn local.pdfData />
    </cffunction>
    
</cfcomponent>