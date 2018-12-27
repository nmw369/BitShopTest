

<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE>
<html>
	<head>
	<!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>���Ż���ȸ</title>
		
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
		
		
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		 $(function() {
			 
			//==> �˻� Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
			 $( "td.ct_btn01:contains('Ȯ��')" ).on("click" , function() {
				 history.go(-1);
				});
			 $( "td.ct_btn01:contains('�������')" ).on("click" , function() {
				 self.location="/purchase/cancel?tranNo="+"${pur.tranNo}"+"&cancelCode="+"${pur.cancelCode}";
						
			});
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
				 self.location="/purchase/updatePurchaseView?tranNo="+"${pur.tranNo}";
						
			});
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
				 history.go(-1);
			});
			
		 });
		
	</script>
		
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="../layout/menubar.jsp"/>
		<div class="container" >
	
		<div class="page-header" >

	      <h3 class=" text-info" align="center">��ǰ����ȸ</h3>
	      <h5 class="text-muted" align="center">�����Ͻ� <strong class="text-danger">��ǰ�� ����</strong>�� ������ �����ϴ�.</h5>
	      </div>
		
		<div class="row" >
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${pur.purchaseProd.prodNo}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${pur.buyer.userId}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">${pur.paymentOption=="1"? "���ݱ���" : "�ſ뱸��"}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ż���</strong></div>
			<div class="col-xs-8 col-md-4">${pur.sEA}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ű���</strong></div>
			<div class="col-xs-8 col-md-4">${pur.purchaseProd.price*pur.sEA}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${pur.buyer.userName}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${pur.receiverPhone}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyAddr}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyRequest}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${pur.divyDate}</div>
		</div>
		<hr/>			
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ֹ���</strong></div>
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
								<!-- <a href="javascript:history.go(-1);">Ȯ��</a> -->
								Ȯ��
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
							<%-- <a href="/purchase/cancel?tranNo=${pur.tranNo}&cancelCode=${pur.cancelCode}">�������</a> --%>
							�������
						</td>
						<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
						<td width="30"></td>
							
						<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<%-- <a href="/purchase/updatePurchaseView?tranNo=${pur.tranNo}">����</a> --%>
								����
							</td>
							
							
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">����</a> -->
							����
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
								<%-- <a href="/purchase/updatePurchaseView?tranNo=${pur.tranNo}">����</a> --%>
								����
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
								<!-- <a href="javascript:history.go(-1);">Ȯ��</a> -->
								Ȯ��
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
