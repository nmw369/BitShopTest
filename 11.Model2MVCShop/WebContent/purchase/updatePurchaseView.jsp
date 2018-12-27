<%@page import="com.model2.mvc.service.domain.Purchase"%>
<%@ page contentType="text/html; charset=euc-kr"%>




<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		
		
		<title>구매정보 수정</title>
		
		<script type="text/javascript" src="../javascript/calendar.js">
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
		
		<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	$(function() {
		 
	
		 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
	
			document.getElementById('abc').submit();
		 
		});
		
	
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
	
				self.location ="/user/getUser?userId="+$(this).text().trim();
		});
	
		$( "td.ct_btn01:contains('취소')" ).on("click" , function() {
			
			history.go(-1);
		 
		});
		
		
	});	

	</script>
	</head>

	<body bgcolor="#ffffff" text="#000000">
<jsp:include page="../layout/menubar.jsp"/>
	<%-- <form name="updatePurchase" method="post"	action="/purchase/updatePurchase?tranNo=${purchaseVO.tranNo}" id="abc"> --%>
	
	<div class="container">
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
	    </div>
						
	<form class="form-horizontal">
	<div class="form-group">
		    <label for="buyer.userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${purchaseVO.buyer.userId}" readonly>
		      <input type="hidden" name="buyer.userId" value="${purchaseVO.buyer.userId}">
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">아이디는 수정불가</strong>
		      </span>
		    </div>
		  </div>
		
		
		<div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		      <select 	name="paymentOption" 	class="ct_input_g" style="width: 100px; height: 19px" 
								maxLength="20">
					<option value="1" selected="selected">현금구매</option>
					<option value="2">신용구매</option>
				</select>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input 	type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" 
								maxLength="20" value="${purchaseVO.buyer.userName}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		      <input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" 
								maxLength="20" value="${purchaseVO.receiverPhone}" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input 	type="text" name="divyAddr" class="ct_input_g" style="width: 100px; height: 19px" 
								maxLength="20" value="${purchaseVO.divyAddr}" />
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input 	type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
								maxLength="20" value="${purchaseVO.divyRequest}" />
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="readonly" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${purchaseVO.divyDate}"/>
					<img 	src="../images/ct_icon_date.gif" width="15" height="15"	
								onclick="show_calendar('document.updatePurchase.divyDate', document.updatePurchase.divyDate.value)"/>
		    </div>
		  </div>
		
		
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						<!-- <input type="submit" value="수정"/> -->
						수정
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
	</form>
	</div>
	</body>
</html>