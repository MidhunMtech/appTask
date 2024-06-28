<cfinvoke component="component.component" method="getData" returnvariable="getData">

<cfset csvData = "ID, User Id, Fullname, Email Id, Gender, DOB, Photo Name, Phone No, Address, Street" & chr(13) & chr(10)>

<cfloop query="getData">
    <cfoutput>
        <cfset csvData &= #ID# & "," & #userId# & "," & #fullname# & "," & #email# & "," & #gender# & "," & #DOB# & "," & #photoName# & "," & #phone# & "," & #address# & "," & #street# & chr(13) & chr(10)>
    </cfoutput>
</cfloop>


<cfheader name="Content-Disposition" value="attachment; filename=addressBook.xlsx">
<cfheader name="Content-Type" value="text/xlsx; charset=utf-8">
<cfoutput>#csvData#</cfoutput>
<!--- <cflocation  url="list.cfm?excel=true"> --->
