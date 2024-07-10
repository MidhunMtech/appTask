$(document).ready(function() {

    var urlParams = new URLSearchParams(window.location.search);

    if (urlParams.get('error') == 1) {
        $("#userNameMsg").show();
    }

    $("#registerForm").click(function(){
        var username = $("#username").val();
        var password = $("#password").val();

        var valid = "true";
        if(username.trim().length == "") {
            $("#l_username").show();
            valid = false;
        } else {
                $("#l_username").hide();  
        }

        if(password.trim().length == "") {
            $("#l_password").show();
            valid = false;
        } else {
                $("#l_password").hide();  
        }

        return valid;
    })
})