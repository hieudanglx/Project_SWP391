<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Enter Tablet Information</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #4361ee;
                --primary-hover: #3a56d4;
                --secondary: #6c757d;
                --secondary-hover: #5a6268;
                --success: #2ecc71;
                --success-hover: #27ae60;
                --error: #3498db;
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
                color: #2ecc71;
            }

            .popup-error .popup-icon {
                color: #e74c3c;
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
                background-color: #4361ee;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .popup-close:hover {
                background-color: #3a56d4;
            }

            .input-error {
                border-color: red !important;
                box-shadow: 0 0 5px rgba(255,0,0,0.5) !important;
            }

            .error-text {
                display: block;
                color: red;
                font-size: 0.8em;
                margin-top: 5px;
            }

            @media (max-width: 768px) {
                .form-group {
                    flex: 1 1 100%;
                }

                .button-group {
                    flex-direction: column;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Field validation configuration for Tablet
                const fieldValidations = {
                    productName: {
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
                    imageURL: {
                        required: true,
                        pattern: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\?\=\&\w \.-]*)*$/i,
                        errorMessages: {
                            required: 'Image URL is required',
                            pattern: 'Invalid URL format'
                        }
                    },
                    frontCamera: {
                        required: true,
                        maxLength: 50,
                        pattern: /^(\d+MP)(\s*\+\s*\d+MP)*$/,
                        errorMessages: {
                            required: 'Front camera is required',
                            maxLength: 'Front camera cannot exceed 50 characters',
                            pattern: 'Format must be "12MP" or "12MP + 8MP"'
                        }
                    },
                    rearCamera: {
                        required: true,
                        maxLength: 100,
                        pattern: /^(\d+MP)(\s*\+\s*\d+MP)*$/,
                        errorMessages: {
                            required: 'Rear camera is required',
                            maxLength: 'Rear camera cannot exceed 100 characters',
                            pattern: 'Format must be "12MP" or "12MP + 8MP + 5MP"'
                        }
                    },
                    chiptype: {
                        required: true,
                        maxLength: 30,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\-\+]+$/,
                        errorMessages: {
                            required: 'Chip brand is required',
                            maxLength: 'Chip brand cannot exceed 30 characters',
                            pattern: 'Chip brand can only contain letters, numbers, + and hyphens'
                        }
                    },
                    chip: {
                        required: true,
                        maxLength: 30,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\-\+]+$/,
                        errorMessages: {
                            required: 'Chip name is required',
                            maxLength: 'Chip name cannot exceed 30 characters',
                            pattern: 'Chip name can only contain letters, numbers, + and hyphens'
                        }
                    },
                    gpuType: {
                        required: true,
                        maxLength: 30,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\-\+]+$/,
                        errorMessages: {
                            required: 'GPU brand is required',
                            maxLength: 'GPU brand cannot exceed 30 characters',
                            pattern: 'GPU brand can only contain letters, numbers, + and hyphens'
                        }
                    },
                    gpuName: {
                        required: true,
                        maxLength: 30,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\-\+]+$/,
                        errorMessages: {
                            required: 'GPU name is required',
                            maxLength: 'GPU name cannot exceed 30 characters',
                            pattern: 'GPU name can only contain letters, numbers, + and hyphens'
                        }
                    },
                    size: {
                        required: true,
                        min: 5, // Changed minimum size for tablets (from 1 to 5 inches)
                        max: 20,
                        step: 0.1,
                        errorMessages: {
                            required: 'Screen size is required',
                            min: 'Minimum size is 5 inches for tablets',
                            max: 'Maximum size is 20 inches',
                            step: 'Size must be a multiple of 0.1'
                        }
                    },
                    resolutionWidth: {
                        required: true,
                        min: 500, // Increased minimum resolution for tablets
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Width is required',
                            min: 'Minimum width is 500 pixels for tablets',
                            max: 'Maximum width is 10,000 pixels',
                            pattern: 'Width must be an integer'
                        }
                    },
                    resolutionHeight: {
                        required: true,
                        min: 500, // Increased minimum resolution for tablets
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Height is required',
                            min: 'Minimum height is 500 pixels for tablets',
                            max: 'Maximum height is 10,000 pixels',
                            pattern: 'Height must be an integer'
                        }
                    },
                    version: {
                        required: true,
                        maxLength: 20,
                        pattern: /^[a-zA-Z0-9\s\u00C0-\u1EF9\.\-]+$/,
                        errorMessages: {
                            required: 'OS version is required',
                            maxLength: 'Version cannot exceed 20 characters',
                            pattern: 'Version can only contain letters, numbers, dots and hyphens'
                        }
                    }


                };


                // Function to toggle input when Other is selected
                function toggleInput(selectId, containerId, inputId) {
                    const select = document.getElementById(selectId);
                    const container = document.getElementById(containerId);
                    const input = document.getElementById(inputId);

                    if (select.value === 'other') {
                        container.classList.remove('hidden');
                        input.required = true;

                        // Add special validation for specific fields
                        if (selectId === 'ram') {
                            setupCustomFieldValidation(inputId, /^\d+GB$/i, 'Please enter correct format (e.g., 8GB)');
                        } else if (selectId === 'storage') {
                            setupCustomFieldValidation(inputId, /^\d+(GB|TB)$/i, 'Please enter correct format (e.g., 128GB or 1TB)');
                        } else if (selectId === 'refreshRate') {
                            setupCustomFieldValidation(inputId, /^\d+Hz$/i, 'Please enter correct format (e.g., 120Hz)');
                        } else {
                            setupCustomFieldValidation(inputId);
                        }
                    } else {
                        container.classList.add('hidden');
                        input.required = false;
                        input.value = '';
                        clearError(input);
                    }
                }

                // Set up validation for custom fields (when Other is selected)
                function setupCustomFieldValidation(fieldId, customPattern = null, customErrorMessage = null) {
                    const field = document.getElementById(fieldId);
                    if (!field)
                        return;

                    const baseId = fieldId.replace('Input', '');
                    let validationConfig = fieldValidations[baseId] || {
                        required: true,
                        maxLength: 30,
                        errorMessages: {
                            required: 'This field is required when selecting Other',
                            maxLength: 'Cannot exceed 30 characters'
                        }
                    };

                    if (customPattern && customErrorMessage) {
                        validationConfig = {
                            ...validationConfig,
                            pattern: customPattern,
                            errorMessages: {
                                ...validationConfig.errorMessages,
                                pattern: customErrorMessage
                            }
                        };
                    }

                    field.addEventListener('input', () => validateField(field, validationConfig));
                    if (field.value)
                        validateField(field, validationConfig);
                }

                // Attach events to select boxes
                const selectIds = ['brand', 'ram', 'storage', 'refreshRate', 'screenResolution', 'os'];
                selectIds.forEach(id => {
                    const select = document.getElementById(id);
                    if (select) {
                        select.addEventListener('change', function () {
                            const containerId = id + 'InputContainer';
                            const inputId = id + 'Input';
                            toggleInput(id, containerId, inputId);
                        });

                        // Check on initial page load
                        const containerId = id + 'InputContainer';
                        const inputId = id + 'Input';
                        toggleInput(id, containerId, inputId);
                    }
                });

                // Set up real-time validation for all fields
                function setupRealTimeValidation() {
                    Object.keys(fieldValidations).forEach(fieldId => {
                        const field = document.getElementById(fieldId);
                        if (field) {
                            field.addEventListener('input', () => validateField(field, fieldValidations[fieldId]));
                            if (field.value)
                                validateField(field, fieldValidations[fieldId]);
                        }
                    });
                }

                // Validate on form submit
                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function (e) {
                        let isValid = true;

                        // Validate all main fields
                        Object.keys(fieldValidations).forEach(fieldId => {
                            const field = document.getElementById(fieldId);
                            if (field && !validateField(field, fieldValidations[fieldId])) {
                                isValid = false;
                            }
                        });

                        // Validate custom fields (when Other is selected)
                        selectIds.forEach(id => {
                            const select = document.getElementById(id);
                            if (select && select.value === 'other') {
                                const inputId = id + 'Input';
                                const input = document.getElementById(inputId);
                                const baseId = inputId.replace('Input', '');
                                const validationConfig = fieldValidations[baseId] || {
                                    required: true,
                                    maxLength: 30,
                                    errorMessages: {
                                        required: 'This field is required when selecting Other',
                                        maxLength: 'Cannot exceed 30 characters'
                                    }
                                };

                                if (!validateField(input, validationConfig)) {
                                    isValid = false;
                                }
                            }
                        });

                        if (!isValid) {
                            e.preventDefault();
                            showGlobalError('Please correct all errors before submitting');
                            scrollToFirstError();
                        }
                    });
                }

                // ===== VALIDATION FUNCTIONS =====
                function validateField(field, config) {
                    if (!field)
                        return true;

                    const value = field.value.trim();
                    let isValid = true;

                    // Check required
                    if (config.required && !value) {
                        showError(field, config.errorMessages.required);
                        return false;
                    }

                    // If field is not required and empty, skip other checks
                    if (!config.required && !value) {
                        clearError(field);
                        return true;
                    }

                    // Check maxLength
                    if (config.maxLength && value.length > config.maxLength) {
                        showError(field, config.errorMessages.maxLength);
                        isValid = false;
                    }

                    // Check pattern (regex)
                    if (config.pattern && !config.pattern.test(value)) {
                        showError(field, config.errorMessages.pattern);
                        isValid = false;
                    }

                    // Check numeric values
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

                // ===== ERROR DISPLAY FUNCTIONS =====
                function showError(input, message) {
                    if (!input)
                        return;

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
                    if (!input)
                        return;

                    input.classList.remove('input-error');
                    const errorElement = input.nextElementSibling;
                    if (errorElement && errorElement.classList.contains('error-text')) {
                        errorElement.textContent = '';
                    }
                }

                function showGlobalError(message) {
                    let existingError = document.querySelector('.global-error-message');
                    if (existingError)
                        existingError.remove();

                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'error-message global-error-message';
                    errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;

                    const title = document.querySelector('h2');
                    if (title)
                        title.insertAdjacentElement('afterend', errorDiv);
                }

                function scrollToFirstError() {
                    const firstError = document.querySelector('.input-error');
                    if (firstError) {
                        firstError.scrollIntoView({behavior: 'smooth', block: 'center'});
                        firstError.focus();
                    }
                }

                // Initialize real-time validation
                setupRealTimeValidation();

                // Add popup functionality
                function showPopup(popupId) {
                    const popup = document.getElementById(popupId);
                    if (popup) {
                        popup.classList.add('active');
                    }
                }

                function closePopup(popupId) {
                    const popup = document.getElementById(popupId);
                    if (popup) {
                        popup.classList.remove('active');

                        // Redirect after closing success popup - quay v? createTablet.jsp
                        if (popupId === 'successPopup') {
                            setTimeout(() => {
                                window.location.href = 'createTablet.jsp';
                            }, 300);
                        }
                    }
                }

                // Thêm event listener cho các nút ?óng popup
                document.querySelectorAll('.popup-close').forEach(button => {
                    button.addEventListener('click', function () {
                        const popup = this.closest('.popup');
                        if (popup) {
                            closePopup(popup.id);
                        }
                    });
                });

                // Check URL parameters for popups
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('duplicate') === 'true') {
                    showPopup('duplicatePopup');
                }
                if (urlParams.get('success') === 'true') {
                    showPopup('successPopup');
                }
            });
        </script>
    </head>
    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="main-content">
                <div class="container">
                    <h2><i class="fas fa-tablet-alt"></i> Enter Tablet Information</h2>

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
                        <input type="hidden" name="category" value="3">
                        <input type="hidden" name="ramType" value="">
                        <input type="hidden" name="supportsUpgradingRAM" value="">
                        <input type="hidden" name="supportsUpgradingROM" value="">

                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Tablet Name</label>
                                    <input type="text" id="productName" name="productName" value="${product.productName}" placeholder="e.g., iPad Pro 12.9, Galaxy Tab S8" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price (VND)</label>
                                    <input type="number" id="price" name="price" min="0" max="1000000000" value="${product.price}" placeholder="e.g., 15000000" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="brand">Brand</label>
                                    <select id="brand" name="brand" onchange="toggleInput('brand', 'brandInputContainer', 'brandInput')">
                                        <option value="Apple" ${brand == 'Apple' ? 'selected' : ''}>Apple</option>
                                        <option value="Samsung" ${brand == 'Samsung' ? 'selected' : ''}>Samsung</option>
                                        <option value="Xiaomi" ${brand == 'Xiaomi' ? 'selected' : ''}>Xiaomi</option>
                                        <option value="Oppo" ${brand == 'Oppo' ? 'selected' : ''}>Oppo</option>
                                        <option value="Vivo" ${brand == 'Vivo' ? 'selected' : ''}>Vivo</option>
                                        <option value="other" ${brand_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="brandInputContainer" class="${brand_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="brandInput" name="brand_custom" placeholder="e.g., Huawei, Lenovo" value="${brand_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" id="color" name="color" value="${product.color}" placeholder="e.g., Space Gray, Silver" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="url" id="imageURL" name="imageURL" value="${product.imageURL}" placeholder="e.g., https://example.com/tablet-image.jpg" required>
                                </div>
                            </div>
                        </div>

                        <!-- Camera Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-camera"></i> Camera</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="frontCamera">Front Camera</label>
                                    <input type="text" id="frontCamera" name="frontCamera" value="${product.cameraFront}" placeholder="e.g., 12MP Ultra Wide" required>
                                </div>

                                <div class="form-group">
                                    <label for="rearCamera">Rear Camera</label>
                                    <input type="text" id="rearCamera" name="rearCamera" value="${product.cameraBehind}" placeholder="e.g., 12MP Wide + 10MP Ultra Wide" required>
                                </div>
                            </div>
                        </div>

                        <!-- Performance Specifications Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-microchip"></i> Performance Specifications</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="chiptype">Chip Brand</label>
                                    <input type="text" id="chiptype" name="chiptype" value="${product.chipType}" placeholder="e.g., Apple, Qualcomm, MediaTek" required>
                                </div>

                                <div class="form-group">
                                    <label for="chip">Chip Name</label>
                                    <input type="text" id="chip" name="chip" value="${product.chipName}" placeholder="e.g., M1, Snapdragon 8 Gen 1" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gpuType">GPU Brand</label>
                                    <input type="text" id="gpuType" name="gpuType" value="${product.gpuType}" placeholder="e.g., Apple, Adreno, Mali" required>
                                </div>

                                <div class="form-group">
                                    <label for="gpuName">GPU Name</label>
                                    <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}" placeholder="e.g., Apple GPU 5-core, Adreno 730" required>
                                </div>
                            </div>
                        </div>

                        <!-- Memory & Storage Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-memory"></i> Memory & Storage</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="ram">RAM</label>
                                    <select id="ram" name="ram" onchange="toggleInput('ram', 'ramInputContainer', 'ramInput')">
                                        <option value="3GB" ${ram == '3GB' ? 'selected' : ''}>3GB</option>
                                        <option value="4GB" ${ram == '4GB' ? 'selected' : ''}>4GB</option>
                                        <option value="6GB" ${ram == '6GB' ? 'selected' : ''}>6GB</option>
                                        <option value="8GB" ${ram == '8GB' ? 'selected' : ''}>8GB</option>
                                        <option value="12GB" ${ram == '12GB' ? 'selected' : ''}>12GB</option>
                                        <option value="16GB" ${ram == '16GB' ? 'selected' : ''}>16GB</option>
                                        <option value="other" ${ram_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="ramInputContainer" class="${ram_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="ramInput" name="ram_custom" placeholder="e.g., 2GB, 18GB (include unit)" value="${ram_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="storage">Storage Capacity</label>
                                    <select id="storage" name="storage" onchange="toggleInput('storage', 'storageInputContainer', 'storageInput')">
                                        <option value="64GB" ${storage == '64GB' ? 'selected' : ''}>64GB</option>
                                        <option value="128GB" ${storage == '128GB' ? 'selected' : ''}>128GB</option>
                                        <option value="256GB" ${storage == '256GB' ? 'selected' : ''}>256GB</option>
                                        <option value="512GB" ${storage == '512GB' ? 'selected' : ''}>512GB</option>
                                        <option value="1TB" ${storage == '1TB' ? 'selected' : ''}>1TB</option>
                                        <option value="other" ${storage_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="storageInputContainer" class="${storage_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="storageInput" name="storage_custom" placeholder="e.g., 32GB, 2TB (include unit)" value="${storage_custom}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Display Section -->
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-desktop"></i> Display</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="size">Screen Size (inches)</label>
                                    <input type="number" id="size" name="size" value="${screenSize}" step="0.1" placeholder="e.g., 10.9, 12.9" required>
                                </div>

                                <div class="form-group">
                                    <label for="refreshRate">Refresh Rate</label>
                                    <select id="refreshRate" name="refreshRate" onchange="toggleInput('refreshRate', 'refreshRateInputContainer', 'refreshRateInput')">
                                        <option value="60Hz" ${refreshRate == '60Hz' ? 'selected' : ''}>60Hz</option>
                                        <option value="90Hz" ${refreshRate == '90Hz' ? 'selected' : ''}>90Hz</option>
                                        <option value="120Hz" ${refreshRate == '120Hz' ? 'selected' : ''}>120Hz</option>
                                        <option value="144Hz" ${refreshRate == '144Hz' ? 'selected' : ''}>144Hz</option>
                                        <option value="other" ${refreshRate_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="refreshRateInputContainer" class="${refreshRate_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="refreshRateInput" name="refreshRate_custom" placeholder="e.g., 165Hz, 240Hz (include unit)" value="${refreshRate_custom}">
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="screenResolution">Screen Resolution</label>
                                    <div class="input-group">
                                        <select id="screenResolution" name="screenResolution" onchange="toggleInput('screenResolution', 'screenResolutionInputContainer', 'screenResolutionInput')" style="flex: 1">
                                            <option value="HD+" ${screenResolution == 'HD+' ? 'selected' : ''}>HD+</option>
                                            <option value="Full HD+" ${screenResolution == 'Full HD+' ? 'selected' : ''}>Full HD+</option>
                                            <option value="1.5K" ${screenResolution == '1.5K' ? 'selected' : ''}>1.5K</option>
                                            <option value="1.5K+" ${screenResolution == '1.5K+' ? 'selected' : ''}>1.5K+</option>
                                            <option value="2K+" ${screenResolution == '2K+' ? 'selected' : ''}>2K+</option>
                                            <option value="Retina" ${screenResolution == 'Retina' ? 'selected' : ''}>Retina</option>
                                            <option value="other" ${screenResolution_custom != null ? 'selected' : ''}>Other</option>
                                        </select>
                                        <div class="resolution-inputs">
                                            <input type="number" id="resolutionWidth" name="resolutionWidth" min="1" required placeholder="e.g., 1600" value="${width}">
                                            <span>×</span>
                                            <input type="number" id="resolutionHeight" name="resolutionHeight" min="1" required placeholder="e.g., 2560" value="${height}">
                                        </div>
                                    </div>
                                    <div id="screenResolutionInputContainer" class="${screenResolution_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="e.g., QHD+, 4K" value="${screenResolution_custom}">
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
                                    <select id="os" name="os" onchange="toggleInput('os', 'osInputContainer', 'osInput')">
                                        <option value="Android" ${os == 'Android' ? 'selected' : ''}>Android</option>
                                        <option value="iPadOS" ${os == 'iPadOS' ? 'selected' : ''}>iPadOS</option>
                                        <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="osInput" name="os_custom" placeholder="e.g., HarmonyOS, Windows" value="${os_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="version">OS Version</label>
                                    <input type="text" id="version" name="version" value="${product.operatingSystemVersion}" placeholder="e.g., 15, iPadOS 16" required>
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
                <p class="popup-message">Tablet added successfully!</p>
                <button type="button" class="popup-close">OK</button>
            </div>
        </div>

        <!-- Duplicate Product Popup -->
        <div id="duplicatePopup" class="popup popup-error">
            <div class="popup-content">
                <div class="popup-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h3 class="popup-title">Duplicate Tablet</h3>
                <p class="popup-message">Tablet already exists. Please change 1 of the following 4 data fields: Tablet Name, Color, RAM, Storage Capacity.</p>
                <button type="button" class="popup-close">OK</button>
            </div>
        </div>
    </body>
</html>