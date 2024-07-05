$(document).ready(function() {
    $("#createId").click(function() {
        $("#myModal").fadeIn();
    });

    $(".close").click(function() {
        $("#myModal").fadeOut();
    });
    
    
    var urlParams = new URLSearchParams(window.location.search);

    if (urlParams.get('pdf') === 'true') {
        // Show the element with ID 'pdf'
        $("#pdf").show();
    }

    if (urlParams.get('print') === 'true') {
        $("#print").show();
    }

    if (urlParams.get('excel') === 'true') {
        $("#excel").show();
    }

    if (urlParams.get('error') === 'update') {
        $("#update").show();
    }

    $(".editPop").click(function() {
        var userId = $(this).data('userid');
        $.ajax({
            url: '../appTask/component/component.cfc?method=userDetails1',
            method: 'POST',
            data: {
                userid: userId
            },
            success: function(response) {
                var userData = JSON.parse(response);
                console.log(userData);
                $('#myModal2').show();

                $('.title').val(userData.DATA[0][10]);
                $('.title').text(userData.DATA[0][0]);
                $('.fname').val(userData.DATA[0][1]);
                $('.lname').val(userData.DATA[0][2]);
                $('.gender').val(userData.DATA[0][3]);
                $('.image').text(userData.DATA[0][5]);
                $('.phone').val(userData.DATA[0][6]);
                $('.address').val(userData.DATA[0][7]);
                $('.street').val(userData.DATA[0][8]);
                $('.userid').val(userData.DATA[0][9]);
                // Assign other fields similarly
                var dateString = userData.DATA[0][4];
                var dateObj = new Date(dateString);
                var formattedDate = dateObj.getFullYear() + '-' + ('0' + (dateObj.getMonth() + 1)).slice(-2) + '-' + ('0' + dateObj.getDate()).slice(-2);
                $('.dob').val(formattedDate);
                
            },
            error: function(xhr, status, error) {
                console.error("Error fetching user details:", error);
            }
        });
    });
    
    $(".close").click(function() {
        $("#myModal2").fadeOut()
    });

    
    
    $("#submitId").click(function() {
        var title = $(".title").val();
        var fname = $(".fname").val();
        var lname = $(".lname").val();
        var gender = $(".gender").val();
        var phone = $(".phone").val();
        var address = $(".address").val();
        var street = $(".street").val();
        var dob = $(".dob").val();
        var photo = $(".photo1").val();

        var valid = true;

        if(title.trim().length == "") {
            $("#l1_title").show();
            valid = false;
        } else {
            $("#l1_title").hide();
        }

        if(fname.trim().length == "") {
            $("#l1_fname").show();
            valid = false;
        } else {
            $("#l1_fname").hide();  
        }

        if(lname.trim().length == "") {
            $("#l1_lname").show();
            valid = false;
        } else {
            $("#l1_lname").hide();  
        }

        if(gender.trim().length == "") {
            $("#l1_gender").show();
            valid = false;
        } else {
            $("#l1_gender").hide();  
        }

        if(dob.trim().length == "") {
            $("#l1_dob").show();
            valid = false;
        } else {
            $("#l1_dob").hide();  
        }

        if (phone.trim().length == 0 || phone.length < 10 || isNaN(parseInt(phone))) {
            $("#l1_phone").show();
            valid = false;
        } else {
            $("#l1_phone").hide();  
        }        

        if(photo.length == "") {
            $("#l1_file").show();
            valid = false;
        } else {
            $("#l1_file").hide();  
        }

        if(address.trim().length == "") {
            $("#l1_address").show();
            valid = false;
        } else {
            $("#l1_address").hide();  
        }

        if(street.trim().length == "") {
            $("#l1_street").show();
            valid = false;
        } else {
            $("#l1_street").hide();  
        }

        return valid;
    });

    
    
    $(".viewPop").click(function() {
        var userid = $(this).data('userid');
        $.ajax({
            url: '../appTask/component/component.cfc?method=viewUser',
            method: 'GET',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                $('#myModal3').show();  
                var img = "uploads/" + userData.DATA[0][5]
                $('.fullnameView').text(userData.DATA[0][2]);
                $('.viewEmail').text(userData.DATA[0][0]);
                $('.phoneView').text(userData.DATA[0][6]);
                $('.genderView').text(userData.DATA[0][3]);
                $('.addressView').text(userData.DATA[0][7]);
                $('.streetView').text(userData.DATA[0][8]);
                $(".viewImg").attr("src", img);
            }
        });
    });


    $(".close").click(function() {
        $("#myModal3").hide()
    });


    // Close modal when clicking outside of it
    $(window).click(function(event) {
        if (event.target == $("#myModal3")[0]) {
            $("#myModal3").hide();
        }
    });

    $(document).off('click', '.deletePop').on('click', '.deletePop', function(){
        var userid = $(this).data('userid');

        if (confirm("Are you sure you want to delete this user?")) {
            $.ajax({
                url: '../appTask/component/component.cfc?method=deleteUser',
                method: 'POST',
                data: {
                    userid: userid  
                },
                success: function(response) {
                    location.reload();
                }
            });
        }
    });
    
    
});