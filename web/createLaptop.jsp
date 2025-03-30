<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Enter Laptop Information</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #4361ee;
                --primary-hover: #3a56d4;
                --secondary: #6c757d;
                --secondary-hover: #5a6268;
                --success: #2ecc71;
                --success-hover: #27ae60;
                --error: #e74c3c;
                --light-bg: #f8f9fa;
                --border: #dee2e6;
                --text: #343a40;
                --text-light: #6c757d;
                --white: #ffffff;
                --shadow: rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--light-bg);
                color: var(--text);
                line-height: 1.6;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .main-content {
                flex: 1;
                padding: 40px 20px;
                display: flex;
                justify-content: center;
            }

            .container {
                background: var(--white);
                border-radius: 12px;
                box-shadow: 0 8px 30px var(--shadow);
                width: 100%;
                max-width: 800px;
                padding: 30px;
                margin-bottom: 40px;
            }

            h2 {
                color: var(--primary);
                margin-bottom: 20px;
                font-weight: 600;
                text-align: center;
                font-size: 28px;
            }

            .form-section {
                margin-bottom: 30px;
                border-bottom: 1px solid var(--border);
                padding-bottom: 20px;
            }

            .form-section-title {
                font-size: 18px;
                color: var(--primary);
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-row {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 15px;
            }

            .form-group {
                flex: 1 1 calc(50% - 10px);
                min-width: 250px;
            }

            label {
                font-weight: 500;
                display: block;
                margin-bottom: 8px;
                color: var(--text);
            }

            input, select {
                width: 100%;
                padding: 12px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 15px;
                transition: var(--transition);
            }

            input:focus, select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .input-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .resolution-inputs {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .resolution-inputs input {
                width: 80px;
            }

            .resolution-inputs span {
                color: var(--text-light);
            }

            .hidden {
                display: none;
            }

            .button-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .input-error {
                border-color: var(--error) !important;
                box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.15) !important;
            }

            .error-text {
                display: block;
                color: var(--error);
                font-size: 0.8em;
                margin-top: 5px;
            }

            button, .btn-back {
                flex: 1;
                padding: 12px 20px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                text-align: center;
                cursor: pointer;
                transition: var(--transition);
                text-decoration: none;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                border: none;
            }

            button {
                background-color: var(--success);
                color: var(--white);
            }

            button:hover {
                background-color: var(--success-hover);
            }

            .btn-back {
                background-color: var(--secondary);
                color: var(--white);
            }

            .btn-back:hover {
                background-color: var(--secondary-hover);
            }

            .error-message {
                color: var(--error);
                text-align: center;
                margin-bottom: 20px;
                padding: 10px;
                background-color: rgba(231, 76, 60, 0.1);
                border-radius: 8px;
            }

            @media (max-width: 768px) {
                .form-group {
                    flex: 1 1 100%;
                }

                .button-group {
                    flex-direction: column;
                }
            }

            .toggle-switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 30px;
            }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 30px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 22px;
                width: 22px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked + .toggle-slider {
                background-color: var(--success);
            }

            input:checked + .toggle-slider:before {
                transform: translateX(30px);
            }

            .toggle-label {
                margin-left: 70px;
                font-weight: normal;
            }

            /* Popup styles */
            .popup {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
            }

            .popup.active {
                opacity: 1;
                visibility: visible;
            }

            .popup-content {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                text-align: center;
                max-width: 400px;
                width: 90%;
            }

            .popup-icon {
                font-size: 50px;
                margin-bottom: 20px;
            }

            .popup-success .popup-icon {
                color: var(--success);
            }

            .popup-error .popup-icon {
                color: var(--error);
            }

            .popup-title {
                font-size: 24px;
                margin-bottom: 15px;
                font-weight: 600;
            }

            .popup-message {
                margin-bottom: 25px;
                color: #555;
            }

            .popup-close {
                background-color: var(--primary);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .popup-close:hover {
                background-color: var(--primary-hover);
            }
        </style>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Field validation configuration
                const fieldValidations = {
                    laptopName: {
                        required: true,
                        maxLength: 100,
                        pattern: /^[\w\s\u00C0-\u1EF9\-\.\,\(\)\/]+$/i, // Allows Vietnamese and common characters
                        errorMessages: {
                            required: 'Product name is required',
                            maxLength: 'Product name cannot exceed 100 characters',
                            pattern: 'Product name contains invalid characters'
                        }
                    },
                    price: {
                        required: true,
                        min: 0,
                        max: 1000000000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Price is required',
                            min: 'Minimum price is 0',
                            max: 'Maximum price is 1,000,000,000',
                            pattern: 'Price must be an integer'
                        }
                    },
                    color: {
                        required: true,
                        maxLength: 30,
                        pattern: /^[a-zA-Z\s\u00C0-\u1EF9\-]+$/,
                        errorMessages: {
                            required: 'Color is required',
                            maxLength: 'Color cannot exceed 30 characters',
                            pattern: 'Color can only contain letters and hyphens'
                        }
                    },
                    imageUrl: {
                        required: true,
                        pattern: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\?\=\&\w \.-]*)*$/i, // Basic URL validation
                        errorMessages: {
                            required: 'Image URL is required',
                            pattern: 'Invalid URL format'
                        }
                    },
                    chipGeneration: {
                        required: true,
                        pattern: /^[a-zA-Z0-9\s\-]+$/,
                        errorMessages: {
                            required: 'Chip generation is required',
                            pattern: 'Only letters, numbers and hyphens allowed'
                        }
                    },
                    gpuName: {
                        required: true,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\-\+]+$/,
                        errorMessages: {
                            required: 'GPU name is required',
                            pattern: 'Only letters, numbers, + and hyphens allowed'
                        }
                    },
                    screenSize: {
                        required: true,
                        min: 10,
                        max: 20,
                        step: 0.1,
                        errorMessages: {
                            required: 'Screen size is required',
                            min: 'Minimum size is 10 inches',
                            max: 'Maximum size is 20 inches',
                            step: 'Must be in 0.1 increments'
                        }
                    },
                    resolutionWidth: {
                        required: true,
                        min: 800,
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Width is required',
                            min: 'Minimum width is 800 pixels',
                            max: 'Maximum width is 10,000 pixels',
                            pattern: 'Must be a whole number'
                        }
                    },
                    resolutionHeight: {
                        required: true,
                        min: 600,
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Height is required',
                            min: 'Minimum height is 600 pixels',
                            max: 'Maximum height is 10,000 pixels',
                            pattern: 'Must be a whole number'
                        }
                    },
                    osVersion: {
                        required: true,
                        pattern: /^[a-zA-Z0-9\s\.\-]+$/,
                        errorMessages: {
                            required: 'OS version is required',
                            pattern: 'Only letters, numbers, dots and hyphens allowed'
                        }
                    }
                };
                // Custom field patterns
                const customFieldPatterns = {
                    brandInput: /^[a-zA-Z\s]+$/,
                    chipInput: /^[a-zA-Z\s]+$/,
                    chipNameInput: /^[a-zA-Z0-9\s\-]+$/,
                    gputypeInput: /^[a-zA-Z\s]+$/,
                    ramInput: /^\d+\s*GB$/i,
                    ramTypeInput: /^[a-zA-Z0-9\s]+$/,
                    storageInput: /^\d+\s*(GB|TB)$/i,
                    refreshRateInput: /^\d+\s*Hz$/i,
                    screenResolutionInput: /^[a-zA-Z0-9\sx\+]+$/,
                    osInput: /^[a-zA-Z\s]+$/
                };

                const customFieldErrors = {
                    brandInput: 'Only letters allowed',
                    chipInput: 'Only letters allowed',
                    chipNameInput: 'Letters, numbers and hyphens allowed',
                    gputypeInput: 'Only letters allowed',
                    ramInput: 'Format: number followed by GB (e.g. 16GB)',
                    ramTypeInput: 'Only letters and numbers allowed',
                    storageInput: 'Format: number followed by GB/TB (e.g. 512GB or 1TB)',
                    refreshRateInput: 'Format: number followed by Hz (e.g. 144Hz)',
                    screenResolutionInput: 'Format: 1920x1080 or description',
                    osInput: 'Only letters allowed'
                };

                // Initialize select inputs
                function initializeSelectInputs() {
                    const selectIds = [
                        'brand', 'chip', 'chipName', 'gputype',
                        'ram', 'ramType', 'storage', 'refreshRate',
                        'screenResolution', 'os'
                    ];

                    selectIds.forEach(id => {
                        const select = document.getElementById(id);
                        if (select) {
                            select.dispatchEvent(new Event('change'));
                            select.addEventListener('change', function () {
                                const containerId = id + 'InputContainer';
                                const inputId = id + 'Input';
                                toggleInput(select, containerId, inputId);
                            });
                        }
                    });
                }

                function toggleInput(select, containerId, inputId) {
                    const container = document.getElementById(containerId);
                    const input = document.getElementById(inputId);

                    if (select.value === 'other') {
                        container.classList.remove('hidden');
                        input.required = true;
                        if (customFieldPatterns[inputId]) {
                            setupCustomFieldValidation(input, customFieldPatterns[inputId], customFieldErrors[inputId]);
                        }
                    } else {
                        container.classList.add('hidden');
                        input.required = false;
                        input.value = '';
                        clearError(input);
                    }
                }

                function setupCustomFieldValidation(field, pattern, errorMessage) {
                    field.addEventListener('input', function () {
                        validateCustomField(field, pattern, errorMessage);
                    });
                    if (field.value)
                        validateCustomField(field, pattern, errorMessage);
                }

                function validateCustomField(field, pattern, errorMessage) {
                    const value = field.value.trim();
                    if (!value) {
                        showError(field, 'This field is required');
                        return false;
                    }
                    if (!pattern.test(value)) {
                        showError(field, errorMessage);
                        return false;
                    }
                    clearError(field);
                    return true;
                }

                function setupRealTimeValidation() {
                    Object.keys(fieldValidations).forEach(fieldId => {
                        const field = document.getElementById(fieldId);
                        if (field) {
                            field.addEventListener('input', function () {
                                validateField(field, fieldValidations[fieldId]);
                            });
                            if (field.value)
                                validateField(field, fieldValidations[fieldId]);
                        }
                    });
                }

                function validateField(field, config) {
                    const value = field.value.trim();
                    let isValid = true;

                    if (config.required && !value) {
                        showError(field, config.errorMessages.required);
                        return false;
                    }

                    if (!config.required && !value) {
                        clearError(field);
                        return true;
                    }

                    if (config.maxLength && value.length > config.maxLength) {
                        showError(field, config.errorMessages.maxLength);
                        isValid = false;
                    }

                    if (config.pattern && !config.pattern.test(value)) {
                        showError(field, config.errorMessages.pattern);
                        isValid = false;
                    }

                    if (config.min !== undefined || config.max !== undefined) {
                        const numValue = parseFloat(value);
                        if (isNaN(numValue)) {
                            showError(field, 'Please enter a valid number');
                            isValid = false;
                        } else {
                            if (config.min !== undefined && numValue < config.min) {
                                showError(field, config.errorMessages.min);
                                isValid = false;
                            }
                            if (config.max !== undefined && numValue > config.max) {
                                showError(field, config.errorMessages.max);
                                isValid = false;
                            }
                            if (config.step !== undefined) {
                                const remainder = (numValue * 10) % (config.step * 10);
                                if (remainder !== 0) {
                                    showError(field, config.errorMessages.step);
                                    isValid = false;
                                }
                            }
                        }
                    }

                    if (isValid)
                        clearError(field);
                    return isValid;
                }

                function showError(input, message) {
                    input.classList.add('input-error');
                    let errorElement = input.nextElementSibling;
                    if (!errorElement || !errorElement.classList.contains('error-text')) {
                        errorElement = document.createElement('span');
                        errorElement.className = 'error-text';
                        input.parentNode.insertBefore(errorElement, input.nextSibling);
                    }
                    errorElement.textContent = message;
                }

                function clearError(input) {
                    input.classList.remove('input-error');
                    const errorElement = input.nextElementSibling;
                    if (errorElement && errorElement.classList.contains('error-text')) {
                        errorElement.textContent = '';
                    }
                }

                function validateResolutionRatio(width, height) {
                    const widthInput = document.getElementById('resolutionWidth');
                    const heightInput = document.getElementById('resolutionHeight');

                    if (!width || !height)
                        return true;

                    const w = parseInt(width);
                    const h = parseInt(height);
                    if (isNaN(w) || isNaN(h))
                        return true;

                    const ratio = w / h;
                    const commonRatios = {
                        '4:3': 1.33,
                        '16:10': 1.6,
                        '16:9': 1.78,
                        '3:2': 1.5
                    };

                    let closestRatio = '';
                    let minDiff = Infinity;
                    for (const [name, value] of Object.entries(commonRatios)) {
                        const diff = Math.abs(ratio - value);
                        if (diff < minDiff) {
                            minDiff = diff;
                            closestRatio = name;
                        }
                    }

                    if (minDiff > 0.1) {
                        const errorMsg = `Uncommon resolution ratio (${w}x${h}). Nearest standard: ${closestRatio}`;
                        showError(widthInput, errorMsg);
                        showError(heightInput, errorMsg);
                        return false;
                    }

                    clearError(widthInput);
                    clearError(heightInput);
                    return true;
                }

                // Form submission
                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function (e) {
                        let isValid = true;
                        const errorFields = [];

                        // Validate standard fields
                        Object.keys(fieldValidations).forEach(fieldId => {
                            const field = document.getElementById(fieldId);
                            if (field && !validateField(field, fieldValidations[fieldId])) {
                                isValid = false;
                                errorFields.push(field);
                            }
                        });

                        // Validate custom fields
                        const selectIds = [
                            'brand', 'chip', 'chipName', 'gputype',
                            'ram', 'ramType', 'storage', 'refreshRate',
                            'screenResolution', 'os'
                        ];
                        selectIds.forEach(id => {
                            const select = document.getElementById(id);
                            if (select && select.value === 'other') {
                                const inputId = id + 'Input';
                                const input = document.getElementById(inputId);
                                if (!validateCustomField(input, customFieldPatterns[inputId], customFieldErrors[inputId])) {
                                    isValid = false;
                                    errorFields.push(input);
                                }
                            }
                        });

                        // Validate resolution
                        const width = document.getElementById('resolutionWidth').value;
                        const height = document.getElementById('resolutionHeight').value;
                        if (!validateResolutionRatio(width, height)) {
                            isValid = false;
                            errorFields.push(
                                    document.getElementById('resolutionWidth'),
                                    document.getElementById('resolutionHeight')
                                    );
                        }

                        if (!isValid) {
                            e.preventDefault();
                            if (errorFields.length > 0) {
                                errorFields[0].scrollIntoView({
                                    behavior: 'smooth',
                                    block: 'center'
                                });
                                errorFields[0].focus();
                            }
                        }
                    });
                }

                // Initialize
                initializeSelectInputs();
                setupRealTimeValidation();

                // Success/Duplicate popups
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('success') === 'true') {
                    document.getElementById('successPopup').classList.add('active');
                } else if (urlParams.get('duplicate') === 'true') {
                    document.getElementById('duplicatePopup').classList.add('active');
                }

                document.addEventListener('click', function (e) {
                    if (e.target.classList.contains('popup-close')) {
                        e.target.closest('.popup').classList.remove('active');
                    }
                });
            });
        </script>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="main-content">
                <div class="container">
                    <h2><i class="fas fa-laptop"></i> Enter Laptop Information</h2>

                    <c:if test="${not empty error}">
                        <div style="color: red; text-align: center; margin-bottom: 15px;">
                            ${error}
                        </div>
                    </c:if>

                    <% String error = request.getParameter("error"); %>
                    <% if (error != null) { %>
                    <div class="error-message"><i class="fas fa-exclamation-circle"></i> <%= error %></div>
                    <% } %>

                    <form action="createProduct" method="post">
                        <input type="hidden" name="category" value="1">
                        <input type="hidden" name="frontCamera" value="">
                        <input type="hidden" name="rearCamera" value="">

                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="laptopName">Laptop Name</label>
                                    <input type="text" id="laptopName" name="productName" placeholder="Enter laptop model name" value="${product.productName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price (VND)</label>
                                    <input type="number" id="price" name="price" placeholder="Enter price in VND" min="100000" max="1000000000" value="${product.price}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="brand">Brand</label>
                                    <select id="brand" name="brand">
                                        <option value="Acer" ${brand == 'Acer' ? 'selected' : ''}>Acer</option>
                                        <option value="Apple" ${brand == 'Apple' ? 'selected' : ''}>Apple</option>
                                        <option value="Asus" ${brand == 'Asus' ? 'selected' : ''}>Asus</option>
                                        <option value="Dell" ${brand == 'Dell' ? 'selected' : ''}>Dell</option>
                                        <option value="HP" ${brand == 'HP' ? 'selected' : ''}>HP</option>
                                        <option value="Lenovo" ${brand == 'Lenovo' ? 'selected' : ''}>Lenovo</option>
                                        <option value="MSI" ${brand == 'MSI' ? 'selected' : ''}>MSI</option>
                                        <option value="Razer" ${brand == 'Razer' ? 'selected' : ''}>Razer</option>
                                        <option value="other" ${brand_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="brandInputContainer" class="${brand_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="brandInput" name="brand_custom" placeholder="Enter brand name (e.g. Huawei, Xiaomi)" value="${brand_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" id="color" name="color" placeholder="Enter color (e.g. Space Gray, Silver)" value="${product.color}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="url" id="imageUrl" name="imageURL" placeholder="Enter full image URL starting with http:// or https://" value="${product.imageURL}" required>
                                </div>
                            </div>
                        </div>

                        <!-- Performance Specifications Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-microchip"></i> Performance Specifications</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="chip">Chip Brand</label>
                                    <select id="chip" name="chiptype">
                                        <option value="Intel" ${chipType == 'Intel' ? 'selected' : ''}>Intel</option>
                                        <option value="AMD" ${chipType == 'AMD' ? 'selected' : ''}>AMD</option>
                                        <option value="Apple" ${chipType == 'Apple' ? 'selected' : ''}>Apple</option>
                                        <option value="other" ${chipType_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="chipInputContainer" class="${chipType_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="chipInput" name="chipType_custom" placeholder="Enter chip brand (e.g. Qualcomm, Samsung)" value="${chipType_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="chipName">Chip Name</label>
                                    <select id="chipName" name="chip">
                                        <option value="Core i3" ${chipName == 'Core i3' ? 'selected' : ''}>Core i3</option>
                                        <option value="Core i5" ${chipName == 'Core i5' ? 'selected' : ''}>Core i5</option>
                                        <option value="Core i7" ${chipName == 'Core i7' ? 'selected' : ''}>Core i7</option>
                                        <option value="Core i9" ${chipName == 'Core i9' ? 'selected' : ''}>Core i9</option>
                                        <option value="Ryzen 3" ${chipName == 'Ryzen 3' ? 'selected' : ''}>Ryzen 3</option>
                                        <option value="Ryzen 5" ${chipName == 'Ryzen 5' ? 'selected' : ''}>Ryzen 5</option>
                                        <option value="Ryzen 7" ${chipName == 'Ryzen 7' ? 'selected' : ''}>Ryzen 7</option>
                                        <option value="Ryzen 9" ${chipName == 'Ryzen 9' ? 'selected' : ''}>Ryzen 9</option>
                                        <option value="M1" ${chipName == 'M1' ? 'selected' : ''}>M1</option>
                                        <option value="M2" ${chipName == 'M2' ? 'selected' : ''}>M2</option>
                                        <option value="M3" ${chipName == 'M3' ? 'selected' : ''}>M3</option>
                                        <option value="other" ${chipName_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="chipNameInputContainer" class="${chipName_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="chipNameInput" name="chipName_custom" placeholder="Enter chip name (e.g. Snapdragon 8 Gen 2)" value="${chipName_custom}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="chipGeneration">Chip Generation</label>
                                    <input type="text" id="chipGeneration" name="chipGeneration" placeholder="Enter generation (e.g. 12th Gen, 3rd Gen)" value="${chipGeneration}" required>
                                </div>

                                <div class="form-group">
                                    <label for="gputype">GPU Brand</label>
                                    <select id="gputype" name="gpuType">
                                        <option value="Intel" ${gputype == 'Intel' ? 'selected' : ''}>Intel</option>
                                        <option value="AMD" ${gputype == 'AMD' ? 'selected' : ''}>AMD</option>
                                        <option value="Nvidia" ${gputype == 'Nvidia' ? 'selected' : ''}>Nvidia</option>
                                        <option value="Apple" ${gputype == 'Apple' ? 'selected' : ''}>Apple</option>
                                        <option value="other" ${gputype_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="gputypeInputContainer" class="${gputype_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="gputypeInput" name="gputype_custom" placeholder="Enter GPU brand (e.g. Mali, PowerVR)" value="${gputype_custom}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gpuName">GPU Name</label>
                                    <input type="text" id="gpuName" name="gpuName" placeholder="Enter GPU model name (e.g. RTX 3060, Radeon RX 6800M)" value="${product.gpuName}" required>
                                </div>
                            </div>
                        </div>

                        <!-- Memory & Storage Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-memory"></i> Memory & Storage</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="ram">RAM</label>
                                    <select id="ram" name="ram">
                                        <option value="4 GB" ${ram == '4 GB' ? 'selected' : ''}>4GB</option>
                                        <option value="8 GB" ${ram == '8 GB' ? 'selected' : ''}>8GB</option>
                                        <option value="16 GB" ${ram == '16 GB' ? 'selected' : ''}>16GB</option>
                                        <option value="32 GB" ${ram == '32 GB' ? 'selected' : ''}>32GB</option>
                                        <option value="other" ${ram_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="ramInputContainer" class="${ram_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="ramInput" name="ram_custom" placeholder="Enter RAM with unit (e.g. 12GB, 32GB)" value="${ram_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="ramType">RAM Type</label>
                                    <select id="ramType" name="ramType">
                                        <option value="DDR4" ${ramType == 'DDR4' ? 'selected' : ''}>DDR4</option>
                                        <option value="DDR5" ${ramType == 'DDR5' ? 'selected' : ''}>DDR5</option>
                                        <option value="Unified" ${ramType == 'Unified' ? 'selected' : ''}>Unified</option>
                                        <option value="other" ${ramType_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="ramTypeInputContainer" class="${ramType_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="ramTypeInput" name="ramType_custom" placeholder="Enter RAM type (e.g. LPDDR5, LPDDR4X)" value="${ramType_custom}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
    <div class="form-group">
        <label for="ramUpgrade">RAM Upgrade</label>
        <div class="toggle-container">
            <label class="toggle-switch">
                <input type="checkbox" id="ramUpgrade" name="supportsUpgradingRAM" value="1">
                <span class="toggle-slider"></span>
            </label>
            <span class="toggle-label" id="ramUpgradeLabel">Upgradeable</span>
        </div>
    </div>
</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="storage">Storage Capacity</label>
                                    <select id="storage" name="storage">
                                        <option value="256GB" ${storage == '256GB' ? 'selected' : ''}>256GB</option>
                                        <option value="512GB" ${storage == '512GB' ? 'selected' : ''}>512GB</option>
                                        <option value="1TB" ${storage == '1TB' ? 'selected' : ''}>1TB</option>
                                        <option value="2TB" ${storage == '2TB' ? 'selected' : ''}>2TB</option>
                                        <option value="other" ${storage_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="storageInputContainer" class="${storage_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="storageInput" name="storage_custom" placeholder="Enter storage with unit (e.g. 512GB, 1TB)" value="${storage_custom}">
                                    </div>
                                </div>

                                <div class="form-row">
    <div class="form-row">
    <div class="form-group">
        <label for="storageUpgrade">Storage Upgrade</label>
        <div class="toggle-container">
            <label class="toggle-switch">
                <input type="checkbox" id="storageUpgrade" name="supportsUpgradingROM" value="1">
                <span class="toggle-slider"></span>
            </label>
            <span class="toggle-label" id="storageUpgradeLabel">Upgradeable</span>
        </div>
    </div>
</div>
</div>
                            </div>
                        </div>

                        <!-- Display Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-desktop"></i> Display</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="screenSize">Screen Size (inch)</label>
                                    <input type="number" id="screenSize" name="size" placeholder="Enter size in inches (e.g. 15.6)" value="${screenSize}" step="0.1" min="10" max="20" required>
                                </div>

                                <div class="form-group">
                                    <label for="refreshRate">Refresh Rate</label>
                                    <select id="refreshRate" name="refreshRate">
                                        <option value="60 Hz" ${refreshRate == '60 Hz' ? 'selected' : ''}>60Hz</option>
                                        <option value="90 Hz" ${refreshRate == '90 Hz' ? 'selected' : ''}>90Hz</option>
                                        <option value="120 Hz" ${refreshRate == '120 Hz' ? 'selected' : ''}>120Hz</option>
                                        <option value="144 Hz" ${refreshRate == '144 Hz' ? 'selected' : ''}>144Hz</option>
                                        <option value="165 Hz" ${refreshRate == '165 Hz' ? 'selected' : ''}>165Hz</option>
                                        <option value="240 Hz" ${refreshRate == '240 Hz' ? 'selected' : ''}>240Hz</option>
                                        <option value="other" ${refreshRate_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="refreshRateInputContainer" class="${refreshRate_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="refreshRateInput" name="refreshRate_custom" placeholder="Enter refresh rate with unit (e.g. 90Hz, 165Hz)" value="${refreshRate_custom}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="screenResolution">Screen Resolution</label>
                                    <div class="input-group">
                                        <select id="screenResolution" name="screenResolution" style="flex: 1">
                                            <option value="HD+" ${screenResolution == 'HD+' ? 'selected' : ''}>HD+</option>
                                            <option value="Full HD+" ${screenResolution == 'Full HD+' ? 'selected' : ''}>Full HD+</option>
                                            <option value="1.5K" ${screenResolution == '1.5K' ? 'selected' : ''}>1.5K</option>
                                            <option value="1.5K+" ${screenResolution == '1.5K+' ? 'selected' : ''}>1.5K+</option>
                                            <option value="2K+" ${screenResolution == '2K+' ? 'selected' : ''}>2K+</option>
                                            <option value="Retina" ${screenResolution == 'Retina' ? 'selected' : ''}>Retina</option>
                                            <option value="other" ${screenResolution_custom != null ? 'selected' : ''}>Other</option>
                                        </select>
                                        <div class="resolution-inputs">
                                            <input type="number" id="resolutionWidth" name="resolutionWidth" placeholder="Width (e.g. 1920)" min="800" max="10000" required value="${width}">
                                            <span>×</span>
                                            <input type="number" id="resolutionHeight" name="resolutionHeight" placeholder="Height (e.g. 1080)" min="600" max="10000" required value="${height}">
                                        </div>
                                    </div>
                                    <div id="screenResolutionInputContainer" class="${screenResolution_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="Enter resolution (e.g. 2560x1600, 4K)" value="${screenResolution_custom}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Operating System Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-cogs"></i> Operating System</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="os">Operating System</label>
                                    <select id="os" name="os">
                                        <option value="Windows" ${os == 'Windows' ? 'selected' : ''}>Windows</option>
                                        <option value="MacOS" ${os == 'MacOS' ? 'selected' : ''}>MacOS</option>
                                        <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="osInput" name="os_custom" placeholder="Enter OS name (e.g. ChromeOS, Ubuntu)" value="${os_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="osVersion">Operating System Version</label>
                                    <input type="text" id="osVersion" name="version" placeholder="Enter OS version (e.g. Windows 11, macOS Ventura)" value="${product.operatingSystemVersion}" required>
                                </div>
                            </div>
                        </div>

                        <div class="button-group">
                            <button type="submit"><i class="fas fa-save"></i> Save</button>
                            <a href="listProductsForAdmin" class="btn-back"><i class="fas fa-arrow-left"></i> Back to List</a>
                        </div>
                    </form>
                </div>   
            </div>
        </div>

        <!-- Success Popup -->
        <div id="successPopup" class="popup popup-success">
            <div class="popup-content">
                <div class="popup-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h3 class="popup-title">Success</h3>
                <p class="popup-message">Laptop added successfully!</p>
                <button class="popup-close">OK</button>
            </div>
        </div>

        <!-- Duplicate Product Popup -->
        <div id="duplicatePopup" class="popup popup-error">
            <div class="popup-content">
                <div class="popup-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h3 class="popup-title">Duplicate Product</h3>
                <p class="popup-message">Laptop already exists. Please change product name or specifications.</p>
                <button class="popup-close">OK</button>
            </div>
        </div>
    </body>
</html>