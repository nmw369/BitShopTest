<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="/common/css.jsp" />
<title>상품등록</title>

<script type="text/javascript">
	
	//"확인" 버튼 이벤트 연결
	$(function(){
		$("#listProductNav").on("click", function(){
// 			var prodType = $(".prodSort").val();
// 			if(prodType.equals('0')){
				self.location = "/product/listProduct?prodType=0";
// 			}else{
// 				self.location = "/product/listProduct?prodType=" + prodType;
// 			}
		});
	});
</script>
</head>

<body>

		<jsp:include page="/layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/500_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">Product Registration</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">등록한 상품정보를 확인하세요.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        <!-- content section -->
        <section class="wow fadeIn">
            <div class="container">
            	<div class="col-md-8 col-sm-10 col-xs-11 center-col xs-no-padding">
            
            	<div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">상품구분</div>
					<div class="col-xs-8 col-md-6">
						<c:choose>	
							<c:when test="${product.prodType == '0'}">
								애견용품
							</c:when>
							<c:otherwise>
								애견식품
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="prodType"  value="${product.prodType}" class="prodType"/>
					</div>
				</div>
				
				<hr/>
				
                <div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">상 품 명</div>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">가격</div>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">상품이미지</div>
					<div class="col-xs-8 col-md-4">
						<img src = "/images/store/${product.prodImage}" width="400"/>
					</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">상세정보</div>
					<div class="col-xs-8 col-md-4">
						<img src = "/images/store/${product.prodContent}" width="400"/>
					</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 font-weight-600">상품수량</div>
					<div class="col-xs-8 col-md-4">${product.prodQuantity}</div>
				</div>
				
				<hr/>
				
				<div class="text-center">
                	<button id="listProductNav" type="button" class="highlight-button btn btn-medium">확인</button>
                </div>
                
                
                </div>
        	</div>        
        </section>
        <!-- end content section -->
        
        
        


		<jsp:include page="/layout/footer.jsp" />
	
		<jsp:include page="/common/js.jsp" />

</body>
</html>