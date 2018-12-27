<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	
	<title>로그인 화면</title>
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<!-- 카카오 로그인을 위한 스크립트 -->
	 <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	 <!-- 두번째 success의 request를 위한 스크립트 --> 
	 <script type="text/javascript" src="../javascript/ajaxUtil02.js"></script>
	 
	<script type='text/javascript'>
          
	Kakao.init('267da5a91cd9ec34d394300341892c43'); /* 메타 데이터화 AJAX 쓰기 */
	
        function loginWithKakao() {
          // 로그인 창을 띄웁니다.
          
          
          Kakao.Auth.login({
            success: function(authObj) {
            	 Kakao.API.request({
                     url: '/v2/user/me',
                     success: function(res) {
                   	  
                   	  alert(JSON.stringify(res));
                   	  /*alert(res.properties.nickname); */
                   	  var id = res.id;
                   	  var name = res.properties.nickname;
                   	  var kakaoemail = res.kakao_account.email;
                   	  alert(res.kakao_account.email);
                   	  /* alert(id); */
                   	  $.ajax(
                   			{
                   		url:"http://127.0.0.1:8080/user/json/kakao",
                   		method:"POST",
                   		data:JSON.stringify({
                   			userId:id,
                   			userName:name,
                   			email:kakaoemail
                   		}),
                   		dataType:"json",
                   		headers:{
                   			"Accept" : "application/json",
                   			"Content-Type" : "application/json"
                   		},
                   		success:function(data,status){
                   			if(data.password!=null){
                   				/* self.location("/index.jsp"); */
                   				$("form").attr("method","POST").attr("action","/index.jsp").submit();
                   			}else{
                   				/* self.location("/user/addUserView.jsp"); */
                   				$("form").attr("method","POST").attr("action","/user/addUserView.jsp").submit();
                   			}
                   			
                   			}
                   		                  				
                   			}      			  
					 	  );
                   	  
                   	  /* ajax end */
                   	
					 	  
					/* var info =  JSON.stringify(res);
                   		
                   	  var sendurl = "http://127.0.0.1:8080/user/json/kakao"; */
                   	                     		
                   		/* createRequest();
                   		 
                   	  	openSendRequest(sendurl,"POST",info); */
                   	 	 
                     },
                     fail: function(error) {
                       alert(JSON.stringify(error)+"::::::");
                     }
                   });
            },
            fail: function(err) {
              alert(JSON.stringify(err));
            }
          });
        };
        
        function loginNaver(){
        	/* popWin 
			= window.open("${apiURL}","popWin",	"scrollbars=no,scrolling=no,menubar=no,resizable=no"); */
        	self.location="${apiURL}","popWin",	"scrollbars=no,scrolling=no,menubar=no,resizable=no";
        }
     
    </script>
	
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	
	<script type="text/javascript">
	   
		/*=============jQuery 변경 주석처리 =============
		function fncLogin() {
			var id=document.loginForm.userId.value;
			var pw=document.loginForm.password.value;
			
			if(id == null || id.length <1) {
				alert('ID 를 입력하지 않으셨습니다.');
				document.loginForm.userId.focus();
				return;
			}
			
			if(pw == null || pw.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				document.loginForm.password.focus();
				return;
			}
		}
		
		//Call Back Method 이용 onload 시 Event 처리
		window.onload = function(){
			document.getElementById("userId").focus();
		}========================================	*/
		$( function() {
			
			if('${!empty user}'){
				document.getElementById("userId").value = '${user.userId}';
				document.getElementById("password").value = '${user.password}';
			}
			
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#userId").focus();
			
						
			//==> 추가된부분 : "Login"  Event 연결
			 $("img[src='/images/btn_login.gif']").on("click" , function() {

				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("input:password").focus();
					return;
				}
				
				//$("form").attr("method" , "POST");
				//$("form").attr("action" , "/login.do");
				//$("form").attr("target" , "_parent");
			    //$("form").submit();
				//==> 위의 4실행문과 같은의미			    
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					
				
			}); 
			
			$("input[name=userId]").keydown(function(key){
				if(key.keyCode == 13){
					alert("비밀번호를 입력하세요");
				}
			});
			
			$("input[name=password]").keydown(function(key){
				if(key.keyCode == 13){
					$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
				}
			});
		});
		
		
		//*=============jQuery 추가된부부분 : 회원원가입화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("img[src='/images/btn_add.gif']").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		
	</script>
	
	
	<!-- facebook logoin -->
	<script>
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
		      /* alert(JSON.stringify(response)); */
		    });
		
		  };
		
		  
		 /*  (function(d, s, id) {
		    var js, fjs = d.getElementsByTagName(s)[0];
		    if (d.getElementById(id)) return;
		    js = d.createElement(s); js.id = id;
		    js.src = "https://connect.facebook.net/en_US/sdk.js";
		    fjs.parentNode.insertBefore(js, fjs);
		  }(document, 'script', 'facebook-jssdk')); 버튼용*/
		
		 
		  function testAPI() {
		    console.log('Welcome!  Fetching your information.... ');
		    FB.api('/me', function(response) {
		    	/* alert(JSON.stringify(response.id)); */
		    	var name = response.name;
		    	var id = response.id;
		    	$.ajax(
		    	  {url:"http://localhost:8080/user/json/kakao",
		    	  method:"POST",
		    	  data:JSON.stringify(
		    			  {
		    		 userId:id,
		    		 userName:name
		    	}),
		    	dataType:"json",
		    	headers:{
		    		"Accept":"application/json",
		    		"Content-Type":"application/json"
		    	},
		    	success:function(data,status){
		    		if(data.password!=null){
		    			/* self.location("/index.jsp"); */
		    			$("form").attr("method","POST").attr("action","/index.jsp").submit();
		    		}else{
		    			/* self.location("http://localhost:8080/user/addUserView.jsp"); */
		    			$("form").attr("method","POST").attr("action","/user/addUserView.jsp").submit();
		    		}
		    	}
		    	  }		
		    	
		    	);/* ajax end */
		    	
		    	
		      console.log('Successful login for: ' + response.name);
		      document.getElementById('status').innerHTML =
		        'Thanks for logging in, ' + response.name + '!'+JSON.stringify(response);
		      
		    });
		  }
		  
		  /* $(function(){
			  FB.logout(function(response) {
			   // Person is now logged out
			});
		  }); */
		</script>
	<script>
	(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.0&appId=207057253249778&autoLogAppEvents=1';
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000" >
<jsp:include page="../layout/menubar.jsp"/>
<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
 <form name="loginForm"  method="post" action="/user/login" target="_parent">
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form>

<div align="center" >

<TABLE WITH="100%" HEIGHT="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">

<table width="650" height="390" border="5" cellpadding="0" cellspacing="0" bordercolor="#D6CDB7">
  <tr> 
    <td width="10" height="5" align="left" valign="top" bordercolor="#D6CDB7">
    	<table width="650" height="390" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="305">
            <img src="/images/logo-spring.png" width="305" height="390"/>
          </td>
          <td width="345" align="left" valign="top" background="/images/login02.gif">
          	<table width="100%" height="220" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="30" height="100">&nbsp;</td>
                <td width="100" height="100">&nbsp;</td>
                <td height="100">&nbsp;</td>
                <td width="20" height="100">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="50">&nbsp;</td>
                <td width="100" height="50">
                	<img src="/images/text_login.gif" width="91" height="32"/>
                </td>
                <td height="50">&nbsp;</td>
                <td width="20" height="50">&nbsp;</td>
              </tr>
              <tr> 
                <td width="200" height="50" colspan="4"></td>
              </tr>              
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_id.gif" width="100" height="30"/>
                </td>
                <td height="30">
                  <input 	type="text" name="userId"  id="userId"  class="ct_input_g" 
                  				style="width:180px; height:19px"  maxLength='50'/>          
          		</td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_pas.gif" width="100" height="30"/>
                </td>
                <td height="30">                    
                    <input 	type="password" name="password" id="password" class="ct_input_g" 
                    				style="width:180px; height:19px"  maxLength="50" />
                </td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="20">&nbsp;</td>
                <td width="100" height="20">&nbsp;</td>
                <td height="20" align="center">
   				    <table width="136" height="20" border="0" cellpadding="0" cellspacing="0">
                       <tr> 
                         <td width="56">
                         	<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
							<a href="javascript:fncLogin();">
                         		<img src="/images/btn_login.gif" width="56" height="20" border="0"/>
                         	</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
                         		<img src="/images/btn_login.gif" width="56" height="20" border="0"/>
                         </td>
                         <td width="10">&nbsp;</td>
                         <td width="70">
                         	<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
							<a href="/user/addUser">
                         		<img src="/images/btn_add.gif" width="70" height="20" border="0">
                         	</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
                       			<img src="/images/btn_add.gif" width="70" height="20" border="0">
                         </td>
                       </tr>
                     </table>
                     <table>
                     	<td>
                         <a href="javascript:loginNaver()"><img height="30" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
                         </td>
                         <td>
                         <a id="kakao_login" href="javascript:loginWithKakao()">
                         <img height="30" src="/images/uploadFiles/kakao_login.png" >
                         </a>
                         </td>
                         <td>
                         <!-- facebook -->
                         <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
							<div class="fb-login-button" data-max-rows="1" data-size="small" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div>
						</fb:login-button>
                         </td>
                     </table>
                 </td>
                 <td width="20" height="20">&nbsp;</td>
                </tr>
              </table>
            </td>
      	</tr>                            
      </table>
      </td>
  </tr>
</table>
</TD>
</TR>
</TABLE>

</div>

</form>


</body>

</html>