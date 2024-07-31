<cfscript>
    try {
        getData = application.component.fullContacts();  //application.component is from application.cfc
    } catch (any e) {
        writeDump(e)
    }
     
    //Create Spreadsheet
    spreadsheetObj = SpreadsheetNew('plainTemplate', 'yes'); // this 'yes' is for xlsx format

    // Add header
    SpreadSheetAddRow(spreadsheetObj,'Title,FirstName,LastName,Email,Gender,DOB,phone,address,street,hobbies');

    SpreadsheetFormatRow(spreadsheetobj, {
        bold = true,
        alignment = "center",
        color="black",
        font="Arial"
    }, 1);
    
    try {
        SpreadSheetAddFreezePane(spreadsheetobj,0,1); // header freeze
    } catch (any e) {
        writeDump(e)
    }

    // Write the spreadsheet to a binary variable
    binaryData = SpreadsheetReadBinary(spreadsheetObj);

    // Send the file to the client as an attachment
    cfheader(name="Content-Disposition", value="attachment; filename=plainTemplate.xlsx");
    cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable="#binaryData#");
    
</cfscript>