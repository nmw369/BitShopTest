<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<jsp:include page="/common/css.jsp" />

<title>크라우드펀딩등록</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>



<!-- SommerNote  -->
<script>

	var content

	$(function(){
		
		$("span:contains('펀딩등록')").on("click",function(){
			test();
			getFund();
		});
		
		$('#summernote').summernote({
			height: 600,
					
			callbacks: {
				onImageUpload: function(files, editor, welEditable) {
					 for (var i = files.length - 1; i >= 0; i--) {
			            	sendFile(files[i], this);
			            }
		        }
			}
			
		});
		
	});
	
	
    
    function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: '/common/json/imageUpload',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(url) {
        		console.log(JSON.stringify(url));
        		console.log(url.url);
          		$(el).summernote('editor.insertImage',url.url);
        	}
      	});
    }
	
	function getFund(){
		document.getElementById("fundTerm").value = document.getElementById("fundTerm1").value+" ~ "+document.getElementById("fundTerm2").value;
		documetn.getElementById("fundContent").value= content
		console.log(document.getElementById("fundTerm").value);
		document.detailForm.submit();
		//$("form").attr("method","POST").attr("action","/fund/addFund").submit();
	}

	 function test(){
	    	
	    	content = $('#summernote').summernote('code');
	    	alert(content)
	    		      	
	      }
</script>


</head>
<style type="text/css">
.calendar-icon { 	display: flex; align-items: center;}
.calendar-icon i { margin-left:-30px; z-index:999; margin-right:10px;}
</style>
 
<body>
					
	<jsp:include page="/layout/store-sub-header.jsp" />

	<!-- head section -->
	<section
		class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/700_bg.jpg"
		alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center wow fadeInUp">
				<!-- page title -->
				<h1 class="white-text">CrowdFunding Registration</h1>
				<!-- end page title -->
				<!-- page title tagline -->
				<span class="white-text xs-display-none">Register
					crowdfunding information.</span>
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
			<div class="col-md-13 col-sm-9 col-xs-11 center-col xs-no-padding">
				<form name="detailForm" method="post" action="/fund/addFund" enctype="multipart/form-data">

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label class>펀딩제목</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="fundTitle" id="fundTitle" class="big-input">
						<!-- end input  -->
					</div>

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>펀딩요청기관</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="fundCenter" id="fundCenter" class="big-input">
						<!-- end input  -->
					</div>
					
					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>전화번호</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="text" name="fundPhone" id="fundPhone" class="big-input">
						<!-- end input  -->
					</div>

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>펀딩기간</label>
						<!-- end label  -->
					</div>

					<div class="form-group calendar-icon no-margin-bottom" >
						<!-- input  -->
						<input type="text" placeholder="펀딩시작" class="big-input col-md-6" id="fundTerm1">
						<i class="fa fa-calendar small-icon form-group" style="padding-left:-20px;"></i>
						<input type="text" placeholder="펀딩종료" class="big-input col-md-6" id="fundTerm2">
						<i class="fa fa-calendar small-icon form-group" ></i>
						
						<input type="hidden" name="fundTerm" id="fundTerm"> 
						<!-- end input  -->
					</div>

					<div class="form-group margin margin-two-bottom">
						<!-- label  -->
						<label>펀딩이미지</label>
						<!-- end label  -->
						<!-- input  -->
						<input type="file" name="fundImagePath" id="fundImagePath" class="big-input">
						<!-- end input  -->
					</div>

					<div class="form-group no-margin-bottom">
						<!-- label  -->
						<label>펀딩상세내용</label>
						<!-- end label  -->
						<!-- input  -->
						
						<jsp:include page="/common/sommernote.jsp"></jsp:include>
						<!-- end input  -->
					</div>

				</form>
				
					<div align="right">
        		     <span class="highlight-button btn-medium button margin-five">펀딩등록</span>
        		</div>			
				<textarea name="fundContent" id="fundContent"/>
			</div>
		</div>
	</div>
	</section>
	<!-- end content section -->





	<jsp:include page="/layout/footer.jsp" />

	<jsp:include page="/common/js.jsp" />

</body>
</html>