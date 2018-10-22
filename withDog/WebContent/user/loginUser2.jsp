<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	
	<jsp:include page="../common/css.jsp" />
	
	<title>로그인</title>
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- 카카오 로그인 -->
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!-- 구글 로그인 -->
	<meta name="google-signin-client_id" content="730614234797-kcpkvfk21csstmbunn2hh21tcqjsik71.apps.googleusercontent.com">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<script type="text/javascript">
	
		$( function() {
			
			$("#userId").focus();
			
			//회원가입 연결
			$("#join").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			//아이디/비밀번호찾기 연결 			
			$("#findUser").on("click" , function() {
				self.location = "/user/findUser"
			});
			
			//로그인 연결 
			$("#loginBtn").on("click" , function() {
				
				//유효성체크
				var userId=$("#userId").val();
				var passWord=$("#password").val();
				
				if(userId == null || userId.length <1) {
					$(".spanClass").html("**ID 를  입력해주세요").css('color','red');	
					$("#userId").focus();
					$("input").on("click",function(){
						$(".spanClass").html("");
					});
					return;
				}
				
				if(passWord == null || passWord.length <1) {
					$(".spanClass").html("**비밀번호를 입력해주세요").css('color','red');	
					$("#password").focus();
					$("input").on("click",function(){
						$(".spanClass").html("");
					});
					return;
				}
							
				//로그인 
				$.ajax({
							url : "/user/json/loginUser",
							method : "POST",
							datatype : "json",
							data: JSON.stringify({
								userId:$("#userId").val(),
								password:$("#password").val()
							}),
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status){
								
								var userConCheck = JSONData.userConCheck;
								
								if(userConCheck=='1'){
									
									self.location = "/common/mainPage";
								}else if(userConCheck=='0'){
									//휴면회원
									alert("아이디로 1년 이상 로그인 되지 않아 휴면 상태로 전환되었습니다.");
									self.location = "/user/changeUserCon";
								}else{
									//탈퇴한 회원 로그인시도시, 또는  비번  블일치
									$(".spanClass").html("**아이디 또는 비밀번호가 일치하지 않습니다.").css('color','red');	
									
									$("input").on("click",function(){
										$(".spanClass").html("");
									});
								}
			
							}
						
		 				});//end of Ajax
		 				
		 				
		 				
			});// end 로그인
			
	
			//엔터키 이벤트 ( 로그인 클릭한것처럼)
			$("#password").keydown(function(event){
		       if(event.keyCode==13){
		    	   $('#loginBtn').trigger('click');
		        }
		    });
			
	
			

	}); //end 제이쿼리
	
	
	/////////////////////////////////////////////////////
	//SNS로그인
	$(function(){
			
			//카카오 로그인
			$("#imgKakao").on("click" , function() {
				loginWithKakao()
			});// end 카카오 로그인
			
			Kakao.init('5200ef0db37c84d21094845a8d36eb70');
			
		    function loginWithKakao() {
		      // 로그인 창을 띄웁니다.
		      Kakao.Auth.login({
		        success: function(authObj) {
		            // 로그인 성공시, API를 호출합니다.
		            Kakao.API.request({
		              url: '/v1/user/me',
		              success: function(res) {
		            	  
		                var userId = "k"+res.id;
		                var snsType =0; 
		                
		                checkUserId(userId,snsType);
		                
		              },
		              fail: function(error) {
		                alert(JSON.stringify(error));
		              }
		            });
		          },
		          fail: function(err) {
		            alert(JSON.stringify(err));
		          }
		      });
		    };// end function loginWithKakao()
		    
		    
		    //구글로그인
	        $(function googleLogin() {
			    gapi.load('auth2', function(){
			    	// GoogleAuth 라이브러리에 대한 싱글 톤을 가져 와서 클라이언트를 설정합니다.
			      auth2 = gapi.auth2.init({
			        client_id: '371079507586-pinccq21oaes42c1j79usq7k6588c7jn.apps.googleusercontent.com',
			        //클라이언트 ID
			        cookiepolicy: 'single_host_origin'
			        // Request scopes in addition to 'profile' and 'email'
		//	         scope: 'profile email',
		//	         fetch_basic_profile: 'false',
			    
			      });
		      attachSignin(document.getElementById("google"));
		    });
		  });
			    
	        function attachSignin(element) {
	  		  
			    console.log(element.id);
			    auth2.attachClickHandler(element, {},
			       function(googleUser) {
			    	 var userId ="g"+googleUser.getBasicProfile().getId();
			    	 var snsType =2;
			    	 checkUserId(userId,snsType);
			        })
			      
			  };
		    
			  //네이버로그인
			  $("#naver").on("click",function(){
				  
					$.ajax({
							url : "/user/json/loginWithNaver" ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								popWin = window.open("https:\/\/nid.naver.com\/oauth2.0\/authorize?response_type=code&client_id=FCLaJ11V_c1179DGKDU1&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fuser%2FloginWithNaver&state=1195036747457242073069113635870824381246", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
							}
						});//end ajax
						
					


		    	});// end 네이버 로그인
				  
				  
		    	window.name = "loginView";  
				  
			  
			
		    ////////////////////////////////////////////
		    //SNS 아이디 체크 
		    function checkUserId(userId,snsType){
		    	
		    	var snsType =snsType*1;
		    	
		    	$.ajax({
						url : "/user/json/checkSnsUserId",
						method : "POST" ,
						dataType : "json",
						data: JSON.stringify({
							userId : userId,
							snsType : snsType
						}),
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						
						success : function(JSONData , status) {
							
							if(JSONData){
								self.location = "/common/mainPage";
							}else{
								self.location = "/user/addSnsUser";
							}
						}
					});//end of ajax
					
		    }//end function checkUserId() 
	
	});//end 제이쿼리 
	

