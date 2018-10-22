<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>나의 예약내역</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<!-- 민우 -->	  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

$( function() {
    $("input[name=searchStartDay]").datepicker({
    	
    	dateFormat: 'yy-mm-dd'
    });
    $("input[name=searchEndDay]").datepicker({
    	dateFormat: 'yy-mm-dd'
    });
  } );

function fncGetList(currentPage) {
// 	document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
//    	document.detailForm.submit();		
	$("form").attr("method" , "POST").attr("action" , "/ash/getAshReservationAdminList").submit();
}

$(function () {
	$("#searchButtonByDate").on("click",function () {
		$("input[name=sorting]").val('0');
		fncGetList(1);
	})	
});

$(function () {
	$("#searchButtonByKeyword").on("click",function () {
		console.log("검색")
		fncGetList(1);
	})	
});

$(function () {
	$("form").keydown(function (key) {				
		if(key.keyCode ==13){
			fncGetList(1);
	}
	});			
});

// function fncGetList(currentPage) {
//  	$("#currentPage").val(currentPage)
// 	$("form").attr("method","POST").attr("action","/common/getMyPointList").submit();
// }

$(function () {
	$("a:contains('1개월')").on("click", function () {
		$("input[name=searchStartDay]").val('');
		$("input[name=searchEndDay]").val('');
		$("input[name=sorting]").val('1');
		fncGetList(1)
	})
	$("a:contains('3개월')").on("click", function () {
		$("input[name=searchStartDay]").val('');
		$("input[name=searchEndDay]").val('');
		$("input[name=sorting]").val('2');
		fncGetList(1)
	})
	$("a:contains('6개월')").on("click", function () {
		$("input[name=searchStartDay]").val('');
		$("input[name=searchEndDay]").val('');
		$("input[name=sorting]").val('3');
		fncGetList(1)
	})
	$("a:contains('전체보기')").on("click", function () {
		$("input[name=searchStartDay]").val('');
		$("input[name=searchEndDay]").val('');
		$("input[name=searchKeyword]").val('');
		$("select[name=searchCondition]").val(0).prop("selected", true);
		$("input[name=sorting]").val('4');
		fncGetList(1)
	})
})

</script>

<style type="text/css">
table th, td{text-align:center; font-size:13px;}
table td{font-size:12px;}
</style>

<!--디자인  -->
<style type="text/css">
#pDiv{
	position: relative;
	
}

#cDiv1{
	position: absolute;
	top:10px;
	left:1px;
}

#cDiv2{
	position: absolute;
	top:0px;
	left:81px;
	max-width: 120px;

}

#cDiv3{
	position: absolute;
	top:0px;
	left:216px;
	max-width: 115px;
}


#cDiv4{
	position: absolute;
	top:0px;
	left:340px;

}
.pull-right{
	margin-top: 20px;
	position: absolute;
	top:40px;
	left:340px;
}

.border-gray2{
	height: 220px;
}

#cDiv5{
 position: relative;
 top:10px;
 left:70px;
}

#cDiv6{
 position: absolute;
 top:0px;
 left : 155px;
 width :120px !important;
 max-width :120px !important;
 padding: 8px 0px 8px 0px;
 border-radius: 5px;

}

#searchKeyword{
 position: absolute;
 top:0px;
 left:285px;
 width :115px !important;
 max-width :115px !important;
}

#searchButtonByKeyword{
 position: absolute;
 top:0px;
 left:410px;
 display: block;
 width: 45px;

}

#m{
	position: absolute;
	top:8px;
	left:202px;

}

</style>

<!--end 디자인  -->

