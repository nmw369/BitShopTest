<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<jsp:include page="../common/css.jsp" />
	<title>회원탈퇴</title>
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
		$( function() {
			
			//회원탈퇴 연결
			$("#delete").on("click" , function() {
				
				//라디오 체크 여부
				if($("input:radio[name='leaveReason']").is(":checked") == true){
					  //컨펌창으로 한번 더 묻기
					  var result = confirm("정말 탈퇴를 하시겠습니까?");
					  
					  if(result){
							
						  var userId= $("input[name=userId]").val();
						  alert(userId);
						  var leaveReason= $("input[name=leaveReason]").val();
						  alert(leaveReason+"leaveReason");
						  //탈퇴
						  $.ajax({
								url : "/user/json/deleteUser",
								method : "POST",
								datatype : "json",
								data: JSON.stringify({
									userId : userId,
									leaveReason : leaveReason
								}),
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status){
									
										alert("회원탈퇴가 완료되었습니다.");
										self.location = "/common/mainPage";
									
				
								}
						
		 				});//end of Ajax
						  
						  
						  //$("form").attr("method","POST").attr("action","/user/deleteUser").submit();
					  
					  }else{
						  return;
						  
					  }	
					  
				}else{
					
					alert("사유를 선택해주세요"); 
					
				}	
				
			});
			
		});

	</script>	
	
</head>

<body>

	 <jsp:include page="../layout/header.jsp" />
<!-- 	<!-- head section --> 
<!--           <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog"> -->
<!--             <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt="" /> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-md-12 col-sm-12 text-center wow fadeInUp"> -->
<!--                         <h1 class="white-text">회원탈퇴</h1> -->
<!--                         <span class="white-text xs-display-none">with Dog</span> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </section>  -->
<!--         end head section -->

	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg"
		alt="" />
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


        
           	<!-- content section /// careers.htm /// form.html-->
        <section class="wow fadeIn">
            <div class="container"><!-- container -->
            		<div class="col-md-2 col-sm-3 sidebar">
						<jsp:include page="/layout/mypage-sideBar.jsp" />
					</div>
					
            		<div class="col-md-8 col-sm-6">
	            		<!-- 포인트 -->
	            		<h2 class="font-weight-600">회원 탈퇴 </h2>
			                   <div class="separator-line bg-black no-margin-lr"></div>
			                   <p class="text-large black-text letter-spacing-2">현재 고객님의 사용가능한 포인트는<strong> ${user.currentPoint} point</strong>입니다.</p>
	            		</div>
	                    <!-- 내용 -->
	                    <div class="col-md-8 col-sm-6 bg-gray career-form">
	                    	<h2 class="font-weight-600" style="margin-bottom:20px">회원탈퇴 사유확인 </h2>
	                        <!--  <p class="text-med margin-five">회원 탈퇴 사유를 선택해주세요</p>-->
		                        <!-- form -->
		                        <form>
		                            <div class="col-md-8 col-sm-4"  style="margin-left:-20px">
		                                <label class="radio-inline"><input type="radio" name="leaveReason" id="inlineRadio1" value="1">동물교감치유 서비스 불만 </label>
		                                <label class="radio-inline"><input type="radio" name="leaveReason" id="inlineRadio2" value="2">이용빈도 낮음</label>
		                             </div>   
		                             <div class="col-md-8 col-sm-4"  style="margin-left:-20px"> 
		                                <label class="radio-inline"><input type="radio" name="leaveReason" id="inlineRadio3" value="3">개인정보유출 우려</label>
		                                <label class="radio-inline"><input type="radio" name="leaveReason" id="inlineRadio4" value="4">스토어상품 배송 지연</label>
		                            </div>
		                            <input type="hidden" name="userId" value="${sessionScope.user.userId}">
		                        </form>
		                        <!-- end form -->
	                    	</div>
						              	        
	              	        <!-- button  -->
	       					<div class="col-md-8 col-sm-6 text-center">
								<button class="highlight-button btn post-search" id="delete">회원탈퇴</button>
	                		</div>
	                		<!-- end button  -->


              	         </div>
	                	<!-- 내용 -->  


            </div><!-- container -->
         
        </section>
        <!-- end content section -->    
        
<jsp:include page="../layout/footer.jsp" /> 

<jsp:include page="../common/js.jsp" />
</body>
</html>