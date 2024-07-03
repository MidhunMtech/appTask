$(document).ready(function() {
    $("#createId").click(function() {
        $("#myModal").fadeIn(function() {
            // $("#edit").hide();
            $("#createPop").show();
        });
    });

    $(".close").click(function() {
        $("#myModal").fadeOut(function() {
            $("#createPop").hide();
            // $("#edit").hide();
        });
    });
    
    
    var urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has('error') && urlParams.get('error') === '3') {
        $('#myModal').show();
    }

    /*$(".close").click(function() {
    $("#myModal").fadeOut();
    });*/

    // Close modal when clicking outside of it
    // $(window).click(function(event) {
    //     if (event.target == $("#myModal")[0]) {
    //         $("#myModal").fadeOut();
    //     }
    // });


    $(".editPop").click(function() {
        var userId = $(this).data('userid');
        // var url = '../appTask/component/component.cfc?method=userDetails1&userid='+ userId;
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

                console.log(userData.DATA[0][1]);// Assuming your server response is JSON
                console.log(userData.DATA[0][10]); 
                console.log(userData.DATA[0][9]);

                $('.title').val(userData.DATA[0][10]);
                $('.title').text(userData.DATA[0][0]);
                $('.fname').val(userData.DATA[0][1]);
                $('.lname').val(userData.DATA[0][2]);
                $('.gender').val(userData.DATA[0][3]);
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

    // $(window).click(function(event) {
    //     if (event.target == $("#myModal2")[0]) {
    //         $("#myModal2").fadeOut();
    //     }
    // });
    
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
		var userid = $(".userid").val();

		var valid = true;

        if(title.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }

        if(fname.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }

        if(lname.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(gender.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(dob.length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(photo.length == "") {
            $("#label1").show();
            console.log("1");
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(phone.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(address.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(street.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }
        if(userid.trim().length == "") {
            $("#label1").show();
            valid = false;
        } else {
            $("#label1").hide();  
        }

        return valid;
    });

    
    
    
    $(".viewPop").click(function() {
        var userid = $(this).data('userid');
        console.log(userid);
        $.ajax({
            url: '../appTask/component/component.cfc?method=viewUser',
            method: 'GET',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                console.log(userData); 
                $('#myModal3').show();  
                console.log(userData.DATA[0][1]);
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
        $("#myModal3").fadeOut()
    });
    
});






/*

$(".editPop").click(function() {
    var userId = $(this).data('userid'); // Assuming you have a data-userid attribute on your #editPop element
    $.ajax({
        url: 'component/component.cfc?method=userDetails1',
        method: 'POST',
        data: {
            userid: userId
        },
        success: function(response) {
            var userData = JSON.parse(response); // Assuming your server response is JSON
            $('#title').val(userData.title);
            $('#fname').val(userData.fname);
            $('#lname').val(userData.lname);
            $('#gender').val(userData.gender);
            $('#dob').val(userData.DOB);
            $('#photo').val(userData.photoName);
            $('#phone').val(userData.phone);
            $('#address').val(userData.address);
            $('#street').val(userData.street);
            // Assign other fields similarly
            $('#myModal2').show();
        },
        error: function(xhr, status, error) {
            console.error("An error occurred: " + error);
        }
    });
});
*/