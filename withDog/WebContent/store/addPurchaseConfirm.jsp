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
<% System.out.println("제에스피넘어옴");%>
<title>결제완료</title>

<script type="text/javascript">
$(function(){
	if('${state}'=='1'){
		alert("결제가 취소 되었습니다.");
		window.close();
	}
	if('${state}'=='2'){
		alert("결제실패!!! 다시시도해 주세요");
		window.close();
	}
	if('${state}'=='0'){
		var a = ${pointPurchase.purchase.purchaseNo};
		window.close();
		opener.location.href='/purchase/addPurchaseDone?state=3&purchaseNo='+a;
	}
	
});

$(function(){
	$("#confirm").on("click", function(){
		self.location = "/product/listProduct?prodType=0";
	})	
});

</script>
</head>

<body>

		<c:if test="${state=='3'}">

		<jsp:include page="/layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/500_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">Complete a Payment</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">완료된 결제정보를 확인하세요.</span>
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
            	
            	
                <div class="row text-center">
                    <div class="col-md-10 col-sm-12 col-xs-11 text-center center-col margin-ten no-margin-bottom">
                        <!-- logo -->
                        <img class="logo-style-2" src="../images/logo-sky.png" alt="" >
                        <!-- end logo -->
                    </div>
                    <div class="col-md-10 col-sm-12 col-xs-11 center-col text-center margin-five">
                        <h1>${pointPurchase.user.userName} 님의</h1>
                        <p class="title-small margin-one">구매가 정상적으로 완료되었습니다.</p>
                    </div>
                    <div class="text-center bg-gray">
                    	<div class="padding-three">
	                    	<p class="text-small no-margin">구매번호</p>
	                    	<p class="title-large no-margin">${pointPurchase.purchase.purchaseNo}</p>
                    	</div>
                    </div>
                    <div style="border:5px solid # e3e3e3; padding:4%">
                    	
					
						<div class="row">
					  		<div class="col-xs-4 col-md-2 font-weight-600 text-left">결제금액</div>
							<div class="col-xs-8 col-md-4 center-col text-center">${pointPurchase.purchase.purchasePrice}</div>
						</div>
					
						<hr/>
						
						<div class="row">
					  		<div class="col-xs-4 col-md-2 font-weight-600 text-left">사용포인트</div>
							<div class="col-xs-8 col-md-4 center-col text-center">${pointPurchase.usePoint}</div>
						</div>
						
                    
                    </div>
                    
                    <a href="#" id="confirm" class="box-sky btn btn-large">확인</a>
                </div>
                
                
                </div>
            </div>
        </section>
        <!-- end content section -->
        
		<jsp:include page="/layout/footer.jsp" />
	
		<jsp:include page="/common/js.jsp" />
		</c:if>

</body>
</html>