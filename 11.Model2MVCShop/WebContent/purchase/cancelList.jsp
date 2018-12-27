<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>

<html>
	<head>
	<!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<title>���� ��ҳ���</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
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
		
		
		
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			function fncGetList(currentPage) {
				document.getElementById("currentPage").value = currentPage;
				document.detailForm.submit();
			}
			
			$(function(){
				
				$(".ct_list_pop td:nth-child(1)").on("click",function(){
					
					self.location="/user/getUser?userId="+"${vo.buyer.userId}"+"&menu=search&cancel=yes";
				});
				
				$(".ct_list_pop td:nth-child(3)").on("click",function(){
					
					var index = $($(".ct_list_pop td:nth-child(3)")).index(this);
					var prodNo = $($("input[name=prodNo]")[index]).val();
					
					self.location="/product/getProduct?prodNo="+prodNo+"&menu=search&cancel=yes";
				});
				
				/* $(".ct_list_test1 td:contain('�㰡')").on("click",function(){
					
					self.location="/user/getUser?userId="+"${vo.buyer.userId}"+"&menu=search&cancel=yes";
				}); */
			});
		</script>
	</head>
<!-- 	<style>

body{
    background: url("/images/clock2.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}
</style> -->
	
	
	
	
	<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="../layout/menubar.jsp"/>
	
		<div class="container">
		<div style="width: 98%; margin-left: 10px;">
		
		<!-- <form name="detailForm" action="/purchase/listPurchase" method="post"> -->
		
			<div class="page-header text-info">
							<h3>������ҳ���</h3>
					</div>
		
		<div class="col-md-6 text-left">
		    	<p class="text-primary">
			��ü ${resultPage.totalCount} ��, ���� ${resultPage.currentPage } ������
			</p>
		    </div>
			<div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    </form>
	    	</div>
	    	
	    	<form name="detailForm" action="/purchase/listSale" method="post">
	   	
		<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;"> -->
		<table class="table table-hover table-striped" >
			<thead>	
	    	<tr>
				<!-- <td class="ct_list_b" width="100">�����ID</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="100">��ǰ��</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">��ǰ����</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">����</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">��һ���</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">��Ȳ</td> -->
				
				<th class="text-center">�����ID</th>
				<th class="text-center">��ǰ��</th>
				<th class="text-center">��ǰ����</th>
				<th class="text-center">����</th>
				<th class="text-center">��һ���</th>
				<th class="text-center">��ǰ��Ȳ</th>
				
			</tr>
							
							<%-- <c:set var="i" value="${currentPage}"></c:set>
							<c:set var="j" value="${pageSize}"></c:set>
							<c:set var="k" value="2"></c:set> --%>
							<c:forEach var="vo" items="${list}">
								
							<tr class="ct_list_pop" bgcolor="#ffffff">
								
								<%-- <td class="ct_list_test1" align="center">
							
									<c:set var="k" value="${k-1}"></c:set>
									<c:set var="i" value="${currentPage}"></c:set>
							
								</td>
								<td></td> --%>
								
								<td class="ct_list_test1" align="center">
									<%-- <a	href="/product/getProduct?prodNo=${vo.buyer.userId}&menu=search&cancel=yes"> --%>
										${vo.buyer.userId}
									<!-- </a> -->
								</td>
								
								
								<td class="ct_list_test1" align="center">
									<%-- <a	href="/product/getProduct?prodNo=${vo.purchaseProd.prodNo}&menu=search&cancel=yes"> --%>
										<input type="hidden" name="prodNo" value="${vo.purchaseProd.prodNo}"/>
										${vo.purchaseProd.prodName}
									<!-- </a> -->
								</td>
								
								
								<td class="ct_list_test1" align="center">${vo.purchaseProd.price}</td>
								
								
								<td class="ct_list_test1" align="center">${vo.sEA}</td>
								
								
								<td class="ct_list_test1" align="center">
								<a href="">
										��һ���</a>
								</td>
								
	
								<c:if test="${vo.cancelCode=='1'}">
									<td class="ct_list_test1" align="center">������ҽ�û�� 
									<a href="/purchase/cancel?cancelCode=${vo.cancelCode}&tranNo=${vo.tranNo}">�㰡</a>
									<a href="/purchase/cancel?cancelCode=${vo.cancelCode+1}&tranNo=${vo.tranNo}">����</a>
									</td>
								</c:if>
								<c:if test="${vo.cancelCode=='2'}">
									<td class="ct_list_test1" align="center">��������㰡��</td>
								</c:if>
								<c:if test="${vo.cancelCode=='3'}">
									<td class="ct_list_test1" align="center">������Ұź���</td>
								</c:if>									
								<td></td>
								
								
								
							</tr>
							
							</c:forEach>
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td align="center">
			
					<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
				 
				 <jsp:include page="../common/pageNavigator.jsp"/>
				 
				 
				</td>
			</tr>
		</table>
		
		<!--  ������ Navigator �� -->
		</form>
		</div>
	
		</div>
		
	</body>
</html>