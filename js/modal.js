$(document).ready(function() {
    $("#createId").click(function() {
        $("#myModal").fadeIn();
    });


    $(".close").click(function() {
        $("#myModal").fadeOut();
    });


    var urlParams = new URLSearchParams(window.location.search);

    if (urlParams.get('pdf') === 'true') {
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

    if (urlParams.get('error') === 'create') {
        $("#create").show();
    }
      

    $(".editPop").click(function() {
        var userId = $(this).data('userid');
        $.ajax({
            url: '../component/component.cfc?method=userDetails1',
            method: 'POST',
            data: {
                userid: userId
            },
            success: function(response) {
                var userData = JSON.parse(response);
                console.log(userData);
                $('#myModal2').show();

                $('.title').val(userData.TITLE_ID);
                $('.title').text(userData.TITLE_NAME);
                $('.fname').val(userData.FNAME);
                $('.lname').val(userData.LNAME);
                $('.gender').val(userData.GENDER);
                $('.image').text(userData.PHOTONAME);
                $('.imageName').val(userData.PHOTONAME);
                $('.phone').val(userData.PHONE);
                $('.address').val(userData.ADDRESS);
                $('.street').val(userData.STREET);
                $('.userid').val(userData.USERID);
                // $('.title').val(userData.DATA[0][10]);
                // changing format of DOB.
                var dateString = userData.DOB;
                var dateObj = new Date(dateString);
                var formattedDate = dateObj.getFullYear() + '-' + ('0' + (dateObj.getMonth() + 1)).slice(-2) + '-' + ('0' + dateObj.getDate()).slice(-2);
                $('.dob').val(formattedDate);
                if (userData.PUBLIC === "YES") {
                    // console.log(userData.DATA[0][11]);
                    $('.checkBox').prop('checked', true);
                } else {
                    $('.checkBox').prop('checked', false);   
                }
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

        /* if(photo.length == "") {
            $("#l1_file").show();
            valid = false;
        } else {
            $("#l1_file").hide();  
        } */

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
            url: '../component/component.cfc?method=viewUser',
            method: 'GET',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                // console.log(userData);
                // console.log(userData.ADDRESS);
                $('#myModal3').show();  
                var img = "uploads/" + userData.PHOTONAME
                $('.fullnameView').text(userData.FULLNAME);
                $('.viewEmail').text(userData.EMAIL);
                $('.phoneView').text(userData.PHONE);
                $('.genderView').text(userData.GENDER);
                $('.addressView').text(userData.ADDRESS);
                $('.streetView').text(userData.STREET);
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


    //For delete alert
    $(document).off('click', '.deletePop').on('click', '.deletePop', function(){
        var userid = $(this).data('userid');

        if (confirm("Are you sure you want to delete this user?")) {
            $.ajax({
                url: '../component/component.cfc?method=deleteUser',
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


    //for pdf download message.
    $('#pdfBtn').click(function() {
        if (confirm("Do you want to download PDF?")) {
            window.location.href = 'pdf.cfm';
            setTimeout(function() {
                window.location.href = 'list.cfm?pdf=true';
            }, 500);
        }
    })


    //for excel download message.
    $('#excelBtn').click(function() {
        if (confirm("Do you want to download EXCEL?")) {
            window.location.href = 'excelNew.cfm';
            setTimeout(function() {
                window.location.href = 'list.cfm?excel=true';
            }, 500);
        }
    });


    $("#printBtn").click(function() {
        window.print();
        setTimeout(function() {
            window.location.href = 'list.cfm?print=true';
        }, 500);
    })
 
});




/*  $(document).click('#excelBtn', function(){
        if (confirm("Do you want to download EXCEL?")) {
            window.location.href = 'excelNew.cfm';
            setTimeout(function() {
                window.location.href = 'list.cfm?excel=true';
            }, 500);
        }
    }); */

/* $(document).off('click', '#pdfBtn').on('click', '#pdfBtn', function(){
        if (confirm("Do you want to download PDF?")) {
            window.location.href = 'pdf.cfm';
            setTimeout(function() {
                window.location.href = 'list.cfm?pdf=true';
            }, 500);
        }
    }); */