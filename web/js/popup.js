// Hiển thị popup với icon, message và các nút tùy chọn
function showPopup(type, message, buttons = []) {
    const overlay = document.getElementById('popupOverlay');
    const icon = document.getElementById('popupIcon');
    const msg = document.getElementById('popupMessage');
    const btnContainer = document.getElementById('popupButtons');

    // Thay đổi icon theo loại thông báo
    icon.innerHTML = type === 'success' ? '✔️' : type === 'error' ? '❌' : '⚠️';

    // Thay đổi nội dung thông báo
    msg.innerText = message;

    // Xóa nút cũ và thêm nút mới
    btnContainer.innerHTML = '';
    buttons.forEach(btn => {
        const button = document.createElement('button');
        button.innerText = btn.text;
        button.className = btn.class;
        button.onclick = btn.action;
        btnContainer.appendChild(button);
    });

    // Hiển thị popup
    overlay.style.display = 'flex';

    // Tự động đóng popup sau 1.5 giây
    setTimeout(closePopup, 1500);
}

// Đóng popup
function closePopup() {
    document.getElementById('popupOverlay').style.display = 'none';
}

// Thêm thành công
function addToCartSuccess() {
    showPopup('success', 'Thêm vào giỏ hàng thành công!', [
        {text: 'OK', class: 'btn btn-success', action: closePopup}
    ]);
}

// Thêm thất bại
function addToCartFail() {
    showPopup('error', 'Thêm vào giỏ hàng thất bại. Vui lòng thử lại!', [
        {text: 'Thử lại', class: 'btn btn-danger', action: closePopup}
    ]);
}

// Kiểm tra trạng thái sau khi qua trang UpdateCartController
function checkCartStatus(status) {
    if (status === 'false') {
        addToCartFail();
    } else if (status === 'true') {
        addToCartSuccess();
    }
}

function increaseQuantity(productId, quantity) {
    if (quantity >= 5) {
        alert('Số lượng sản phẩm không thể vượt quá 5.');
        return false;
    }
    return true;
}

function decreaseQuantity(productId, quantity) {
    if (quantity <= 1) {
        return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?');
    }
    return true;
}

function confirmRemove(productId) {
    return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?');
}


// Gọi hàm kiểm tra khi trang được load
window.onload = function () {
    const status = document.body.getAttribute('data-status');
    const m = document.body.getAttribute('Message');
    if (status === 'true') {
        showPopup('success', 'Thêm giỏ hàng thành công!');
    } else if (status === 'false') {
        showPopup('error', 'Thêm giỏ hàng thất bại!');
    }
};
