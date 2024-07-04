$(document).ready(function() {
    $("#createSubmit").click(function() {
        var title = $("#title").val();
        var fname = $("#fname").val();
        var lname = $("#lname").val();
        var gender = $("#gender").val();
        var phone = $("#phone").val();
        var address = $("#address").val();
        var street = $("#street").val();
        var dob = $("#dob").val();
        var photo = $("#photo").val();

        var valid = true;

        if(title.trim().length == "") {
            $("#l_title").show();
            valid = false;
        } else {
            $("#l_title").hide();  
        }

        if(fname.trim().length == "") {
            $("#l_fname").show();
            valid = false;
        } else {
            $("#l_fname").hide();  
        }

        if(lname.trim().length == "") {
            $("#l_lname").show();
            valid = false;
        } else {
            $("#l_lname").hide();  
        }

        if(gender.trim().length == "") {
            $("#l_gender").show();
            valid = false;
        } else {
            $("#l_gender").hide();  
        }

        if(dob.trim().length == "") {
            $("#l_dob").show();
            valid = false;
        } else {
            $("#l_dob").hide();  
        }

        if (phone.trim().length == 0 || phone.length < 10 || isNaN(parseInt(phone))) {
            $("#l_phone").show();
            valid = false;
        } else {
            $("#l_phone").hide();  
        }        

        if(photo.trim().length == "") {
            $("#l_file").show();
            valid = false;
        } else {
            $("#l_file").hide();  
        }

        if(address.trim().length == "") {
            $("#l_address").show();
            valid = false;
        } else {
            $("#l_address").hide();  
        }

        if(street.trim().length == "") {
            $("#l_street").show();
            valid = false;
        } else {
            $("#l_street").hide();  
        }

        return valid;
    });
})