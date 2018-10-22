<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>footer</title>
<jsp:include page="/common/chatBot.jsp" />
  <style>
/*   #closeButton{ */
/*   z-index: 9999; */
/*   } */
  .animated{
    -webkit-animation-duration: 0.55s;
  animation-duration: 0.55s;
  -webkit-animation-timing-function: ease;
  animation-timing-function: ease;
  }
  
  #closeButton{
  margin-left : 105px;
  position: fixed;
  width: 13px;
  height:13px;
  margin-top: 15px;
  cursor: pointer;
  }
  
      #openChatBot{
	font-weight: bold; 
	height: auto; 
	padding: 0; 
	position: fixed; 
	right: 45px; 
	text-align: center; 
	text-decoration: none; 
	top: 91%; 
	width: auto; 
	background-color: #000; 
	z-index: 555; 
	border-radius:2px;
      }
     #clickChatBot{
        position: fixed;
        right: 100px;
        bottom: 50px;
      }
      
/*  @media screen and (max-width: 360px) { */
/*   #clickChatBot { */
/*     display: none; */
/*   } */
 @media screen and (max-width: 735px) {
  #clickChatBot {
    display: none;
  }
}
    </style>
    <script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
    <script>
//       $( document ).ready( function() {
//         $( window ).scroll( function() {
//           if ( $( this ).scrollTop() > 150 ) {
//             $( '.top' ).fadeIn();
//           } else {
//             $( '.top' ).fadeOut();
//             $( '#frame' ).fadeOut();
//           }
//         } );
        $(function () {
        $( '#clickChatBot' ).click( function() {
        	$("#frame").toggle();
        	$("#clickChatBot").css('display','none');
        } );
        
        $( '#closeButton' ).click( function() {
        	$("#frame").toggle();
        	$("#clickChatBot").toggle();
        } );
        
        
        
        
      } );
    </script>
    <!-- 채팅스크립트 -->
  
</head>
<body>

<!-- footer -->
        <footer>
            <div class=" bg-white footer-top">
                <div class="container">
                    <div class="row margin-four">
                        <!-- phone -->
                        <div class="col-md-4 col-sm-4 text-center"><i class="icon-phone small-icon black-text"></i><h6 class="black-text margin-two no-margin-bottom">123-456-7890</h6></div>
                        <!-- end phone -->
                        <!-- address -->
                        <div class="col-md-4 col-sm-4 text-center"><i class="icon-map-pin small-icon black-text"></i><h6 class="black-text margin-two no-margin-bottom">Seoul, South Korea</h6></div>
                        <!-- end address -->
                        <!-- email -->
                        <div class="col-md-4 col-sm-4 text-center"><i class="icon-envelope small-icon black-text"></i><h6 class="margin-two no-margin-bottom"><a href="/common/index.jsp" class="black-text">withdog.ga</a></h6></div>
                        <!-- end email -->
                    </div>
                </div>
            </div>
            <div class="container onepage-footer-middle">
                <div class="row">
                    <div class="col-md-12 col-sm-12 footer-social text-right text-center">
                        <!-- social media link -->
                        <a target="_blank" href="https://www.kakaocorp.com/"><i class="fa fa-comment"></i></a>
                        <a target="_blank" href="https://www.instagram.com/"><i class="fa fa-instagram"></i></a>
                        <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-facebook"></i></a>
                        <a target="_blank" href="https://www.naver.com/"><i class="fa fa-coffee"></i></a>
                        <a target="_blank" href="https://plus.google.com"><i class="fa fa-google-plus"></i></a>
                        <!-- end social media link -->
                    </div>
                </div>
            </div>
            <div class="container-fluid bg-dark-gray footer-bottom">
                <div class="container">
                    <div class="row margin-three">
                        <!-- copyright -->
                        <div class="col-md-6 col-sm-6 col-xs-12 copyright text-left letter-spacing-1 xs-text-center xs-margin-bottom-one">
                            &copy; 2018 by withDog.Com. All Right Reserved.
                        </div>
                        <!-- end copyright -->
                        <!-- logo -->
                        <div class="col-md-6 col-sm-6 col-xs-12 footer-logo text-right xs-text-center">
                            <a href="index.html"><img src="../images/logo-light-gray.png" alt=""/></a>
                        </div>
                        <!-- end logo -->
                    </div>
                </div>
            </div>
            <!-- scroll to top --> 
            <a href="javascript:;" class="scrollToTop"><i class="fa fa-angle-up"></i></a>
             
</footer>
        <!-- end footer -->
        
        
<!--   챗봇 -->
	      
     	<img id="clickChatBot" class="top animated zoomIn" style="width: 145px; height: 60px; cursor: pointer;" src="/images/oneone.png"/>
    
    <%-- <jsp:include page="/quick/chating.jsp"></jsp:include> --%>

<div id="frame" class="animated zoomIn fast" style="display: none;">

	<div class="content">
		<div class="contact-profile">
			<img class="logo" src="/images/whiteLogo.png" alt="" />
			<p class="one">1:1 빠른상담</p><img id="closeButton" src="/images/close-button.png"  ><br>
			 <div class="social-media">
				<span><i style="font-size: 11px">보통 10분내에 응답합니다.</i></span>
				<span><i style="font-weight: bold;">상담사 연결 가능  </i><img class="state" src="/images/greenRight.png" width="10px" height="10px"></span>
			 </div>
		</div>
		<div class="messages">
			<ul>
			<!-- 상대방 -->
