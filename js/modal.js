$(document).ready(function() {

    $("#createId").click(function() {
    $("#myModal").fadeIn();
    });

    var urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has('error') && urlParams.get('error') === '3') {
        $('#myModal').show();
    }

    $(".close").click(function() {
    $("#myModal").fadeOut();
    });

    // Close modal when clicking outside of it
    $(window).click(function(event) {
    if (event.target == $("#myModal")[0]) {
        $("#myModal").fadeOut();
    }
    });
});
