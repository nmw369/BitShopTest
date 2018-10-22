<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

	<jsp:include page="../common/css.jsp" />
	
	<title>회원정보 수정</title>
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- 카카오 로그인 -->
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!-- 구글 로그인 -->
	<meta name="google-signin-client_id" content="730614234797-kcpkvfk21csstmbunn2hh21tcqjsik71.apps.googleusercontent.com">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	
	<script type="text/javascript">

	//좋아하는 견종 관련 제이쿼리 
	$(function () {
		
		//좋아하는 견종 dogNo => dogBreedKO
		var dogNum  = "${user.dogNo}";
		var displayValue ;
		
		//dogNo =>  dogBreedKO
		$.ajax(
				{
				url : "/dogBreedDic/json/getDogBreed2",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					dogNo : dogNum
				}),
				success : function(JSONData , status) {
					
					displayValue = JSONData.key.dogBreedKO;
					$( "#dogName" ).text(displayValue);
				}
			
			});// end of ajax
		
		//셀렉박스 옵션
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
					$("#likeDogNo").append($('<option value='+data.allDogBreedInfo[i].dogNo+'>'+data.allDogBreedInfo[i].dogBreedKO+'</option>'));
					
				}
				//$("#a > option[value='dogNum']").attr("selected", "true"); //value값으로 선택
				$("#likeDogNo option:selected").val(dogNum);
				$("#likeDogNo option:selected").text(displayValue);
				
			}
			
		}); //end of ajax	
		
	
	}); //end 좋아하는 견종제이쿼리 끝

	
	//유저 정보조회 제이쿼리  1. 정보 조회 :: 가입일, 이메일   2.도로주소명  
	$( function() {
		
		//가입일 보여줄때 뒤에 시간 빼기
		var joinDate =$("#joinDate").text().substring( 0, 10 );
		$("#joinDate").text(joinDate);
		
		//이메일 정보 세팅
		var email = "${user.email}";
		var emailAll = email.split('@');
		var email1 = emailAll[0];
		var email2 = emailAll[1];
		
		$("#email1").val(email1);
		if(email2=='naver.com'){
			$("#email2").val("naver.com").prop("selected", true); 
		}else if(email2=='daum.net')	{
			$("#email2").val("daum.net").prop("selected", true); 
		}else if(email2=='gmail.com')	{
			$("#email2").val("gmail.com").prop("selected", true); 
		}else if(email2=='hotmail.com')	{
			$("#email2").val("hotmail.com").prop("selected", true); 
		}else if(email2=='nate.com')	{
			$("#email2").val("nate.com").prop("selected", true); 
		}else{
			//직접입력인 경우
			$("#email2").val("1").prop("selected", true); 
			$("#email1").val(email);
		}
		
		//이메일 셀렉박스 선택시 직접입력 누르면
		$("#email2").on("change",function(){
			if($("#email2").val()=='1' ){
				$("#email1").focus();
			}
		});
		
		
		//도로명 주소  우편번호 검색 클릭시
		$("#searchPost").on("click" , function() {
		
			var pop = window.open("http://localhost:8080/user/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		});
						
		function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			//alert(roadFullAddr);
			$("#postNo").val(zipNo);
			$("#address1").val(roadAddrPart1);
			$("#address2").val(addrDetail);
	
		}	
		window.jusoCallBack = jusoCallBack;
		
		//회원정보 수정 이벤트
		$("#change").on("click" , function() {
			
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
					alert("email"+email)
					//$("#email2 option:selected").val(email2);
				}
			
				
			//수정 넘기기전 유효성 체크
			updateUser();
			
		});
	
	
	}); //end 유저 정보조회 제이쿼리
	
	/////////////////////////////////////////////////////
	//SNS로그인 제이쿼리 
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
		    
		    ////////////////////////////////////////////
		    //SNS 아이디 체크 
		    function checkUserId(userId,snsType){
		    	
		    	var snsType =snsType*1;
		    	
		    	$.ajax({
						url : "/user/json/connectSnsId",
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
								self.location = "/user/getUser";
							}else{
								alert("해당 아이디로 연동은 불가합니다.");
							}
						}
					});//end of ajax
					
		    }//end function checkUserId() 
	
	});//end SNS로그인 제이쿼리 


	//수정시 유효성 체크 매서드
	function updateUser() {
		
		var phone=$("input[name='phone']").val();
		var email= $("#email").val();
		var email1= $("#email1").val();
		
		//휴대전화
		if(phone == null || phone.length <1){
			alert("휴대전화는  반드시 입력하셔야 합니다.");
			return;
		}
		
		//이메일 입력여부
		if(email == null || email.length <1){		
			alert("이메일이 입력되지 않았습니다.");
			$("input:text[name='email']").focus();
			return;
		}
		
		if(email1 == null || email1.length <1){		
			alert("이메일이 입력되지 않았습니다.");
			$("input:text[name='email1']").focus();
			return;
		}
	
	$("form").attr("method","POST").attr("action","/user/updateUser").submit();
	
	}//end updateUser()

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
					url : "/user/json/connectSnsId",
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

	<jsp:include page="../layout/header.jsp" /> 
	
