<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<title>영상상담 내역</title>

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<jsp:include page="../common/css.jsp" />

<script type="text/javascript">

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("#myConsulting").attr("method","POST").attr("action","/ash/getMyConsultingList").submit();
}

$(function(){
	$('a[name="cancelConsulting"]').on('click', function(){
		var index = $('a[name="cancelConsulting"]').index(this);
		var userId = $($('input[name="userId"]')[index]).val();
		var consultingNo = $($('input[name="consultingNoList"]')[index]).val();
		
		//$('#consultingNoModal').val(consultingNo);
		//$('#index').val(index);
		
		swal({
			  title: "영상상담 신청취소",
			  text: "영상상담 신청을 취소하시겠습니까?",
			  //icon: "warning",
			  buttons: true,
			  //dangerMode: true,
			}).then(function(value){
				if(value){
					swal("영상상담 신청을 취소하였습니다.", {
					      icon: "success",
					    });
					
					$.ajax(
							{
								url : "/ash/json/updateConsultingState/"+consultingNo+"/3",
								method : "GET",
								dataType : "json",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status){
									$($('td:nth-child(4)')[index]).text('취소');
									$($('a[name="cancelConsulting"]')[index]).css('display','none');
									$($('a[name="connectConsulting"]')[index]).css('display', 'none');
								}
							}
						); //end of ajax
				}
		});
	});

	$('a[name="connectConsulting"]').on('click', function(){
		var index = $('a[name="connectConsulting"]').index(this);
		var userId = $($('input[name="userId"]')[index]).val();
		var consultingNo = $($('input[name="consultingNoList"]')[index]).val();
		popWin = window.open("https://withdog.herokuapp.com/chat/"+consultingNo+"/"+userId, "popWin", "left=200, top=20, width=1200, height=725, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	});
});


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

			<form id="myConsulting">
			    <input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="consultingNoModal" name="consultingNo" value="" />
				<input type="hidden" name="consultingState" value="3" />
				<input type="hidden" id="index" value=""/>
		    </form>
		    
	      	<h1 align="center">영상상담내역</h1>
	  		<hr/>
	    
		
	      <!--  table Start /////////////////////////////////////-->
	      <table class="table table-hover table-striped" >
	      
	        <thead>
	          <tr>
	            <th class="text-center">신청날짜</th>
	            <th class="text-center">상담사</th>
	            <th class="text-center">치유견</th>
	            <th class="text-center">상태</th>
	            <th class="text-center"></th>
	          </tr>
	        </thead>
	        
	       
			<tbody>
			  <c:forEach var="list" items="${list}">
				<tr>
				  <td align="center" style="white-space: nowrap;">${list.regDate}</td>
				  <td align="center" style="white-space: nowrap;">${list.healingDog.healingDogHealer}</td>
				  <td align="center" style="white-space: nowrap;">${list.healingDog.healingDogName}</td>
				  <td align="center" style="white-space: nowrap;">${list.consultingState=='0'?"대기":list.consultingState=='1'?"진행":list.consultingState=='2'?"완료":"취소"}</td>
				  <td align="center" style="white-space: nowrap;">
				  		<div><a href="#" class="highlight-button-dark popup-with-zoom-anim margin-three-bottom" name="cancelConsulting" style='display: ${list.consultingState=="0"||list.consultingState=="1"?"":"none"};'>상담취소</a></div>
				  		<div><a href="#" class="highlight-button-dark popup-with-zoom-anim" name="connectConsulting" style='display: ${list.consultingState=="1"?"":"none"};'>상담연결</a></div>
				  		<input type="hidden" name="userId" value="${user.userId }"/>
				  		<input type="hidden" name="consultingNoList" value="${list.consultingNo }"/>
			  	  </td>
				 
				</tr>
	          </c:forEach>
	        </tbody>
	      
	      </table>
	      <!-- end table -->

			<!--  table End /////////////////////////////////////-->
			<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp"
				align="center">
				<!-- pagination -->
				<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
				<!-- end pagination -->
			</div>


			<!-- 알림팝업 -->
			<div class="col-md-9 col-sm-9 no-padding margin-five">
		
				<div class="col-lg-3 col-md-4 col-sm-5 center-col text-center">
					<div id="modal-popup" class="zoom-anim-dialog mfp-hide col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main">
			
					<div>
						<span class="black-text">영상상담 신청취소</span>
						<p class="borderline-gray"></p>
					</div>
		
					<!-- <span class="text-small">신청날짜 : </span><br/>
					<span class="text-small">상담사 : </span><br/>
					<span class="text-small">치유견 : </span> -->
					<p class="text-small"><br/>영상상담 신청을 취소하시겠습니까?</p>
					
					<!-- 버튼 -->
					<div class="text-center no-margin-bottom">
						<a href="#" id="okModal"
							class="highlight-button-dark btn btn-medium no-margin popup-modal-dismiss">OK</a>
						<a href="#"
							class="highlight-button btn btn-medium no-margin-bottom popup-modal-dismiss">CANCEL</a>
					</div>
					<!-- end 버튼 -->
		
				</div>
			  </div>
			  
			</div>
		    <!-- end 알림팝업 -->  
		      
		
		</div>
		<!-- end content -->
	
	</div>
	</div>
	</section>
	
	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
	
	
</body>

</html>