package model;

public class Product {
    private String productID;
    private String productName;
    private int price;
    private String category;
    private String brand;
    private String camera;
    private String ram;
    private String rom;
    private String color;
    private String operatingSystem;
    private String size;
    private String refreshRate;
    private String chip;
    private String gpu;
    private int quantitySell;
    private int quantityProduct;
    private String imageURL;

    public Product(String productID, String productName, int price, String category, String brand, 
                   String camera, String ram, String rom, String color, String operatingSystem, 
                   String size, String refreshRate, String chip, String gpu, int quantitySell, 
                   int quantityProduct, String imageURL) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.category = category;
        this.brand = brand;
        this.camera = camera;
        this.ram = ram;
        this.rom = rom;
        this.color = color;
        this.operatingSystem = operatingSystem;
        this.size = size;
        this.refreshRate = refreshRate;
        this.chip = chip;
        this.gpu = gpu;
        this.quantitySell = quantitySell;
        this.quantityProduct = quantityProduct;
        this.imageURL = imageURL;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCamera() {
        return camera;
    }

    public void setCamera(String camera) {
        this.camera = camera;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getOperatingSystem() {
        return operatingSystem;
    }

    public void setOperatingSystem(String operatingSystem) {
        this.operatingSystem = operatingSystem;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getRefreshRate() {
        return refreshRate;
    }

    public void setRefreshRate(String refreshRate) {
        this.refreshRate = refreshRate;
    }

    public String getChip() {
        return chip;
    }

    public void setChip(String chip) {
        this.chip = chip;
    }

    public String getGpu() {
        return gpu;
    }

    public void setGpu(String gpu) {
        this.gpu = gpu;
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
}
