<cftry>
    <cfif structKeyExists(form, "excelSubmit")>
        <cfset uploadPath = expandPath("./uploads/Excel/")>
        
        <cffile action="upload" 
                fileField="excelFileUpload" 
                destination="#uploadPath#" 
                nameConflict="makeUnique">

        <cfset spreadsheetObj = SpreadSheetRead(uploadPath & cffile.SERVERFILE)>

        <cfspreadsheet action="read" 
                    src="#uploadPath##cffile.SERVERFILE#" 
                    query="excelData">

        <cfset numRows = excelData.recordcount>
        <cfset numColumns = SpreadSheetGetColumnCount(spreadsheetObj)>
        
        <cfset errorReturnExcelArray = []>
        <cfset returnExcelArray = []>
        <cfloop from="2" to="#numRows#" index="rowIndex">
            <cfset result = []>
            <cfset resultList = ''>
            <cfset rowStruct = {}>
            <cfloop from="1" to="#numColumns#" index="colIndex">
                <cfset rowValue = SpreadSheetGetCellValue(spreadsheetObj, rowIndex, colIndex)>
                <cfset headerValue = SpreadSheetGetCellValue(spreadsheetObj, 1, colIndex)>

                <cfif rowValue EQ ''>
                    <cfset arrayAppend(result, headerValue)>
                </cfif>

                <cfset rowStruct[headerValue] = rowValue>

                <cfif colIndex EQ numColumns>
                    <cfif arrayToList(result) NEQ ''>
                        <!--- <cfset arrayAppend(result, " Missing.")> --->
                        <cfloop from="1" to="#arrayLen(result)#" index=i>
                            <cfset words = result[i]>
                            <cfif i == arrayLen(result)>
                                <cfset resultList = resultList & words & " Missing">
                                <cfdump  var="#resultList#">
                            <cfelse>
                                <cfset resultList = resultList & words & ", ">
                            </cfif>
                        </cfloop>
                    </cfif>
                    <cfset rowStruct["Result"] = resultList>
                </cfif>
            </cfloop>
            
            <cfif arrayToList(result) EQ ''>
                <cftry>
                    <cfset excelUpload = application.component.ExcelUploadContact(
                                form = rowStruct)>
                    <cfset rowStruct["Result"] = excelUpload.message>
                    <cfif excelUpload.message EQ "Updated" OR excelUpload.message EQ "Added">
                        <cfset arrayAppend(returnExcelArray, rowStruct)>
                    <cfelse>
                        <cfset arrayAppend(errorReturnExcelArray, rowStruct)>
                    </cfif>
                <cfcatch type="any">
                    <cfdump  var="#cfcatch#">
                </cfcatch>
                </cftry>
            <cfelse>
                <cfset arrayAppend(errorReturnExcelArray, rowStruct)>
            </cfif>
        </cfloop>

        <cfset spreadsheetObj = SpreadsheetNew('uploadResult', 'yes')>
        <cfset SpreadSheetAddRow(spreadsheetObj,'Title,FirstName,LastName,Email,Gender,DOB,phone,address,street,hobbies,Result')>

        <cfset i = 2>
        <cftry>
            <cfloop array="#errorReturnExcelArray#" index="row">
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Title,i,1)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.FirstName,i,2)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.LastName,i,3)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Email,i,4)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Gender,i,5)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.DOB,i,6)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.phone,i,7)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.address,i,8)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.street,i,9)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.hobbies,i,10)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Result,i,11)>
                <cfset i += 1>
            </cfloop>
            <cfloop array="#returnExcelArray#" index="row">
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Title,i,1)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.FirstName,i,2)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.LastName,i,3)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Email,i,4)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Gender,i,5)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.DOB,i,6)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.phone,i,7)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.address,i,8)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.street,i,9)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.hobbies,i,10)>
                <cfset SpreadsheetSetCellValue(spreadsheetObj,row.Result,i,11)>
                <cfset i += 1>
            </cfloop>  
        <cfcatch type="any">
            <cfdump  var="#cfcatch#">
        </cfcatch>
        </cftry>

        <cfset SpreadsheetFormatRow(spreadsheetobj, {
            bold = true,
            alignment = "center",
            color="black",
            font="Arial"
        }, 1)>
        
        <cfset SpreadSheetAddFreezePane(spreadsheetobj,0,1)>
        <cfset binaryData = SpreadsheetReadBinary(spreadsheetObj)>

        <cfheader name="Content-Disposition" value="attachment; filename=uploadResult.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#binaryData#">
    </cfif>
<cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry>