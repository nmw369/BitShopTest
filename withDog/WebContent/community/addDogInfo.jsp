<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <link href='/css/summernote.css' rel='stylesheet' /> -->
<!-- <script src='/js/summernote.min.js'></script> -->



<jsp:include page="/common/css.jsp" />
<style type="text/css">
        

</style>
<title>애견상식 등록</title>

<script type="text/javascript">
/* $(function() {
	  $('#summernote').summernote();
	}); */
function test(){
	
	content = $('#summernote').summernote('code');
	     	
  }
  
  
function close_pop(flag) {
    $('#selectTopic').hide();
    $('#writeTitle').hide();
    $('#writeContent').hide();
    $('#insertFile').hide();
};


function fncAddDogInfo(){
	//Form 유효성 검증
	
	document.getElementById("dogInfoContent").value= content;
	
 	var dogInfoTopic = $('#dogInfoTopic option:selected').val();
	var dogInfoTitle = $('input[name=dogInfoTitle]').val();
	var dogInfoContent = content;	
	var filecheck = $('input[name=file]').val();
	console.log(dogInfoContent.length)

	if(dogInfoTopic == null || dogInfoTopic.length<1){
		$('#selectTopic').show();
		return;
	}
	if(dogInfoTitle == null || dogInfoTitle.length<1){
		$('#writeTitle').show();
		return;
	}
	if(dogInfoContent == null || dogInfoContent.length<20){
		$('#writeContent').show();
		return;
	}
	if(filecheck == null || filecheck.length<1){
		$('#insertFile').show();
		return;
	}
	$('#isWrite').show();
	
}


/* $(function () {
	$("#submit").on("click", function () {
		fncAddDogInfo();
	});
}) */


$(function () {
	$("#ok").on("click", function () {
		$('#isWrite').hide();
		$("form").attr("method","post").attr("action","/dogInfo/addDogInfo").attr("enctype","multipart/form-data").submit();
		
	})
	$("#cancel").on("click", function () {
		$('#isWrite').hide();
	})
})

</script>

</head>

<body>


	<%-- <jsp:include page="/layout/common-header.jsp" /> --%>
	<jsp:include page="/layout/header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/602_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/602_tit.png"></h1>
                        <!-- end page title -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section class="wow fadeIn">
            <div class="container">
 
                <!-- comment form -->
                <div class="row">
                <form>
                    <div id="addcomment" class="col-md-8 col-sm-12  center-col ">
                        <h5 class="info-title margin-five no-margin-top">애견상식 등록하기</h5>
                        <div class="blog-comment-form">
                            	<!-- select -->
                                <select id="dogInfoTopic" name="dogInfoTopic" class="big-input col-md-4" style="padding-bottom:9px; padding-right:10px;">
                                    <option value="" selected="selected">주제 선택</option>
                                    <option value="1" >훈련</option>
                                    <option value="2" >번식</option>
                                    <option value="3" >위생</option>
                                    <option value="4" >음식</option>
                                    <option value="5" >행동</option>
                                    <option value="6" >미용</option>
                                    <option value="7" >기타</option>
                                </select>
                                <!-- end select -->
                                <!-- input  -->
                                <input type="text" name="dogInfoTitle" placeholder="애견상식제목" class="big-input col-md-8 pull-right">
                                <!-- end input -->
                                <!-- textarea  -->
                            </div>    
                                
								
                               <!-- <textarea name="dogInfoContent" placeholder="애견상식내용" class="info-textarea" ></textarea>
                                end textarea 
                                input 
                                <input type="file"  id="file" name="file" class="big-input">
                                <input type="file"  id="file" name="file" class="big-input">
                                <input type="file"  id="file" name="file" class="big-input">
                                end input
                                required
                                <span class="required text-right">*Please complete all fields correctly</span> -->
                                <!-- end required  -->
                                <br/><br/><br/>
                              
                              <input type="hidden" name="dogInfoContent" id="dogInfoContent" value="">
							<jsp:include page="/common/dogInfoSommernote.jsp"></jsp:include>   		
                            <br>
                            <br>
                            <a style="color: gray; font-size: 13px">* 이 애견상식의 대표 섬네일 이미지를 등록해주세요.</a>
                            <input type="file" name="file" placeholder="섬네일로 사용할 이미지를 반드시 등록해주세요."></input>
                            <br>
                            </form>
                         
                            <!-- button  -->
                            <div class="text-center">
                            
                            <span style="cursor: pointer;" id="submit" class="highlight-button btn btn-medium text-center" >애견상식등록</span>
<!--                             <button id="asdf" type="button" class="btn btn-primary"  >등 &nbsp;록</button> -->
                            <!-- end button  -->
                            
                        </div>
                    </div>
                    
                    <!-- end comment form -->
                </div>
                <!-- end content  -->


		    </div>
        </section>
        <!-- end content section -->
        
        
                <!--         모달만 모여있는곳 Start -->
  <!-- 1. 주제작성 모달 -->
    <div id="selectTopic" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />주제를 선택해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
  <!-- 1. 주제작성 모달 -->
      
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
                <p style="text-align: center; line-height: 1.5;"><br />내용은 20자 이상 작성해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 3. 내용작성 모달 -->
      
  	<!-- 3. 섬네일 이미지 등록 모달 -->
    <div id="insertFile" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />섬네일 사진을 등록해주세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 3. 섬네일 이미지 등록 모달 -->
      
  <!-- 4. 등록여부 모달 -->
    <div id="isWrite" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />애견상식을 등록하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="ok" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancel" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 4. 내용작성 모달 -->


<!--         모달만 모여있는곳 End -->
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/jsSummnerNote.jsp" />
	
</body>
</html>