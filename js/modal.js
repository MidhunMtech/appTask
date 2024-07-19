$(document).ready(function() {
    $("#createId").click(function() {
        $("#myModal").fadeIn();
    });


    $(".close").click(function() {
        $("#myModal").fadeOut();
    });

    // Close modal when clicking outside of it
    $(window).click(function(event) {
        if (event.target == $("#myModal")[0]) {
            $("#myModal").hide();
        }
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

    if (urlParams.get('error') === 'hack') {
        $("#hack").show();
    }
      

    $(".editPop").click(function() {
        var userid = $(this).data('userid');
        $.ajax({
            url: '../component/component.cfc?method=userDetails',
            method: 'POST',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                console.log(userData);
                $('#myModal2').show();

                $('.title').val(userData.title_id);
                $('.title').text(userData.title_name);
                $('.fname').val(userData.fname);
                $('.lname').val(userData.lname);
                $('.gender').val(userData.gender);
                $('.image').text(userData.photoName);
                $('.imageName').val(userData.photoName);
                $('.phone').val(userData.phone);
                $('.address').val(userData.address);
                $('.street').val(userData.street);
                $('.userid').val(userData.userId);
                // $('.title').val(userData.DATA[0][10]);
                // changing format of DOB.
                var dateString = userData.DOB;
                var dateObj = new Date(dateString);
                var formattedDate = dateObj.getFullYear() + '-' + ('0' + (dateObj.getMonth() + 1)).slice(-2) + '-' + ('0' + dateObj.getDate()).slice(-2);
                $('.dob').val(formattedDate);
                if (userData.public === "YES") {
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

    $(window).click(function(event) {
        if (event.target == $("#myModal2")[0]) {
            $("#myModal2").hide();
        }
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
            url: '../component/component.cfc?method=userDetails',
            method: 'GET',
            data: {
                userid: userid
            },
            success: function(response) {
                var userData = JSON.parse(response);
                $('#myModal3').show();  
                var img = "uploads/" + userData.photoName;
                $('.fullnameView').text(userData.fullname);
                $('.viewEmail').text(userData.email);
                $('.phoneView').text(userData.phone);
                $('.genderView').text(userData.gender);
                $('.addressView').text(userData.address);
                $('.streetView').text(userData.street);
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