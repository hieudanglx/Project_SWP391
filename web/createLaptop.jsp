<%-- 
    Document   : createLaptop
    Created on : Mar 3, 2025, 11:47:03 PM
    Author     : Dinh Van Do - CE182224
--%>

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
             
            <form action="createProduct" method="post">
                <input type="hidden" name="category" value= "1">
                <input type="hidden" name="frontCamera" value="">
                <input type="hidden" name="rearCamera" value="">
                <label for="laptopName">Laptop Name:</label>
                <input type="text" id="laptopName" name="productName" value="${product.productName}" required>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" min="0" value="${product.price}"required>

                <label for="brand">Brand:</label>
                <select id="brand" name="brand" onchange="toggleInput('brand', 'brandInputContainer', 'brandInput')">
                    <option value="Acer">Acer</option>
                    <option value="Apple">Apple</option>
                    <option value="Asus">Asus</option>
                    <option value="Dell">Dell</option>
                    <option value="HP">HP</option>
                    <option value="Lenovo">Lenovo</option>
                    <option value="MSI">MSI</option>
                    <option value="Razer">Razer</option>
                    <option value="other">Other</option>
                </select>
                <div id="brandInputContainer" class="hidden">
                    <input type="text" id="brandInput" name="brand_custom" placeholder="Enter brand">
                </div>

                <label for="ram">RAM:</label>
                <select id="ram" name="ram" onchange="toggleInput('ram', 'ramInputContainer', 'ramInput', 'GB')">
                    <option value="4 GB">4GB</option>
                    <option value="8 GB">8GB</option>
                    <option value="8 GB">16GB</option>
                    <option value="8 GB">32GB</option>
                    <option value="other">Other</option>
                </select>
                <div id="ramInputContainer" class="hidden">
                    <input type="number" id="ramInput" name="ram_custom" placeholder="Enter RAM">
                </div>

                <label for="ramType">RAM Type:</label>
                <select id="ramType" name="ramType" onchange="toggleInput('ramType', 'ramTypeInputContainer', 'ramTypeInput')">
                    <option>DDR4</option>
                    <option>DDR5</option>
                    <option>Unified</option>
                    <option value="other">Other</option>
                </select>
                <div id="ramTypeInputContainer" class="hidden">
                    <input type="text" id="ramTypeInput" name="ramType_custom" placeholder="Enter RAM Type">
                </div>

                <label for="ramUpgrade">RAM Upgrade:</label>
                <select id="ramUpgrade" name="supportsUpgradingRAM">
                    <option value="1">Upgradeable</option>
                    <option value="0">Not Upgradeable</option>
                </select>

                <label for="storage">Storage Capacity:</label>
                <select id="storage" name="storage" onchange="toggleInput('storage', 'storageInputContainer', 'storageInput')">
                    <option> 256GB</option>
                    <option> 512GB</option>
                    <option> 1TB</option>
                    <option> 2TB</option>
                    <option value="other">Other</option>
                </select>
                <div id="storageInputContainer" class="hidden">
                    <input type="number" id="storageInput" name="storage_custom" placeholder="Enter Storage Capacity">
                </div>

                <label for="storageUpgrade">Storage Upgrade:</label>
                <select id="storageUpgrade" name="supportsUpgradingROM">
                    <option value="1">Upgradeable</option>
                    <option value ="0">Not Upgradeable</option>
                </select>

                <label for="color">Color:</label>
                <input type="text" id="color" name="color" required>

                <label for="os">Operating System:</label>
                <select id="os" name="os" onchange="toggleInput('os', 'osInputContainer', 'osInput')">
                    <option>Windows</option>
                    <option>MacOS</option>
                    <option value="other">Other</option>
                </select>
                <div id="osInputContainer" class="hidden">
                    <input type="text" id="osInput" name="os_custom" placeholder="Enter OS">
                </div>
                <label for="osVersion">Operating System Version:</label>
                <input type="text" id="osVersion" name="version" required>

                <label for="screenSize">Screen Size (inch):</label>
                <input type="number" id="screenSize" name="size" required>

                <label for="refreshRate">Refresh Rate:</label>
                <select id="refreshRate" name="refreshRate" onchange="toggleInput('refreshRate', 'refreshRateInputContainer', 'refreshRateInput', 'Hz')">
                    <option value="60 Hz">60Hz</option>
                    <option value="60 Hz">90Hz</option>
                    <option value="120 Hz">120Hz</option>
                    <option value="120 Hz">144Hz</option>
                    <option value="120 Hz">165Hz</option>
                    <option value="120 Hz">240Hz</option>
                    <option value="other">Other</option>
                </select>
                <div id="refreshRateInputContainer" class="hidden">
                    <input type="number" id="refreshRateInput" name="refreshRate_custom" placeholder="Enter refresh rate">
                </div>

                <label for="screenResolution">Screen Resolution:</label>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <select id="screenResolution" name="screenResolution" onchange="toggleInput('screenResolution', 'screenResolutionInputContainer', 'screenResolutionInput')">
                        <option value="HD+">HD+</option>
                        <option value="Full HD+">Full HD+</option>
                        <option value="1.5K">1.5K</option>
                        <option value="1.5K+">1.5K+</option>
                        <option value="2K+">2K+</option>
                        <option value="Retina">Retina</option>
                        <option value="other">Other</option>
                    </select>
                    <input type="number" id="resolutionWidth" name="resolutionWidth" min="1" required placeholder="Width" style="width: 80px;">
                    <input type="number" id="resolutionHeight" name="resolutionHeight" min="1" required placeholder="Height" style="width: 80px;">
                </div>
                <div id="screenResolutionInputContainer" class="hidden">
                    <input type="text" id="screenResolutionInput" name="screenResolution_custom" placeholder="Enter screen resolution">
                </div>


                <label for="chip">Chip Brand:</label>
                <select id="chip" name="chiptype" onchange="toggleInput('chip', 'chipInputContainer', 'chipInput')">
                    <option>Intel</option>
                    <option>AMD</option>
                    <option>Apple</option>
                    <option value="other">Other</option>
                </select>
                <div id="chipInputContainer" class="hidden">
                    <input type="text" id="chipInput" name="chip_custom" placeholder="Enter Chip Brand">
                </div>

                <label for="chipName">Chip Name:</label>
                <input type="text" id="chipName" name="chip" value="${product.chipName}" required>

                <label for="gpu">GPU Brand:</label>
                <select id="gpu" name="gpuType" onchange="toggleInput('gpu', 'gpuInputContainer', 'gpuInput')">
                    <option>Intel</option>
                    <option>AMD</option>
                    <option>Nvidia</option>
                    <option>Apple</option>
                    <option value="other">Other</option>
                </select>
                <div id="gpuInputContainer" class="hidden">
                    <input type="text" id="gpuInput" name="gpu_custom" placeholder="Enter GPU">
                </div>

                <label for="gpuName">GPU Name:</label>
                <input type="text" id="gpuName" name="gpuName" value="${product.gpuName}"required>

                <label for="imageUrl">Image URL:</label>
                <input type="url" id="imageUrl" name="imageURL" value="${product.imageURL}" required>

                <button type="submit">Save</button>
                <a href="listProductsForAdmin" class="btn-back">Back to List</a>
            </form>
        </div>
    </body>
</html>
