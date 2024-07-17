<cfscript>
    getData = application.component.getData();  //application.component is from application.cfc
    
    //Create Spreadsheet
    spreadsheetObj = SpreadsheetNew('addressBook', 'yes'); // this 'yes' is for xlsx format

    // Add header
    SpreadSheetAddRow(spreadsheetObj,'ID,UserId,fullname,email,gender,DOB,photoName,phone,address,street');
    
    //Add Data
     i = 2;

    for (row in getData) {
        SpreadsheetSetCellValue(spreadsheetObj,row.ID,i,1);
        SpreadsheetSetCellValue(spreadsheetObj,row.userId,i,2);
        SpreadsheetSetCellValue(spreadsheetObj,row.fullname,i,3);
        SpreadsheetSetCellValue(spreadsheetObj,row.email,i,4);
        SpreadsheetSetCellValue(spreadsheetObj,row.gender,i,5);
        SpreadsheetSetCellValue(spreadsheetObj,row.DOB,i,6);
        SpreadsheetSetCellValue(spreadsheetObj,row.photoName,i,7);
        SpreadsheetSetCellValue(spreadsheetObj,row.phone,i,8);
        SpreadsheetSetCellValue(spreadsheetObj,row.address,i,9);
        SpreadsheetSetCellValue(spreadsheetObj,row.street,i,10);

        i += 1;
    }

    /* try {
        imgPath = expandPath("uploads/Matt_LeBlanc_as_Joey_Tribbiani.jpg");
        SpreadsheetAddImage(spreadsheetObj,imgPath,3,4);
    } catch (any e) {
        writeDump(e)
    } */

    // 
    //Format Header
    SpreadsheetFormatRow(spreadsheetobj, {
        bold = true,
        alignment = "center",
        color="blue",
        font="Arial",
        fgcolor="green"
    }, 1);
    
    try {
        SpreadSheetAddFreezePane(spreadsheetobj,0,1); // header freeze
    } catch (any e) {
        writeDump(e)
    }

    // Write the file to a temporary path
    tempFilePath = expandPath('downloads/excel/AddressBook.xlsx');
    SpreadsheetWrite(spreadsheetObj, tempFilePath, true);

    // Send the file to the client as an attachment
    cfheader(name="Content-Disposition", value="attachment; filename=AddressBook.xlsx");
    cfcontent(type="application/vnd.ms-excel", file="#tempFilePath#", deleteFile="true"); // deleteFile="true" is for delete this file from server side
    
</cfscript>




<!--- <cftry>
    <cfchart format="png" name="image_var"> 
        <cfchartseries type="line"> 
            <cfchartdata item="Point1" value="-50"> 
            <cfchartdata item="Point2" value="-25"> 
            <cfchartdata item="Point3" value="1"> 
    </cfchartseries> 
    </cfchart> 
    <cfset sObj = SpreadsheetNew()> 
    <cfset SpreadsheetAddRow(sObj, "")> 
    <cfset SpreadsheetAddImage(sObj,image_var,"png","1,1,7,6")> 
    <cfheader name="Content-Disposition" value="inline; filename=testFile.xls"> 
    <cfcontent type="application/vnd.msexcel" variable="#SpreadSheetReadBinary(sObj)#"> 
 <cfcatch type="any">
    <cfdump  var="#cfcatch#">
</cfcatch>
</cftry> --->