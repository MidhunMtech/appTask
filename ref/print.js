$(document).ready(function() {
    $('#print').click(function() {
        $('#print').hide();
        window.print();
        
        setTimeout(function() {
            window.location.href = 'list.cfm?print=true';
        }, 500);
    });
});
