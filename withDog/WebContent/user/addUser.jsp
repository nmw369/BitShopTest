<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

	<title>회원가입</title>
	
	<jsp:include page="../common/css.jsp" />
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->

	<!-- 제이쿼리 달력  -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  	<link rel="stylesheet" href="/resources/demos/style.css">
	  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	  	<!-- 제이쿼리 달력 :: 크롬에서 년도 안에 글씨 작게 -->
		<style type="text/css">
		.ui-datepicker .ui-datepicker-title select {
	    font-size: 12px;
		}
		</style>
		<!-- 제이쿼리 달력 기본값 세팅 -->
		<script src="../js/datepicker.js"></script>
	<!-- end 제이쿼리 달력 -->
	
	<!-- 오토컴플릿 -->
	  <style>
	  .custom-combobox {
	    position: relative;
	    display: block;
/* 	    width : 500px; */
	  }
	  .custom-combobox-toggle {
	    position: absolute;
	    top: 0;
	    bottom: 0;
	    margin-left: -1px;
	    padding: 0;
	  }
	  .custom-combobox-input {
	    margin: 0;
	    padding: 5px 10px;
	  }
	  
	    .ui-autocomplete {
	    max-height: 200px;
	    overflow-y: auto;
	    /* prevent horizontal scrollbar */
	    overflow-x: hidden;
  	  }
  	  
  	  .ui-widget{
  	  	padding:12px 0;
  	  }


		* html .ui-autocomplete {
	    height: 200px;
	  }
	  
	  .ui-button{
	  position: absolute;
	  right :-3px;
	  }
  	</style>
  	<script src="../js/autocomplete.js"></script>
	<!-- end 오토컴플릿 -->

	<script type="text/javascript">
	
	//좋아하는 견종 제이쿼리 
	$(function () {

	
		$.ajax({
			url : "/dogBreedDic/json/getAllBreedInfoListByKo",
			method : "GET",
			datatype : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function (data) {
							
				//console.log(data)
				//console.log(data.allDogBreedInfo[2].dogNo)
				for(var i = 0; i<data.allDogBreedInfo.length; i++){
					$("#combobox").append($('<option value='+data.allDogBreedInfo[i].dogNo+'>'+data.allDogBreedInfo[i].dogBreedKO+'</option>'));
					
				}
			}
			
		}); //end of ajax	
	
	});// end 좋아하는 견종 제이쿼리
	
	//가입시 필요한 제이쿼리  1.아이디중복검사 2. 비밀번호 일치여부  3.도로주소명  4.이메일 입력방식   5.가입클릭 이벤트
	$( function() {

		$("#userId").focus();
		
		//아이디 중복검사 
		$("input[name=userId]").on("keyup", function(){
			
			// 잆력 값 저장
	       	var userId = $("input[name=userId]").val();
			
			 // 입력값 길이 저장
	        var textlength = userId.length;
			 
	        if(textlength < 3 ){
                $(".changeSpanId").html('아이디는 3자리 이상 입력해주세요').css('color','red');
                return false;
        	}
	        
	        if(textlength > 9){
                $(".changeSpanId").html('아이디는 8자리 이하로 입력해주세요').css('color','red');
                // 제한 글자 길이만큼 값 재 저장
                $("input[name=userId]").val(userId.substr(0,8));
                return false;
	        }
			
			if(userId == ""){
				$("#userId").focus();
			}else{
				$.ajax(
						{
							url : "/user/json/checkUserId/"+userId,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
						success : function(JSONData , status){
							var check = JSONData;
							//체크값이 true이면 DB에 유저정보 없는것
							if(check){
								$(".changeSpanId").html("사용 가능한 아이디입니다.").css('color','blue');
							}else{
								$(".changeSpanId").html("중복 아이디입니다.").css('color','red');
							}
						}
					});
			}
		});//end 아이디 중복 검사
		
		
		//비밀번호 확인
		$("#passwordCheck").on("keyup",function(){ 
			
			var pw=$("input[name='password']").val();
			var pwCheck=$("input[name='passwordCheck']").val();
			
			if(pw!=pwCheck){
				$(".changeSpanPW").html("비밀번호가 일치하지 않습니다.").css('color','red');
			}else{
				
				$(".changeSpanPW").html("비밀번호 일치").css('color','blue');
			}		
			
		});//end 비밀번호 확인
		

		//도로명 주소  우편번호 검색 클릭시
		$("#searchPost").on("click" , function() {
			var pop = window.open("http://localhost:8080/user/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		});
						
		function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
// 			alert(roadFullAddr);
			$("#postNo").val(zipNo);
			$("#address1").val(roadAddrPart1);
			$("#address2").val(addrDetail);

		}	
		window.jusoCallBack = jusoCallBack;
		
		//이메일 입력방식 선택 
		//이메일 셀렉박스 선택시 직접입력 누르면
		$("#email2").on("change",function(){
			if($("#email2").val()=='1' ){
				$("#email1").focus();
			}
		});
		
		
		
		//회원가입 연결
		$("#join").on("click" , function() {
			 
			//가입으로 넘기기전 체크사항   :: 1.이메일 2.좋아하는 견종 값 세팅
			///1.이메일 입력 :: 직접 입력 선택시 option value값이 1
				if($("#email2").val()=='1' ){
					
					var email= $("#email1").val();
					$("#email").val(email);
					
				}else{
					
					var email2= '@'+$("#email2").val();
					var email1 = $("#email1").val();
					var email =email1+email2;
					$("#email").val(email);
					//alert("email"+email)
					//$("#email2 option:selected").val(email2);
				}
			
			///2.좋아하는 견종 :: option value값이 String => 도메인이 int 이므로 바꿔서
 			var dogNo = $("#combobox").val()*1;
 			$("#combobox option:selected").val(dogNo);
 			
						
			addUser();
			
			
		}); 
		
	});//end 제이쿼리
	
	//가입시 유효성 체크
	function addUser() {
	
		var id=$("input[name='userId']").val();
		var pw=$("input[name='password']").val();
		var pwCheck=$("input[name='passwordCheck']").val();
		var name=$("input[name='userName']").val();
		var birth=$("input[name='birth']").val();
		var dogNo =$("#combobox option:selected").val();
		//alert("dogNo"+dogNo);
		var phone=$("input[name='phone']").val();
		var emailCheck= $("#tempNo").val();
		
		//아이디
		if(id == null || id.length <1){
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		}
	
		//비밀번호
		if(pw == null || pw.length <1){
			alert("비밀번호는  반드시 입력하셔야 합니다.");
			return;
		}
		
		//비밀번호 확인
		if(pwCheck == null || pwCheck.length <1){
			alert("비밀번호확인은  반드시 입력하셔야 합니다.");
			return;
		}
		
		//비밀번호와 비밀번호확인 값 일치여부
		if( pw != pwCheck ) {				
			alert("비밀번호 확인이 일치하지 않습니다.");
			$("input:text[name='password2']").focus();
			return;
		}
		
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
		
		//좋아하는 견종 선택
		if(dogNo == 0){
			alert("견종은  반드시 입력하셔야 합니다.");
			return;
		}
		
		//휴대전화
		if(phone == null || phone.length <1){
			alert("휴대전화는  반드시 입력하셔야 합니다.");
			return;
		}
		
		//이메일 인증여부
		if( emailCheck != 100 ) {				
			alert("이메일 인증이 완료되지 않았습니다.");
			$("input:text[name='email']").val("ggg");
			$("input:text[name='email']").focus();
			return;
		}
		
		$("form").attr("method","POST").attr("action","/user/addUser").submit();
	
	}//end addUser()

	
	//영문 키워드 (크롬 작동을 위해)
	$(document).ready(function(){

		$("#userId").css("ime-mode", "disabled");

	});
</script>	

<script type="text/javascript">
	
	//이메일 인증 제이쿼리 
	$( function() {
		
		//이메일 인증
		$("#checkEmail").on("click" , function() {
			
			
			//유효성 검사
			var email1= $("#email1").val();
			
			//alert(email1+"email1");
			var email2= '@'+$("#email2").val();
			var email = email1 + email2 ;
			
			if(email1 == null || email1.length <1){		
				alert("이메일이 입력되지 않았습니다.");
				$("input:text[name='email1']").focus();
				return;
			}
			
			 
			$.ajax({
				
				url : "/user/json/checkEmail",
				method : "POST",
				datatype : "json",
				data: JSON.stringify({
					email : email
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					
					var check = JSONData.check;
					var tempNo = JSONData.tempNo;
					
					$(".span1").remove();
					
					if(!check){
						$(".spanChange").append("<span class=\"span1\" style=\"color:red;font-size:12px;\">입력하신 정보로 가입된 아이디가 존재합니다.</span>");
// 						$(".changeDiv1").html("입력하신 정보로 가입된 아이디가 존재합니다.").css('color','red').css('font-size','12px');
					}else{
						//고유번호 숨기기
						$("#tempNo").val(tempNo);
						$(".changeDiv1").append('<div class=\"col-md-12 bg-gray\" style=\"padding:20px 0px 0px;\"><div class=\"col-md-12\" style="\margin:0px 80px\"><input type=\"text\" id=\"userTextNum\" class="\col-md-6\" placeholder="\인증코드를 입력하세요.\" /><button type="\button\" class="\highlight-button-dark col-md-2\" id="\checkTextNum\" >확인</button></div></div>');
						$(".spanChange").append("<span style=\"color:blue;font-size:12px;\">인증코드를 입력해주세요!</span>");
// 						$(".changeDiv2").html("인증코드를 입력해주세요!").css('color','blue').css('font-size','14px');	
					}

				}
			
			});//end of Ajax
						
			
		}); //end 이메일 인증
		
	});//end 이메일 인증 제이쿼리
	
	//발송한 숫자와 고객이 입력한 숫자 비교
	$(document).on("click","#checkTextNum",function() {
		//숨겨놓은 발송 숫자
		var textNum = $("#tempNo").val();
	
		//고객이 입력한 값
		var userTextNum = $("#userTextNum").val();
		//alert("userTextNum"+userTextNum);
		if(textNum!=userTextNum){
			alert("인증번호를 잘못 입력하였습니다.");
			$(".changeDiv1").remove();
			$(".changeDiv2").remove();
			
		}else{
			swal("이메일 인증이 완료되었습니다.", {
			      icon: "success",
			    });
			//이메일 인증완료시  
			var textNum = $("#tempNo").val(100);
			$(".changeDiv1").remove();
			$(".changeDiv2").remove();
 			$(".spanChange").text("이메일 :");
			$("#checkEmail").val("재인증");
			$(".spanChange").append("<span style=\"color:red;\">인증완료</span>");
		}//end of if
	});
	
</script>	

	
</head>

<body>

	<jsp:include page="../layout/common-header2.jsp" />


		
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/join_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/join_tit.png"></h1>
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
      <!-- content section -->
        <section>
            <div class="container clearfix"><!-- container1 -->
                <div class="row margin-five no-margin-top"><!-- row1 -->
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                        <p class="black-text font-weight-600 text-uppercase text-large">가입 정보</p>
                        
				<!-- form  -->
				<form>
					
					<div class="form-group">
				        <label for="textbox" class="text-uppercase">아이디 :</label>
				        <input type="text" id="userId" name="userId" class="input-round big-input" placeholder="아이디는 공백없이  3자 이상 ~8자 이하"  style="ime-mode:disabled">
				          <span class="changeSpanId"></span>
				    </div>
					
				    <div class="form-group">
				        <label for="textbox" class="text-uppercase">비밀번호 :</label>
				        <input type="password"name="password" class="input-round big-input">
				    </div>
				
				    <div class="form-group">
				        <label for="errortextbox" class="text-uppercase">비밀번호 확인 :</label>
				        <input type="password" id="passwordCheck" name="passwordCheck" class="input-round big-input" >
				        <span class="changeSpanPW"></span>
				    </div>
				    
				    <div class="form-group">
				        <label for="errortextbox" class="text-uppercase">이름 :</label>
				        <input type="text" name="userName" class="input-round big-input">
				    </div>
				                   
				   	<div class="form-group">
				        <label for="errortextbox" class="text-uppercase">생년월일 :</label>
				        <input type=text id="datepicker" name="birth" class="input-round big-input" readOnly>
				    </div>     
				              
   				    <div class="form-group">
					    <div class="ui-widget">
						  <label>좋아하는 견종: </label><span style="color:gray">*입력 또는 선택이 가능합니다.</span>
						  <select id="combobox" name="dogNo">
						    <option value="">Select one...</option>
						  </select>
						</div>
					</div>
						          
					<div class="form-group">
				        <label for="errortextbox" class="text-uppercase">휴대전화 :</label>
				        <input type="text" name="phone" class="input-round big-input" placeholder="'-'제외하고 숫자만 입력 " >
				    </div>
				    
				    <div class="form-group">
				        <label for="errortextbox" class="text-uppercase">주소 :</label>
				        <div>
				        	<input type="text" id="postNo" name="postNo" class="input-round big-input col-md-6 col-xs-6" >
				        	<input type="button" id="searchPost" value="우편번호검색" class="highlight-button btn-large input-round col-xs-4 pull-right" style="padding:12px 20px 9px;">
				        </div>
				        <input type="text" id="address1" name="address1" class="input-round big-input">
				        <input type="text" id="address2" name="address2" class="input-round big-input">
				    </div>
				    
   				    <div class="form-group">
				    	<p class=""><span class="spanChange">이메일 :</span> <input type="button" class="pull-right col-md-2 col-xs-4 highlight-button input-round text-center no-margin-bottom" id="checkEmail" value="인증하기"></p>
				    	<input type="text" name="email1" class="col-md-6 margin-top-two big-input" id="email1" style="border-top-left-radius: 5px;border-bottom-left-radius: 5px;"/>
    	         		<div class="col-md-6 no-padding margin-top-two">
							<select name="email2" id="email2" style="border-top-right-radius: 5px;border-bottom-right-radius: 5px; padding-bottom:9px;" class="big-input">
								<option value="1">직접입력</option>
								<option value="naver.com">@naver.com</option>
								<option value="daum.net">@daum.net</option>
								<option value="gmail.com">@gmail.com</option>
								<option value="hotmail.com">@hotmail.com</option>
								<option value="nate.com">@nate.com</option>
							</select>
		           		</div>
		           		<div class="changeDiv1"></div>
		           		<input type="hidden" name="email" id="email">
                        <input type="hidden" id="tempNo" value=""/>
			       </div> 

			                    
			    </form>
			    <!-- end form  -->  
        
		         <div class="text-center">
                 	<input type="button" class="input-round highlight-button-dark btn no-margin post-search" id="join" value="회원가입하기"/>
                 </div>
			             
            </div>
        </div><!-- row1 -->
    </div><!-- container1 -->
    
</section>
<!-- end content section -->
	    
        
  <jsp:include page="../common/js.jsp" />

	<jsp:include page="../layout/footer.jsp" />
</body>
</html>