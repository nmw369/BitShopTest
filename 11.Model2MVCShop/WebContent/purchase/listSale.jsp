<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>

<html>
	<head>
	
	<!-- 화면 변경 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<title>판매된 상품관리</title>
		
		<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	
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
				
				$(".ct_list_pop td:nth-child(7)").on("click",function(){
					
					var index = $($(".ct_list_pop td:nth-child(7)")).index(this);
					
					var prodNo = $($("input[name=prodNo]")[index]).val();
					self.location="/product/getProduct?prodNo="+prodNo+"&menu=search&cancel=yes";
				});
				
				$("").on("click",function(){
					
					var index = $($(".ct_list_pop td:nth-child(13)")).index(this);
					var tranNo = $($("input[name=tranNo]")[index]).val();
					self.location = "/purchase/getPurchase?tranNo="+tranNo;
				});
				
							
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
</head>
<body>
	<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="../layout/menubar.jsp"/>
	<div class="container">
		<div style="width: 98%; margin-left: 10px;">
		
		
		 
					
					<div class="page-header text-info">
							<h3>판매된 상품관리</h3>
					</div>	
			
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
			전체 ${resultPage.totalCount} 건, 현재 ${resultPage.currentPage } 페이지
			</p>
		    </div>
		    
		     <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>구매자ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="tags" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value="1"/>
				  <input type="hidden" id="currentPage" name="cancelCode" value="0"/>
				  
				</form>
	    	</div>
	   
	   <form name="detailForm" action="/purchase/listSale" method="post">
	   	
		<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;"> -->
		<table class="table table-hover table-striped" >
		<thead>	
			<tr>
				<!-- <td class="ct_list_b" width="100">판매번호</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="100">구매자Id</td>
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
				
				<th class="text-center">판매번호</th>
				<th class="text-center">구매자Id</th>
				<th class="text-center">상품이미지</th>
				<th class="text-center">상품명ㄴ</th>
				<th class="text-center">상품가격</th>
				<th class="text-center">구매수량</th>
				<th class="text-center">상품정보확인/수정</th>
				<th class="text-center">상품현황</th>
				
			</tr>
			</thead>
			
			<tbody>	
				<c:set var="i" value="${currentPage}"></c:set>
				<%-- <c:set var="j" value="${pageSize}"></c:set>
				<c:set var="k" value="2"></c:set>
				 --%>
				
				<c:forEach var="vo" items="${list}">
					<c:if test="${vo.cancelCode == '0'}">					
						<%-- <c:set var="i" value="${i*j-k}"></c:set> --%>
						<c:set var="i" value="${i+1}"></c:set>
					<tr>
						
						<td align="center">
								${vo.tranNo}
						</td>
						
						
						<td align="left">
							<a	href="/user/getUser?userId=${vo.buyer.userId}">
								${vo.buyer.userId}
							</a>
						</td>
												
						<td align="center">
						<c:if test="${!empty vo.purchaseProd.fileName}">
						<a href="#" data-geo="" class="num">마우스를 올려주세요</a>
						<input type="hidden" name="filename" value="${vo.purchaseProd.fileName}">
						</c:if>
						<c:if test="${empty vo.purchaseProd.fileName}">
						<a href="#" data-geo="" class="num">마우스를 올려주세요</a>
						<input type="hidden" name="filename" value="notimage.gif">
						</c:if>
								
						<td align="left">
							<%-- <a	href="/product/getProduct?prodNo=${vo.purchaseProd.prodNo}&menu=search&cancel=yes"> --%>
							<input type="hidden" name="prodNo" value="${vo.purchaseProd.prodNo}"/> 
								${vo.purchaseProd.prodName}
							</a>
						</td>
												
						<td align="left">${vo.purchaseProd.price}</td>
						
						
						<td align="left">${vo.sEA}</td>
						
						
						<td align="left">
						<a href="/purchase/getPurchase?tranNo=${vo.tranNo}">상품정보</a>
						<%-- <input type="hidden" name="tranNo" value="${vo.tranNo}">
						구매정보 --%>
						</td>
						
						
						<c:if test="${vo.tranCode=='2'}">
							<td align="left">결제완료  
							<a href="/purchase/updateTranCodeByProd?tranNo=${vo.tranNo}&tranCode=${vo.tranCode}">배송하기</a>
							</td>
						</c:if>
						<c:if test="${vo.tranCode=='3'}">
							<td class="ct_list_test1" align="left">배송중
						</c:if>
						<c:if test="${vo.tranCode=='4'}">
							<td class="ct_list_test1" align="left">배송완료</td>
						</c:if>
						
						
						
						
					</tr>
					
					</c:if>
				</c:forEach>
				</tbody>
		</table>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td align="center">
			
					<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
				 
				 <jsp:include page="../common/pageNavigator.jsp"/>
				 
				 
				</td>
			</tr>
		</table>
		
		<!--  페이지 Navigator 끝 -->
		</form>
		
		</div>
		
	</body>
</html>