</script>
	<!-- 페이스북 로그인 1-->	
	<script type="text/javascript">
	
		  // This is called with the results from from FB.getLoginStatus().
		  function statusChangeCallback(response) {
		    console.log('statusChangeCallback');
		    console.log(response);
		    if (response.status === 'connected') {
		   
		      testAPI();
		    } else {
		   
		      document.getElementById('status').innerHTML = 'Please log ' +
		        'into this app.';
		    }
		  }
		
		  
		  function checkLoginState() {
		    FB.getLoginStatus(function(response) {
		      statusChangeCallback(response);
		    });
		  }
		
		  window.fbAsyncInit = function() {
		    FB.init({
		      appId      : '{207057253249778}',
		      cookie     : true,  // enable cookies to allow the server to access 
		                          // the session
		      xfbml      : true,  // parse social plugins on this page
		      version    : 'v2.8' // use graph api version 2.8
		    });
		
		   
		
		   FB.getLoginStatus(function(response) {
		      statusChangeCallback(response);
		      // alert(JSON.stringify(response)); 
		    });
		
		  };
		  
		
		 
		  function testAPI() {
		    console.log('Welcome!  Fetching your information.... ');
		    FB.api('/me', function(response) {
		    	// alert(JSON.stringify(response.id)); 
		    	//var name = response.name;
		    	var userId = "f"+response.id;
		    	var snsType = 3;
		    	checkUserId(userId,snsType);
		    	
		    });
		    
		    ////////////////////////////////////////////
		    //SNS 아이디 체크 
		    function checkUserId(userId,snsType){
		    	
		    	alert(userId+"userId");
		    	
		    	$.ajax({
						url : "/user/json/checkSnsUserId",
						method : "POST" ,
						dataType : "json",
						data: JSON.stringify({
							userId : userId,
							snsType : snsType,
						}),
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						
						success : function(JSONData , status) {
							
							if(JSONData){
								self.location = "/common/mainPage";
							}else{
								self.location = "/user/addSnsUser";
							}
						}
					});//end of ajax
					
		    }//end function checkUserId() 
		    
		  }
	  
	</script>

	<!-- 페이스북 로그인 2 -->
	
	<script type="text/javascript">
	/*
	(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.0&appId=207057253249778&autoLogAppEvents=1';
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk')); 
	*/
	
	</script>	

</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />
		
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/login_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/login_tit.png"></h1>
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
        <section class="wow fadeIn">
            <div class="container">
                <div class="row">
                
                    <div class="col-md-5 col-sm-8 col-xs-11 center-col xs-no-padding">
                    	
                    	<div>
<!-- 	                    	<form> -->
		                        <div class="col-md-12 no-padding">
		                            <label>ID</label>
		                            <input type="userId" name="userId" id="userId" placeholder="아이디">
		                              <span class="spanId"></span>
		                        </div>
		                        
		                        <div class="col-md-12 no-padding">
		                            <label>Password</label>
		                            <input type="password" name="password" id="password" placeholder="비밀번호">
		                        	<span class="spanClass"></span>  
		                        </div>
		                        
<!-- 	                         </form>  -->
	                         
                          </div>   
                          
                          <div>
	                          <div class="col-md-12 col-xs-11 no-padding xs-center-col">
	                           <input type="button"  class="btn highlight-button-dark btn-medium btn-round margin-five no-margin-right" type="submit" id="loginBtn" value="Login"/>             
	                          </div>
	                          
	                          <div class="col-md-12 col-xs-11 no-padding xs-center-col">
	                         	<a class="highlight-button btn btn-medium button text-center col-md-12 col-xs-12" href="#" id ="join">회 원 가 입</a>
	                          </div>	
	                         	
	                         <div class="col-md-12 col-xs-11 no-padding margin-ten">
	                         	<a href="#" class="display-block text-uppercase" id="findUser" style="width:460px;"> 아이디 찾기 | 비밀번호 찾기</a> 
	                         </div>	
                         </div>
                         
                   		  <!-- sns 로그인 -->           
            		      <div class="col-md-12 col-xs-11">
            		      
            		      	<div class="row">
            		      	 <!-- 카카오 --> 
	                          <div class="col-md-6 col-xs-11 no-padding">  
	                        	<a href="#"><img src="../images/login/kakao.png"/ id="imgKakao"></a>
							  </div>
	                                 
	                          	<!-- 구글 -->
								<div class="col-md-6" style="margin-left: -15px;">
									<a href="#"><img src="../images/login/google.png" id="google" /></a>
								</div>    
	                          </div>
	                          
                             <div class="row margin-two">        
						    	<!-- 네이버--> 
						    	<div class="col-md-6" style="margin-left: -15px;">
									<a href="#"><img src="../images/login/naver.png" id="naver" /></a>
								</div>	

								<!-- 페이스북 임시--> 
						    	<div class="col-md-6" style="margin-left: -15px;">
									<a href="#"><img src="../images/login/facebook.png"  /></a>
								</div>	

								<!-- 페이스북 -->
								<div class="col-md-6">
									<div class="fb-login-button" data-max-rows="1" data-size="medium" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" onlogin="checkLoginState();"></div>
								</div>
								
							 </div>		
						</div>
					</div>
	         </div>
	     </div>
	 </section>
        <!-- end content section -->
        
<jsp:include page="../layout/footer3.jsp" />

<jsp:include page="../common/js.jsp" />
</body>
</html>