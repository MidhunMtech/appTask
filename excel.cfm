<cfscript>
    getData = application.component.getData();  //application.component is from application.cfc
    
    //Create Spreadsheet
    spreadsheetObj = SpreadsheetNew('addressBook');

    // Add header
    SpreadSheetAddRow(spreadsheetObj,'ID,UserId,fullname,email,gender,DOB,photoName,phone,address,street');
    //Add Data
    for (row in getData) {
        // Remove commas from each field
        ID = replace(row.ID, ',', '', 'all');
        userId = replace(row.userId, ',', '', 'all');
        fullname = replace(row.fullname, ',', '', 'all');
        email = replace(row.email, ',', '', 'all');
        gender = replace(row.gender, ',', '', 'all');
        DOB = replace(row.DOB, ',', '', 'all');
        photoName = replace(row.photoName, ',', '', 'all');
        phone = replace(row.phone, ',', '', 'all');
        address = replace(row.address, ',', ' ', 'all');
        street = replace(row.street, ',', ' ', 'all');

        SpreadSheetAddRow(spreadsheetObj, ID & ',' & userId & ',' & fullname & ',' & email & ',' & gender & ',' & DOB & ',' & photoName & ',' & phone & ',' & address & ',' & street);
    }
    //Format Header
    SpreadsheetformatRow(spreadsheetobj,{bold=true,alignment='center'},1);

    // Write the file to a temporary path
    tempFilePath = expandPath('downloads/excel/AddressBook.xls');
    SpreadsheetWrite(spreadsheetObj, tempFilePath, true);

    // Send the file to the client as an attachment
    cfheader(name="Content-Disposition", value="attachment; filename=AddressBook.xls");
    cfcontent(type="application/vnd.ms-excel", file="#tempFilePath#", deleteFile="true"); // deleteFile="true" is for delete this file from server side
    
</cfscript>