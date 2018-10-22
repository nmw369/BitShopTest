<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="kr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- 달력 -->
<script type="text/javascript" src="http://www.blueb.co.kr/data/201010/IJ12873724731095/datepicker.js"></script>
<link href="http://www.blueb.co.kr/data/201010/IJ12873724731095/datepicker.css" rel="stylesheet" type="text/css" />
<!-- 달력 -->
<jsp:include page="/common/css.jsp" />
<title>치유견등록</title>

</head>

<body>

<script type="text/javascript">
function close_pop(flag) {
    $('#hName').hide();
    $('#hBirth').hide();
    $('#hChar').hide();
    $('#hHealer').hide();
    $('#cancel').hide();
};


function fncAddHealingDog(){
	//Form 유효성 검증
	var healingDogBirth = $('input[name=healingDogBirth]').val();
	var healingDogName = $('input[name=healingDogName]').val();
	var healingDogChar = $('textarea[name=healingDogChar]').val();	
	var healingDogHealer = $('input[name=healingDogHealer]').val();	


	if(healingDogName == null || healingDogName.length<1){
		$('#hName').show();
		return;
	}
	
	if(healingDogBirth == null || healingDogBirth.length<1){
		$('#hBirth').show();
		return;
	}
	if(healingDogChar == null || healingDogChar.length<1){
		$('#hChar').show();
		return;
	}
	if(healingDogHealer == null || healingDogHealer.length<1){
		$('#hHealer').show();
		return;
	}
	$('#isWrite').show();
}

$(function () {
	$("#addHealingDog").on("click", function () {
			fncAddHealingDog();
	});
})


$(function () {
	$("#ok").on("click", function () {
		$('#isWrite').hide();
		$("form").attr("method","post").attr("action","/ash/addHealingDog").attr("enctype","multipart/form-data").submit();
		
	})
	$("#cancel").on("click", function () {
		$('#isWrite').hide();
	})
})


</script>

	<jsp:include page="/layout/header.jsp" />

	<!-- head section -->
	<section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/302_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center wow fadeInUp">
				<!-- page title -->
				<h1 class="white-text">HealingDog Registration</h1>
				<!-- end page title -->
				<!-- page title tagline -->
				<span class="white-text xs-display-none">Register HealingDog Information.</span>
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

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label class>치유견 이름</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="healingDogName" id="healingDogName" class="big-input2" value="">
						<!-- end input  -->
					</div>

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>치유견 견종</label>
						<!-- end label  -->
						<!-- input  -->
						<select type="text" name="healingDogBreed.dogNo" id="healingDogBreed" class="big-input2" >
							<c:forEach var="dog" items="${dog}">
								<option value="${dog.dogNo}">${dog.dogBreedKO}</option>
							</c:forEach>
						</select>
						<!-- end input  -->
					</div>
					
					<div class="form-group no-margin-bottom " >
						<!-- label  -->
						<label>치유견 생년월일</label>
						<!-- end label  -->
						<!-- input  -->
						
						<span style="white-space: nowrap;">
						<input type="text" name="healingDogBirth" id="healingDogBirth" class="big-input2" placeholder="ex) 2018-05-06" value="" readonly>
						<script type="text/javascript">
									var opts = {                            
									        formElements:{"healingDogBirth":"Y-ds-m-ds-d"},
									        statusFormat:"l-cc-sp-d-sp-F-sp-Y",
									        // Fill the grid...
									        fillGrid:true,
									        // ... and make all displayed dates selectable
									        constrainSelection:false        
									        };      
									datePickerController.createDatePicker(opts);
						
						 </script>
						 </span>
						<!-- end input  -->
					</div>
					
					<div class="form-group">
						<!-- label  -->
						<label >치유견 성별</label>
						<!-- end label  -->
						<!-- input  -->
						<div class="wrap">
							<input value="0" type="radio" name="healingDogGender" id="radio1" class="checkbox">
							<label for="radio1" class="input-label radio">남아</label>
							<input value="1" type="radio" name="healingDogGender" id="radio2" class="checkbox">
							<label for="radio2" class="input-label radio">여아</label>
						<!-- end input  -->
						</div>

						<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>치유견 특징</label>
						<!-- end label  -->
						<!-- input  -->
						<textarea name="healingDogChar" placeholder="내용을 입력해주세요." class="big-textarea"></textarea>
						<!-- end input  -->
					</div>

					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>치유견이미지</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file" name="file" id=healingDogImage class="big-input2" value="">
						<!-- end input  -->
					</div>

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>담당치유사</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="healingDogHealer" class="big-input2" value=""/>
						<!-- end input  -->
					</div>

				</form>
				
				<div class="text-center">
					<a id="addHealingDog" style="cursor: pointer;" class="highlight-button btn btn-medium">치유견 등록</a>
				</div>
				
			</div>
		</div>
	</div>
	</section>
	<!-- end content section -->



<!--         모달만 모여있는곳 Start -->
  <!-- 1. 치유견이름 모달 -->
    <div id="hName" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />치유견 이름을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
  <!-- 1. 치유견이름 모달 -->
      
  <!-- 2. 치유견 생년월일 모달 -->
    <div id="hBirth" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />치유견 생년월일을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 2. 치유견 생년월일 모달 -->
      
  <!-- 3. 치유견 특징 모달 -->
    <div id="hChar" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />치유견 특징을 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 3. 치유견 특징 모달 -->
      
  <!-- 4. 담당치유사 모달-->
    <div id="hHealer" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />담당치유사를 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 4. 담당치유사 모달-->
      
  <!-- 4. 등록 여부-->
    <div id="isWrite" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />치유견을 등록하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="ok" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancel" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 4. 등록 여부-->


<!--         모달만 모여있는곳 End -->




	<jsp:include page="/layout/footer.jsp" />

	<jsp:include page="/common/js.jsp" />

</body>
</html>