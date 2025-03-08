function accordion(section, heading, list) {
    $(section).each(function () {
        var that = this,
                listHeight = $(this).find(list).height();

        // Ẩn danh sách khi khởi tạo
        $(that).find(list).hide();

        $(this).find(heading).click(function () {
            $(this).toggleClass("plus minus");
            $(that).find(list).slideToggle(250); // Sử dụng slideToggle để mượt mà
        });
    });
}
$(document).ready(function () {
    accordion('.filter-item', '.filter-item-inner-heading', '.filter-attribute-list');
});

// Hàm định dạng số với dấu chấm phân cách
function formatNumber(number) {
    return new Intl.NumberFormat('vi-VN').format(number);
}

// Hàm chuyển đổi giá trị từ chuỗi định dạng sang số
function parseFormattedNumber(formattedNumber) {
    return parseInt(formattedNumber.replace(/\./g, ''));
}

// Cập nhật sự kiện input cho các trường giá
document.querySelectorAll('.price-input input').forEach(input => {
    input.addEventListener('input', (e) => {
        // Lấy giá trị số thô
        let rawValue = parseFormattedNumber(e.target.value);
        // Lưu vào data attribute
        e.target.dataset.rawValue = rawValue;
        // Định dạng lại hiển thị
        e.target.value = formatNumber(rawValue);
    });
});
const rangeInput = document.querySelectorAll(".range-input input"),
        priceInput = document.querySelectorAll(".price-input input"),
        range = document.querySelector(".slider .progress");
let priceGap = 4000000;

priceInput.forEach((input) => {
    input.addEventListener("input", (e) => {
        let minPrice = parseInt(priceInput[0].value),
                maxPrice = parseInt(priceInput[1].value);

        if (maxPrice - minPrice >= priceGap && maxPrice <= rangeInput[1].max) {
            if (e.target.className === "input-min") {
                rangeInput[0].value = minPrice;
                range.style.left = (minPrice / rangeInput[0].max) * 100 + "%";
            } else {
                rangeInput[1].value = maxPrice;
                range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
            }
        }
    });
});

rangeInput.forEach((input) => {
    input.addEventListener("input", (e) => {
        let minVal = parseInt(rangeInput[0].value),
                maxVal = parseInt(rangeInput[1].value);

        if (maxVal - minVal < priceGap) {
            if (e.target.className === "range-min") {
                rangeInput[0].value = maxVal - priceGap;
            } else {
                rangeInput[1].value = minVal + priceGap;
            }
        } else {
            priceInput[0].value = minVal;
            priceInput[1].value = maxVal;
            range.style.left = (minVal / rangeInput[0].max) * 100 + "%";
            range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
        }
    });
});


function updatePriceRange(min, max) {
    document.querySelector('.input-min').value = formatNumber(min);
    document.querySelector('.input-min').dataset.rawValue = min;
    document.querySelector('.input-max').value = formatNumber(max);
    document.querySelector('.input-max').dataset.rawValue = max;

    // Cập nhật slider và các xử lý khác
    document.querySelector('.range-min').value = min;
    document.querySelector('.range-max').value = max;
}