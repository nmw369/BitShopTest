<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<!-- 민우 -->	  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
 		
 	if('${sorting}'!=0){
 		if('${sorting}'==1){
 		$("#sorting").val(1)
 		}else{
 			if('${sorting}'==2){
 		 		$("#sorting").val(2)
 		 		}
 		}
 	}else{
 		
 		$("#sorting").val(0)
 	}
	
 	$("form").attr("method","POST").attr("action","/common/getMyPointList").submit();
}
function fncGetPointList(sorting) {
	$("#currentPage").val(1);
	if(sorting==1){
	$("#sorting").val(1)
	$("form").attr("method","POST").attr("action","/common/getMyPointList").submit();
	}else{
	$("#sorting").val(2)
	$("form").attr("method","POST").attr("action","/common/getMyPointList").submit();
	}
}
</script>


</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />

	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/myPage_tit.png">
				</h1>
				<!-- end page title -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->
	
	
	<section class="wow fadeIn">
	<div class="container">
	<div class="row">
		
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/mypage-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
			
			
			<!-- content -->
			<div class="col-md-9 col-sm-9 col-md-offset-1">

				<form>
					<input type="hidden" id="currentPage" name="currentPage" value="" />
					<input type="hidden" id="sorting" name="sorting" value="" />
				</form>

				<h1 align="center">나의포인트내역</h1>
				<hr />
				<div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<h2 align="center" style="display: inline;">
						현재포인트 :
						<div class="counter" style="display: inline;">
						<span class="timer counter-number alt-font" data-to="${currentPoint}" data-speed="1000"></span>
							Point
						</div>
					</h2>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="highlight-button btn-medium button margin-five" id="sorting" onclick="javascript:fncGetPointList(1);">적립포인트</button>
					<button type="button" class="highlight-button btn-medium button margin-five" id="sorting" onclick="javascript:fncGetPointList(2);">사용포인트</button>
					</div>
				<hr />
				
				<!--  table Start /////////////////////////////////////-->
				<table class="table table-hover table-striped">

					<thead>
						<tr>
							<td align="center">날짜</td>
							<td align="center">내역</td>
							<td align="center">포인트</td>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="point" items="${resultList}">
							<tr>
								<td align="center">${point.pointDate}</td>
								<c:if test="${point.pointHistory=='0'}">
									<td align="center">크라우드펀딩후원</td>
								</c:if>
								<c:if test="${point.pointHistory=='1'}">
									<td align="center">동물교감치유예약</td>
								</c:if>
								<c:if test="${point.pointHistory=='2'}">
									<td align="center">스토어상품구매</td>
								</c:if>
								<td align="center">${point.usePoint!=0? "사용포인트 : ":"적립포인트 : "}
									${point.usePoint!=0? point.usePoint : point.point}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
				<!--  table End /////////////////////////////////////-->


				<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
					<!-- pagination -->
					<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
					<!-- end pagination -->
				</div>


			</div>
			<!--  end content -->
			
			</div>
		</div>
	</section>
 	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
 	
</body>

</html>