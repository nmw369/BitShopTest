

<%@ page contentType="text/html;charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
	Purchase purchaseVO = (Purchase) request.getAttribute("purchase");
	String pay = "";
	if(purchaseVO != null){
		if(purchaseVO.getPaymentOption().equals("1")){
			pay = "���ݱ���";
		}else{
			pay = "�ſ뱸��";
		}
	}
%> --%>


<html>
	<head>
	<!-- ȭ�� ���� -->
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

		<form name="updatePurchase" action="/purchase/updatePurchaseView?tranNo=${purchase.tranNo}" method="post">
		
		������ ���� �Ŀ� �Ǿ����ϴ�.
		
		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>�ݵ��̸�</td>
				<td><�ɰ� ������Ʈ></td>
				<td></td>
			</tr>
			<tr>
				<td>�Ŀ��ݾ�</td>
				<td>${purchase.getPurchaseProd().getPrice()} ��</td>
				<td></td>
			</tr>
			<tr>
				<td>�������</td>
				<td>
				${purchase.paymentOption=='1'?"���̹�Pay":"īī��Pay"}
				</td>
				<td></td>
			</tr>
			
		</table>
		</form>
	
	</body>
</html>