<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<title>영상상담 관리</title>

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<jsp:include page="../common/css.jsp" />
	  
  
<script type="text/javascript">

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("#myConsulting").attr("method","POST").attr("action","/ash/getConsultingAdminList").submit();
}

$(function(){
	$('a[name="btnConsulting"]').on('click', function(){
		var index = $('a[name="btnConsulting"]').index(this);	

		var btnConsulting = $($('a[name="btnConsulting"]')[index]).text();
		var regDate = $($('input[name="regDate"]')[index]).val();
		var userId = $($('input[name="userId"]')[index]).val();
		var healingDogHealer = $($('input[name="healingDogHealer"]')[index]).val();
		var healingDogName = $($('input[name="healingDogName"]')[index]).val();
		var consultingNo = $($('input[name="consultingNoList"]')[index]).val();
		
		if(btnConsulting == '상담취소'){
			swal({
				  title: "영상상담 취소",
				  text: "신청일자 : "+regDate+"\n신청자 : "+userId+"\n상담사 : "+healingDogHealer+"\n치유견 : "+healingDogName+"\n\n영상상담 취소 처리하시겠습니까?",
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
										$($('td:nth-child(5)')[index]).text('취소');
										$($('a[name="btnConsulting"]')[index]).css('display','none');
										$($('a[name="startConsulting"]')[index]).css('display','none');
									}
								}
							); //end of ajax
					}
			});
			
		}else{
			swal({
				  title: "영상상담 완료",
				  text: "신청일자 : "+regDate+"\n신청자 : "+userId+"\n상담사 : "+healingDogHealer+"\n치유견 : "+healingDogName+"\n\n영상상담 완료 처리하시겠습니까?",
				  //icon: "warning",
				  buttons: true,
				  //dangerMode: true,
				}).then(function(value){
					if(value){
						swal("영상상담을 완료하였습니다.", {
						      icon: "success",
						    });
						
						$.ajax(
								{
									url : "/ash/json/updateConsultingState/"+consultingNo+"/2",
									method : "GET",
									dataType : "json",
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status){
										$($('td:nth-child(5)')[index]).text('완료');
										$($('a[name="btnConsulting"]')[index]).css('display','none');
										$($('a[name="startConsulting"]')[index]).css('display','none');
									}
								}
							); //end of ajax
					}
			});
		}		
	});
	
	$('a[name="startConsulting"]').on('click', function(){
		var index = $('a[name="startConsulting"]').index(this);

		var startConsulting = $($('a[name="startConsulting"]')[index]).text();
		var regDate = $($('input[name="regDate"]')[index]).val();
		var userId = $($('input[name="userId"]')[index]).val();
		var healingDogHealer = $($('input[name="healingDogHealer"]')[index]).val();
		var healingDogName = $($('input[name="healingDogName"]')[index]).val();
		var consultingNo = $($('input[name="consultingNoList"]')[index]).val();
		
		if(startConsulting == '상담시작'){
			swal({
				  title: "영상상담 시작",
				  text: "신청일자 : "+regDate+"\n신청자 : "+userId+"\n상담사 : "+healingDogHealer+"\n치유견 : "+healingDogName+"\n\n영상상담을 시작하시겠습니까?",
				  //icon: "warning",
				  buttons: true,
				  //dangerMode: true,
				}).then(function(value){
					if(value){
						swal("영상상담을 시작하였습니다.", {
						      icon: "success",
						    });
						
						$.ajax(
								{
									url : "/ash/json/updateConsultingState/"+consultingNo+"/1",
									method : "GET",
									dataType : "json",
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status){
										$($('td:nth-child(5)')[index]).text('진행');
										$($('a[name="btnConsulting"]')[index]).text('상담완료');
										$($('a[name="startConsulting"]')[index]).text('다시연결');
										popWin = window.open("https://withdog.herokuapp.com/chat/"+consultingNo+"/함깨할게", "popWin", "left=200, top=20, width=1200, height=725, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
									}
								}
							); //end of ajax
					}
			});
		}else{
			swal({
				  title: "영상상담 다시연결",
				  text: "신청일자 : "+regDate+"\n신청자 : "+userId+"\n상담사 : "+healingDogHealer+"\n치유견 : "+healingDogName+"\n\n영상상담을 다시연결하시겠습니까?",
				  //icon: "warning",
				  buttons: true,
				  //dangerMode: true,
				}).then(function(value){
					if(value){
						popWin = window.open("https://withdog.herokuapp.com/chat/"+consultingNo+"/함깨할게", "popWin", "left=200, top=20, width=1200, height=725, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
					}
			});
		}
	});
	
});

</script>

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
		<div class="col-md-9 col-sm-9 col-md-offset-1">

			<form id="myConsulting">
				<input type="hidden" id="currentPage" name="currentPage" value="" />
				<input type="hidden" id="consultingNoModal" name="consultingNo" value="" />
				<input type="hidden" id="consultingUserId" name="consultingUserId" value="" />
				<input type="hidden" name="consultingState" value="" />
				<input type="hidden" id="index" value=""/>
			</form>
			
			<h1 align="center">영상상담 관리</h1>
		    <hr/>
		    
		    <!--  table Start-->
		     <table class="table table-hover table-striped" >
		     
		       <thead>
		         <tr>
		           <th class="text-center">신청날짜</th>
		           <th class="text-center">신청자</th>
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
				  <td align="center" style="white-space: nowrap;">${list.user.userId}</td>
				  <td align="center" style="white-space: nowrap;">${list.healingDog.healingDogHealer}</td>
				  <td align="center" style="white-space: nowrap;">${list.healingDog.healingDogName}</td>
				  <td align="center" style="white-space: nowrap;">${list.consultingState=='0'?"대기":list.consultingState=='1'?"진행":list.consultingState=='2'?"완료":"취소"}</td>
				  <td align="center" style="white-space: nowrap;">
				  	<div><a href="#" class="popup-with-zoom-anim highlight-button-dark margin-three" name="btnConsulting" style='display: ${list.consultingState=="2"||list.consultingState=="3"?"none":""};'>${list.consultingState=="0"?"상담취소":"상담완료"}</a></div>
				  	<div><a href="#" class="popup-with-zoom-anim highlight-button-dark" name="startConsulting" style='display: ${list.consultingState=="0"||list.consultingState=="1"?"":"none"};'>${list.consultingState=="0"?"상담시작":"다시연결"}</a></div>
			  		
			  		<input type="hidden" name="userId" value="${list.user.userId }"/>
			  		<input type="hidden" name="regDate" value="${list.regDate }"/>
			  		<input type="hidden" name="healingDogHealer" value="${list.healingDog.healingDogHealer}"/>
			  		<input type="hidden" name="healingDogName" value="${list.healingDog.healingDogName}"/>
			  		<input type="hidden" name="consultingNoList" value="${list.consultingNo }"/>
				  	
			  	  </td>
				 
				</tr>
		         </c:forEach>
		       
		       </tbody>
		     
		     </table>
		     <!-- end table -->
		     
		     <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
                <!-- pagination -->
				<jsp:include page="../common/pageNavigator_new.jsp" />
                <!-- end pagination -->
            </div> 
            
		</div>
		<!-- end content  -->
	
	</div>
	</div>
	</section>
	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />

</body>

</html>