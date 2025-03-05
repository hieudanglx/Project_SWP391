<%-- 
    Document   : new
    Created on : Mar 5, 2025, 11:33:42 AM
    Author     : CE180594_Phan Quốc Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản phẩm</title>
        <!-- favicon -->
        <link rel="shortcut icon" href="/assets/ico/favicon-dagstore.ico" type="image/x-icon">
        <!-- fontawesome font -->
        <link rel="stylesheet" href="/assets/font/font-awesome-pro-5/css/all.min.css">
        <!-- bootstrap css -->
        <link rel="stylesheet" href="/lib/bootstrap-5.2.0-dist/css/bootstrap.min.css">
        <!-- swiper css -->
        <link rel="stylesheet" href="/lib/swiper-8.3.2/package/swiper-bundle.min.css">
        <!-- css -->
        <link rel="stylesheet" href="/assets/css/product-detail.css">
    </head>
    <body>
        <div id="root">
            <!-- begin: content -->
            <div class="content">
                <div class="container py-2">
                    <!-- begin: breadcumbb -->
                    <ol class="breadcrumb mb-2">
                        <li class="breadcrumb-item"><a href="/page/client/categories/categories.html">Điện thoại</a></li>
                        <li class="breadcrumb-item active">Điện thoại Oppo</li>
                    </ol>
                    <!-- end: breadcrumb -->

                    <!-- begin: intro-product -->
                    <div class="intro-product d-flex align-items-center pb-2 border-bottom flex-wrap">
                        <strong class="product-title d-block d-md-inline-block mw-100">Điện thoại OPPO Reno8 Z 5G</strong>
                        <a href="#" class="product-rate d-flex align-items-center mx-3 flex-wrap">
                            <div class="small-ratings d-flex gap-1">
                                <i class="fa fa-star rating-color"></i>
                                <i class="fa fa-star rating-color"></i>
                                <i class="fa fa-star rating-color"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <span href="#" class="text-primary ms-2">6 đánh giá</span>
                        </a>
                        <a href="#" class="product-compare text-primary d-none d-md-flex align-items-center me-auto"><i class="fal fa-plus-circle me-1"></i><span>So sánh</span></a>    
                        <div class="introduct-product__social-btn me-1 d-none d-md-block"><i class="fas fa-thumbs-up me-1"></i>Thích 12K</div>  
                        <div class="introduct-product__social-btn d-none d-md-block">Chia sẻ</div>   
                    </div>
                    <!-- end: introproduct -->

                    <!-- begin: main-content-product -->
                    <div class="main-content-product">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-7">
                                    <ul class="nav nav-pills mb-3 d-flex justify-content-center gap-3" id="pills-tab" role="tablist">
                                        <li class="nav-item" role="presentation">
                                            <div class="product-preview-tab tab-item-core" control="#childButtonTab7" id="pills-home-tab" data-bs-toggle="modal" data-bs-target="#staticBackdrop" type="button" role="tab" aria-controls="pills-preview-product-7" aria-selected="true">
                                                <div class="thumb-tab-item p-2">
                                                    <img class="img-fluid" src="/assets/img/ico/magic-box.png" alt="">
                                                </div>
                                                <div class="title-tab-item text-center">
                                                    Thông số kỹ thuật
                                                </div>
                                            </div>
                                        </li>

                                        <li class="nav-item" role="presentation">
                                            <div class="product-preview-tab tab-item-core" control="#childButtonTab8" id="pills-home-tab" data-bs-toggle="modal" data-bs-target="#staticBackdrop" type="button" role="tab" aria-controls="pills-preview-product-8" aria-selected="true">
                                                <div class="thumb-tab-item p-2">
                                                    <img class="img-fluid" src="/assets/img/ico/to-do-list.png" alt="">
                                                </div>
                                                <div class="title-tab-item text-center">
                                                    Thông tin sản phẩm
                                                </div>
                                            </div>
                                        </li>
                                    </ul>

                                    <div class="modal fade product-info-content" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog my-0">
                                            <div class="modal-content rounded-0 h-100">
                                                <div class="modal-header d-flex align-items-center justify-content-center gap-3 p-0">
                                                    <ul class="nav nav-pills d-flex justify-content-center gap-3" id="pills-tab" role="tablist">
                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab1" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-1" type="button" role="tab" aria-controls="pills-content-product-1" aria-selected="true">
                                                                <span class="py-3 px-1">Điểm nổi bật</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab2" id="demo" data-bs-toggle="pill" data-bs-target="#pills-content-product-2" type="button" role="tab" aria-controls="pills-content-product-2" aria-selected="true">
                                                                <span class="py-3 px-1">Vàng đồng</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab3" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-3" type="button" role="tab" aria-controls="pills-content-product-3" aria-selected="true">
                                                                <span class="py-3 px-1">Đen</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab4" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-4" type="button" role="tab" aria-controls="pills-content-product-4" aria-selected="true">
                                                                <span class="py-3 px-1">Hình mở hộp</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab5" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-5" type="button" role="tab" aria-controls="pills-content-product-5" aria-selected="true">
                                                                <span class="py-3 px-1">Chụp từ camera</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab6" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-6" type="button" role="tab" aria-controls="pills-content-product-6" aria-selected="true">
                                                                <span class="py-3 px-1">Hình 360</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab7" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-7" type="button" role="tab" aria-controls="pills-content-product-7" aria-selected="true">
                                                                <span class="py-3 px-1">Thông số kỹ thuật</span>
                                                            </div>
                                                        </li>

                                                        <li class="nav-item" role="presentation">
                                                            <div class="product-content-tab tab-item-core" control="#childButtonTab8" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-content-product-8" type="button" role="tab" aria-controls="pills-content-product-8" aria-selected="true">
                                                                <span class="py-3 px-1">Thông tin sản phẩm</span>
                                                            </div>
                                                        </li>


                                                    </ul>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="tab-content">
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab1" id="pills-content-product-1" role="tabpanel" aria-labelledby="pills-content-product-1">
                                                            <div class="product-content px-0 pt-4 pb-1">
                                                                <div class="swiper product-content__list-img-product">
                                                                    <div class="swiper-wrapper">
                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(1).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(4).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(2).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(5).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(3).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/vi-vn-oppo-reno8-z-5g--(6).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/bg_csmh_tgdd-min.png" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="swiper-button-next slide-button-next-core product-content__list-img-product__button-next"><i class="far fa-angle-right"></i></div>
                                                                    <div class="swiper-button-prev slide-button-prev-core product-content__list-img-product__button-pre"><i class="far fa-angle-left"></i></div>
                                                                </div>
                                                                <span class="product-preview__total-preview d-block text-center my-3"><a href="#" class="me-1">Xem tất cả ảnh nổi bật</a>(7/7)</span>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab2" id="pills-content-product-2" role="tabpanel" aria-labelledby="pills-content-product-2">
                                                            <div class="product-preview px-0 pt-4 pb-1">
                                                                <div class="swiper product-preview__list-img-product">
                                                                    <div class="swiper-wrapper">
                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-1-1.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-2-1.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-dong-3.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-4.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-5.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-6.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-7.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-vang-8.jpg" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="swiper-button-next slide-button-next-core product-preview__list-img-product__button-next"><i class="far fa-angle-right"></i></div>
                                                                    <div class="swiper-button-prev slide-button-prev-core product-preview__list-img-product__button-pre"><i class="far fa-angle-left"></i></div>
                                                                </div>
                                                                <span class="product-preview__total-preview d-block text-center my-3"><a href="#" class="me-1">Xem tất cả ảnh nổi bật</a>(8/8)</span>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab3" id="pills-content-product-3" role="tabpanel" aria-labelledby="pills-content-product-3">
                                                            <div class="product-preview px-0 pt-4 pb-1">
                                                                <div class="swiper product-preview__list-img-product">
                                                                    <div class="swiper-wrapper">
                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-1.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-2.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-3 (1).jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-4-1.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-5-1.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-6-2.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-10.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-9.jpg" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="swiper-button-next slide-button-next-core product-preview__list-img-product__button-next"><i class="far fa-angle-right"></i></div>
                                                                    <div class="swiper-button-prev slide-button-prev-core product-preview__list-img-product__button-pre"><i class="far fa-angle-left"></i></div>
                                                                </div>
                                                                <span class="product-preview__total-preview d-block text-center my-3"><a href="#" class="me-1">Xem tất cả ảnh nổi bật</a>(7/7)</span>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab4" id="pills-content-product-4" role="tabpanel" aria-labelledby="pills-content-product-4">
                                                            <div class="container">
                                                                <div class="d-flex justify-content-center flex-column">
                                                                    <img class="img-fluid" src="/assets/img/product/oppo-reno8-z-5g-mo-hop-org.jpg" alt="">
                                                                    <div class="p-3 mb-2 bg-secondary text-white  rounded">Bộ sản phẩm gồm: Hộp, Sách hướng dẫn, Cây lấy sim, Ốp lưng, Cáp Type C, Củ sạc nhanh Type C</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab5" id="pills-content-product-5" role="tabpanel" aria-labelledby="pills-content-product-5">
                                                            <div class="product-preview px-0 pt-4 pb-1">
                                                                <div class="swiper product-preview__list-img-product">
                                                                    <div class="swiper-wrapper">
                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-1-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-2-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-3-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-4-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-5-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-6-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-7-800x800.jpg" />
                                                                        </div>

                                                                        <div class="swiper-slide slide-img-core d-flex justify-content-center">
                                                                            <img class="img-fluid rounded" src="/assets/img/product/oppo-reno8-z-5g-8-800x800.jpg" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="swiper-button-next slide-button-next-core product-preview__list-img-product__button-next"><i class="far fa-angle-right"></i></div>
                                                                    <div class="swiper-button-prev slide-button-prev-core product-preview__list-img-product__button-pre"><i class="far fa-angle-left"></i></div>
                                                                </div>
                                                                <span class="product-preview__total-preview d-block text-center my-3"><a href="#" class="me-1 product-preview-tab" control="#childButtonTab5" id="pills-home-tab" data-bs-toggle="modal" data-bs-target="#staticBackdrop" data-bs-target="#pills-content-product-5" type="button" role="tab" aria-controls="pills-content-product-5" aria-selected="true">Xem tất cả ảnh nổi bật</a>(7/7)</span>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab6" id="pills-content-product-6" role="tabpanel" aria-labelledby="pills-content-product-6">
                                                            <div class="container">
                                                                <div class="d-flex justify-content-center flex-column">
                                                                    <img class="img-fluid" src="/assets/img/product/oppo-reno8-z-5g-vang-1-1.jpg" alt="">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab7" id="pills-content-product-7" role="tabpanel" aria-labelledby="pills-content-product-7">
                                                            <div class="container">
                                                                <div class="d-flex justify-content-center flex-column">
                                                                    <img class="img-fluid" src="/assets/img/product/oppo-reno8-z-5g-note.jpg" alt="">

                                                                    <table class="table">
                                                                        <tbody>
                                                                            <tr class="table-secondary">
                                                                                <th scope="col" colspan="2">Màn hình</th>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Độ phân giải</th>
                                                                                <td>Full HD+ (1080 x 2400 Pixels)</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Màn hình rộng</th>
                                                                                <td>6.43" - Tần số quét 60 Hz</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Mặt kính cảm ứng:</th>
                                                                                <td>Kính cường lực Schott Xensation UP</td>
                                                                            </tr>

                                                                            <tr class="table-secondary">
                                                                                <th scope="col" colspan="2">Camera sau</th>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Quay phim</th>
                                                                                <td>FullHD 1080p@30fpsHD 720p@30fps</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Đèn Flash:</th>
                                                                                <td>Có</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Tính năng:</th>
                                                                                <td>
                                                                                    <ul>
                                                                                        <li>AI Camera</li>
                                                                                        <li>Ban đêm (Night Mode)</li>
                                                                                        <li>Bộ lọc màu</li>
                                                                                        <li>Chuyên nghiệp (Pro)</li>
                                                                                        <li>Google Lens</li>
                                                                                        <li>Bộ lọc màu</li>
                                                                                        <li>AI Camera</li>
                                                                                        <li>HDR</li>
                                                                                        <li>Hiệu ứng Bokeh</li>
                                                                                        <li>Làm đẹp</li>
                                                                                        <li>Nhãn dán (AR Stickers)</li>
                                                                                        <li>Quay chậm (Slow Motion)</li>
                                                                                    </ul>
                                                                                </td>
                                                                            </tr>

                                                                            <tr class="table-secondary">
                                                                                <th scope="col" colspan="2">Camera trước</th>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Độ phân giải:</th>
                                                                                <td>16 MP</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Tính năng:</th>
                                                                                <td>
                                                                                    <ul>
                                                                                        <li>Xóa phông</li>
                                                                                        <li>Nhãn dán (AR Stickers)</li>
                                                                                        <li>Quay video HD</li>
                                                                                        <li>Toàn cảnh (Panorama)</li>
                                                                                        <li>Bộ lọc màu</li>
                                                                                        <li>Quay video Full HD</li>
                                                                                        <li>HDR</li>
                                                                                        <li>Trôi nhanh thời gian (Time Lapse)</li>
                                                                                        <li>Chụp bằng cử chỉ</li>
                                                                                        <li>Chụp đêm</li>
                                                                                    </ul>
                                                                                </td>
                                                                            </tr>

                                                                            <tr class="table-secondary">
                                                                                <th scope="col" colspan="2">Hệ điều hành & CPU</th>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Hệ điều hành:</th>
                                                                                <td>Android 12</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Chip xử lý (CPU):</th>
                                                                                <td>Snapdragon 695 5G 8 nhân</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Tốc độ CPU:</th>
                                                                                <td>2.2 GHz</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Chip đồ họa (GPU):</th>
                                                                                <td>Adreno 619</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Hệ điều hành:</th>
                                                                                <td>Android 12</td>
                                                                            </tr>

                                                                            <tr class="table-secondary">
                                                                                <th scope="col" colspan="2">Bộ nhớ & Lưu trữ</th>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">RAM:</th>
                                                                                <td>8 GB</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Bộ nhớ trong:</th>
                                                                                <td>256 GB</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Thẻ nhớ:</th>
                                                                                <td>236 GB</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Bộ nhớ còn lại (khả dụng) khoảng:</th>
                                                                                <td>MicroSD, hỗ trợ tối đa 1 TB</td>
                                                                            </tr>

                                                                            <tr>
                                                                                <th scope="row">Danh bạ:</th>
                                                                                <td>Không giới hạn</td>
                                                                            </tr>                                                                      
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="tab-pane fade product-content-tab-child" control="#childButtonTab8" id="pills-content-product-8" role="tabpanel" aria-labelledby="pills-content-product-8">
                                                            <div class="container">
                                                                <div class="d-flex justify-content-center flex-column">
                                                                    <strong>OPPO Reno8 Z 5G đã được ra mắt trên thị trường di động Việt Nam. Điện thoại có vẻ ngoài được tạo hình vuông vức với màu sắc hết sức trẻ trung, cùng với đó là một hiệu năng mạnh mẽ và bộ camera có khả năng chụp ảnh sắc nét.</strong>

                                                                    <strong>Ngoại hình vuông vức hợp xu hướng</strong>

                                                                    <p>Reno8 Z 5G được OPPO sử dụng kiểu thiết kế vuông vức khá tương đồng với phiên bản tiền nhiệm Reno7 Z 5G khi mặt lưng và các cạnh bên được vát phẳng một cách tinh tế, mang lại cho người dùng một cái nhìn sang trọng và thời thượng hơn khi cầm nắm sử dụng trên tay.</p>
                                                                    <img src="/assets/img/product/oppo-reno8-z-5g-050822-104602.jpg" alt="" class="img-fluid rounded">
                                                                    <p>Mặt lưng của máy được làm từ vật liệu kính cùng một độ nhám nhất định giúp cho thiết bị có khả năng hạn chế các vết xước nhẹ, tình trạng bám dấu vân tay cũng được cải thiện đáng kể nên người dùng sẽ không cần tốn quá nhiều thời gian để vệ sinh máy.</p>
                                                                    <strong>Màn hình hiển thị chất lượng</strong>
                                                                    <p>Reno8 Z 5G mang đến cho bạn những hình ảnh sống động đầy rực rỡ khi được phủ lên trên một tấm nền AMOLED cao cấp, ngoài ra với kích thước màn hình lên đến 6.43 inch và độ phân giải Full HD+ (1080 x 2400 Pixels) nên mọi thông tin trên màn hình đều được tái hiện sắc nét và to rõ.</p>
                                                                    <img src="/assets/img/product/oppo-reno8-z-5g-050822-111635.jpg" alt="" class="img-fluid rounded">
                                                                    <strong>Nâng tầm trải nghiệm chụp ảnh</strong>
                                                                    <p>Reno8 Z 5G được OPPO trang bị 3 camera với camera chính có độ phân giải lên đến 64 MP cùng hai ống kính phụ có chung độ phân giải 2 MP, điều này giúp cho điện thoại có thể bắt lại những khung cảnh đẹp sắc nét hơn hay thỏa mình sáng tạo với nhiều góc độ khác nhau thông qua các tính năng chụp mới mẻ mà ống kính phụ mang lại.</p>
                                                                    <img src="/assets/img/product/oppo-reno8-z-5g-050822-104833.jpg" alt="" class="img-fluid rounded">
                                                                    <strong>Hiệu năng mạnh mẽ đến từ chipset Qualcomm</strong>
                                                                    <p>OPPO Reno8 Z 5G được vận hành bởi con chip Snapdragon 695 5G 8 nhân với hiệu suất tôi đa có thể đạt được là 2.2 GHz, đi kèm với đó là sự tối ưu về hệ điều hành Android 12 giúp cho các nhu cầu sử dụng hàng ngày trở nên mượt mà hơn hẳn.</p>
                                                                    <img src="/assets/img/product/oppo-reno8-z-5g-250722-105256.jpg" alt="" class="img-fluid rounded">
                                                                    <p>Điện thoại RAM 8 GB giúp bạn có thể mở đồng thời nhiều ứng dụng mà không cần phải lo lắng đến vấn đề giật lag trong lúc đa nhiệm. Ngoài ra hãng còn bổ sung thêm cho thiết bị tính năng mở rộng RAM nhằm giúp cho người dùng sử dụng nhiều tác vụ nâng cao được ổn định hơn.</p>
                                                                    <strong>Hỗ trợ sạc pin nhanh chóng</strong>
                                                                    <p>Với viên pin có dung lượng 4500 mAh thừa sức mang lại cho bạn thời lượng dùng lên đến cả ngày cho các tác vụ đàm thoại, nhắn tin hay nghe nhạc. Để tối ưu thời gian sạc trên thiết bị nên OPPO cũng đã tích hợp thêm công nghệ SuperVOOC 33 W có khả năng lấp đầy viên pin trong tích tắc.</p>
                                                                    <img src="/assets/img/product/oppo-reno8-z-5g-050822-105151.jpg" alt="" class="img-fluid rounded">
                                                                    <p>Với vẻ ngoài trẻ trung, lịch lãm sản phẩm sẽ thu hút được rất nhiều bạn trẻ hiện nay và nhất là thế hệ GenZ, bên cạnh đó thì OPPO Reno8 Z 5G cũng được trang bị bộ 3 camera chất lượng để bạn có thể nâng cấp khả năng nhiếp ảnh hay một cấu hình mạnh mẽ giúp bạn tối ưu công việc nhanh chóng.</p>
                                                                </div>
                                                            </div>
                                                        </div>                              
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="accompanying-program-product">
                                        <div class="row border-bottom">
                                            <div class="col-12 col-md-6">
                                                <div class="accompanying-program-product__item d-flex py-2">
                                                    <i class="fad fa-box-usd text-primary me-2"></i>
                                                    <div class="product-item-core__text text-dark">   
                                                        Hư gì đổi nấy <strong>12 tháng</strong> tại 3301 siêu thị toàn quốc (miễn phí tháng đầu) <a class="ms-2" href="#">Xem chi tiết</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <div class="accompanying-program-product__item d-flex py-2">
                                                    <i class="fad fa-shield-check text-primary me-2"></i>
                                                    <div class="product-item-core__text text-dark">   
                                                        Bảo hành <strong>chính hãng điện thoại 1 năm</strong> tại các trung tâm bảo hành hãng <a class="ms-2" href="#">Xem chi tiết</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 col-md-6">
                                                <div class="accompanying-program-product__item d-flex py-2">
                                                    <i class="fad fa-box text-primary me-2"></i>
                                                    <div class="product-item-core__text text-dark">   
                                                        Bộ sản phẩm gồm: Hộp, Sách hướng dẫn, Cây lấy sim, Ốp lưng, Cáp Type C, Củ sạc nhanh Type C  <a class="ms-2" href="#">Xem chi tiết</a>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="col-12 col-md-6">

                                            </div>
                                        </div>
                                    </div>

                                    <div class="product-item-core__text text-dark">
                                        <a class="ms-2" href="#">Xem Điện thoại OPPO Reno8 Z 5G cũ giá từ <span class="text-danger">7.570.000₫</span> <span class="text-dark bg-secondary py-1 px-2 rounded ms-2">Tiết kiệm đến <span class="text-danger">27%</span></span></a>
                                    </div>

                                    <div class="box-info-product overflow-hidden">
                                        <h5 class="my-3">Thông tin sản phẩm</h5>
                                        <div class="d-flex justify-content-center flex-column">
                                            <strong>OPPO Reno8 Z 5G đã được ra mắt trên thị trường di động Việt Nam. Điện thoại có vẻ ngoài được tạo hình vuông vức với màu sắc hết sức trẻ trung, cùng với đó là một hiệu năng mạnh mẽ và bộ camera có khả năng chụp ảnh sắc nét.</strong>

                                            <strong>Ngoại hình vuông vức hợp xu hướng</strong>

                                            <p>Reno8 Z 5G được OPPO sử dụng kiểu thiết kế vuông vức khá tương đồng với phiên bản tiền nhiệm Reno7 Z 5G khi mặt lưng và các cạnh bên được vát phẳng một cách tinh tế, mang lại cho người dùng một cái nhìn sang trọng và thời thượng hơn khi cầm nắm sử dụng trên tay.</p>
                                            <img src="/assets/img/product/oppo-reno8-z-5g-050822-104602.jpg" alt="" class="img-fluid rounded">
                                            <p>Mặt lưng của máy được làm từ vật liệu kính cùng một độ nhám nhất định giúp cho thiết bị có khả năng hạn chế các vết xước nhẹ, tình trạng bám dấu vân tay cũng được cải thiện đáng kể nên người dùng sẽ không cần tốn quá nhiều thời gian để vệ sinh máy.</p>
                                            <strong>Màn hình hiển thị chất lượng</strong>
                                            <p>Reno8 Z 5G mang đến cho bạn những hình ảnh sống động đầy rực rỡ khi được phủ lên trên một tấm nền AMOLED cao cấp, ngoài ra với kích thước màn hình lên đến 6.43 inch và độ phân giải Full HD+ (1080 x 2400 Pixels) nên mọi thông tin trên màn hình đều được tái hiện sắc nét và to rõ.</p>
                                            <img src="/assets/img/product/oppo-reno8-z-5g-050822-111635.jpg" alt="" class="img-fluid rounded">
                                            <strong>Nâng tầm trải nghiệm chụp ảnh</strong>
                                            <p>Reno8 Z 5G được OPPO trang bị 3 camera với camera chính có độ phân giải lên đến 64 MP cùng hai ống kính phụ có chung độ phân giải 2 MP, điều này giúp cho điện thoại có thể bắt lại những khung cảnh đẹp sắc nét hơn hay thỏa mình sáng tạo với nhiều góc độ khác nhau thông qua các tính năng chụp mới mẻ mà ống kính phụ mang lại.</p>
                                            <img src="/assets/img/product/oppo-reno8-z-5g-050822-104833.jpg" alt="" class="img-fluid rounded">
                                            <strong>Hiệu năng mạnh mẽ đến từ chipset Qualcomm</strong>
                                            <p>OPPO Reno8 Z 5G được vận hành bởi con chip Snapdragon 695 5G 8 nhân với hiệu suất tôi đa có thể đạt được là 2.2 GHz, đi kèm với đó là sự tối ưu về hệ điều hành Android 12 giúp cho các nhu cầu sử dụng hàng ngày trở nên mượt mà hơn hẳn.</p>
                                            <img src="/assets/img/product/oppo-reno8-z-5g-250722-105256.jpg" alt="" class="img-fluid rounded">
                                            <p>Điện thoại RAM 8 GB giúp bạn có thể mở đồng thời nhiều ứng dụng mà không cần phải lo lắng đến vấn đề giật lag trong lúc đa nhiệm. Ngoài ra hãng còn bổ sung thêm cho thiết bị tính năng mở rộng RAM nhằm giúp cho người dùng sử dụng nhiều tác vụ nâng cao được ổn định hơn.</p>
                                            <strong>Hỗ trợ sạc pin nhanh chóng</strong>
                                            <p>Với viên pin có dung lượng 4500 mAh thừa sức mang lại cho bạn thời lượng dùng lên đến cả ngày cho các tác vụ đàm thoại, nhắn tin hay nghe nhạc. Để tối ưu thời gian sạc trên thiết bị nên OPPO cũng đã tích hợp thêm công nghệ SuperVOOC 33 W có khả năng lấp đầy viên pin trong tích tắc.</p>
                                            <img src="/assets/img/product/oppo-reno8-z-5g-050822-105151.jpg" alt="" class="img-fluid rounded">
                                            <p>Với vẻ ngoài trẻ trung, lịch lãm sản phẩm sẽ thu hút được rất nhiều bạn trẻ hiện nay và nhất là thế hệ GenZ, bên cạnh đó thì OPPO Reno8 Z 5G cũng được trang bị bộ 3 camera chất lượng để bạn có thể nâng cấp khả năng nhiếp ảnh hay một cấu hình mạnh mẽ giúp bạn tối ưu công việc nhanh chóng.</p>
                                        </div>
                                        <div class="bg-article"></div>
                                        <div class="btn-read-more">
                                            <div class="nav-item" role="presentation">
                                                <div class="product-preview-tab d-flex justify-content-center" control="#childButtonTab8" id="pills-home-tab" data-bs-toggle="modal" data-bs-target="#staticBackdrop" type="button" role="tab" aria-controls="pills-preview-product-8" aria-selected="false" tabindex="-1">

                                                    <button type="button" class="btn btn-outline-primary w-60">Xem thêm</button>
                                                </div>
                                            </div>
                                        </div>                                  
                                    </div>
                                </div>
                                <div class="col-lg-5">
                                    <div class="list-models-group-product pt-4 pb-2">
                                        <div class="models-group-product mb-2">
                                            <button type="button" class="btn">Zeno8</button>
                                            <button type="button" class="btn active">Zeno8 Z 5G</button>
                                            <button type="button" class="btn">Zeno8 5G</button>
                                        </div>
                                        <div class="models-group-product">
                                            <button type="button" class="btn active">Vàng đồng</button>
                                            <button type="button" class="btn">Đen</button>
                                        </div>
                                    </div>

                                    <div class="box-pay-product">
                                        <div class="product-item-core__text">Giá tại <a href="#">Hà Nội<i class="fas fa-caret-down"></i></a></div>
                                        <div class="product-item-core__row">
                                            <strong class="product-item-core__price me-2">
                                                <span>40.990.000₫</span>
                                            </strong>
                                            <div class="product-item-core__label">
                                                <span class="lalel-product-core label-installment">Trả góp 0%</span>
                                            </div>
                                        </div> 
                                    </div>

                                    <div class="card mb-3">
                                        <div class="card-header">
                                            <h6 class="card-title">Khuyến mãi</h6>
                                            <span class="text-sm d-block">Giá và khuyến mãi dự kiến áp dụng đến 23:59 | 16/09</span>
                                        </div>
                                        <div class="card-body">
                                            <div class="product-item-core__text">
                                                <div class="product-item-core__dot me-2">1</div>
                                                Giảm 20% gói Bảo hành Mở rộng 12 tháng <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>
                                            <div class="product-item-core__text">
                                                <div class="product-item-core__dot me-2">2</div>
                                                Nhập mã TGDD giảm 5% tối đa 200.000đ cho đơn hàng từ 500.000đ trở lên khi thanh toán qua Ví Moca trên ứng dụng Grab <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>
                                            <div class="product-item-core__text">
                                                <div class="product-item-core__dot me-2">3</div>
                                                Nhập mã SPPMWG giảm 10% tối đa 100.000đ khi thanh toán qua Ví ShopeePay <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>
                                            <div class="product-item-core__text">
                                                <div class="product-item-core__dot me-2">4</div>
                                                Nhập mã MWG18 giảm 3% tối đa 100.000đ khi thanh toán quét QRcode qua App của ngân hàng <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="product-item-core__text text-dark">
                                        <i class="fas fa-map-marker text-primary me-2"></i>
                                        Giao hàng tới Số nhà 106, Chi Long, Ngọc Long, Yên Mỹ, Hưng Yên <a class="ms-2" href="#">Đổi</a>
                                    </div>

                                    <div class="product-item-core__text text-success">
                                        Giao hàng Từ <strong>10h - 12h ngày mai (12/09)</strong> 
                                    </div>

                                    <div class="product-item-core__text text-success">
                                        Miễn phí giao hàng 
                                    </div>

                                    <div class="product-item-core__text text-primary">
                                        <i class="far fa-store text-primary"></i>
                                        <a class="ms-2" href="#">Xem siêu thị có hàng</a>
                                    </div>

                                    <div class="border-bottom my-2"></div>

                                    <div class="box-endow-product">
                                        <h6>Ưu đãi khi thanh toán</h6>

                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <div class="form-check m-0">
                                                    <div class="mb-3">
                                                        <input class="form-check-input rounded-circle" type="checkbox" value="" id="flexCheckDefault">
                                                        <label class="form-check-label d-flex align-items-center" for="flexCheckDefault">
                                                            <img src="/assets/img/banner-ads/eximbank.jpg" class="" alt="" height="18px">
                                                            <small class="ms-2 text-dark">
                                                                Giảm <strong>500.000đ</strong> sản phẩm từ 3Tr 
                                                            </small>
                                                        </label>
                                                    </div>
                                                    <div class="mb-2">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="d-flex mb-1">
                                            <button class="btn btn-primary btn-md w-100" type="button">MUA NGAY</button>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button class="btn btn-primary btn-md w-100" type="button">
                                                <h6 class="m-0">MUA TRẢ GÓP 0%</h6>
                                                <small>Duyệt hồ sơ trong 5p</small>
                                            </button>

                                            <button class="btn btn-primary btn-md w-100" type="button">
                                                <h6 class="m-0">TRẢ GÓP QUA THẺ</h6>
                                                <small>Visa, Mastercard, JCB, Amex</small>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="product-item-core__text text-dark text-center my-2">
                                        Gọi đặt hàng
                                        <a class="" href="tel:18001060">1800.1060</a>
                                        (7:30 - 22:00)
                                    </div>

                                    <div class="card mb-3">
                                        <div class="card-header">
                                            <h6 class="card-title d-inline-block">2 ưu đãi thêm</h6>
                                            <small class="product-item-core__text">Dự kiến áp dụng đến 23:00 | 30/09</small>
                                        </div>
                                        <div class="card-body">
                                            <div class="product-item-core__text">
                                                <i class="fas fa-check-circle text-success me-2"></i>
                                                Khách hàng mua tai nghe OPPO giảm 20% khi mua kèm điện thoại /tablet OPPO <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>

                                            <div class="product-item-core__text">
                                                <i class="fas fa-check-circle text-success me-2"></i>
                                                Khách hàng mua tai nghe giảm đến 40% khi mua kèm Điện thoại/Laptop/Tablet <a class="ms-2" href="#">Xem chi tiết</a>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="box-info-product">
                                        <h5>Cấu hình Điện thoại OPPO Reno8 Z 5G</h5>
                                        <table class="table">
                                            <tbody>
                                                <tr>
                                                    <td scope="row">Màn hình:</td>
                                                    <td>AMOLED6.43"Full HD+</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">Hệ điều hành:</td>
                                                    <td>Android 12</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">Camera sau:</td>
                                                    <td>Chính 64 MP & Phụ 2 MP, 2 MP</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">Camera trước:</td>
                                                    <td>16 MP</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">Chip:</td>
                                                    <td>Snapdragon 695 5G</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">RAM:</td>
                                                    <td>8GB</td>
                                                </tr>


                                                <tr>
                                                    <td scope="row">Bộ nhớ trong: </td>
                                                    <td>256GB</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">SIM:</td>
                                                    <td>2 Nano SIMHỗ trợ 5G</td>
                                                </tr>

                                                <tr>
                                                    <td scope="row">Pin, Sạc:</td>
                                                    <td>4500 mAh33 W</td>
                                                </tr>                                                               
                                            </tbody>
                                        </table>

                                        <div class="nav-item" role="presentation">
                                            <div class="product-preview-tab d-flex justify-content-center" control="#childButtonTab7" id="pills-home-tab" data-bs-toggle="modal" data-bs-target="#staticBackdrop" type="button" role="tab" aria-controls="pills-preview-product-7" aria-selected="false" tabindex="-1">

                                                <button type="button" class="btn btn-outline-primary w-60">Xem thêm cấu hình chi tiết</button>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- end: main-content-product -->
                </div>
            </div>
            <!-- end: content -->

            <!-- begin: footer -->
            <footer class="footer">
                <div class="container">
                    <div class="row row-cols-2 row-cols-lg-4 gy-4">
                        <div class="col">
                            <div class="footer__list-link">
                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Tích điểm Quà tặng VIP</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Lịch sử mua hàng</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Cộng tác bán cùng TGDD</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Tìm hiểu về mua trả góp</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Chính sách bảo hành</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Chính sách đổi trả</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Giao hàng và thanh toán</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Hướng dẫn mua online</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Bán hàng doanh nghiệp</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Phiếu mua hàng</a>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="footer__list-link">
                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">In hóa đơn điện tử</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Quy chế hoạt động</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Nội quy cửa hàng</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Chất lượng phục vụ</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Cảnh báo giả mạo</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Chính sách sản phẩm Apple</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Giới thiệu công ty</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Tuyển dụng</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Gửi góp ý, khiếu nại</a>
                                </div>

                                <div class="footer__link">
                                    <a href="/page/client/sale-event/sale-event.html">Tìm siêu thị</a>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="footer__link">
                                <span><b>Tổng đài hỗ trợ</b> (Miễn phí gọi)</span>
                            </div>

                            <div class="footer__link">
                                <span><b>Gọi mua: </b> <a class="text-primary" href="tel:18001060">1800.1060</a> (7:30 - 22:00)</span>
                            </div>

                            <div class="footer__link">
                                <span><b>Kỹ thuật: </b> <a class="text-primary" href="tel:18001060">1800.1763</a> (7:30 - 22:00)</span>
                            </div>

                            <div class="footer__link">
                                <span><b>Khiếu nại: </b> <a class="text-primary" href="tel:18001060">1800.1062</a> (7:30 - 22:00)</span>
                            </div>

                            <div class="footer__link">
                                <span><b>Bảo hành: </b> <a class="text-primary" href="tel:18001060">1800.1064</a> (7:30 - 22:00)</span>
                            </div>
                        </div>
                        <div class="col">
                            <div class="footer__social">
                                <a href="/page/client/blog/app.html">
                                    <i class="fab fa-facebook"></i> 3755.1k Fan
                                </a>
                                <a href="/page/client/blog/app.html">
                                    <i class="fab fa-youtube"></i> 848k Đăng ký
                                </a>
                            </div>

                            <div class="footer__certify">
                                <a href="/page/client/blog/app.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/blog/app.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/blog/app.html">
                                    <i></i>
                                </a>
                            </div>

                            <div class="footer__website">
                                <!-- <p>Website cùng tập đoàn</p> -->
                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>

                                <a href="/page/client/ads/ads.html">
                                    <i></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- end: footer -->

            <!-- begin: copyright -->
            <div class="copyright text-center">
                Copyright ©2022 Bản quyền thuộc về Khoa CNTT Trường Đại học Sư Phạm Kỹ Thuật Hưng Yên
            </div>
            <!-- end: copyright -->
        </div>

        <!-- bootstrap js -->
        <script src="/lib/bootstrap-5.2.0-dist/js/bootstrap.bundle.min.js"></script>
        <!-- swiper js -->
        <script src="/lib/swiper-8.3.2/package/swiper-bundle.min.js"></script>
        <script src="/assets/js/carousel.js"></script>
        <!-- jquery js -->
        <script src="/lib/jquery-3.6.0/jquery-3.6.0.min.js"></script>
        <script>
            let select = "";
            let buttonTab = $(".product-preview-tab");
            let tab = $(".product-content-tab");
            let contentTab = $(".product-content-tab-child");

            buttonTab.click(function () {

                select = $(this).attr('control');

                tab.removeClass("active");
                for (let i = 0; i <= tab.length; i++) {

                    if ($(tab[i]).attr("control") === select) {
                        $(tab[i]).addClass("active");
                    }

                    contentTab.removeClass("active").removeClass("show");
                    for (let k = 0; k <= contentTab.length; k++) {

                        if ($(contentTab[k]).attr("control") === select) {

                            $(contentTab[k]).addClass("show").addClass("active");
                        }
                    }
                }
            });        // $(tab[2]).addClass("active");
        </script>
    </body>
</html>