$(document).ready(function() {
    $("#registerForm").click(function(){
        var fullname = $("#fullname").val();
        var email = $("#email").val();
        var username = $("#username").val();
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();

        var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        var valid = true;

        if(fullname.trim().length == "") {
            $("#l_fullname").show();
            valid = false;
        } else {
                $("#l_fullname").hide();  
        }

        if(!email.match(regex)) {
            $("#l_email").show();
            valid = false;
        } else {
                $("#l_email").hide();  
        }

        if(username.trim().length == "") {
            $("#l_username").show();
            valid = false;
        } else {
                $("#l_username").hide();  
        }

        $.ajax({
            url: '../appTask/component/component.cfc',
            type: 'GET',
            data: {
                method: 'checkUsernameExists',
                username: username
            },
            success: function(response) {
                // ColdFusion returns a JSON string, parse it
                var result = JSON.parse(response);
                if (username in result) {
                    $("#l_username2").show();
                    valid = false;
                } else {
                        $("#l_username2").hide();  
                }
            }
        });

        if(password.trim().length < 8 ) {
            $("#l_password").show();
            valid = false;
        } else {
                $("#l_password").hide();  
        }

        if(password != confirmPassword || confirmPassword.trim().length == "") {
            $("#l_confirmPassword").show();
            valid = false;
        } else {
                $("#l_confirmPassword").hide();  
        }

        return valid;
    })
})