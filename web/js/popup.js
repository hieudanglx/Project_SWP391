// ========== POPUP GIỎ HÀNG ==========
let currentAction = null;
let currentProductId = null;

function showConfirmPopup(message, actionType, productId) {
    currentProductId = productId;
    currentAction = actionType;

    const popup = document.getElementById('confirmPopup');
    const messageElement = document.getElementById('confirmPopupMessage');

    messageElement.textContent = message;
    popup.style.display = 'flex';
}

function hideConfirmPopup() {
    document.getElementById('confirmPopup').style.display = 'none';
    currentAction = null;
    currentProductId = null;
}

document.addEventListener("DOMContentLoaded", function () {
    document.getElementById('confirmActionBtn').addEventListener('click', function () {
        let url;
        if (currentAction && currentProductId) {
            switch (currentAction) {
                case '-':
                    url = `UpdateCartController?id=${currentProductId}&type=-&Quantity=1`;
                    break;
                case 'R':
                    url = `RemoveInCartController?id=${currentProductId}`;
                    break;
            }
            // Thêm console log để debug
            console.log("Redirecting to:", url);
            window.location.href = url;
        }
        hideConfirmPopup();
    });
});
// ========== POPUP THÔNG BÁO ==========
function showAlertPopup(type, message) {
    const popup = document.getElementById('alertPopup');
    const icon = document.getElementById('alertIcon');
    const messageElement = document.getElementById('alertMessage');
    // Reset classes
    icon.className = 'alert-popup-icon';
    popup.style.display = 'flex';
    console.log("showAlertPopup");
    // Set icon và màu sắc
    switch (type) {
        case 'success':
            icon.classList.add('success-icon', 'fas', 'fa-check-circle');
            break;
        case 'error':
            icon.classList.add('error-icon', 'fas', 'fa-times-circle');
            break;
        case 'warning':
            icon.classList.add('warning-icon', 'fas', 'fa-exclamation-triangle');
            break;
    }
    if (type !== 'warning') {
        messageElement.textContent = message;
        // Tự động ẩn sau 1s
        setTimeout(() => {
            popup.style.display = 'none';
        }, 4000);
    }
}

// ========== XỬ LÝ SỰ KIỆN ==========
function decreaseQuantity(productId, quantity) {
    if (quantity === 1) {
        showConfirmPopup(
                "Giảm số lượng về 0 sẽ xóa sản phẩm khỏi giỏ hàng!",
                '-',
                productId
                );
        return false;
    }
    return true;
}

function confirmRemove(productId) {
    showConfirmPopup(
            "Bạn chắc chắn muốn xóa sản phẩm này?",
            'R',
            productId
            );
    return false;
}
// Gọi hàm khi trang tải xong
window.onload = function () {
    checkCartStatus();
};

function checkCartStatus() {
    const status = document.body.getAttribute("data-status");
    const message = document.body.getAttribute("data-message");
    if (status && message && status !== "null" && message !== "null") {
        console.log("Có status, hiển thị popup");
        showAlertPopup(status, message);
    }
}
// Hàm validate khi nhập
function validateQuantityInput(input) {
    const value = parseInt(input.value);
    if (value > 999999999) {
        input.value = 999999999;
        showAlertPopup('warning', 'Số lượng tối đa là 999,999,999');
    }
}

function updateQuantityEdit(input, productId) {
    const quantity = input.value.trim();
    let parsedQuantity = parseInt(quantity);

    // Kiểm tra hợp lệ
    if (isNaN(parsedQuantity) || parsedQuantity < 1) {
        showAlertPopup('error', 'Vui lòng nhập số nguyên lớn hơn 0');
        input.value = input.defaultValue;
        return;
    }

    if (parsedQuantity > 999999999) {
        showAlertPopup('warning', 'Số lượng tối đa là 999,999,999');
        input.value = input.defaultValue;
        return;
    }

    // Cập nhật URL
    const url = `UpdateCartController?id=` + productId + `&type=E&Quantity=` + parsedQuantity;
    window.location.href = url;
}

function incrementQuantity(productId, currentQuantity) {
    if (currentQuantity >= 999999999) {
        showAlertPopup('warning', 'Đã đạt số lượng tối đa cho phép');
        return;
    }
    const newQuantity = currentQuantity + 1;
    const url = `UpdateCartController?id=` + productId + `&type=E&Quantity=` + newQuantity;
    window.location.href = url;
}

function handleKeyPress(event, input, productId) {
    if (event.key === 'Enter') {
        event.preventDefault();

        // Kiểm tra trước khi submit
        const value = parseInt(input.value);
        if (value > 999999999) {
            showAlertPopup('warning', 'Số lượng tối đa là 999,999,999');
            input.value = input.defaultValue;
            return false;
        }

        updateQuantityEdit(input, productId);
    }
    return event.key.match(/[0-9]/) !== null;
}

