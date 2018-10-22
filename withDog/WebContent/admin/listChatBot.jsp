<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>나의 예약내역</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />


<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

</script>

<style type="text/css">
table th, td{text-align:center; font-size:13px;}
table td{font-size:12px;}

</style>

</head>

<body>
<script type="text/javascript">

$(function () {
	var questionNo2 = "";
	
	$(document).on("click", ".updateButton", function(){
		
		var index = $(".updateButton").index(this);
		var question =$($(".question")[index]).html();
		var answer =$($(".answer")[index]).html();
		questionNo2 = $($(".questionNo")[index]).val();
		console.log(questionNo2)
		
// 		console.log($($(".question")[index]).html());
// 		console.log($($(".answer")[index]).html());
		
		$("#deleteFlag").html('')
		$("#addQuestion").val(question)
		$("#addAnswer").val(answer)
		$("#updateButton").html('<select id="isDelete"><option value="0">공개</option><option value="1">숨김</option></select><hr><a style="cursor: pointer;" id="updateSuccess">수정</a><hr><a style="cursor: pointer;" id="deleteSuccess">삭제</a><hr><a style="cursor: pointer;" id="updateCancel">취소</a>');
		
		$("#updateCancel").on("click", function () {
			questionNo2 = "";
			console.log(questionNo2)
			$("#addQuestion").val('');
			$("#addAnswer").val('');
			$("#updateButton").html('<a style="cursor: pointer;" id="addChatBot">추가</a>');
		})
		
		$(document).on("click", "#updateSuccess", function(){
			$.ajax({
				url : "/quick/json/updateChatbot",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					questionNo : questionNo2,
					question : $("#addQuestion").val(),
					answer : $("#addAnswer").val(),
					deleteFlag : $("#isDelete").val()
				}),
				success : function (data) {
					location.reload();
// 					$("#content").append('<tr><td>'+no+'</td><td>'+data.chatBot.question+'</td><td>'+data.chatBot.answer+"</td><td><a>수정</a></td></tr>");

				}
			}) //end ajax
		})
		
		$(document).on("click", "#deleteSuccess", function(){
			$.ajax({
				url : "/quick/json/deleteChatbot",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					questionNo : questionNo2
				}),
				success : function (data) {
					 $($("tr")[index+1]).remove()
					 $($(".questionNo")[index]).remove()
		 			$("#addQuestion").val('');
					$("#addAnswer").val('');
					$("#updateButton").html('<a style="cursor: pointer;" id="addChatBot">추가</a>');
// 					location.reload();
// 					$("#content").append('<tr><td>'+no+'</td><td>'+data.chatBot.question+'</td><td>'+data.chatBot.answer+"</td><td><a>수정</a></td></tr>");

				}
			}) //end ajax
		}) //end delete function
		
	})
}) //end function


$(document).on("click", "#addChatBot", function(){
	$("#isWrite").show();
});


$(function () {
	var no = ($("#content tr").length)+1;
	$("#ok").on("click", function () {
		$('#isWrite').hide();
		$.ajax({
			url : "/quick/json/addChatbot",
			method : "post",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				question : $("#addQuestion").val(),
				answer : $("#addAnswer").val()
			}),
			success : function (data) {
				console.log(data)
				$("#content").append('<input type="hidden" id="questionNo" class="questionNo" value="'+data.chatBot.questionNo+'"></input>');
				$("#content").append('<tr><td>'+no+'<br>(공개)</td><td><a class="question">'+data.chatBot.question+'</a></td><td><a class="answer">'+data.chatBot.answer+'</a></td><td><a style="cursor: pointer;" class="updateButton">수정</a></td></tr>');
				$("#addQuestion").val('')
				$("#addAnswer").val('')

			}
		})
		
	})
	$("#cancel").on("click", function () {
		$('#isWrite').hide();
	})
})

		
</script>

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
			<div class="col-md-10 col-sm-9 col-xs-12">
			
				<h1 align="center">빠른 상담</h1>
				
				<!-- search -->
				<div class="border-gray2 margin-two padding-two col-md-12 col-sm-10 col-xs-12">
				
					<div class="padding-two border-bottom col-md-11 col-xs-11 center-col text-center margin-two-bottom">
						<label class="text-small"><span class="magenta-text">빠른 상담</span>관리합니다. 추가/수정이 가능합니다.</label>
					</div>
			        
		        </div>
		        <!-- end search -->


				<!--  table Start /////////////////////////////////////-->
				<table style="table-layout:fixed;" class="table table-striped">
                            <thead>
                                <tr>
                                    <th width="10%">번호</th>
                                    <th width="35%">질문</th>
                                    <th width="35%">응답</th>
                                    <th width="15%">설정</th>
                                </tr>
                            </thead>
                            <tbody  id="content">
                            	<c:set var="i" value="0"/>
								<c:forEach var="list" items="${list}">
								<input type="hidden" id="questionNo" class="questionNo" value="${list.questionNo}"></input>
								<c:set var="i" value="${i+1}"/>
	                                <tr id="arr">
	                                    <td id="no">${i}<br>${list.deleteFlag==0?'(공개)':'(숨김)'}</td>
	                                    <td><a class="question">${list.question}</a></td>
	                                    <td><a class="answer">${list.answer}</a></td>
	                                    <td><a style="cursor: pointer;" class="updateButton">수정</a></td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                                 <tr id="update">
                               		<td id="deleteFlag"></td>
                                    <td><textarea id="addQuestion" rows="10px" cols="30px"></textarea> </td>
                                    <td><textarea id="addAnswer" rows="10px" cols="30px"></textarea> </td>
                                    <td id="updateButton"><a style="cursor: pointer;" id="addChatBot">추가</a></td>
                                </tr>
                        </table>
				<!--  table End /////////////////////////////////////-->
			</div>
			<!--  end content -->
			
			</div>
		</div>
	</section>
	
	  <!-- 1. 등록 여부-->
    <div id="isWrite" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />빠른상담 내용을 등록하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="ok" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancel" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 1. 등록 여부-->
	
	
 	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
 	
</body>

</html>