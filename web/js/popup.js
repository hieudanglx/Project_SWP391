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
        if (currentAction && currentProductId) {
// Sửa logic xác định type
            const type = currentAction === 'delete' ? 'R' : '-';
            let url = `UpdateCartController?id=${currentProductId}&type=${type}`;
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
    if (type != 'warning') {
        messageElement.textContent = message;
        // Tự động ẩn sau 1s
        setTimeout(() => {
            popup.style.display = 'none';
        }, 4000);
    }
}

// ========== XỬ LÝ SỰ KIỆN ==========
function decreaseQuantity(productId, quantity) {
    if (quantity <= 1) {
        showConfirmPopup(
                "Giảm số lượng về 0 sẽ xóa sản phẩm khỏi giỏ hàng!",
                'delete',
                productId
                );
        return false;
    }
    return true;
}

function confirmRemove(productId) {
    showConfirmPopup(
            "Bạn chắc chắn muốn xóa sản phẩm này?",
            'delete',
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
