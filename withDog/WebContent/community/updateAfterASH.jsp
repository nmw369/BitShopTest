<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="kr">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<link href="/css/jquery.minical.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 달력 -->
<script type="text/javascript" src="http://www.blueb.co.kr/data/201010/IJ12873724731095/datepicker.js"></script>
<link href="http://www.blueb.co.kr/data/201010/IJ12873724731095/datepicker.css" rel="stylesheet" type="text/css" />
<!-- 달력 -->
<jsp:include page="/common/css.jsp" />

<title>동물 교감 후기 수정</title>
<style type="text/css">


</style>

<script type="text/javascript">
function close_pop(flag) {
    $('#selectDate').hide();
    $('#writeTitle').hide();
    $('#writeContent').hide();
    $('#cancel').hide();
};


$(function () {
	$("#fd-but-afterASHDate").attr('class','fa fa-calendar small-icon form-group');
})

function fncUpdateAfterAsh(){
	//Form 유효성 검증
 	var healingDog = $('#healingDog option:selected').val();
	var afterASHTitle = $('input[name=afterASHTitle]').val();
	var afterASHContent = $('textarea[name=afterASHContent]').val();
	var afterASHDate = $('input[name=afterASHDate]').val();


	if(afterASHTitle == null || afterASHTitle.length<1){
		$('#writeTitle').show();
		return;
	}
	if(afterASHContent == null || afterASHContent.length<1){
		$('#writeContent').show();
		return;
	}
	if(afterASHDate == null || afterASHDate.length<1){
		$('#selectDate').show();
		return;
	}
	$('#isUpdate').show();
	
}

$(function () {
	$("#submit").on("click", function () {
		fncUpdateAfterAsh();
	})
})

$(function () {
	$("#ok").on("click", function () {
		$('#isUpdate').hide();
		$("form").attr("method","post").attr("action","/afterAsh/updateAfterAsh").attr("enctype","multipart/form-data").submit();
		
	})
	$("#cancel").on("click", function () {
		$('#isUpdate').hide();
	})
})


$(function () {
	$.ajax({
		url : "/ash/json/getAllHealingDogList",
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {
			console.log(data)
			for(var i = 0; i<data.healingDogs.length; i++){
// 				 ${afterAsh.healingDog.healingDogNo==data.healingDogs[i].healingDogNo?"selected":""}
				$("#healingDog").append($('<option value='+data.healingDogs[i].healingDogNo +'>'+data.healingDogs[i].healingDogName+'</option>'));
				}
		}
	})
})

</script>


</head>

<style type="text/css">
.calendar-icon { 	display: flex; align-items: center;}
.calendar-icon i { margin-left:-30px; z-index:999; margin-right:10px;}
</style>
 
<body>

	<jsp:include page="../layout/header.jsp" />
	

	<!-- head section -->
	<section
		class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/603_bg.jpg"
		alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center wow fadeInUp">
				<!-- page title -->
				<h1 class="white-text"> 동물 교감치유 후기수정</h1>
				<!-- end page title -->
				<!-- page title tagline -->
				<span class="white-text xs-display-none">review</span>
				<!-- end title tagline -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->

	<!-- content section -->
	<section class="wow fadeIn">
	<div class="container">
		<div class="row">
			<div class="col-md-5 col-sm-8 col-xs-11 center-col xs-no-padding">
				<form>
				<input type="hidden" name="afterASHNo"  value="${afterAsh.afterASHNo}">
					<!-- 후기제목 -->
					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label class>후기제목</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="afterASHTitle" id="afterASHTitle" class="big-input" value="${afterAsh.afterASHTitle}">
						<!-- end input  -->
					</div>
					
					<!-- 이용날짜 -->
					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>이용기간</label>
						
						<!-- end label  -->
					</div>
					<div class="form-group calendar-icon no-margin-bottom" >
					

						<input  type="text" class="big-input" name="afterASHDate" id="afterASHDate" value="${afterAsh.afterASHDate}" readonly>
						      <script type="text/javascript">
									var opts = {                            
									        formElements:{"afterASHDate":"Y-ds-m-ds-d"},
									        statusFormat:"l-cc-sp-d-sp-F-sp-Y",
									        // Fill the grid...
									        fillGrid:true,
									        // ... and make all displayed dates selectable
									        constrainSelection:false        
									        };      
									datePickerController.createDatePicker(opts);
									 </script>
						<select class="big-input" name="afterASHTime" id="afterASHTime">
							<option value="0" ${afterAsh.afterASHTime=='0'?'selected':''}>오전 [10:00~13:00]</option>
                         	 <option value="1" ${afterAsh.afterASHTime=='1'?'selected':''} >오후 [14:00~17:00]</option>
						</select>
						<!-- end input  -->
					</div>

					<!-- 치유견 선택 -->
					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>치유견 선택</label>
						<div class="select-style">
							<select name="healingDog.healingDogNo" id="healingDog" >
							</select>
						<!-- end input  -->
					</div>
					
					<!-- 후기상세 -->
					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>후기상세내용</label>
						<!-- end label  -->
						<!-- input  -->
						<textarea name="afterASHContent" id="afterASHContent" placeholder="상세내용을 입력해주세요">${afterAsh.afterASHContent}</textarea>
						<!-- end input  -->
					</div>
					<c:forEach var="a" items="${afterAsh.afterASHImageList}">
								<img  src = "/images/uploadFiles/dogInfo/${a}" width="400px" height="200px" alt=""/>
					</c:forEach>

					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>이미지 1</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file"  id="file" name="file" class="big-input">
						<!-- end input  -->
					</div>
					
					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>이미지2</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file"   id="file" name="file" class="big-input">
						<!-- end input  -->
					</div>
					
					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>이미지3</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file"   id="file" name="file"  class="big-input">
						<!-- end input  -->
					</div>
					
					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>동영상</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file" name="file" class="big-input">
						<!-- end input  -->
					</div>
					
                   		<!-- required  -->
                        <span class="required text-right">*Please complete all fields correctly</span>
                        <!-- end required  -->

				</form>
				<div class="text-center">
					<span style="cursor: pointer;" id="submit" class="highlight-button btn btn-medium">수정</span>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- end content section -->

<!--         모달만 모여있는곳 Start -->
  <!-- 1. 이용기간작성 모달 -->
    <div id="selectDate" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />이용기간을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
  <!-- 1. 이용기간작성 모달 -->
      
  <!-- 2. 제목작성 모달 -->
    <div id="writeTitle" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />제목을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 2. 제목작성 모달 -->
      
  <!-- 3. 내용작성 모달 -->
    <div id="writeContent" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />내용을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 3. 내용작성 모달 -->
      
  <!-- 4. 수정여부 모달 -->
    <div id="isUpdate" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />후기를 수정하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="ok" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancel" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 4. 수정여부 모달 -->


<!--         모달만 모여있는곳 End -->




	<jsp:include page="/layout/footer.jsp" />

	<jsp:include page="/common/js.jsp" />

</body>
</html>