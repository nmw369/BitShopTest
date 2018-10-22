<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<jsp:include page="../common/css.jsp" />
<title>아이디 / 비밀번호 찾기</title>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- 제이쿼리 달력  -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<!-- 제이쿼리 달력 :: 크롬에서 년도 안에 글씨 작게 -->
	<style type="text/css">
	.ui-datepicker .ui-datepicker-title select {
    font-size: 12px;
	}
	</style>
	<!-- 제이쿼리 달력 기본값 세팅 -->
	<script src="../js/datepicker.js"></script>
	<!-- end 제이쿼리 달력 -->
	
	<style type="text/css">

	
	#head_section{
	padding : 120px 0px 40px 0px !important;
	}
	</style>
	
	<script type="text/javascript">
	
	$( function() {
		
		$("#userName").focus();
		
		//아이디 찾기
		$("#findUserId").on("click", function(){
			
			//아이디 찾기 유효성 체크
			var name=$("input[name='userName']").val();
			var birth=$("input[name='birth']").val();
			
			//이름
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}	
			
			//생년월일
			if(birth == null|| birth.length <1){
				alert("생일은  반드시 선택하셔야 합니다.");
				return;
			}	
			
			$.ajax({
				url : "/user/json/findUserId",
				method : "POST",
				dataType : "json",
				data: JSON.stringify({
					userName:$("#userName").val(),
					birth:$("#datepicker").val(),
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					
					var check = JSONData.userId;
					
					if(check==null){
						$(".spanId").html("해당 정보 확인이 되지 않습니다.").css('color','red');
					}else{
						
						//원래 아이디 길이
						var showIdNo = check.length;
						showIdNo = showIdNo-3;
						//아이디 앞에서 3개
						var showId = check.substring(0,3);
						
						for(i=0;i<showIdNo;i++){
							showId+="*";
						}
						
						$(".spanId").html("고객님의 ID는 "+showId+"입니다.").css('color','blue');	
					}
				}
			});// end ajax
			 
		 });//end 아이디 찾기
	
		
		 
		 
		//이메일 입력방식 선택 
		//이메일 셀렉박스 선택시 직접입력 누르면
		$("#email2").on("change",function(){
			if($("#email2").val()=='1' ){
				$("#email1").focus();
			}
		});
		
		
		//비밀번호 찾기 연결
		$("#findPW").on("click" , function() {
			
			
			//가입으로 넘기기전 체크사항   email
			///1.이메일 입력 :: 직접 입력 선택시 option value값이 1
				if($("#email2").val()=='1' ){
					
					var email= $("#email1").val();
					$("#email").val(email);
					
				}else{
					
					var email2= '@'+$("#email2").val();
					var email1 = $("#email1").val();
					var email =email1+email2;
					$("#email").val(email);
					//$("#email2 option:selected").val(email2);
				}
			
			//비밀번호 찾기 유효성 체크
			var id=$("input[name='userId']").val();
			var email1= $("#email1").val();
			
			
			//아이디
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			
			
			if(email1 == null || email1.length <1){		
				alert("이메일이 입력되지 않았습니다.");
				$("input:text[name='email1']").focus();
				return;
			}
		
	
			$.ajax({
				url : "/user/json/findUserPW",
				method : "POST",
				dataType : "json",
				data: JSON.stringify({
					userId:$("#userId").val(),
					email:$("input[name='email']").val(),
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					
					var check = JSONData;
					
					if(!check){
						$(".spanId2").html("해당 정보 확인이 되지 않습니다.").css('color','red');
					}else{
						$(".spanId2").html("고객님의 이메일로 임시 비밀번호가 전송되었습니다.").css('color','blue');	
					}
				}
			});// end ajax
			
		});//end 비밀번호 찾기 연결

	});	
	</script>	


</head>
<body>
		
		<jsp:include page="/layout/common-header.jsp" />
		
		
		 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog" id="head_section">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/findUser_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h2 class="white-text tit_png"><img src="../images/sub/findUser_tit.png">
                         	<p style ="margin-top: 10px;">가입시 입력했던 정보를 입력해주세요.</p>
                        </h2>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->        
        
        <!-- content section -->
        <section>
            <div class="container clearfix"><!-- container1 -->
                <div class="row margin-five no-margin-top"><!-- row1 -->
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                        <p class="black-text font-weight-600 text-uppercase text-large">아이디 찾기</p>
                        
                        <form id="findIdForm">
                        
                            <div class="col-md-12 no-padding">
                                <label>이름 :</label>
                                <input type="text" name="userName" id="userName">
                            </div>
                            
                             <div class="col-md-12 no-padding">
                                <label>생년월일 :</label>
                                <input type="text" name="birth" id="datepicker" readOnly>
                                <span class="spanId"></span>
                            </div>
                             
                             
                         </form> 
                         
                         <div class="text-center">
                         	<button class="highlight-button btn no-margin post-search" id="findUserId">아이디 찾기</button>
                         </div>
                         
                    </div>
                </div><!-- row1 -->
                
                <div class="row margin-five no-margin-top"><!-- row1 -->
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                        <p class="black-text font-weight-600 text-uppercase text-large">비밀번호 찾기</p>
                        
                        <form id="findPWForm">
                           
                            <div class="col-md-12 no-padding">
                                <label>아이디 :</label>
                                <input type="text" name="userId" id="userId">
                            </div>
                            
			   		    	<div class="form-group">
						    	<p>이메일 :  </p>  
					        	<input type="text" name="email1" class="col-md-4" id="email1">
					                <div class="col-md-4">
										<select name="email2" id="email2">
											<option value="1">직접입력</option>
											<option value="naver.com">@naver.com</option>
											<option value="daum.net">@daum.net</option>
											<option value="gmail.com">@gmail.com</option>
											<option value="hotmail.com">@hotmail.com</option>
											<option value="nate.com">@nate.com</option>
										</select>
						            </div>
						           <span class="spanId2"></span>  
						           <input type="hidden" name="email" id="email">
					        </div> 
                            
                        </form> 
                        
                        <div class="text-center">
                       		<button class="highlight-button btn no-margin post-search" id="findPW">비밀번호 찾기</button>
                        </div>
                        
                    </div>
                </div><!-- row1 -->
                
                
            </div><!-- container1 -->
            
        </section>
        <!-- end content section -->
        
		
		<jsp:include page="../layout/footer.jsp" />
	
		<jsp:include page="../common/js.jsp" />
</body>
</html>