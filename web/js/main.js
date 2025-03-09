jQuery(document).ready(function ($) {
    $('.bar-menu').click(function (event) {
        $(this).next('.list-child').slideToggle(300);
    });
});

function confirmLogout(event) {
    event.preventDefault(); // Ngăn chặn hành động mặc định
    let confirmAction = confirm("Do you want to log out?");
    if (confirmAction) {
        window.location.href = "logoutOfCustomerController";
    }
}
