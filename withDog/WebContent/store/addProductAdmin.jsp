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

	function fncAddProduct(){
		
		//Form 유효성 검증
		var name = $("input[name='prodName']").val();
		var price = $("input[name='price']").val();
		
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("enctype", "multipart/form-data").attr("action", "/product/addProductAdmin").submit();
	}
	
	//"상품등록" 버튼 이벤트 연결
	$(function(){
		$("#add").on("click", function(){
			fncAddProduct();
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
                        <span class="white-text xs-display-none">Register and modify product information.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        <!-- content section -->
        <section class="wow fadeIn">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 col-sm-8 col-xs-11 center-col xs-no-padding">
                        <form>
                        
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label class>상품구분</label>
                                <!-- end label  -->
                                <div class="select-style" style="margin-bottom:20px;">
                                    <select name="prodType" id="prodType">
                                        <option value="" selected="selected">상품구분</option>
                                        <option value="0" >애견용품</option>
                                        <option value="1" >애견식품</option>
                                     </select>
                                </div>
                            </div>
                            
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label>상품명</label>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="text" name="prodName" id="prodName"  class="big-input">
                                <!-- end input  -->
                            </div>
                            
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label>가격</label>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="text" name="price" id="price" class="big-input">
                                <!-- end input  -->
                            </div>
                            
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label>상품이미지</label>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="file" name="file" id="prodImage" class="big-input">
                                <!-- end input  -->
                            </div>
                            
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label>상세내용</label>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="file" name="file" id="prodContent" class="big-input">
                                <!-- end input  -->
                            </div>
                            
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <label>상품수량</label>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="text" name="prodQuantity" id="prodQuantity" class="big-input">
                                <!-- end input  -->
                            </div>
                        </form>
                        
                        <div class="text-center">
                            <button id="add" type="button" class="highlight-button btn btn-medium">상품등록</button>
                         </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end content section -->
        
        
        


		<jsp:include page="/layout/footer.jsp" />
	
		<jsp:include page="/common/js.jsp" />

</body>
</html>