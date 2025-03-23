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
            function toggleInput(selectId, inputContainerId, inputId) {
                var select = document.getElementById(selectId);
                var inputContainer = document.getElementById(inputContainerId);
                var input = document.getElementById(inputId);

                if (select.value === "other") {
                    inputContainer.classList.remove("hidden");
                    input.required = true;
                } else {
                    inputContainer.classList.add("hidden");
                    input.required = false;
                    input.value = "";
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                // Initialize all dropdowns on page load
                const dropdowns = document.querySelectorAll('select');
                dropdowns.forEach(dropdown => {
                    const id = dropdown.id;
                    if (id) {
                        const containerId = id + 'InputContainer';
                        const inputId = id + 'Input';
                        const container = document.getElementById(containerId);

                        if (container && dropdown.value === 'other') {
                            container.classList.remove('hidden');
                            const input = document.getElementById(inputId);
                            if (input)
                                input.required = true;
                        }
                    }
                });

                function formatInputWithUnit(inputId, unit) {
                    var input = document.getElementById(inputId);
                    if (!input)
                        return;

                    input.addEventListener("input", function () {
                        let value = this.value.replace(/\D/g, ''); // Only keep digits
                        if (value) {
                            this.value = value + unit;
                        }
                    });

                    // Format initial value if present
                    if (input.value && !input.value.endsWith(unit)) {
                        let value = input.value.replace(/\D/g, '');
                        if (value)
                            input.value = value + unit;
                    }
                }

                formatInputWithUnit("ramInput", "GB");
                formatInputWithUnit("storageInput", "TB");
                formatInputWithUnit("refreshRateInput", "Hz");
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

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Tablet Name</label>
                                    <input type="text" id="productName" name="productName" value="${product.productName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="number" id="price" name="price" min="0" max="1000000000" value="${product.price}" required>
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
                                        <input type="text" id="brandInput" name="brand_custom" placeholder="Enter brand" value="${brand_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="color">Color</label>
                                    <input type="text" id="color" name="color" value="${product.color}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="url" id="imageURL" name="imageURL" value="${product.imageURL}" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-camera"></i> Camera</div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="frontCamera">Front Camera</label>
                                    <input type="text" id="frontCamera" name="frontCamera" value="${product.cameraFront}" required>
                                </div>

                                <div class="form-group">
                                    <label for="rearCamera">Rear Camera</label>
                                    <input type="text" id="rearCamera" name="rearCamera" value="${product.cameraBehind}" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-microchip"></i> Performance Specifications</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="chiptype">Chip Brand</label>
                                    <input type="text" id="chiptype" name="chiptype" value="${product.chipType}" required>
                                </div>

                                <div class="form-group">
                                    <label for="chip">Chip Name</label>
                                    <input type="text" id="chip" name="chip" value="${product.chipName}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gpuType">GPU Brand</label>
                                    <input type="text" id="gpuType" name="gpuType" value="${product.gpuType}" required>
                                </div>

                                <div class="form-group">
                                    <label for="gpuName">GPU Name</label>
                                    <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}" required>
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
                                    <div id="ramInputContainer" class="${ram_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="ramInput" name="ram_custom" placeholder="Enter RAM" value="${ram_custom}">
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
                                        <input type="text" id="storageInput" name="storage_custom" placeholder="Enter Storage Capacity" value="${storage_custom}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="form-section-title"><i class="fas fa-desktop"></i> Display</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="size">Screen Size (inch)</label>
                                    <input type="number" id="size" name="size" value="${screenSize}" step="0.1" required>
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
                                    <div id="screenResolutionInputContainer" class="${screenResolution_custom != null ? '' : 'hidden'}">
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
                                        <option value="iPadOS" ${os == 'iPadOS' ? 'selected' : ''}>iPadOS</option>
                                        <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                                        <input type="text" id="osInput" name="os_custom" placeholder="Enter OS" value="${os_custom}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="version">Operating System Version</label>
                                    <input type="text" id="version" name="version" value="${product.operatingSystemVersion}" required>
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

    </body>
</html>