<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	
<%-- 	<jsp:include page="../common/css.jsp" /> --%>
	
	<title>로그인</title>
	
	<!-- 디자인 -->
	<link rel="stylesheet" href="../css/vegas.min.css" />
	<script src="http://zeptojs.com/zepto.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	
 	<script src="../js/jquery-2.2.4.min.js"></script>
	<script src="../js/vegas.min.js" /></script>

		<style>
		.form-signin {
		  width: 100%;
		  max-width: 300px;
		  padding-top: 105px;
		  margin: auto;
		}

		.form-signin .form-control {
		  position: relative;
		  box-sizing: border-box;
		  height: auto;
		  padding: 10px;
		  font-size: 16px;
		}
		.form-signin .form-control:focus {
		  z-index: 2;
		}
		.mg-t-30{
			margin-top:30px; 
		}

		.mg-r-30{
			margin-right: 30px;
		}
		.mg-b-10{
			margin-bottom: 10px;
		}
		.btn-none{
			border-color: #000;
			background-color: none;
		}
		.white{
			color: #fff;
		}
		.black{
			color: #000;
		}
		.btn-black{
			color: #fff;
			background-color: #000;
		}
	.input-fa{
	padding: 6px 12px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1;
    color: #222;
    text-align: center;
    border: 1px solid #ccc;
    width: 1%;
    white-space: nowrap;
    vertical-align: middle;
    display: table-cell;
    border-radius: 4px 0 0 4px;
    background-color: rgba(247, 247, 247, 0.5098039215686274);
	}
	.input-fa:first-child
	{
	 border-right:0;
	}

	.login-a:hover{
	color:#fff;
	background-color:#D86D39;
	}
	
	.join-a:hover{
	color:#D86D39;
	border-color:#D86D39;
	}
	.find-user-a:hover{
	color:#000;
	}
	
	.login-bg{  
	  background-image: url("../images/login/jamie-street-712602-unsplash.jpg");  
	background-repeat: no-repeat;
	  background-size: cover;
	  height:100vh;
	}

	</style>
	

	
	
	
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
			
			//로고클릭시 메인으로
			$(".mb-4").on("click" , function() {
				
				self.location.href="/common/mainPage"
			});
			
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
									//alert("아이디로 1년 이상 로그인 되지 않아 휴면 상태로 전환되었습니다.");
									swal("아이디로 1년 이상 로그인 되지 않아 휴면 상태로 \n전환되었습니다.").then(function(value){
										if(value){
											self.location = "/user/changeUserCon";
										}
									});
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
								
								popWin = window.open("https:\/\/nid.naver.com\/oauth2.0\/authorize?response_type=code&client_id=FCLaJ11V_c1179DGKDU1&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fuser%2FloginWithNaver&state=725686096104573705842676333917167259918", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
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
	
			$("#facebook").on("click",function(){
				 $('.fb-login-button').trigger('click');
			});
	
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
		    	
		    	//alert(userId+"userId");
		    	
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
	
	(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.0&appId=207057253249778&autoLogAppEvents=1';
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk')); 
	
	
	</script>	

</head>

<body class="text-center login-bg">

    <form class="form-signin">
      <a style="cursor: pointer;"><img class="mb-4 mg-t-30" src="../images/login/logo-light.png" alt="" width="60%"></a>

      <div class="form-group mg-t-30">
        	<div class="input-group">
                <span class="input-fa"><i class="fas fa-user"></i></span>
                <input type="userId" name="userId" id="userId" class="form-control" placeholder="아이디" required="required">
	        </div>
        </div>

      <div class="form-group">
        	<div class="input-group">
                <span class="input-fa"><i class="fas fa-lock"></i></span>
                <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호" required="required">
           </div>
           <span class="spanClass"></span>  
        </div>

      <a class="btn btn-lg btn-black btn-block mg-b-10 login-a" type="submit" id="loginBtn" value="Login"/>로그인</a>
      <a class="btn btn-lg btn-none btn-block black join-a" type="submit" id ="join">회원가입</a>

      <div class="mt-5 mb-3 mg-t-30"> <a class="white find-user-a" href="#" id="findUser">아이디 찾기 | 비밀번호 찾기</a></div>

      <div class="mg-t-30">
      	<!-- 카카오 로그인 -->
		<a class="mg-r-30" href="#">
			<img src="../images/login/kakao.png" id="imgKakao">
		</a>
		<!-- 네이버 로그인 -->
		<a class="mg-r-30" href="#">
			<img src="../images/login/naver.png" id="naver">
		</a>
		<!-- 페이스북 로그인 -->
		<a class="mg-r-30" href="#">
			<img src="../images/login/facebook.png" id="facebook">
			<div style="display:none;" class="fb-login-button" data-max-rows="1" data-size="medium" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" onlogin="checkLoginState();"></div>
		</a>
		<!-- 구글 로그인 -->
		<a href="#">
			<img src="../images/login/google.png" id="google">
		</a>
	  </div>

    </form>

        
</body>
</html>