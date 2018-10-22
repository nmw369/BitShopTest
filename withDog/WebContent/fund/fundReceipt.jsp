

<%@ page contentType="text/html;charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>Insert title here</title>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script>
	$(function(){
		
		if('${state}'=='1'){
			alert("결제가 취소 되었습니다.");
			window.close();
		}
		if('${state}'=='2'){
			alert("결제실패!!! 다시시도해 주세요");
			window.close();
		}
		window.opener.top.location.href="/fund/getMyFundList"
		//window.opener.top.location.reload();//새로고침
		window.close()
		
		
	});
	
	</script>
	</head>

	<body>

		<%-- <form name="updatePurchase" action="/purchase/updatePurchaseView?tranNo=${purchase.tranNo}" method="post"> --%>
		<c:if test="${state=='0'}">
		다음과 같이 후원 되었습니다.
		
		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>펀딩이름</td>
				<td>${fundpurchase.fund.fundTitle}</td>
				<td></td>
			</tr>
			<tr>
				<td>후원금액</td>
				<td>${empty fundpurchase.fund.fundMyPrice? 0:fundpurchase.fund.fundMyPrice} 원</td>
				<td></td>
			</tr>
			<tr>
				<td>사용포인트</td>
				<td>
				${empty fundpurchase.usePoint? 0:fundpurchase.usePoint}
				</td>
				<td></td>
			</tr>
			
		</table>
		</c:if>
		<!-- </form> -->
	
	</body>
</html>