</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />

	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/305_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/admin_tit.png">
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
				<jsp:include page="/layout/admin-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
			
			
			<!-- content -->
			<div class="col-md-9 col-sm-9 col-xs-12">
			
				<h1 align="center">회원예약내역</h1>
				
				<!-- search -->
				<div class="border-gray2 margin-two padding-two col-md-12 col-sm-10 col-xs-12">
				
					<div class="padding-two border-bottom col-md-11 col-xs-11 center-col text-center margin-two-bottom">
						<label class="text-small"><span class="magenta-text">모든 회원들</span>의 예약내역입니다. 지난 예약확인을 원하시면 조회조건을 선택해주세요.</label>
					</div>
					
					<form>
					
					<div class="col-md-12 col-xs-12" id="pDiv">
						<div class="col-md-6 col-xs-12">
							<label class="text-small">기간별 조회</label>
							<a style="cursor: pointer" class="highlight-button-navy1">1개월</a>
							<a style="cursor: pointer" class="highlight-button-navy1">3개월</a>
							<a style="cursor: pointer" class="highlight-button-navy1">6개월</a>
							<a style="cursor: pointer" class="highlight-button-navy1">전체보기</a>
						</div>
						
						<div class="col-md-6 col-xs-12">
								<label class="text-small f-left" id="cDiv1">일자별 조회&nbsp;</label>
								<div id="cDiv2">
						            <input type="text" name="searchStartDay" value="${!empty search.searchStartDay?search.searchStartDay:''}" placeholder="startDate" class="input-round big-input" style="padding:8px 12px 9px;"/>
						        </div>
						        <div id="m">~</div>
						        <div id="cDiv3">
						            <input type="text"  name="searchEndDay" value="${!empty search.searchEndDay?search.searchEndDay:''}" placeholder="lastDate" class="input-round big-input" style="padding:8px 12px 9px;"/>
						        </div>
						        <div id="cDiv4"><a id="searchButtonByDate" style="cursor: pointer" class="highlight-button-navy1">조회</a></div>
				        </div>
				        
				        <input type="hidden" id="currentPage" name="currentPage" value="" />
				        <input type="hidden" id="sorting" name="sorting" value="0"/>

				        <div class="pull-right">
				        <label class="text-small f-left" id="cDiv5">조건별 조회&nbsp;</label>
					        <select name = searchCondition id="cDiv6">
							  	<option value="0" ${search.searchCondition==0?'selected':'' }>유저ID</option>
							  	<option value="1" ${search.searchCondition==1?'selected':'' }>예약번호</option>
							  	<option value="2" ${search.searchCondition==2?'selected':'' }>치유견이름</option>
						  </select>
						  
					  	  	<input type="text" id="searchKeyword" name="searchKeyword" value="${!empty search.searchKeyword?search.searchKeyword:''}" class="input-round big-input" style="padding:8px 12px 9px;"/>
					       
					        <a id="searchButtonByKeyword" style="cursor: pointer" class="highlight-button-navy1">검색</a>
				        </div>
				        </form>
			        </div>
			        
		        </div>
		        <!-- end search -->


				<!--  table Start /////////////////////////////////////-->
				<table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>예약번호</th>
                                    <th>회원ID</th>
                                    <th>치유견</th>
                                    <th>예약일</th>
                                    <th>예약상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:set var="i" value="0"/>
								<c:forEach var="list" items="${list}">
								<c:set var="i" value="${i+1}"/>
	                                <tr>
	                                    <td>${i}</td>
	                                    <td>${list.ashReservationNo}</td>
	                                    <td>${list.user.userId}</td>
	                                    <td>${list.healingDog.healingDogName}</td>
	                                    <td>${list.ashReservationDate}  <c:if test="${list.ashReservationTime==0}">오전</c:if><c:if test="${list.ashReservationTime==1}">오후</c:if> </td>
	                                    <td>
		                                    <span class="highlight-box">
                                    			<c:if test="${list.ashReservationCondition==0}">예약완료</c:if>
												<c:if test="${list.ashReservationCondition==1}">출장확정</c:if>
												<c:if test="${list.ashReservationCondition==2}">출장완료</c:if>
												<c:if test="${list.ashReservationCondition==3}">예약취소</c:if>
		                                    </span>
		                                    <a href="/ash/getUserReservationASH?ashReservationNo=${list.ashReservationNo}&userId=${list.user.userId}">(상세보기)</a>
	                                    </td>
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