

<%@ page contentType="text/html;charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
	Purchase purchaseVO = (Purchase) request.getAttribute("purchase");
	String pay = "";
	if(purchaseVO != null){
		if(purchaseVO.getPaymentOption().equals("1")){
			pay = "현금구매";
		}else{
			pay = "신용구매";
		}
	}
%> --%>


<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>Insert title here</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		$(function(){
			
			$.ajax({
				url:"/purchase/json/addPurchase",
				method:"POST",
				dataType:"json",
				
				hearders:{
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success:function(data,status){
			
				}
			  }	
			);/* ajax end */
		});
	</script>

	</head>

	<body>
<jsp:include page="../layout/menubar.jsp"/>
		<form name="updatePurchase" action="/purchase/updatePurchaseView?tranNo=${purchase.tranNo}" method="post">
		
		다음과 같이 구매가 되었습니다.
		
		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>물품번호</td>
				<td>${purchase.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자아이디</td>
				<td>${purchase.buyer.userId}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매방법</td>
				<td>
				${purchase.paymentOption=='1'?"현금구매":"신용구매"}
				</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자이름</td>
				<td>${purchase.receiverName}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자연락처</td>
				<td>${purchase.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매수량</td>
				<td>${purchase.sEA}</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자주소</td>
				<td>${purchase.divyAddr}</td>
				<td></td>
			</tr>
				<tr>
				<td>구매요청사항</td>
				<td>${purchase.divyRequest }</td>
				<td></td>
			</tr>
			<tr>
				<td>배송희망일자</td>
				<td>${purchase.divyDate}</td>
				<td></td>
			</tr>
		</table>
		</form>
	
	</body>
</html>