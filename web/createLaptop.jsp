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
                display: flex;
                justify-content: center;
                min-height: 100vh;
                padding: 40px 20px;
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
                            if (input) input.required = true;
                        }
                    }
                });
                
                function formatInputWithUnit(inputId, unit) {
                    var input = document.getElementById(inputId);
                    if (!input) return;
                    
                    input.addEventListener("input", function () {
                        let value = this.value.replace(/\D/g, ''); // Only keep digits
                        if (value) {
                            this.value = value + unit;
                        }
                    });
                    
                    // Format initial value if present
                    if (input.value && !input.value.endsWith(unit)) {
                        let value = input.value.replace(/\D/g, '');
                        if (value) input.value = value + unit;
                    }
                }

                formatInputWithUnit("ramInput", "GB");
                formatInputWithUnit("storageInput", "TB");
                formatInputWithUnit("refreshRateInput", "Hz");
            });
        </script>
    </head>
    <body>
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

                <div class="form-section">
                    <div class="form-section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="laptopName">Laptop Name</label>
                            <input type="text" id="laptopName" name="productName" value="${product.productName}" required>
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
                            <input type="url" id="imageUrl" name="imageURL" value="${product.imageURL}" required>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="form-section-title"><i class="fas fa-microchip"></i> Performance Specifications</div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="chip">Chip Brand</label>
                            <select id="chip" name="chiptype" onchange="toggleInput('chip', 'chipTypeInputContainer', 'chipTypeInput')">
                                <option value="Intel" ${chipType == 'Intel' ? 'selected' : ''}>Intel</option>
                                <option value="AMD" ${chipType == 'AMD' ? 'selected' : ''}>AMD</option>
                                <option value="Apple" ${chipType == 'Apple' ? 'selected' : ''}>Apple</option>
                                <option value="other" ${chipType_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="chipTypeInputContainer" class="${chipType_custom != null ? '' : 'hidden'}">
                                <input type="text" id="chipTypeInput" name="chipType_custom" placeholder="Enter Chip Brand" value="${chipType_custom}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="chipName">Chip Name</label>
                            <select id="chipName" name="chip" onchange="toggleInput('chipName', 'chipNameInputContainer', 'chipNameInput')">
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
                                <input type="text" id="chipNameInput" name="chipName_custom" placeholder="Enter Chip Name" value="${chipName_custom}">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="chipGeneration">Chip Generation</label>
                            <input type="text" id="chipGeneration" name="chipGeneration" placeholder="Enter Generation" value="${chipGeneration}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="gputype">GPU Brand</label>
                            <select id="gputype" name="gpuType" onchange="toggleInput('gputype', 'gputypeInputContainer', 'gputypeInput')">
                                <option value="Intel" ${gputype == 'Intel' ? 'selected' : ''}>Intel</option>
                                <option value="AMD" ${gputype == 'AMD' ? 'selected' : ''}>AMD</option>
                                <option value="Nvidia" ${gputype == 'Nvidia' ? 'selected' : ''}>Nvidia</option>
                                <option value="Apple" ${gputype == 'Apple' ? 'selected' : ''}>Apple</option>
                                <option value="other" ${gputype_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="gputypeInputContainer" class="${gputype_custom != null ? '' : 'hidden'}">
                                <input type="text" id="gputypeInput" name="gputype_custom" placeholder="Enter GPU Brand" value="${gputype_custom}">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
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
                                <option value="4 GB" ${ram == '4 GB' ? 'selected' : ''}>4GB</option>
                                <option value="8 GB" ${ram == '8 GB' ? 'selected' : ''}>8GB</option>
                                <option value="16 GB" ${ram == '16 GB' ? 'selected' : ''}>16GB</option>
                                <option value="32 GB" ${ram == '32 GB' ? 'selected' : ''}>32GB</option>
                                <option value="other" ${ram_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="ramInputContainer" class="${ram_custom != null ? '' : 'hidden'}">
                                <input type="text" id="ramInput" name="ram_custom" placeholder="Enter RAM" value="${ram_custom}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="ramType">RAM Type</label>
                            <select id="ramType" name="ramType" onchange="toggleInput('ramType', 'ramTypeInputContainer', 'ramTypeInput')">
                                <option value="DDR4" ${ramType == 'DDR4' ? 'selected' : ''}>DDR4</option>
                                <option value="DDR5" ${ramType == 'DDR5' ? 'selected' : ''}>DDR5</option>
                                <option value="Unified" ${ramType == 'Unified' ? 'selected' : ''}>Unified</option>
                                <option value="other" ${ramType_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="ramTypeInputContainer" class="${ramType_custom != null ? '' : 'hidden'}">
                                <input type="text" id="ramTypeInput" name="ramType_custom" placeholder="Enter RAM Type" value="${ramType_custom}">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="ramUpgrade">RAM Upgrade</label>
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" id="ramUpgrade" name="supportsUpgradingRAM" value="1" ${supportsUpgradingRAM == '1' ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                                <span class="toggle-label" id="ramUpgradeLabel">Upgradeable</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="storage">Storage Capacity</label>
                            <select id="storage" name="storage" onchange="toggleInput('storage', 'storageInputContainer', 'storageInput')">
                                <option value="256GB" ${storage == '256GB' ? 'selected' : ''}>256GB</option>
                                <option value="512GB" ${storage == '512GB' ? 'selected' : ''}>512GB</option>
                                <option value="1TB" ${storage == '1TB' ? 'selected' : ''}>1TB</option>
                                <option value="2TB" ${storage == '2TB' ? 'selected' : ''}>2TB</option>
                                <option value="other" ${storage_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="storageInputContainer" class="${storage_custom != null ? '' : 'hidden'}">
                                <input type="text" id="storageInput" name="storage_custom" placeholder="Enter Storage Capacity" value="${storage_custom}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="storageUpgrade">Storage Upgrade</label>
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" id="storageUpgrade" name="supportsUpgradingROM" value="1" ${supportsUpgradingROM == '1' ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                                <span class="toggle-label" id="storageUpgradeLabel">Upgradeable</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="form-section-title"><i class="fas fa-desktop"></i> Display</div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="screenSize">Screen Size (inch)</label>
                            <input type="number" id="screenSize" name="size" value="${screenSize}" step="0.1" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="refreshRate">Refresh Rate</label>
                            <select id="refreshRate" name="refreshRate" onchange="toggleInput('refreshRate', 'refreshRateInputContainer', 'refreshRateInput')">
                                <option value="60 Hz" ${refreshRate == '60 Hz' ? 'selected' : ''}>60Hz</option>
                                <option value="90 Hz" ${refreshRate == '90 Hz' ? 'selected' : ''}>90Hz</option>
                                <option value="120 Hz" ${refreshRate == '120 Hz' ? 'selected' : ''}>120Hz</option>
                                <option value="144 Hz" ${refreshRate == '144 Hz' ? 'selected' : ''}>144Hz</option>
                                <option value="165 Hz" ${refreshRate == '165 Hz' ? 'selected' : ''}>165Hz</option>
                                <option value="240 Hz" ${refreshRate == '240 Hz' ? 'selected' : ''}>240Hz</option>
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
                                <option value="Windows" ${os == 'Windows' ? 'selected' : ''}>Windows</option>
                                <option value="MacOS" ${os == 'MacOS' ? 'selected' : ''}>MacOS</option>
                                <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                            </select>
                            <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                                <input type="text" id="osInput" name="os_custom" placeholder="Enter OS" value="${os_custom}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="osVersion">Operating System Version</label>
                            <input type="text" id="osVersion" name="version" value="${product.operatingSystemVersion}" required>
                        </div>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit"><i class="fas fa-save"></i> Save</button>
                    <a href="listProductsForAdmin" class="btn-back"><i class="fas fa-arrow-left"></i> Back to List</a>
                </div>
            </form>
        </div>
        
        <script>
            // Add toggle functionality for the switches
            document.addEventListener('DOMContentLoaded', function() {
                const ramUpgrade = document.getElementById('ramUpgrade');
                const ramUpgradeLabel = document.getElementById('ramUpgradeLabel');
                const storageUpgrade = document.getElementById('storageUpgrade');
                const storageUpgradeLabel = document.getElementById('storageUpgradeLabel');
                
                function updateLabel(checkbox, label) {
                    if (checkbox.checked) {
                        label.textContent = 'Upgradeable';
                    } else {
                        label.textContent = 'Not Upgradeable';
                    }
                }
                
                if (ramUpgrade && ramUpgradeLabel) {
                    updateLabel(ramUpgrade, ramUpgradeLabel);
                    ramUpgrade.addEventListener('change', function() {
                        updateLabel(this, ramUpgradeLabel);
                        this.value = this.checked ? '1' : '0';
                    });
                }
                
                if (storageUpgrade && storageUpgradeLabel) {
                    updateLabel(storageUpgrade, storageUpgradeLabel);
                    storageUpgrade.addEventListener('change', function() {
                        updateLabel(this, storageUpgradeLabel);
                        this.value = this.checked ? '1' : '0';
                    });
                }
            });
        </script>
    </body>
</html>