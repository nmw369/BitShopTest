<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<jsp:include page="../common/css.jsp" />
<title>휴면계정 >> 일반회원 전환</title>

<style type="text/css">
.con_section{
padding : 0px 0px 120px 0px !important;

}

#check{
margin-top:40px !important; 
}

#head_section{
padding : 120px 0px 40px 0px !important;
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
	$( function() {
		
		$("#userName").focus();

		//핸드폰 인증
		$("#check").on("click" , function() {
			
			//이름과 휴대폰 번호 일치하면 인증번호 전송 
			$.ajax({
				url : "/user/json/changeUserCon",
				method : "POST",
				dataType : "json",
				data: JSON.stringify({
					userName:$("#userName").val(),
					phone:$("#phone").val(),
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					
					var check = JSONData.check;
					var tempNo = JSONData.tempNo;
					
					if(!check){
						$(".spanId").html("해당 정보 확인이 되지 않습니다.").css('color','red');
					}else{
						//고유번호 숨기기
						$("#tempNo").val(tempNo);
						$(".changeDiv1").append('<div class=\"col-md-12 bg-gray\" style=\"padding:20px 0px 0px;\"><div class=\"col-md-12\" style="\margin:0px 80px\"><input type=\"text\" id=\"userTextNum\" class="\col-md-6\" placeholder="\인증번호를 입력하세요.\" /><button type="\button\" class="\highlight-button-dark col-md-2\" id="\checkTextNum\" >확인</button></div></div>');
						$("#check").hide();	
						$(".spanChange").append("<span style=\"color:blue;font-size:12px;\">고객님의 인증번호를 입력해주세요</span>");
					}
				}
			});// end ajax
			
		});//end 인증번호 전송
		
		
		
		//엔터키 이벤트 ( 인증번호 전송하기 클릭한것처럼)
		$("#phone").keydown(function(event){
	       if(event.keyCode==13){
	    	   $('#check').trigger('click');
	        }
	    });
		

	});	
	
	
	//발송한 숫자와 고객이 입력한 숫자 비교
	$(document).on("click","#checkTextNum",function() {
		//숨겨놓은 발송 숫자
		var textNum = $("#tempNo").val();
		//alert("textNum"+textNum);
		//고객이 입력한 값
		var userTextNum = $("#userTextNum").val();
		//alert("userTextNum"+userTextNum);
		if(textNum!=userTextNum){
			alert("인증번호를 잘못 입력하였습니다.");
			$(".changeDiv1").remove();
			$(".changeDiv2").remove();
			$("#check").show();
		}else{
			alert("일반회원으로 전환되었습니다.로그인 페이지로 이동합니다.");
			update();
		}//end of if
	});
// 	$(document).on("click","#checkTextNum",function() {
		

// 	)};
		
		function update() {
			
			//휴면회원일 경우 세션 스콥에서 "userCon0"
			var userId = "${sessionScope.userCon0}"; 
			//alert("userId"+userId);
			
			$.ajax({
					url : "/user/json/changeUserConditionTest/"+userId,
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status){
						
						self.location = "/user/loginUser";
					}
			});
		
		}
	</script>	

	

</head>
<body>
		
			<jsp:include page="/layout/common-header.jsp" />
		
		
		 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog" id="head_section">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/changeUserCon_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h2 class="white-text tit_png"><img src="../images/sub/change_tit.png">
                         	<p style ="margin-top: 10px;">1년이상 로그인 되지 않아 휴면 상태로 전환되었습니다.</p>
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
        <section class="con_section">
            <div class="container clearfix"><!-- container1 -->
                <div class="row margin-five no-margin-top"><!-- row1 -->
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                    	<div class="separator-line bg-black" style="margin-bottom:30px;"></div>
                        <p class="black-text font-weight-600 text-uppercase text-large text-center">
                        	휴면회원을 해제하시려면 본인인증을 해주세요.
                        	</p>
                        
                        <div class="col-md-12" style="margin-top: 50px;">
	                        <form id="findIdForm">
	                        
	                            <div class="col-md-12 no-padding">
	                                <label>이름 :</label>
	                                <input type="text" name="userName" id="userName">
	                            </div>
	                            
	                             <div class="col-md-12 no-padding">
	                                <label>휴대전화 :</label><span class="spanChange"></span>
	                                <input type="text" name="phone" id="phone">
	                                <span class="changeSpan"></span>
	                            </div>
	                            <div class="changeDiv1"></div>
	                            <div class="changeDiv2"></div>
	                            <input type="hidden" id="tempNo" value="">
	                             
	                         </form> 
	                         
	                         <div class="text-center">
	                         	<button class="highlight-button btn no-margin post-search" id="check" >인증번호 전송하기</button>
	                         </div>
                         
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