<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%
	Product product = (Product)request.getAttribute("product");
	String menu = request.getParameter("menu");
	
	System.out.println("getProduct JSP ���� �Ѿ�� menu ���Ȯ��: "+menu);
	System.out.println("getProduct JSP ������������ Product product ���Ȯ��: "+product);
	
	Purchase pu = new PurchaseServiceImpl().getPurchase2(product.getProdNo());
	//System.out.println(pu.getTranNo()+"::getProduct���� �޾ƿ� tranNo");
	
%> --%>


<html>
<head>
<!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>��ǰ������ȸ</title>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
	
	<style>
		body{
			padding-top : 70px;
		 /* background: url("..../images/uploadFiles/back.png") no-repeat center center fixed; */ 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    
		}
	</style>


<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script type="text/javascript">
		
		//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
				history.go(-1);
			});
			
			 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					self.location = "/user/updateUser?userId=${user.userId}"
				});
			 
			 $( "td.ct_btn01:contains('�Ŀ��ϱ�')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					/* self.location = "/purchase/addPurchaseView?prodNo=${product.prodNo}" */
				 popWin 
	    			= window.open("/withdog/dogPurchase.jsp","popWin", "left=300,width=500,height=300,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");		
				});
			 $( "td.ct_btn01:contains('��ǰ��������')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					self.location = "/product/updateProductView?prodNo=${product.prodNo}"
				});
			 		 
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="../layout/menubar2.jsp"/>

<div>

</div>
<div class="container" >
	
	 
		<div class="row" >
		<div class="col-xs-4 col-md-2">
		<img src="../images/uploadFiles/flower.jpg" width="300px" height="300">
		</div>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>�ݵ����� : <�ɰ� ������Ʈ> </strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>�ݵ���ȣ : 1007</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>�ݵ���û��� : [���彺Ʃ���]</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>�ݵ��Ⱓ : 2018-6-19 ~ 2018-07-19</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>���紩���ݾ� : 800,000 </strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>�Ŀ��ڼ� : 104�� </strong></div><br/>
	  		
	  		
			<!-- �ݵ� ����, �ݵ��̹���, �ݵ���ȣ, �ݵ�����,�ݵ� ��û ���, �ݵ� �Ⱓ, �����ݾ� -->
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ݵ� ����</strong></div><br/>
			<���彺Ʃ����Դϴ�>
			���彺Ʃ����� �츮�� ������ ������ �� �������� ��ǰ���������� Ǯ�����, 
			�� ��ǰ�� �Ǹ��� ���ͱ��� �Ϻδ� �ݵ�� �ҿܰ����� ���ڿ��� �ǵ����ִ� ������Ʈ�� �ϴ� 1�� ��Ʃ����Դϴ�.
			<�ɰ� ������Ʈ>�� �����ΰ���?
			�� ���󿡼� ���� ���ڴ� �ΰ����� ���� ����޴� �������̶� �����մϴ�. 
			����� ���� �Ҽ��ְ� ������ ǥ���� �� �ֱ⿡ ������ �� ������ �������� ���� �Ҽ���, 
			����� ������ ���� �����ϱ��. ���� �ΰ����� �̱������ ��Ÿ��� �������� ����ߵ�, 
			�ѹ� �������� ������ �ִ� ���̵������� '��'�� ������ �� ����ߵ��� ���� ���迡�� �ϼ����� ����Ǳ� �ʻ��Դϴ�.
			��� '��'�� ���������� �� ������ �ɱ��� �ȴ� '�ɰ�'�� ���ڴ� �ǹ̿��� �������� ������Ʈ �̸� <�ɰ� ������Ʈ>, 
			�濡 ������ ����ߵ��� ���Ϳ� ������ ���Ŀ� ����� ġ�Ḧ ���� �� �ְ� ����ε� ��Ḧ ���� �� �ֵ��� �����ּ���.
			��ǥ�� �ɰ�, �Ͼ��̿� �����̸� �Ұ��մϴ�!
			�ɱ��� �̹� �Ȱ������� <�ɰ� ������Ʈ>�� �Ŀ��ڴԵ��� �̾��� �Ͼ��̿� �������Դϴ�. 
			��Ʈ����� ������ �ڿ�, �ɱ��� �ȴ� �ֿ� ������ ���� �Ӹ������ �ϰ��ִ� ���� Ư¡�̿���. 
			��ҿ� ��ǥ���� ���� �ϰ������� ����� �ָ� �������ٵ� �ູ���ϴ� ���̵��̶��ϴ�.
			�Ŀ����� ��� ���̳���?
			�Ŀ����� ��κ��� �������ۺ�� ���Դϴ�. ���� ������ ���ۺ�, ��۷� �� �����Ḧ ������ �����ͱ� �� 20%�� ����� ��ȣ���Ϳ� ��� ��θ�, 
			�������� ���� �Ŀ�Ȱ���� ���� �ں������� ���˴ϴ�. 			

		</div>
		
	
	<hr/>
	
	<div class="container">
  
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">�Ŀ��ϱ�</h4>
        </div>
        <div class="modal-body">
        <div class="container">
           <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�Ŀ��� �ݾ�</label>
		    <div class="col-sm-2">
		      <div Class="k"><input type="text" id="price" name="purchaseProd.price" class="form-control" value="0"/></div>
		     
		    </div>
		    <br/>
		    
		    <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">����� ���ϸ���</label>
		    <div class="col-sm-2 ea">
		      <input type="text" value="0" id="sEA" name="sEA" class="form-control" onkeypress="javascript:if(event.keyCode==13){test();}"/> /���縶�ϸ��� :3000
		      
		    </div>
		    </div>
		    <br/>
		    	   		  
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-2">
		      
		      <select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
						<option value="1" selected="selected">īī��Pay</option>
						<option value="2">���̹� Pay</option>
			</select>
		    </div>
		    
		  </div>
		   </div> 
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">�Ŀ��ݰ���</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">���</button>
        </div>
      </div>
      
    </div>
  </div>
  
</div>

	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
					
					
						<td width="17" height="23">
							<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;"  data-toggle="modal" data-target="#myModal">
							<%-- <a href="/purchase/addPurchaseView?prodNo=${product.prodNo}">����</a> --%>
							�Ŀ��ϱ�
						</td>
						<td width="14" height="23">
							<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">����</a> -->
							����
						</td>
						<td width="14" height="23">
							<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
					
				
						
					</tr>
				</table>
			</td>
		</tr>
	</table>


</div>
</body>
</html>