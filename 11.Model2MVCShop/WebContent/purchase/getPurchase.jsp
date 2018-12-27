

<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE>
<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>구매상세조회</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
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
		
		
		<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		 $(function() {
			 
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			 $( "td.ct_btn01:contains('확인')" ).on("click" , function() {
				 history.go(-1);
				});
			 $( "td.ct_btn01:contains('구매취소')" ).on("click" , function() {
				 self.location="/purchase/cancel?tranNo="+"${pur.tranNo}"+"&cancelCode="+"${pur.cancelCode}";
						
			});
			 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
				 self.location="/purchase/updatePurchaseView?tranNo="+"${pur.tranNo}";
						
			});
			 $( "td.ct_btn01:contains('이전')" ).on("click" , function() {
				 history.go(-1);
			});
			
		 });
		
	</script>
		
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="../layout/menubar.jsp"/>
		<div class="container" >
	
		<div class="page-header" >

	      <h3 class=" text-info" align="center">상품상세조회</h3>
	      <h5 class="text-muted" align="center">구매하신 <strong class="text-danger">상품의 정보</strong>는 다음과 같습니다.</h5>
	      </div>
		
		<div class="row" >
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${pur.purchaseProd.prodNo}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${pur.buyer.userId}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법</strong></div>
			<div class="col-xs-8 col-md-4">${pur.paymentOption=="1"? "현금구매" : "신용구매"}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매수량</strong></div>
			<div class="col-xs-8 col-md-4">${pur.sEA}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매가격</strong></div>
			<div class="col-xs-8 col-md-4">${pur.purchaseProd.price*pur.sEA}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자이름</strong></div>
			<div class="col-xs-8 col-md-4">${pur.buyer.userName}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자연락처</strong></div>
			<div class="col-xs-8 col-md-4">${pur.receiverPhone}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자주소</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyAddr}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyRequest}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyDate}</div>
		</div>
		<hr/>			
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${pur.orderDate}</div>
		</div>
		<hr/>
		
			
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<c:if test="${pur.tranCode=='3' || pur.tranCode == '4'}">
						</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<!-- <a href="javascript:history.go(-1);">확인</a> -->
								확인
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
							</td>
						</c:if>
						
						
						<c:if test="${ pur.tranCode =='2'&&pur.cancelCode<'1'}">
						
							<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<%-- <a href="/purchase/cancel?tranNo=${pur.tranNo}&cancelCode=${pur.cancelCode}">구매취소</a> --%>
							구매취소
						</td>
						<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
						<td width="30"></td>
							
						<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<%-- <a href="/purchase/updatePurchaseView?tranNo=${pur.tranNo}">수정</a> --%>
								수정
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
						
						
							<c:if test="${pur.tranCode =='1'||pur.cancelCode>0}">
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<%-- <a href="/purchase/updatePurchaseView?tranNo=${pur.tranNo}">수정</a> --%>
								수정
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<!-- <a href="javascript:history.go(-1);">확인</a> -->
								확인
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
							</td>
							</c:if>
												
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
	</body>
</html>
