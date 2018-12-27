
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
			
			
			/* var price = $("option").val(); */
			var price = '${prodVO.price}'*$("#sEA").val();	
			document.getElementById("price").value = price;
			
			$('.ea').keypress(function(event){
				   //alert(event.which);
				   if (event.which && (event.which  > 47 && event.which  < 58 || event.which == 8)) {
				     //alert('숫자임!');
				   } else {
				     //alert('숫자아님!');
				     event.preventDefault();
				   }
				});
		
			
			
			$( '.ea' ).on("keyup" , function() {
				//Debug..
				var price = '${prodVO.price}'*$("#sEA").val();	
				document.getElementById("price").value = price;	
			});
			
			$("td.ct_btn01:contains('취소')").on("click",function(){
				history.go(-1);
			});
			
			$("td.ct_btn01:contains('구매')").on("click",function(){
				alert("결제를위한 페이지로 이동합니다.");
				document.getElementById('frm').submit();
			/* fncAddPurchase(); */
			});
								
		});
		
		 
		 
		 
		 
		 
				
		</script>
	</head>
	
	<body>
	<jsp:include page="../layout/menubar.jsp"/>
		<!-- <form name="addPurchase" method="post" action="/purchase/addPurchase"> -->
		<form name="addPurchase" method="post" action="/purchase/kakaoPay" id="frm">
		
		<div class="container">
	
		<h1 class="bg-primary text-center">구매상세정보</h1>
		
		<input type="hidden" name="prodNo" value="${prodVO.prodNo}" />
		
		<input type="hidden" name="purchaseProd.prodNo" value="${prodVO.prodNo}" />
		<input type="hidden" name="buyer.userId" value="${user.userId}" />
		<input type="hidden" name="tranCode" value="2"/>
		<!-- <input type="hidden" name="cancelCode" value="0"/> -->
		
		
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.prodNo}" readonly="true">
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명 </label>
		    <div class="col-sm-2">
		    <input type="hidden" name="purchaseProd.prodName" value="${prodVO.prodName}">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.prodName}" readonly="true">
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.prodDetail}" readonly="true">
		    <input type="hidden" name="purchaseProd.prodDetail" value="${prodVO.prodDetail}">
		    </div>
		    
		  </div>
		  
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-2">
		      <input type="hidden" name="purchaseProd.manuDate" value="${prodVO.manuDate}">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.manuDate}" readonly="true">
		    </div>
		    
		  </div>
		  
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-2">
		      <div Class="k"><input type="text" id="price" name="purchaseProd.price" class="form-control"/></div>
		      <%-- <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.prodNo}" readonly="true"> --%>
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">수량</label>
		    <div class="col-sm-2 ea">
		      <input type="text" value="1" id="sEA" name="sEA" class="form-control"/> /최대 :${prodVO.nEA}
		      <%-- <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.prodNo}" readonly="true"> --%>
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${prodVO.regDate}" readonly="true">
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${user.userId}" readonly="true">
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-2">
		      
		      <select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
			</select>
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" name="receiverName" value="${user.userName}">
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-2">
		        <input 	type="text" name="receiverPhone" value="${user.phone}" class="form-control"/>
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-2">
		      
		      <input 	type="text" name="divyAddr" class="form-control" value="${user.addr}" />
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-2">
		      <input type="text" name="divyRequest" class="form-control"/>
		      
		    </div>
		    
		  </div>
		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-2">
		      <input 	type="text" readonly="readonly" name="divyDate" class="form-control" />
		    	<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
		      		      
		    </div>
		    
		  </div>
		 
		<%--   
		
		<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="300" class="ct_write">
					상품번호 
					<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01" width="299">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">
								${prodVO.prodNo}
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6">
				</td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					상품명 
					<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
				<input type="hidden" name="purchaseProd.prodName" value="${prodVO.prodName}">
					${prodVO.prodName}
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					상품상세정보 
					<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
				<input type="hidden" name="purchaseProd.prodDetail" value="${prodVO.prodDetail}">
					${prodVO.prodDetail}
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					제조일자
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
				<input type="hidden" name="purchaseProd.manuDate" value="${prodVO.manuDate}">
					${prodVO.manuDate}
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6">
				</td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					가격
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					<div Class="k"><input type="text" id="price" name="purchaseProd.price"/></div>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td width="104" class="ct_write">
					수량
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
				<div Class="ea">
				<input type="text" value="1" id="sEA" name="sEA" /> /최대 :${prodVO.nEA}
				</div> 
				
					<select name="sEA" class="ct_input_g" style="width:80px" id="abc">
						<c:forEach var="i" begin="1" end="${prodVO.nEA}">
							<div class="n"><option id="sr" value="${i}">${i}</option></div>
							<c:set var="i" value="${i+1}"></c:set>
						</c:forEach> 
					</select>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td width="104" class="ct_write">
					등록일자
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					${prodVO.regDate}
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매자아이디
					<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					${user.userId}
				</td>
				
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6">
				</td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매방법
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매자이름
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					<input type="text" name="receiverName" 	class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6">
				</td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매자연락처
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					<input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					구매자주소
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td class="ct_write01">
					<input 	type="text" name="divyAddr" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" 	value="${user.addr}" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6">
				</td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매요청사항</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<input type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					배송희망일자
				</td>
				<td bgcolor="D6D6D6" width="1">
				</td>
				<td width="200" class="ct_write01">
					<input 	type="text" readonly="readonly" name="divyDate" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20"/>
					<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table> --%>
		
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
								구매
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