<!-- 	<!-- head section --> 
<!-- 	 <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog"> -->
<!-- 	   <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt="" /> -->
<!-- 	   <div class="container"> -->
<!-- 	       <div class="row"> -->
<!-- 	           <div class="col-md-12 col-sm-12 text-center wow fadeInUp"> -->
<!-- 	                <h1 class="white-text">회원정보 수정</h1> -->
<!-- 	               <span class="white-text xs-display-none">Register and modify user information.</span> -->
<!-- 	            </div> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	</section>  -->
<!-- 	<!-- end head section -->	 

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
	
        <!-- form option #2 -->  
        <section class="wow fadeIn" >
            <div class="container">
                <div class="row">
                
				<!-- sidebar  -->
				<div class="col-md-2 col-sm-3 sidebar">
					<jsp:include page="/layout/mypage-sideBar2.jsp" />
				</div>
				<!-- end sidebar  -->
					
				<!-- content -->
				<div class="col-md-9 col-sm-9 col-md-offset-1">		
             		<h3 style="margin-bottom:20px">회원정보수정</h3>
                       <form>
                       	<div class="form-group">
                       	
                       	
                       		<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>아이디</strong></div>
								<div class="col-xs-8 col-md-8">${user.userId}</div>
								<input type="hidden" id="" name="userId" value="${user.userId}">
							</div>
							<hr/>
                           
                           
                       		<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>이&nbsp;름</strong></div>
								<div class="col-xs-8 col-md-8">${user.userName}</div>
								 <input type="hidden" id="" name="userName" value="${user.userName}">
							</div>
							<hr/>
                              
                              
                            <div class="row"> 
                            	<div class="col-xs-4 col-md-4"><strong>생년월일</strong></div>
                            	<div class="col-xs-8 col-md-8">${user.birth}</div>
                            	<input type="hidden" id="" name="birth" value="${user.birth}">
                            </div>
                            <hr/>
                            
                            
                            <div class="row"> 
                            	<div class="col-xs-4 col-md-4"><strong>이메일</strong></div>
                            	<div class="row">
	                            	<div class="col-xs-4 col-md-4 "></div>
	                            	<div class="col-xs-8 col-md-8 pull-right">	
		                                <input type="text" name="email1" class="col-md-4" id="email1">
						                <!--  <input type="text" class="col-md-1 no-border" placeholder="@">
						                <input type="text" name="emailText"class="col-md-2" id="emailText">-->
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
					           		</div>
				           		</div>
				           		  <input type="hidden" name="email" id="email">
                            </div>
                            <hr/>
                            
                            <div class="row"> 
                            	<div class="col-xs-4 col-md-4"><strong>전화번호</strong></div>
                                <input type="text" id="" name="phone" class="input-round big-input col-xs-8 col-md-8" value="${user.phone}">
                            </div>
                            <hr/>
                                
                                                      
                           	 <div class="row">  
                            	<div class="col-xs-4 col-md-4"><strong>주소</strong></div>
                                 <div class="row"> 
                               		<input type="text" id="postNo" name="postNo" required class="input-round big-input col-md-2" value="${user.postNo}" >
                               		<input type="button" class="col-md-2" id="searchPost" value="우편번호검색">
                               	</div>
                               	<div class="row"> 
                               		<div class="col-xs-4 col-md-4"></div>
                               		<input type="text" id="address1" name="address1" required class="input-round big-input col-xs-8 col-md-8" value="${user.address1}" >
                               	</div>
                               	<div class="row"> 	
                               		<div class="col-xs-4 col-md-4"></div>
                               		<input type="text" id="address2" name="address2" required class="input-round big-input col-xs-8 col-md-8" value="${user.address2}" >
                            	</div>
                            </div>
                            <hr/>
                            
                            
                            <div class="row"> 
						 		<div class="col-xs-4 col-md-4 "><strong>좋아하는 견종</strong></div>
                        		<div class="col-xs-4 col-md-4 "></div>
                        		<div class="col-xs-8 col-md-8">	
                        			<div class="ui-widget">
						  				<select id="likeDogNo" name="dogNo">
						   					 <option value=""></option>
						  				</select>
									</div> 
								</div>
								
                            </div>
                            <hr/>
                            
                            
                            <div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>가입일</strong></div>
								<div class="col-xs-8 col-md-8"  id="joinDate">${user.joinDate}</div>
								<input type="hidden" name="joinDate" value="${user.joinDate}">
							</div>
							<hr/>
							
							
							<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>현재포인트</strong></div>
								<div class="col-xs-8 col-md-8">${user.currentPoint}</div>
								<input type="hidden" id="" name="currentPoint" value="${user.currentPoint}">
							</div>
							<hr/>
            
							
							<div class="row">
								<div class="row">
									<div class="col-xs-4 col-md-12"><strong>&nbsp;&nbsp;SNS 계정연동관리 </strong></div>
								</div>
								<hr/>
								
								<!-- 네이버 -->
								<div class="row">
									<div class="col-xs-8 col-md-12">
		                           		<div class="col-xs-4 col-md-4"><img src ="../images/login/n_icon.png">네이버</div>
		                           		<div class="col-xs-8 col-md-8">
		                           			<c:choose>
		                           				<c:when test="${user.snsNaverId==null}">연결된 정보가 없습니다.<a href="#"><img src ="../images/login/naver1.png" id="naver"></a></c:when>
		                           				<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>		
		                           			</c:choose>
	                         			</div>
	                         		</div>	
                         		</div>	
                         		<hr/>
                         		
                         		<!-- 카카오 -->
                         		<div class="row">
									<div class="col-xs-8 col-md-12">
		                           		<div class="col-xs-4 col-md-4"><img src ="../images/login/k_icon.png">카카오</div>
		                           		<div class="col-xs-8 col-md-8">
			                 				<c:choose>
												<c:when test="${user.snsKakaoId==null}">연결된 정보가 없습니다.&nbsp;&nbsp;<a href="#"><img src="../images/login/kakao1.png"/ id="imgKakao"></a></c:when>
										  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>	
								  			</c:choose>
	                         			</div>
	                         		</div>	
                         		</div>
                         		<hr/>
                         		
                         		<!-- 구글 -->
                         		<div class="row">
									<div class="col-xs-8 col-md-12">
		                           		<div class="col-xs-4 col-md-4"><img src ="../images/login/g_icon.png">구글</div>
		                           		<div class="col-xs-8 col-md-8">
			                 				<c:choose>
												<c:when test="${user.snsGoogleId==null}">연결된 정보가 없습니다.&nbsp;&nbsp;<a href="#"><img src="../images/login/google1.png"/ id="google"></a></c:when>
										  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>		
								  			</c:choose>
	                         			</div>
	                         		</div>
                         		</div>	
                         		<hr/>
                         		
                         		<!-- 페이스북 -->
                         		<div class="row">
									<div class="col-xs-8 col-md-12">
		                           		<div class="col-xs-4 col-md-4"><img src ="../images/login/f_icon.png">페이스북</div>
		                           		<div class="col-xs-8 col-md-8">
			                            	<c:choose>
												<c:when test="${user.snsFacebookId==null}">연결된 정보가 없습니다.&nbsp;&nbsp;<a href="#"><img src="../images/login/facebook1.png"/ id="facebook"></a></c:when>
										  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>		
								  			</c:choose>
	                         			</div>
	                         		</div>	
                         		</div>
                     
                          </div> 
      						<hr/>
      						
      					   <!-- 어드민만 볼수있음 -->
      					   
                           <c:if test="${sessionScope.user.role=='admin'}"> 
                           
                 			 <div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>계정상태</strong></div>
						  		<div class="col-xs-8 col-md-8">
									<select name="userCondition" id="">
											<option value="0" ${user.userCondition=='0' ? "selected" : "" }>휴면</option>
											<option value="1" ${user.userCondition=='1' ? "selected" : "" }>정상</option>
											<option value="2" ${user.userCondition=='2' ? "selected" : "" }>탈퇴</option>
									</select>
								</div>
							</div>
                           	<hr/>
                 
                           	<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>최근접속일</strong></div>
								<div class="col-xs-8 col-md-8">${user.recentlyDate}</div>
								<input type="hidden" id="" name="recentlyDate" value="${user.recentlyDate}">
							</div>
                           	<hr/>
                           	
                           	
                       		<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>탈퇴일</strong></div>
								<div class="col-xs-8 col-md-8">${user.leaveDate}</div>
								<input type="hidden" id="" name="leaveDate" value="${user.leaveDate}">
							</div>
                            <hr/>
                            
                            
                           	<div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>탈퇴사유</strong></div>
								<div class="col-xs-8 col-md-8">${user.leaveReason}</div>
								<input type="hidden" id="" name="leaveReason" value="${user.leaveReason}">
							</div>
                           	<hr/>
                           
                            <div class="row">
						  		<div class="col-xs-4 col-md-4"><strong>권한</strong></div>
						  		<div class="col-xs-8 col-md-8">
									<select name="role" id="role">
											<option value="user" ${user.role=='user' ? "selected" : "" }>user</option>
											<option value="admin" ${user.role=='admin' ? "selected" : "" }>admin</option>
									</select>
								</div>
							</div>
                           	<hr/>
                           	 
                           
                           </c:if>
                           
                       </form>
                       
                             <div class="form-group">
                                <span class="required margin-three">*Please complete all fields correctly</span>
                                <input type="button" class="highlight-button btn no-margin post-search col-md-3" id="change" value="수정하기"/>
                            </div>
                        
                    </div>
                </div>
            </div>
        </section>
        <!-- end form option #2 -->   
        
        <jsp:include page="../common/js.jsp" />
        
        <jsp:include page="../layout/footer.jsp" />

</body>
</html>