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
//
//function confirmLogout(event) {
//    event.preventDefault(); // Ngăn chặn hành động mặc định
//    let confirmAction = confirm("Do you want to log out?");
//    if (confirmAction) {
//        window.location.href = "logoutOfCustomerController";
//    }
//}
//// Price Slider Logic
//const rangeMin = document.querySelector('.range-min');
//const rangeMax = document.querySelector('.range-max');
//const inputMin = document.querySelector('.input-min');
//const inputMax = document.querySelector('.input-max');
//const progress = document.querySelector('.progress');
//
//let priceGap = 100;
//
//// Update giá trị khi kéo slider
//function updateSlider() {
//    let minVal = parseInt(rangeMin.value);
//    let maxVal = parseInt(rangeMax.value);
//
//    if (maxVal - minVal < priceGap) {
//        if (event.target.className === "range-min") {
//            rangeMin.value = maxVal - priceGap;
//        } else {
//            rangeMax.value = minVal + priceGap;
//        }
//    } else {
//        inputMin.value = minVal;
//        inputMax.value = maxVal;
//        progress.style.left = (minVal / rangeMin.max) * 100 + "%";
//        progress.style.right = 100 - (maxVal / rangeMax.max) * 100 + "%";
//    }
//}
//
//// Thêm event listeners
//rangeMin.addEventListener('input', updateSlider);
//rangeMax.addEventListener('input', updateSlider);
//inputMin.addEventListener('input', function() {
//    rangeMin.value = this.value;
//    updateSlider();
//});
//inputMax.addEventListener('input', function() {
//    rangeMax.value = this.value;
//    updateSlider();
//});