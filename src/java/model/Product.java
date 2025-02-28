package model;

public class Product {
    private int productID;
    private String productName;
    private int price;
    private int categoryID;
    private String brand;
    private String cameraFront;
    private String cameraBehind;
    private String ram;
    private String ramType;
    private String supportsUpgradingRAM;
    private String rom;
    private String supportsUpgradingROM;
    private String color;
    private String operatingSystemName;
    private String operatingSystemVersion;
    private String screenSize;
    private String refreshRate;
    private String screenResolution;
    private String chipType;
    private String chipName;
    private String gpuType;
    private String gpuName;
    private int quantitySell;
    private int quantityProduct;
    private String imageURL;
    private int isDelete;

    public Product(int productID, String productName, int price, int categoryID, String brand, String cameraFront, String cameraBehind, String ram, String ramType, String supportsUpgradingRAM, String rom, String supportsUpgradingROM, String color, String operatingSystemName, String operatingSystemVersion, String screenSize, String refreshRate, String screenResolution, String chipType, String chipName, String gpuType, String gpuName, int quantitySell, int quantityProduct, String imageURL, int isDelete) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.categoryID = categoryID;
        this.brand = brand;
        this.cameraFront = cameraFront;
        this.cameraBehind = cameraBehind;
        this.ram = ram;
        this.ramType = ramType;
        this.supportsUpgradingRAM = supportsUpgradingRAM;
        this.rom = rom;
        this.supportsUpgradingROM = supportsUpgradingROM;
        this.color = color;
        this.operatingSystemName = operatingSystemName;
        this.operatingSystemVersion = operatingSystemVersion;
        this.screenSize = screenSize;
        this.refreshRate = refreshRate;
        this.screenResolution = screenResolution;
        this.chipType = chipType;
        this.chipName = chipName;
        this.gpuType = gpuType;
        this.gpuName = gpuName;
        this.quantitySell = quantitySell;
        this.quantityProduct = quantityProduct;
        this.imageURL = imageURL;
        this.isDelete = isDelete;
    }

    

    public Product(int productID, String productName, int price, String color, int quantityProduct, String imageURL, int isDelete) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.color = color;
        this.quantityProduct = quantityProduct;
        this.imageURL = imageURL;
        this.isDelete = isDelete;
    }

    public Product(int categoryID, String brand, String ram, String rom, String operatingSystemName, String screenSize
            , String screenResolution, String refreshRate, String chipType, String chipName) {
        this.categoryID = categoryID;
        this.brand = brand;
        this.ram = ram;
        this.rom = rom;
        this.operatingSystemName = operatingSystemName;
        this.screenSize = screenSize;
        this.screenResolution = screenResolution;
        this.refreshRate = refreshRate;
        this.chipType = chipType;
        this.chipName = chipName;
    }


    public Product() {}

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCameraFront() {
        return cameraFront;
    }

    public void setCameraFront(String cameraFront) {
        this.cameraFront = cameraFront;
    }

    public String getCameraBehind() {
        return cameraBehind;
    }

    public void setCameraBehind(String cameraBehind) {
        this.cameraBehind = cameraBehind;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getRamType() {
        return ramType;
    }

    public void setRamType(String ramType) {
        this.ramType = ramType;
    }

    public String getSupportsUpgradingRAM() {
        return supportsUpgradingRAM;
    }

    public void setSupportsUpgradingRAM(String supportsUpgradingRAM) {
        this.supportsUpgradingRAM = supportsUpgradingRAM;
    }

    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    public String getSupportsUpgradingROM() {
        return supportsUpgradingROM;
    }

    public void setSupportsUpgradingROM(String supportsUpgradingROM) {
        this.supportsUpgradingROM = supportsUpgradingROM;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getOperatingSystemName() {
        return operatingSystemName;
    }

    public void setOperatingSystemName(String operatingSystemName) {
        this.operatingSystemName = operatingSystemName;
    }

    public String getOperatingSystemVersion() {
        return operatingSystemVersion;
    }

    public void setOperatingSystemVersion(String operatingSystemVersion) {
        this.operatingSystemVersion = operatingSystemVersion;
    }

    public String getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(String screenSize) {
        this.screenSize = screenSize;
    }

    public String getRefreshRate() {
        return refreshRate;
    }

    public void setRefreshRate(String refreshRate) {
        this.refreshRate = refreshRate;
    }

    public String getScreenResolution() {
        return screenResolution;
    }

    public void setScreenResolution(String screenResolution) {
        this.screenResolution = screenResolution;
    }

    public String getChipType() {
        return chipType;
    }

    public void setChipType(String chipType) {
        this.chipType = chipType;
    }

    public String getChipName() {
        return chipName;
    }

    public void setChipName(String chipName) {
        this.chipName = chipName;
    }

    public String getGpuType() {
        return gpuType;
    }

    public void setGpuType(String gpuType) {
        this.gpuType = gpuType;
    }

    public String getGpuName() {
        return gpuName;
    }

    public void setGpuName(String gpuName) {
        this.gpuName = gpuName;
    }

    public int getQuantitySell() {
        return quantitySell;
    }

    public void setQuantitySell(int quantitySell) {
        this.quantitySell = quantitySell;
    }

    public int getQuantityProduct() {
        return quantityProduct;
    }

    public void setQuantityProduct(int quantityProduct) {
        this.quantityProduct = quantityProduct;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }

}
