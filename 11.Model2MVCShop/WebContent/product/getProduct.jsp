<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%
	Product product = (Product)request.getAttribute("product");
	String menu = request.getParameter("menu");
	
	System.out.println("getProduct JSP 까지 넘어온 menu 출력확인: "+menu);
	System.out.println("getProduct JSP 시작지점에서 Product product 출력확인: "+product);
	
	Purchase pu = new PurchaseServiceImpl().getPurchase2(product.getProdNo());
	//System.out.println(pu.getTranNo()+"::getProduct에서 받아온 tranNo");
	
%> --%>


<html>
<head>
<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>상품정보조회</title>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		 background: url("../images/uploadFiles/back.png") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    
		}
	</style>


<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script type="text/javascript">
		
		//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('이전')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
				history.go(-1);
			});
			
			 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					self.location = "/user/updateUser?userId=${user.userId}"
				});
			 
			 $( "td.ct_btn01:contains('구매')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					self.location = "/purchase/addPurchaseView?prodNo=${product.prodNo}"
				});
			 $( "td.ct_btn01:contains('상품정보수정')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					self.location = "/product/updateProductView?prodNo=${product.prodNo}"
				});
			 		 
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="../layout/menubar.jsp"/>


<div class="container" >
	
		<div class="page-header" >

	      <h3 class=" text-info" align="center">상품상세조회</h3>
	      <h5 class="text-muted" align="center">선택하신 <strong class="text-danger">상품의 정보</strong>는 다음과 같습니다.</h5>
	      </div>
	    
		<div class="row" >
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			<c:if test="${empty filelist}">
			<img src = "/images/uploadFiles/notimage.gif" width = "100">
			</c:if>
			
			<c:if test="${!empty filelist}">
			<c:forEach var="filelist" items="${filelist}">
				<img src="/images/uploadFiles/${filelist}" width="200">
			</c:forEach>
			</c:if>
			
		</div>
		
		<hr/>
	
	<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>현재남은수량</strong></div>
			<div class="col-xs-8 col-md-4">${product.nEA}</div>
		</div>
	<hr/>

<%-- <c:if test="${param.menu=='manage' }"> --%>
<c:if test="${user.role=='admin' }">

	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
				
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<%-- <a href="/product/updateProductView?prodNo=${product.prodNo}">상품정보수정</a> --%>
							상품정보수정
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">이전</a> -->
							이전
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
					
						
					</tr>
				</table>
			</td>
		</tr>
	</table>
</c:if>

<c:if test="${user.role=='user' }">

	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
					
				
						
						<c:if test="${ product.nEA==0}">
						
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">이전</a> -->
							이전
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						
						</c:if>
					
					
						<c:if test="${ product.nEA!=0}">
						
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<%-- <a href="/purchase/addPurchaseView?prodNo=${product.prodNo}">구매</a> --%>
							구매
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">이전</a> -->
							이전
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						</c:if>
						
				
						
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</c:if>

</div>
</body>
</html>