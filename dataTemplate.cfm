<cfscript>
    try {
        try {
            getData = application.component.fullContacts();  //application.component is from application.cfc
        } catch (any e) {
            writeDump(e)
        }

        spreadsheetObj = SpreadsheetNew('dataTemplate', 'yes'); // this 'yes' is for xlsx format

        // Add header
        SpreadSheetAddRow(spreadsheetObj,'Title,FirstName,LastName,Email,Gender,DOB,phone,address,street,hobbies');

        //Add Data
        i = 2;
        for (row in getData) {
            if (row.nameId_fk EQ session.userId) {
                hobbiesArray = [];
                for (hobbie in row.hobbies) {
                    ArrayAppend(hobbiesArray, hobbie.Name);
                }
                SpreadsheetSetCellValue(spreadsheetObj,row.title_name,i,1);
                SpreadsheetSetCellValue(spreadsheetObj,row.fname,i,2);
                SpreadsheetSetCellValue(spreadsheetObj,row.lname,i,3);
                SpreadsheetSetCellValue(spreadsheetObj,row.contactEmail,i,4);
                SpreadsheetSetCellValue(spreadsheetObj,row.gender,i,5);
                SpreadsheetSetCellValue(spreadsheetObj,row.DOB,i,6);
                SpreadsheetSetCellValue(spreadsheetObj,row.phone,i,7);
                SpreadsheetSetCellValue(spreadsheetObj,row.address,i,8);
                SpreadsheetSetCellValue(spreadsheetObj,row.street,i,9);
                SpreadsheetSetCellValue(spreadsheetObj, ArrayToList(hobbiesArray),i,10);

                i += 1;

            }
        }
        

        //Format Header
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
        cfheader(name="Content-Disposition", value="attachment; filename=dataTemplate.xlsx");
        cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable="#binaryData#");
    } catch (any e){
        writeDump(e)
    }
</cfscript>