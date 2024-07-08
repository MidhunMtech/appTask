<cfscript>
    getData = application.component.getData();  //application.component is from application.cfc
    
    //Create Spreadsheet
    spreadsheetObj = SpreadsheetNew('addressBook');
    // Add header
    SpreadSheetAddRow(spreadsheetObj,'ID,UserId,fullname,email,gender,DOB,photoName,phone,address,street');
    //Add Data
    for (row in getData) {
        SpreadSheetAddRow(spreadsheetObj, row.ID & ',' & row.userId & ',' & row.fullname & ',' & row.email & ',' & row.gender & ',' & row.DOB & ',' & row.photoName & ',' & row.phone & ',' & row.address & ',' & row.street);
    }
    //Format Header
    SpreadsheetformatRow(spreadsheetobj,{bold=true,alignment='center'},1);
    //Write File
    Spreadsheetwrite(spreadsheetobj,expandpath('downloads/excel/AddressBook.xls'),true);

    location(url="list.cfm?excel=true");
</cfscript>