<!-- 				<li class="sent"> -->
<!-- 					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" /> -->
<!-- 					빠른상담의 질문 들어갈곳 -->
<!-- 				</li> -->

			<!-- 내가 말한거 -->
<!-- 				<li class="replies"> -->
<!-- 					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" /> -->
<!-- 					사용자의 질문 들어갈곳 -->
<!-- 				</li> -->
			</ul>
		</div>
		<div class="message-input" >
			<div class="wrap" >
			<input type="text" placeholder="상담사 1:1 연결시에만 입력이 가능합니다." readonly="true" id="inputMessage" onkeypress="if(event.keyCode == 13){ send()};"/>
	<!-- 			<i class="fa fa-paperclip attachment" aria-hidden="true"></i> -->
			<button class="submit" onclick="send()"><i class="fa fa-paper-plane" aria-hidden="true" ></i></button>
			</div>
		</div>
	</div>
</div>
<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script><script src='https://code.jquery.com/jquery-2.2.4.min.js'></script>

<!-- 웹소켓 스크립트 -->
<script>
	var serverIP;
	var webSocket;
	function chatStart(){
	$("#inputMessage").attr("readonly",false);
	$("#inputMessage").attr("placeholder","질문을 입력하세요.")
	
	serverIP = "ws://"+"localhost"+":8080/chat";
	webSocket = new WebSocket(serverIP);
	webSocket.onopen = function(event) {
		onOpen(event)
		};
	webSocket.binaryType="arraybuffer";
	webSocket.onerror = function(event) {
		onError(event)
		};
		
		webSocket.onmessage = function(event) {
		onMessage(event)
		};
	}
	
	
	function onMessage(event) {
			
		newMessage(event.data);
	
	}
	function onOpen(event) {
		/* newMessage("채팅이연결되었습니다."); */
	
	}
	function onError(event) {
	//alert(event.data);
	}

function send() {
	var sendWeb = document.getElementById("inputMessage").value;
	if('${user.role}'=='user'){
		/* alert("${user.userId}:"+sendWeb); */
		newMessage(sendWeb);
		webSocket.send("고객 :${user.userId}:"+sendWeb);
	}else if('${user.role}'=='admin'){
		/* alert("${user.userId}:"+sendWeb); */
		newMessage(sendWeb);
		webSocket.send("상담사:"+sendWeb);	
	}else{
		/* alert("Custom:"+sendWeb); */
		newMessage(sendWeb);
		webSocket.send("고객:"+sendWeb);
	}
	
}

</script>

<script >
$(".messages").animate({ scrollTop: $(document).height() }, "slow");

function newMessage(message) {
	/* message = $(".message-input input").val(); */
	if($.trim(message) == '') {
		return false;
	}
	if("${user.role}"=='user'){
		if(message.indexOf('상담사')==-1){
			$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}else{
			$('<li class="sent"><img src="/images/whiteLogo.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
	}else if("${user.role}"=='admin'){
		if(message.indexOf('고객')==-1){
			$('<li class="replies"><img src="/images/whiteLogo.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
		else{
			$('<li class="sent"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
	}else {
		if(message.indexOf('상담사')==-1){
			$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}else{
			$('<li class="sent"><img src="/images/whiteLogo.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
	}
	
	$('.message-input input').val(null);
// 	$('.contact.active .preview').html('<span>You: </span>' + message);
	$(".messages").scrollTop($(".messages")[0].scrollHeight);
// 	$(".messages").animate({ scrollTop: $(document).height() }, "fast");
};

$('.submit').click(function() {
  newMessage();
});

$(window).on('keydown', function(e) {
  if (e.which == 13) {
    newMessage();
    return false;
  }
});

$(function () {
	abc("안녕하세요^^ 무엇을 도와드릴까요?");
})


function abc(message) {
	$.ajax({
		url: "/quick/json/getChatBotList",
		method : "get",
		dataType : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {
			console.log(data)
			for(var i = 0; i<data.list.length; i++){
				message += "<br/><a class= 'que' style='cursor:pointer;color: #516378'>"+data.list[i].question+"</a><input type='hidden' class='queNo' value='"+data.list[i].questionNo+"'/>  ";
			}
// 			console.log(message);
			
			$('<li class="sent"><img src="/images/whiteLogo.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		 	$(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, 500);
// 			$(".messages").scrollTop($(".messages")[0].scrollHeight,"slow");
		}
	})
}


$(function () {
	$(document).on("click", ".que", function(){
		var index = $(".que").index(this);
		var questionNo = $($(".queNo")[index]).val();
		
		$.ajax({
			url : "/quick/json/getChatbot/"+questionNo,
			method :"get",
			dataType : "json",
			success : function (data) {
				console.log(data)
				var message = data.chatBot.question
				var answer = data.chatBot.answer
				 
				
				$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p style="font-weight: bold;">' + message + '</p></li>').appendTo($('.messages ul'));
				$('<li class="sent"><img src="/images/whiteLogo.png" alt="" /><p>' + answer + '</p></li>').appendTo($('.messages ul'));
				if(data.chatState=='3'){
					chatStart();
				}else{
					abc("다른 필요한건 없으신가요?");
				}
				
				
// 				$(".messages").animate({ scrollTop: $(document).height() }, "fast");
// 				$(".messages").scrollTop($(".messages")[0].scrollHeight);
			} //end success function
			}) //end ajax
	})//end function
}) //end fucntion




</script>
            <!-- scroll to top End... --> 
        
       
        
        
</body>
</html>