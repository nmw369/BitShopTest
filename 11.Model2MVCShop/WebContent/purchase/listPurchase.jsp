<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>

<%-- <%
	HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map");
	Search searchVO = (Search) request.getAttribute("Search");
	
	int total = 0;
	int pageNumber = Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
	
	ArrayList<Purchase> list = null;
	if (map != null) {
		total = ((Integer) map.get("count")).intValue();
		list = (ArrayList<Purchase>) map.get("list");
	}
	int currentPage = searchVO.getCurrentPage();
	
	System.out.println(currentPage+"::::LISTPURCHASE 확인!@@!@!!@!@!@@!!@");
	
	int totalPage = 0;
	if (total > 0) {
		totalPage = total / searchVO.getPageSize();
		if (total % searchVO.getPageSize() > 0)
			totalPage += 1;
	}
	
	int start = 1 + ( pageNumber * ((searchVO.getCurrentPage() - 1) / pageNumber) );
	int end = start + pageNumber - 1;
	if(end > totalPage){
		end = totalPage;
	}
	
%> --%>
<html>
	<head>
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<title>구매 이력조회</title>
		
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
		
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			function fncGetList(currentPage) {
				document.getElementById("currentPage").value = currentPage;
				document.detailForm.submit();
				
				
			}
			
			$(function(){
				
				$(".ct_list_pop td:nth-child(5)").on("click",function(){
					
					self.location="/user/getUser?userId="+"${vo.buyer.userId}"+"&menu=search&cancel=yes";
				});
				
				$(".ct_list_pop td:nth-child(3)").on("click",function(){
					
					var index = $($(".ct_list_pop td:nth-child(3)")).index(this);
					var prodNo = $($("input[name=prodNo]")[index]).val();
					
					self.location="/product/getProduct?prodNo="+prodNo+"&menu=search&cancel=yes";
				});
				
				/* $(".ct_list_test1 td:contain('허가')").on("click",function(){
					
					self.location="/user/getUser?userId="+"${vo.buyer.userId}"+"&menu=search&cancel=yes";
				}); */
			});
		</script>
	</head>
	<style>

/* body{
    background: url("/images/clock2.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
} */
</style>
	<!-- ---------------------tooltip========================== -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  <style>
  .photo {
    width: 300px;
    text-align: center;
  }
  .photo .ui-widget-header {
    margin: 1em 0;
  }
  .map {
    width: 350px;
    height: 350px;
  }
  .ui-tooltip {
    max-width: 350px;
  }
  </style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( document ).tooltip({
      items: "img, [data-geo], [title]",
      content: function() {
        var element = $( this );
        if ( element.is( "[data-geo]" ) ) {
        
        	var index = $($(".num")).index(this);
        	console.log(index)
        	var text = $($("input[name=filename]")[index]).val();
        	console.log(text);
          
          return "<img class='map' src='/images/uploadFiles/"+text+"'>";
        }
        if ( element.is( "[title]" ) ) {
          return element.attr( "title" );
        }
        if ( element.is( "img" ) ) {
          return element.attr( "alt" );
        }
      }
    });
  } );
  </script>	
	
	
	
	<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="../layout/menubar.jsp"/>
		<div class="container">
		<div style="width: 98%; margin-left: 10px;">
		
		<!-- <form name="detailForm" action="/purchase/listPurchase" method="post"> -->
		
			<div class="page-header text-info">
							<h3>구매이력조회</h3>
					</div>
		
		<div class="col-md-6 text-left">
		    	<p class="text-primary">
			전체 ${resultPage.totalCount} 건, 현재 ${resultPage.currentPage } 페이지
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
				<!-- <td class="ct_list_b" width="100">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="100">상품이미지</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">구매상품정보</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">상품가격</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">구매수량</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">구매정보확인/수정</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">상품현황</td> -->
				
				<th class="text-center">No</th>
				<th class="text-center">상품이미지</th>
				<th class="text-center">구매상품정보</th>
				<th class="text-center">상품가격</th>
				<th class="text-center">구매수량</th>
				<th class="text-center">구매정보확인/수정</th>
				<th class="text-center">상품현황</th>
				
				</tr>
			</thead>
							
							<c:set var="i" value="${currentPage}"></c:set>
														
							
							<c:forEach var="vo" items="${list}">
							
								<c:set var="i" value="${i+1}"></c:set>
							<tr class="ct_list_pop" bgcolor="#ffffff">
								
								<td class="ct_list_test1" align="center">
									<a href="/purchase/getPurchase?tranNo=${vo.tranNo}">
										${i}
									</a>
									
								</td>
								
								<td align="center">
								<c:if test="${!empty vo.purchaseProd.fileName}">
								<%-- <img src = "/images/uploadFiles/${vo.purchaseProd.fileName}" width = "150"> --%>
								<a href="#" data-geo="" class="num">마우스를 올려주세요</a>
								<input type="hidden" name="filename" value="${vo.purchaseProd.fileName}">
								</c:if>
								<c:if test="${empty vo.purchaseProd.fileName}">
								<!-- <img src = "/images/uploadFiles/notimage.gif" width = "150"> -->
								<a href="#" data-geo="" class="num">마우스를 올려주세요</a>
								<input type="hidden" name="filename" value="${vo.purchaseProd.fileName}">
								</c:if>
								
								
								<td class="ct_list_test1" align="left">
									<%-- <a	href="/product/getProduct?prodNo=${vo.purchaseProd.prodNo}&menu=search&cancel=yes"> --%>
										${vo.purchaseProd.prodName}
									</a>
								</td>
								
								
								<td class="ct_list_test1" align="left">${vo.purchaseProd.price*vo.sEA}</td>
								
								
								<td class="ct_list_test1" align="left">${vo.sEA}</td>
								
								
								<td class="ct_list_test1" align="left">
								<a href="/purchase/getPurchase?tranNo=${vo.tranNo}">
										구매정보</a>
								</td>
								
								
									
								<c:if test="${vo.tranCode=='2'&& vo.cancelCode=='0'}">
									
									<td class="ct_list_test1" align="left">결제완료/배송대기중</td>
																	
								</c:if>
								<c:if test="${vo.tranCode=='3' && vo.cancelCode=='0' }">
									<td class="ct_list_test1" align="left">배송중 ::
									<a href="/purchase/updateTranCodeByProd?tranNo=${vo.tranNo}&tranCode=${vo.tranCode}">물건도착</a></td>
								</c:if>
								<c:if test="${vo.tranCode=='4' && vo.cancelCode=='0'}">
									<td class="ct_list_test1" align="left">배송완료</td>
								</c:if>
								<c:if test="${vo.cancelCode=='1'}">
									<td class="ct_list_test1" align="left">구매취소가 진행중입니다.</td>
								</c:if>
								<c:if test="${vo.cancelCode=='2'}">
									<td class="ct_list_test1" align="left">구매취소가 완료되었습니다.</td>
								</c:if>
								<c:if test="${vo.cancelCode=='3'}">
									<td class="ct_list_test1" align="left">구매가 거부되었습니다.</td>
								</c:if>
								
								
								
								
							</tr>
							
							</c:forEach>
							
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td align="center">
			
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
				 
				 <jsp:include page="../common/pageNavigator.jsp"/>
				 
				 
				</td>
			</tr>
		</table>
		
		<!--  페이지 Navigator 끝 -->
		<!-- </form> -->
		</form>
		</div>
		</div>
	</body>
</html>