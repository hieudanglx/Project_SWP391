<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter Phone Information</title>

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
            h2 {
                text-align: center;
                color: #333;
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
                display: block;
            }
            .hidden {
                display: none;
            }
            .indented {
                margin-left: 20px;
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
                    inputContainer.classList.add("indented");
                    input.required = true;
                } else {
                    inputContainer.classList.add("hidden");
                    inputContainer.classList.remove("indented");
                    input.required = false;
                    input.value = "";
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                function formatInputWithUnit(inputId, unit) {
                    var input = document.getElementById(inputId);
                    input.addEventListener("input", function () {
                        let value = this.value.replace(/\D/g, ''); // Ch? gi? l?i s?
                        this.value = value ? value + unit : ""; // Thêm ??n v? ngay sau s?, không có kho?ng tr?ng
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

            <h2>Enter Phone Information</h2>
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
                <input type="hidden" name="category" value="2">
                <input type="hidden" name="ramType" value="">
                <input type="hidden" name="supportsUpgradingRAM" value="">
                <input type="hidden" name="supportsUpgradingROM" value="">

                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" value="${product.productName}" required>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" value="${product.price}" min="0" required>

                <label for="brand">Brand:</label>
                <select id="brand" name="brand" onchange="toggleInput('brand', 'brandInputContainer', 'brandInput')">
                    <option value="Apple" ${brand == 'Apple' ? 'selected' : ''}>Apple</option>
                    <option value="Samsung" ${brand == 'Samsung' ? 'selected' : ''}>Samsung</option>
                    <option value="Xiaomi" ${brand == 'Xiaomi' ? 'selected' : ''}>Xiaomi</option>
                    <option value="Oppo" ${brand == 'Oppo' ? 'selected' : ''}>Oppo</option>
                    <option value="Vivo" ${brand == 'Vivo' ? 'selected' : ''}>Vivo</option>
                    <option value="other" ${brand_custom != null ? 'selected' : ''}>Other</option>
                </select>

                <div id="brandInputContainer" class="${brand_custom != null ? '' : 'hidden'}">
                    <input type="text" id="brandInput" name="brand_custom" placeholder="Enter brand" value="${brand_custom != null ? brand_custom : ""}">
                </div>

                <label for="frontCamera">Front Camera:</label>
                <input type="text" id="frontCamera" name="frontCamera" value="${product.cameraFront}" required>

                <label for="rearCamera">Rear Camera:</label>
                <input type="text" id="rearCamera" name="rearCamera" value="${product.cameraBehind}" required>

                <label for="ram">RAM:</label>
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
                    <input type="text" id="ramInput" name="ram_custom" placeholder="Enter RAM" value="${ram_custom != null ? ram_custom : ""}">
                </div>

                <label for="storage">Storage Capacity:</label>
                <select id="storage" name="storage" onchange="toggleInput('storage', 'storageInputContainer', 'storageInput')">
                    <option value="64GB" ${storage == '64GB' ? 'selected' : ''}>64GB</option>
                    <option value="128GB" ${storage == '128GB' ? 'selected' : ''}>128GB</option>
                    <option value="256GB" ${storage == '256GB' ? 'selected' : ''}>256GB</option>
                    <option value="512GB" ${storage == '512GB' ? 'selected' : ''}>512GB</option>
                    <option value="1TB" ${storage == '1TB' ? 'selected' : ''}>1TB</option>
                    <option value="other" ${storage_custom != null ? 'selected' : ''}>Other</option>
                </select>

                <div id="storageInputContainer" class="${storage_custom != null ? '' : 'hidden'}">
                    <input type="text" id="storageInput" name="storage_custom" placeholder="Enter storage capacity" value="${storage_custom != null ? storage_custom : ""}">
                </div>

                <label for="color">Color:</label>
                <input type="text" id="color" name="color" value="${product.color}" required>

                <label for="os">Operating System:</label>
                <select id="os" name="os" onchange="toggleInput('os', 'osInputContainer', 'osInput')">
                    <option value="Android" ${os == 'Android' ? 'selected' : ''}>Android</option>
                    <option value="iOS" ${os == 'iOS' ? 'selected' : ''}>iOS</option>
                    <option value="other" ${os_custom != null ? 'selected' : ''}>Other</option>
                </select>

                <div id="osInputContainer" class="${os_custom != null ? '' : 'hidden'}">
                    <input type="text" id="osInput" name="os_custom" placeholder="Enter operating system" value="${os_custom != null ? os_custom : ""}">
                </div>

                <input type="number" name="version" placeholder="OS Version" value="${product.operatingSystemVersion}" required>

                <label for="size">Screen Size(inch):</label>
                <input type="number" id="size" name="size" value="${screenSize}" required>

                <label for="refreshRate">Refresh Rate:</label>
                <select id="refreshRate" name="refreshRate" onchange="toggleInput('refreshRate', 'refreshRateInputContainer', 'refreshRateInput')">
                    <option value="60Hz" ${refreshRate == '60Hz' ? 'selected' : ''}>60Hz</option>
                    <option value="90Hz" ${refreshRate == '90Hz' ? 'selected' : ''}>90Hz</option>
                    <option value="120Hz" ${refreshRate == '120Hz' ? 'selected' : ''}>120Hz</option>
                    <option value="144Hz" ${refreshRate == '144Hz' ? 'selected' : ''}>144Hz</option>
                    <option value="other" ${refreshRate_custom != null ? 'selected' : ''}>Other</option>
                </select>

                <div id="refreshRateInputContainer" class="${refreshRate_custom != null ? '' : 'hidden'}">
                    <input type="text" id="refreshRateInput" name="refreshRate_custom" placeholder="Enter refresh rate" value="${refreshRate_custom != null ? refreshRate_custom : ""}">
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
                    <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="Enter screen resolution" value="${screenResolution_custom != null ? screenResolution_custom : ""}">
                </div>

                <label for="chip">Chip type:</label>
                <input type="text" id="chiptype" name="chiptype" value="${product.chipType}" required>       

                <label for="chip">Chip Name:</label>
                <input type="text" id="chip" name="chip" value="${product.chipName}" required>

                <label for="gpuType">GPU Type:</label>
                <input type="text" id="gpuType" name="gpuType" value="${product.gpuType}" required>

                <label for="gpuName">GPU Name:</label>
                <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}" required>

                <label for="imageURL">Image URL:</label>
                <input type="url" id="imageURL" name="imageURL" value="${product.imageURL}" required>
                <button type="submit">Save</button>
                <a href="listProductsForAdmin" class="btn-back">Back to List</a>
            </form>
        </div>
    </body>
</html>