<cfscript>
    try {
        getData = application.component.fullContacts();  //application.component is from application.cfc
    } catch (any e) {
        writeDump(e)
    }
    
    
    //Create Spreadsheet
    spreadsheetObj = SpreadsheetNew('addressBook', 'yes'); // this 'yes' is for xlsx format

    // Add header
    SpreadSheetAddRow(spreadsheetObj,'ID,UserId,fullname,email,gender,DOB,photoName,phone,address,street,photo');

    //Add Data
     i = 2;
     
    try {
            for (row in getData) {
                cellRange = "#i#,11,#i+1#,12";
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
                imagePath = expandPath("uploads/#row.photoName#");
                spreadsheetAddImage(spreadsheetObj, imagePath, cellRange);

                i += 1;
            }
    } catch (any e){
        writeDump(e)
    }

    //for height of the row
    startRow = 2;  
    endRow = i-1;  
    newRowHeight = 40;  

    // Loop through the specified range of rows and set their height.
    for (i = startRow; i <= endRow; i++) {
        spreadsheetSetRowHeight(spreadsheetObj, i, newRowHeight);
        spreadsheetSetColumnWidth(spreadsheetObj, 11, 10);
    }

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

    /* // Write the file to a temporary path
    tempFilePath = expandPath('downloads/excel/AddressBook.xlsx');
    SpreadsheetWrite(spreadsheetObj, tempFilePath, true); */

    // Write the spreadsheet to a binary variable
    binaryData = SpreadsheetReadBinary(spreadsheetObj);

    // Send the file to the client as an attachment
    cfheader(name="Content-Disposition", value="attachment; filename=AddressBook.xlsx");
    cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable="#binaryData#");
    /* cfcontent(type="application/vnd.ms-excel", file="#tempFilePath#", deleteFile="true"); */ // deleteFile="true" is for delete this file from server side
    
</cfscript>