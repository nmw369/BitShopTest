<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<jsp:include page="/common/css.jsp" />


<title>채팅방</title>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/605_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/605_tit.png"></h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="shorting clearfix xs-margin-top-three">
                            <div class="col-md-8 col-sm-8 grid-nav">
                                <a href="shop-with-sidebar-list.html"><i class="fa fa-bars"></i></a>
                                <a href="#"><i class="fa fa-th"></i></a>
                                <p class="text-uppercase letter-spacing-1">Showing 1–12 of 22 results</p>
                            </div>
                            <div class="col-md-3 col-sm-3 pull-right">
                                <div class="select-style input-round med-input shop-shorting-full no-border">
                                    <select>
                                        <option value="">Select sort by</option>
                                        <option value="">By popularity</option>
                                        <option value="">By rating</option>
                                        <option value="">Price: low to high</option>
                                        <option value="">Price: high to low</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="product-listing margin-three">
                            <!-- shop item -->
                            <div class="col-md-4 col-sm-6">
                                <div class="home-product text-center position-relative overflow-hidden margin-ten no-margin-top">
                                    <a href="getProduct.jsp"><img src="http://placehold.it/600x500" alt=""/></a>
                                    <span class="product-name text-uppercase"><a href="getProduct.jsp">Gianvito Rossi</a></span>
                                    <span class="price black-text"><del>$750.00</del>$450</span>
                                    <span class="onsale onsale-style-2">Sale</span>
                                    <div class="quick-buy">
                                        <div class="product-share">
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Wishlist"><i class="fa fa-heart-o"></i></a>
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Compare"><i class="fa fa-refresh"></i></a>
                                            <a href="shop-cart.html" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Cart"><i class="fa fa-shopping-cart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end shop item -->
                            <!-- shop item -->
                            <div class="col-md-4 col-sm-6">
                                <div class="home-product text-center position-relative overflow-hidden margin-ten no-margin-top">
                                    <a href="getProduct.jsp"><img src="http://placehold.it/600x500" alt=""/></a>
                                    <span class="product-name text-uppercase"><a href="shop-single-product.html">Givenchy Low</a></span>
                                    <span class="price black-text">$500</span>
                                    <div class="quick-buy">
                                        <div class="product-share">
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Wishlist"><i class="fa fa-heart-o"></i></a>
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Compare"><i class="fa fa-refresh"></i></a>
                                            <a href="shop-cart.html" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Cart"><i class="fa fa-shopping-cart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end shop item -->
                            <!-- shop item -->
                            <div class="col-md-4 col-sm-6">
                                <div class="home-product text-center position-relative overflow-hidden margin-ten no-margin-top">
                                    <a href="getProduct.jsp"><img src="http://placehold.it/600x500" alt=""/></a>
                                    <span class="product-name text-uppercase"><a href="shop-single-product.html">Alexander McQueen</a></span>
                                    <span class="price black-text">$380</span>
                                    <div class="quick-buy">
                                        <div class="product-share">
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Wishlist"><i class="fa fa-heart-o"></i></a>
                                            <a href="#" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Compare"><i class="fa fa-refresh"></i></a>
                                            <a href="shop-cart.html" class="highlight-button-dark btn btn-small no-margin-right quick-buy-btn" title="Add to Cart"><i class="fa fa-shopping-cart"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end shop item -->
                            </div>
                        <!-- pagination -->
                        <div class="pagination margin-ten no-margin-bottom">
                            <a href="#"><img src="images/arrow-pre-small.png" alt=""/></a>
                            <a href="#">1</a>
                            <a href="#">2</a>
                            <a href="#" class="active">3</a>
                            <a href="#">4</a>
                            <a href="#">5</a>
                            <a href="#"><img src="images/arrow-next-small.png" alt=""/></a>
                        </div>
                        <!-- end pagination -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end content section -->
        
        
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>