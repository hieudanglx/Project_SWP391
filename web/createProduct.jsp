<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Enter Phone Information</title>
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
                --sidebar-width: 250px;
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

            .content {
                margin-left: 250px;
                padding: 20px;
                background-color: #f0f2f5;
            }

            .page-wrapper {
                display: flex;
                flex: 1;
                min-height: calc(100vh - 60px);
            }

            /* Sidebar Styles - keeping as is */
            .sidebar {
                width: var(--sidebar-width);
                background-color: var(--white);
                box-shadow: 2px 0 10px var(--shadow);
                padding: 20px 0;
                overflow-y: auto;
                flex-shrink: 0;
                position: sticky;
                top: 0;
                height: 100vh;
            }

            .sidebar-logo {
                text-align: center;
                padding: 0 20px 20px;
                border-bottom: 1px solid var(--border);
                margin-bottom: 20px;
            }

            .sidebar-logo img {
                max-width: 150px;
                height: auto;
            }

            .sidebar-menu {
                list-style: none;
            }

            .sidebar-item {
                margin-bottom: 5px;
            }

            .sidebar-link {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: var(--text);
                text-decoration: none;
                transition: var(--transition);
                font-weight: 500;
            }

            .sidebar-link:hover, .sidebar-link.active {
                background-color: rgba(67, 97, 238, 0.1);
                color: var(--primary);
            }

            .sidebar-link i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .sidebar-category {
                padding: 10px 20px;
                font-size: 12px;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: var(--text-light);
                margin-top: 15px;
                font-weight: 600;
            }

            /* Main Content Styles - ENHANCED */
            .main-content {
                flex: 1;
                padding: 30px 20px;
                display: flex;
                justify-content: center;
            }

            .container {
                background: var(--white);
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
                width: 100%;
                max-width: 900px;
                padding: 40px;
                margin-bottom: 40px;
                position: relative;
                overflow: hidden;
            }

            .container::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 8px;
                background: linear-gradient(to right, var(--primary), #6366f1);
            }

            h2 {
                color: var(--text);
                margin-bottom: 30px;
                font-weight: 700;
                text-align: center;
                font-size: 28px;
                position: relative;
                padding-bottom: 15px;
            }

            h2:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(to right, var(--primary), #6366f1);
                border-radius: 2px;
            }

            h2 i {
                color: var(--primary);
                margin-right: 10px;
            }

            .form-section {
                margin-bottom: 35px;
                border-bottom: 1px solid #eee;
                padding-bottom: 30px;
                transition: all 0.3s ease;
            }

            .form-section:hover {
                border-bottom-color: #d1d5db;
            }

            .form-section:last-child {
                border-bottom: none;
                margin-bottom: 15px;
            }

            .form-section-title {
                font-size: 20px;
                color: var(--primary);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 600;
                padding-left: 10px;
                border-left: 4px solid var(--primary);
            }

            .form-row {
                display: flex;
                flex-wrap: wrap;
                gap: 24px;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1 1 calc(50% - 12px);
                min-width: 250px;
                position: relative;
            }

            label {
                font-weight: 500;
                display: block;
                margin-bottom: 10px;
                color: var(--text);
                font-size: 16px;
            }

            input, select {
                width: 100%;
                padding: 14px;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                font-size: 15px;
                transition: all 0.3s ease;
                background-color: #f9fafb;
                color: var(--text);
            }

            input:focus, select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
                background-color: #fff;
            }

            input:hover, select:hover {
                border-color: #cbd5e1;
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
                gap: 20px;
                margin-top: 40px;
            }

            button, .btn-back {
                flex: 1;
                padding: 15px 20px;
                border-radius: 10px;
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
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            button {
                background: linear-gradient(to right, var(--success), #32d74b);
                color: var(--white);
            }

            button:hover {
                background: linear-gradient(to right, var(--success-hover), #28bd40);
                transform: translateY(-2px);
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
            }

            .btn-back {
                background-color: var(--secondary);
                color: var(--white);
            }

            .btn-back:hover {
                background-color: var(--secondary-hover);
                transform: translateY(-2px);
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
            }

            .error-message {
                color: #fff;
                text-align: center;
                margin-bottom: 25px;
                padding: 15px;
                background-color: var(--error);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                font-weight: 500;
                box-shadow: 0 4px 6px rgba(231, 76, 60, 0.2);
            }

            /* Custom input elements */
            .custom-input-container {
                margin-top: 10px;
                animation: fadeIn 0.3s ease;
                display: block; /* ??m b?o hi?n th? khi không b? ?n */
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

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive Styles */
            @media (max-width: 992px) {
                .page-wrapper {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    padding: 10px 0;
                }

                .sidebar-logo {
                    padding: 10px 20px;
                    margin-bottom: 10px;
                }

                .sidebar-menu {
                    display: flex;
                    flex-wrap: wrap;
                    justify-content: center;
                }

                .sidebar-item {
                    margin: 0 5px;
                }

                .sidebar-link {
                    padding: 8px 15px;
                }

                .sidebar-category {
                    display: none;
                }

                .content {
                    margin-left: 0;
                }

                .container {
                    padding: 30px 20px;
                }
            }

            @media (max-width: 768px) {
                .form-group {
                    flex: 1 1 100%;
                }

                .button-group {
                    flex-direction: column;
                }

                .sidebar-menu {
                    flex-direction: column;
                }

                .sidebar-item {
                    margin: 0;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Field validation configuration (adjusted as requested)
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
                        min: 0, // Changed to minimum value of 0
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
                        pattern: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\?\=\&\w \.-]*)*$/i, // Basic URL validation
                        errorMessages: {
                            required: 'Image URL is required',
                            pattern: 'Invalid URL format'
                        }
                    },
                    frontCamera: {
                        required: true,
                        maxLength: 50,
                        pattern: /^(\d+MP)(\s*\+\s*\d+MP)*$/, // Format like 12MP or 12MP + 8MP
                        errorMessages: {
                            required: 'Front camera is required',
                            maxLength: 'Front camera cannot exceed 50 characters',
                            pattern: 'Format must be "12MP" or "12MP + 8MP"'
                        }
                    },
                    rearCamera: {
                        required: true,
                        maxLength: 100,
                        pattern: /^(\d+MP)(\s*\+\s*\d+MP)*$/, // Format like 12MP or 12MP + 8MP + 5MP
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
                            required: 'Chip type is required',
                            maxLength: 'Chip type cannot exceed 30 characters',
                            pattern: 'Chip type can only contain letters, numbers, + and hyphens'
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
                            required: 'GPU type is required',
                            maxLength: 'GPU type cannot exceed 30 characters',
                            pattern: 'GPU type can only contain letters, numbers, + and hyphens'
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
                        min: 1,
                        max: 20,
                        step: 0.1,
                        errorMessages: {
                            required: 'Screen size is required',
                            min: 'Minimum size is 1 inch',
                            max: 'Maximum size is 20 inches',
                            step: 'Size must be a multiple of 0.1'
                        }
                    },

                    resolutionWidth: {
                        required: true,
                        min: 100,
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Width is required',
                            min: 'Minimum width is 100 pixels',
                            max: 'Maximum width is 10,000 pixels',
                            pattern: 'Width must be an integer'
                        }
                    },
                    resolutionHeight: {
                        required: true,
                        min: 100,
                        max: 10000,
                        pattern: /^\d+$/,
                        errorMessages: {
                            required: 'Height is required',
                            min: 'Minimum height is 100 pixels',
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
                    },

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
                            setupCustomFieldValidation(inputId, /^\d+GB$/i, 'Please enter correct format (e.g., 15GB)');
                        } else if (selectId === 'storage') {
                            setupCustomFieldValidation(inputId, /^\d+TB$/i, 'Please enter correct format (e.g., 12TB)');
                        } else if (selectId === 'refreshRate') {
                            setupCustomFieldValidation(inputId, /^\d+Hz$/i, 'Please enter correct format (e.g., 15Hz)');
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

                    // Apply custom pattern and error message if provided
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

                    field.addEventListener('input', () => {
                        validateField(field, validationConfig);
                    });

                    // Validate immediately if there's a value
                    if (field.value) {
                        validateField(field, validationConfig);
                }
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
                            field.addEventListener('input', () => {
                                validateField(field, fieldValidations[fieldId]);
                            });

                            // Validate on page load if there's a value
                            if (field.value) {
                                validateField(field, fieldValidations[fieldId]);
                            }
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

                    if (isValid) {
                        clearError(field);
                    }

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
                    if (existingError) {
                        existingError.remove();
                    }

                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'error-message global-error-message';
                    errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;

                    const title = document.querySelector('h2');
                    if (title) {
                        title.insertAdjacentElement('afterend', errorDiv);
                    }
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
            });
            // Function to show popup
function showPopup(popupId) {
    const popup = document.getElementById(popupId);
    if (popup) {
        popup.classList.add('active');
    }
}

// Function to close popup
function closePopup(popupId) {
    const popup = document.getElementById(popupId);
    if (popup) {
        popup.classList.remove('active');
    }
}

// Check for success or duplicate in URL parameters on page load
document.addEventListener('DOMContentLoaded', function() {
    // Get the current URL
    const url = new URL(window.location.href);
    
    // Check for duplicate parameter
    if (url.searchParams.get('duplicate') === 'true') {
        showPopup('duplicatePopup');
    }
    
    // Check for success parameter
    if (url.searchParams.get('success') === 'true') {
        showPopup('successPopup');
    }
});
        </script>
    </head>

    <body>
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <!-- Main Content -->
            <div class="main-content">
                <div class="container">
                    <h2><i class="fas fa-mobile-alt"></i> Enter Phone Information</h2>

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
                        <input type="hidden" name="category" value="2">
                        <input type="hidden" name="ramType" value="">
                        <input type="hidden" name="supportsUpgradingRAM" value="">
                        <input type="hidden" name="supportsUpgradingROM" value="">
                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Phone Name</label>
                                    <input type="text" id="productName" name="productName" value="${product.productName}" placeholder="Enter phone model name" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="number" id="price" name="price" min="0" max="1000000000" value="${product.price}" placeholder="Enter price" required>
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
                                    <div id="brandInputContainer" class="${brand_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="brandInput" name="brand_custom" placeholder="Enter brand" value="${brand_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" id="color" name="color" value="${product.color}" placeholder="Enter phone color" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="url" id="imageURL" name="imageURL" value="${product.imageURL}" placeholder="Enter product image URL" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-camera"></i> Camera</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="frontCamera">Front Camera</label>
                                    <input type="text" id="frontCamera" name="frontCamera" value="${product.cameraFront}" placeholder="e.g., 12MP" required>
                                </div>

                                <div class="form-group">
                                    <label for="rearCamera">Rear Camera</label>
                                    <input type="text" id="rearCamera" name="rearCamera" value="${product.cameraBehind}" placeholder="e.g., 48MP + 12MP + 5MP" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-microchip"></i> Performance Specifications</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="chiptype">Chip Brand</label>
                                    <input type="text" id="chiptype" name="chiptype" value="${product.chipType}" placeholder="e.g., Snapdragon, Apple, MediaTek" required>
                                </div>

                                <div class="form-group">
                                    <label for="chip">Chip Name</label>
                                    <input type="text" id="chip" name="chip" value="${product.chipName}" placeholder="e.g., A15 Bionic, 8 Gen 2" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gpuType">GPU Brand</label>
                                    <input type="text" id="gpuType" name="gpuType" value="${product.gpuType}" placeholder="e.g., Adreno, Apple, Mali" required>
                                </div>

                                <div class="form-group">
                                    <label for="gpuName">GPU Name</label>
                                    <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}" placeholder="e.g., Adreno 740, Mali-G78" required>
                                </div>
                            </div>
                        </div>

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
                                    <div id="ramInputContainer" class="${ram_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="ramInput" name="ram_custom" placeholder="Enter RAM amount" value="${ram_custom}">
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
                                    <div id="storageInputContainer" class="${storage_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="storageInput" name="storage_custom" placeholder="Enter storage capacity" value="${storage_custom}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-desktop"></i> Display</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="size">Screen Size (inch)</label>
                                    <input type="number" id="size" name="size" value="${screenSize}" step="0.1" placeholder="e.g., 6.5" required>
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
                                    <div id="refreshRateInputContainer" class="${refreshRate_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="refreshRateInput" name="refreshRate_custom" placeholder="Enter refresh rate" value="${refreshRate_custom}">
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
                                            <input type="number" id="resolutionWidth" name="resolutionWidth" min="1" required placeholder="Width" value="${width}">
                                            <span>×</span>
                                            <input type="number" id="resolutionHeight" name="resolutionHeight" min="1" required placeholder="Height" value="${height}">
                                        </div>
                                    </div>
                                    <div id="screenResolutionInputContainer" class="${screenResolution_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="Enter screen resolution" value="${screenResolution_custom}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-cogs"></i> Operating System</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="os">Operating System</label>
                                    <select id="os" name="os" onchange="toggleInput('os', 'osInputContainer', 'osInput')">
                                        <option value="Android" ${os == 'Android' ? 'selected' : ''}>Android</option>
                                        <option value="iOS" ${os == 'iOS' ? 'selected' : ''}>iOS</option>
                                        <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="osInputContainer" class="${os_custom != null ? 'custom-input-container' : 'hidden'}">
                                        <input type="text" id="osInput" name="os_custom" placeholder="Enter OS" value="${os_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="version">Operating System Version</label>
                                    <input type="text" id="version" name="version" value="${product.operatingSystemVersion}" placeholder="e.g., 13, iOS 16" required>
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
                <p class="popup-message">Product added successfully!</p>
                <button class="popup-close" onclick="closePopup('successPopup')">OK</button>
            </div>
        </div>

        <!-- Duplicate Product Popup -->
        <div id="duplicatePopup" class="popup popup-error">
            <div class="popup-content">
                <div class="popup-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h3 class="popup-title">Duplicate Product</h3>
                <p class="popup-message">Product already exists. Please change 1 of the following 4 data fields: Phone Name, Color, RAM, Storage Capacity.</p>
                <button class="popup-close" onclick="closePopup('duplicatePopup')">OK</button>
            </div>
        </div>
    </body>
</html>