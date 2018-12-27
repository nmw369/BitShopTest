
<%-- <%@page import="com.model2.mvc.service.domain.User"%>
<%@page import="com.model2.mvc.service.domain.Product"%> --%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- <%
	Product productVO = (Product) request.getAttribute("prodVO");
	System.out.println("ADDPURVIEW확인 +++++++::"+productVO);
	User userVO = (User) session.getAttribute("user");
	System.out.println("ADDPURVIEW확인 +++++++::"+userVO);
%> --%>
<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<title>purView</title>
		
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		
		<script type="text/javascript" src="../javascript/calendar.js">
		
		<script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
		
		</script>
		
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
		
		
		<script type="text/javascript">
		function fncAddPurchase() {
			document.addPurchase.submit();
		}
		
		
			 
		
		 $(function(){
			 $("td.ct_btn01:contains('후원금결제')").on("click",function(){
					alert("결제를위한 페이지로 이동합니다.");
					document.getElementById('frm').submit();
				/* fncAddPurchase(); */
				});
			 $("td.ct_btn01:contains('취소')").on("click",function(){
					history.go(-1);
				});
			
											
		});
		
					
		</script>
		<script type="text/javascript">
		function test() {
			//Debug..
									
			var price = $("#price").val()-$("#sEA").val();	
			document.getElementById("price").value = price;	
		}
		</script>
	</head>
	
	<body >

		<!-- <form name="addPurchase" method="post" action="/purchase/addPurchase"> -->
		<form name="addPurchase" method="post" action="/purchase/kakaoPay2" id="frm">
		
		<div class="container">
	
		<h1 class="bg-primary text-center">후원하기</h1>
		
		<%-- <input type="hidden" name="prodNo" value="${prodVO.prodNo}" />
		
		<input type="hidden" name="purchaseProd.prodNo" value="${prodVO.prodNo}" />
		<input type="hidden" name="buyer.userId" value="${user.userId}" />
		<input type="hidden" name="tranCode" value="2"/> --%>
		<!-- <input type="hidden" name="cancelCode" value="0"/> -->
		
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">후원할 금액</label>
		    <div class="col-sm-2">
		      <div Class="k"><input type="text" id="price" name="purchaseProd.price" class="form-control" value="0"/></div>
		     
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">사용할 마일리지</label>
		    <div class="col-sm-2 ea">
		      <input type="text" value="0" id="sEA" name="sEA" class="form-control" onkeypress="javascript:if(event.keyCode==13){test();}"/> /현재마일리지 :3000
		      
		    </div>
		    
		  </div>
		  		 		  
		   		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">결제방법</label>
		    <div class="col-sm-2">
		      
		      <select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
						<option value="1" selected="selected">카카오Pay</option>
						<option value="2">네이버 Pay</option>
			</select>
		    </div>
		    
		  </div>
		 
		  </div>
		 
		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="center">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								<!-- <a href="javascript:fncAddPurchase();">구매</a> -->
								후원금결제
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								<!-- <a href="javascript:history.go(-1)">취소</a> -->
								취소
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		 
		</div>
	</form>
	
	</body>
</html>