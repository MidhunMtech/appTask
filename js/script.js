$(document).ready(function() {
    // $('#print').css('background-color', 'green');
    $('#print').click(function() {
        $('#print').hide();
        window.print();
        
        setTimeout(function() {
            window.location.href = 'list.cfm?print=true';
        }, 500);
    });
});
