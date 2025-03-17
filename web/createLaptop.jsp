<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter Laptop Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                height: 100vh;
                margin: 20px 0 0 0;
            }
            .container {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 600px;
                margin-top: 20px;
            }
            .btn-back {
                display: block;
                text-align: center;
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                background-color: #6c757d;
                color: white;
                border-radius: 4px;
                text-decoration: none;
                font-size: 16px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .btn-back:hover {
                background-color: #5a6268;
            }
            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .hidden {
                display: none;
            }
            button {
                width: 100%;
                padding: 10px;
                margin-top: 15px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            button:hover {
                background-color: #218838;
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
                function formatInputWithUnit(inputId, unit) {
                    var input = document.getElementById(inputId);
                    input.addEventListener("input", function () {
                        let value = this.value.replace(/\D/g, ''); // Chỉ lấy số
                        if (value) {
                            this.value = value + unit; // Thêm đơn vị ngay sau số, không có khoảng cách
                        }
                    });
                }

                formatInputWithUnit("ramInput", "GB");
                formatInputWithUnit("storageInput", "TB");
                formatInputWithUnit("refreshRateInput", "Hz");
            });
        </script>
    </head>
    <body>
        <div class="container">
            <h2>Enter Laptop Information</h2>
            <c:if test="${not empty error}">
                <div style="color: red; text-align: center; margin-bottom: 15px;">
                    ${error}
                </div>
            </c:if>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
            <p style="color: red;"><%= error %></p>
            <% } %>

            <form action="createProduct" method="post">
                <input type="hidden" name="category" value="1"> <!-- Category ID for Laptop -->
                <input type="hidden" name="frontCamera" value="">
                <input type="hidden" name="rearCamera" value="">

                <label for="laptopName">Laptop Name:</label>
                <input type="text" id="laptopName" name="productName" value="${product.productName}" required>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" min="0" max ="1000000000" value="${product.price}" required>

                <label for="brand">Brand:</label>
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

                <label for="ram">RAM:</label>
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

                <label for="ramType">RAM Type:</label>
                <select id="ramType" name="ramType" onchange="toggleInput('ramType', 'ramTypeInputContainer', 'ramTypeInput')">
                    <option value="DDR4" ${ramType == 'DDR4' ? 'selected' : ''}>DDR4</option>
                    <option value="DDR5" ${ramType == 'DDR5' ? 'selected' : ''}>DDR5</option>
                    <option value="Unified" ${ramType == 'Unified' ? 'selected' : ''}>Unified</option>
                    <option value="other" ${ramType_custom != null ? 'selected' : ''}>Other</option>
                </select>
                <div id="ramTypeInputContainer" class="${ramType_custom != null ? '' : 'hidden'}">
                    <input type="text" id="ramTypeInput" name="ramType_custom" placeholder="Enter RAM Type" value="${ramType_custom}">
                </div>

                <label for="ramUpgrade">RAM Upgrade:</label>
                <select id="ramUpgrade" name="supportsUpgradingRAM">
                    <option value="1" ${supportsUpgradingRAM == '1' ? 'selected' : ''}>Upgradeable</option>
                    <option value="0" ${supportsUpgradingRAM == '0' ? 'selected' : ''}>Not Upgradeable</option>
                </select>

                <label for="storage">Storage Capacity:</label>
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

                <label for="storageUpgrade">Storage Upgrade:</label>
                <select id="storageUpgrade" name="supportsUpgradingROM">
                    <option value="1" ${supportsUpgradingROM == '1' ? 'selected' : ''}>Upgradeable</option>
                    <option value="0" ${supportsUpgradingROM == '0' ? 'selected' : ''}>Not Upgradeable</option>
                </select>

                <label for="color">Color:</label>
                <input type="text" id="color" name="color" value="${product.color}" required>

                <label for="os">Operating System:</label>
                <select id="os" name="os" onchange="toggleInput('os', 'osInputContainer', 'osInput')">
                    <option value="Windows" ${os == 'Windows' ? 'selected' : ''}>Windows</option>
                    <option value="MacOS" ${os == 'MacOS' ? 'selected' : ''}>MacOS</option>
                    <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                </select>
                <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                    <input type="text" id="osInput" name="os_custom" placeholder="Enter OS" value="${os_custom}">
                </div>

                <label for="osVersion">Operating System Version:</label>
                <input type="text" id="osVersion" name="version" value="${product.operatingSystemVersion}" required>

                <label for="screenSize">Screen Size (inch):</label>
                <input type="number" id="screenSize" name="size" value="${screenSize}" required>

                <label for="refreshRate">Refresh Rate:</label>
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

                <label for="screenResolution">Screen Resolution:</label>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <select id="screenResolution" name="screenResolution" onchange="toggleInput('screenResolution', 'screenResolutionInputContainer', 'screenResolutionInput')">
                        <option value="HD+" ${screenResolution == 'HD+' ? 'selected' : ''}>HD+</option>
                        <option value="Full HD+" ${screenResolution == 'Full HD+' ? 'selected' : ''}>Full HD+</option>
                        <option value="1.5K" ${screenResolution == '1.5K' ? 'selected' : ''}>1.5K</option>
                        <option value="1.5K+" ${screenResolution == '1.5K+' ? 'selected' : ''}>1.5K+</option>
                        <option value="2K+" ${screenResolution == '2K+' ? 'selected' : ''}>2K+</option>
                        <option value="Retina" ${screenResolution == 'Retina' ? 'selected' : ''}>Retina</option>
                        <option value="other" ${screenResolution_custom != null ? 'selected' : ''}>Other</option>
                    </select>
                    <input type="number" id="resolutionWidth" name="resolutionWidth" min="1" required placeholder="Width" value="${width}" style="width: 80px;">
                    <input type="number" id="resolutionHeight" name="resolutionHeight" min="1" required placeholder="Height" value="${height}" style="width: 80px;">
                </div>
                <div id="screenResolutionInputContainer" class="${screenResolution_custom != null ? '' : 'hidden'}">
                    <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="Enter screen resolution" value="${screenResolution_custom}">
                </div>

                <label for="chip">Chip Brand:</label>
                <select id="chip" name="chiptype" onchange="toggleInput('chip', 'chipTypeInputContainer', 'chipTypeInput')">
                    <option value="Intel" ${chipType == 'Intel' ? 'selected' : ''}>Intel</option>
                    <option value="AMD" ${chipType == 'AMD' ? 'selected' : ''}>AMD</option>
                    <option value="Apple" ${chipType == 'Apple' ? 'selected' : ''}>Apple</option>
                    <option value="other" ${chipType_custom != null ? 'selected' : ''}>Other</option>
                </select>
                <div id="chipTypeInputContainer" class="${chipType_custom != null ? '' : 'hidden'}">
                    <input type="text" id="chipTypeInput" name="chipType_custom" placeholder="Enter Chip Brand" value="${chipType_custom}">
                </div>

                <label for="chipName">Chip Name:</label>
              
                    <select id="chipName" name="chip" onchange="toggleInput('chipName', 'chipNameInputContainer', 'chipNameInput')" >
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
                    <input type="text" id="chipGeneration" name="chipGeneration" placeholder="Enter Generation " value="${chipGeneration}" required>
                
                

                <label for="gpu">GPU Brand:</label>
                <select id="gputype" name="gpuType" onchange="toggleInput('gputype', 'gputypeInputContainer', 'gputypeInput')">
                    <option value="Intel" ${gputype == 'Intel' ? 'selected' : ''}>Intel</option>
                    <option value="AMD" ${gputype == 'AMD' ? 'selected' : ''}>AMD</option>
                    <option value="Nvidia" ${gputype == 'Nvidia' ? 'selected' : ''}>Nvidia</option>
                    <option value="Apple" ${gputype == 'Apple' ? 'selected' : ''}>Apple</option>
                    <option value="other" ${gputype_custom != null ? 'selected' : ''}>Other</option>
                </select>
                <div id="gputypeInputContainer" class="${gputype_custom != null ? '' : 'hidden'}">
                    <input type="text" id="gputypeInput" name="gputype_custom" placeholder="Enter GPU" value="${gputype_custom}">
                </div>

                <label for="gpuName">GPU Name:</label>
                <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}" required>

                <label for="imageUrl">Image URL:</label>
                <input type="url" id="imageUrl" name="imageURL" value="${product.imageURL}" required>

                <button type="submit">Save</button>
                <a href="listProductsForAdmin" class="btn-back">Back to List</a>
            </form>
        </div>
    </body>
</html>