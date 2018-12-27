<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%
	Product product = (Product)request.getAttribute("product");
	String menu = request.getParameter("menu");
	
	System.out.println("getProduct JSP 까지 넘어온 menu 출력확인: "+menu);
	System.out.println("getProduct JSP 시작지점에서 Product product 출력확인: "+product);
	
	Purchase pu = new PurchaseServiceImpl().getPurchase2(product.getProdNo());
	//System.out.println(pu.getTranNo()+"::getProduct에서 받아온 tranNo");
	
%> --%>


<html>
<head>
<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>상품정보조회</title>


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

<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script type="text/javascript">
		
		//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('이전')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
				history.go(-1);
			});
			
			 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					self.location = "/user/updateUser?userId=${user.userId}"
				});
			 
			 $( "td.ct_btn01:contains('후원하기')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					/* self.location = "/purchase/addPurchaseView?prodNo=${product.prodNo}" */
				 popWin 
	    			= window.open("/withdog/dogPurchase.jsp","popWin", "left=300,width=500,height=300,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");		
				});
			 $( "td.ct_btn01:contains('상품정보수정')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
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
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>펀딩제목 : <꽃개 프로젝트> </strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>펀딩번호 : 1007</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>펀딩요청기관 : [위드스튜디오]</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>펀딩기간 : 2018-6-19 ~ 2018-07-19</strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>현재누적금액 : 800,000 </strong></div><br/>
	  		<br/><br/>
	  		<div class="col-xs-4 col-md-4" style="right:-60px"><strong>후원자수 : 104명 </strong></div><br/>
	  		
	  		
			<!-- 펀딩 제목, 펀딩이미지, 펀딩번호, 펀딩설명,펀딩 요청 기관, 펀딩 기간, 누적금액 -->
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>펀딩 설명</strong></div><br/>
			<위드스튜디오입니다>
			위드스튜디오는 우리가 관심을 가져야 할 문제들을 제품디자인으로 풀어나가고, 
			그 제품을 판매한 수익금의 일부는 반드시 소외계층과 약자에게 되돌려주는 프로젝트를 하는 1인 스튜디오입니다.
			<꽃개 프로젝트>가 무엇인가요?
			이 세상에서 가장 약자는 인간으로 인해 고통받는 동물들이라 생각합니다. 
			사람은 말을 할수있고 의지를 표현할 수 있기에 저항할 수 있지만 동물들은 말을 할수도, 
			제대로 저항할 수도 없으니까요. 매일 인간들의 이기심으로 길거리로 버려지는 유기견들, 
			한번 버림받은 아픔이 있는 아이들이지만 '길'에 떠도는 이 유기견들은 각종 위험에도 일순위로 노출되기 십상입니다.
			비록 '길'에 버려졌지만 그 다음은 꽃길을 걷는 '꽃개'가 되자는 의미에서 지어지는 프로젝트 이름 <꽃개 프로젝트>, 
			길에 버려진 유기견들이 센터에 구조된 이후에 제대로 치료를 받을 수 있고 제대로된 사료를 먹을 수 있도록 도와주세요.
			대표적 꽃개, 하양이와 누렁이를 소개합니다!
			꽃길을 이미 걷고있으며 <꽃개 프로젝트>와 후원자님들을 이어줄 하양이와 누렁이입니다. 
			하트모양의 깜찍한 코와, 꽃길을 걷다 주운 꽃으로 만든 머리장식을 하고있는 것이 특징이에요. 
			평소엔 무표정한 얼굴을 하고있지만 사랑을 주면 누구보다도 행복해하는 아이들이랍니다.
			후원금은 어떻게 쓰이나요?
			후원금의 대부분은 굿즈제작비로 쓰입니다. 또한 굿즈의 제작비, 배송료 및 수수료를 제외한 순수익금 중 20%는 유기견 보호센터에 즉시 기부를, 
			나머지는 다음 후원활동을 위한 자본금으로 사용됩니다. 			

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
          <h4 class="modal-title">후원하기</h4>
        </div>
        <div class="modal-body">
        <div class="container">
           <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">후원할 금액</label>
		    <div class="col-sm-2">
		      <div Class="k"><input type="text" id="price" name="purchaseProd.price" class="form-control" value="0"/></div>
		     
		    </div>
		    <br/>
		    
		    <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">사용할 마일리지</label>
		    <div class="col-sm-2 ea">
		      <input type="text" value="0" id="sEA" name="sEA" class="form-control" onkeypress="javascript:if(event.keyCode==13){test();}"/> /현재마일리지 :3000
		      
		    </div>
		    </div>
		    <br/>
		    	   		  
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
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">후원금결제</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
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
							<%-- <a href="/purchase/addPurchaseView?prodNo=${product.prodNo}">구매</a> --%>
							후원하기
						</td>
						<td width="14" height="23">
							<img src="../images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="../images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="../images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="javascript:history.go(-1);">이전</a> -->
							이전
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