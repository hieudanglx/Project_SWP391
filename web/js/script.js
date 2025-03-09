jQuery(document).ready(function ($) {
    $('.bar-menu').click(function (event) {
        $(this).next('.list-child').slideToggle(300);
    });
});

$(document).ready(function() {
    $('.accordion-toggle').on('click', function() {
        if ($(this).hasClass('collapsed')) {
            $(this).find('::after').css('content', '"\\f067"'); // Icon "+"
        } else {
            $(this).find('::after').css('content', '"\\f068"'); // Icon "-"
        }
    });
});

