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
	.another{
	
	font-weight:bold; 
	}

	.sty{
	background-color: #0e4425;
	color: white;
	border-radius: 10px;
	}


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
      
      .another{
      text-decoration: underline;
       cursor:pointer
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
<!--     <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<!-- //       $( document ).ready( function() { -->
<!-- //         $( window ).scroll( function() { -->
<!-- //           if ( $( this ).scrollTop() > 150 ) { -->
<!-- //             $( '.top' ).fadeIn(); -->
<!-- //           } else { -->
<!-- //             $( '.top' ).fadeOut(); -->
<!-- //             $( '#frame' ).fadeOut(); -->
<!-- //           } -->
<!-- //         } ); -->
<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script>
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
		if("${user.role}"=='user' || "${user.role}"==""){
// 			newMessage("고객님이 접속하셨습니다.",'user')
			webSocket.send("고객님이 접속하셨습니다.");
			}
		};
	webSocket.binaryType="arraybuffer";
	webSocket.onerror = function(event) {
		onError(event)
		};
		
		webSocket.onmessage = function(event) {
		onMessage(event)
		};
		webSocket.onclose = function(event) { //close 메소드를 사용할수 있도록함
			onClose(event)
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
	function onClose(event) {
		}

function send() {
	var sendWeb = document.getElementById("inputMessage").value;
	if('${user.role}'=='user'){
		/* alert("${user.userId}:"+sendWeb); */
		newMessage(sendWeb,"user");
		webSocket.send("${user.userId}:"+sendWeb);
	}else if('${user.role}'=='admin'){
		/* alert("${user.userId}:"+sendWeb); */
		newMessage(sendWeb,"admin");
		webSocket.send(sendWeb);
	}else{
		/* alert("Custom:"+sendWeb); */
		newMessage(sendWeb,"user");
		webSocket.send(sendWeb);
	}
		$(".messages").scrollTop($(".messages")[0].scrollHeight);
	
}

</script>
<script >$(".messages").animate({ scrollTop: $(document).height() }, "slow");

function newMessage(message, role) {
// 	message = $(".message-input input").val(); 
	if($.trim(message) == '') {
		return false;
	}
	if("${user.role}"=='user'){
		if(role=='user'){
			$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}else{
			$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
			if(message.indexOf("종료")!=-1) {
				$("#inputMessage").attr("readonly",true);
			}
		}
	}else if("${user.role}"=='admin'){
		if(role=='admin'){
			$('<li class="replies"><img src="/images/chat_icon.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
		else{
			$('<li class="sent"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}
	}else {
		if(role=='user'){
			$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		}else{
			$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
			if(message.indexOf("종료")!=-1) {
				$("#inputMessage").attr("readonly",true);
			}
		}
	}
	/* $('<li class="replies"><img src="/images/whiteLogo.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul')); */
	$('.message-input input').val(null);
// 	$('.contact.active .preview').html('<span>You: </span>' + message);
	$(".messages").scrollTop($(".messages")[0].scrollHeight);
// 	$(".messages").animate({ scrollTop: $(document).height() }, "fast");
};

// $('.submit').click(function() {
//   newMessage();
// });

$(function () {
$("#inputMessage").on('keypress', function(event) {
  if (event.keyCode == 13) {
    send();
  }
});
})	

$(function () {
	abc("안녕하세요^^ <br>무엇을 도와드릴까요?<br/>");
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
			if(message == null){
				message =""				
			}
			for(var i = 0; i<data.list.length; i++){
				message += "<a class= 'que' style='cursor:pointer;color: #516378'>"+data.list[i].question+"</a><br><input type='hidden' class='queNo' value='"+data.list[i].questionNo+"'/>  ";
			}
// 			console.log(message);
			
			$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
		 	$(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, 500);
// 			$(".messages").scrollTop($(".messages")[0].scrollHeight,"slow");
		}
	})
}

$(function () { // 상담시작 버튼을 눌렀을 경우 실행
	$(document).on("click", "#start", function(){ 
		
		var role = "${user.role}" 
		if(role=="" || role=='user'){
				$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>상담사와 연결합니다.</p></li>').appendTo($('.messages ul'));
		}else{
			$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>고객과 연결합니다.</p></li>').appendTo($('.messages ul'));
		}
		$(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, 500);
		
		if(role=="" || role=='user'){
			chatStart();
			$.ajax({
				url : "/quick/json/updateConnect/3",
				method:"get",
				dataType :"json",
				success : function (data) {
				} //end success
				}) //end ajax	
		}
		if(role=='admin'){
			chatStart();
		}
		

	})
	$(document).on("click", ".another", function(){
		abc();
	})
	$(document).on("click", ".que", function(){ // 질문 선택시
		var index = $(".que").index(this);
		var questionNo = $($(".queNo")[index]).val();
		
		$.ajax({
			url : "/quick/json/getChatbot/"+questionNo,
			method :"get",
			dataType : "json",
			success : function (data) {
				var message = data.chatBot.question
				var answer = data.chatBot.answer
				$('<li class="replies"><img src="/images/chatbotuser.png" alt="" /><p style="font-weight: bold;">' + message + '</p></li>').appendTo($('.messages ul'));
				$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>' + answer + '<br><span class="another">* 다른 질문이 있으신가요?<span></p></li>').appendTo($('.messages ul'));
				
				
				$(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, 500);
// 				$(".messages").scrollTop($(".messages")[0].scrollHeight);
			} //end success function
		}) //end ajax
	})//end function
}) //end fucntion

$(function () { // 아래 토글버튼 누를경우 챗봇 실행
	$( '#clickChatBot' ).click( function() {
		$("#frame").toggle();
		$("#clickChatBot").css('display','none');
	});
	        
$( '#closeButton' ).click( function() { //닫기버튼누를경우
		$("#frame").toggle();
		$("#clickChatBot").toggle();
	});
});
        
$(function () { //상담상태 변경
	$("#changState").on("change", function () {
		var state = $("#changState").val();
		if(state==0){
			return;
		}else{
			if(state==1){
				$("#isPossible").html('<i style="font-weight: bold;">상담사 부재중  </i><img style="position: fixed; margin-top: 25px; margin-left: 105px;" class="state" src="/images/redRight.png" width="10px" height="10px">')
				$("#isPossible2").html('<i style="font-size: 11px">상담 가능시간 : 14:00~16:00</i>')
			} //end if
			if(state==2){
				$("#isPossible").html('<i style="font-weight: bold;">상담사 연결 가능  </i><img style="position: fixed; margin-top: 25px; margin-left: 105px;" class="state" src="/images/greenRight.png" width="10px" height="10px">')
				$("#isPossible2").html('<i style="font-size: 11px">보통 10분내에 응답합니다.</i>')
			} //end if
			if(state==4){
				 document.getElementById("inputMessage").value="상담을 종료합니다.";
				send();
				$("#changState option:eq(2)").prop("selected", true);
				$('<li class="sent"><img src="/images/chat_icon.png" alt="" /><p>아래 링크를 통해 접속해 주십시요. 응답시간은 10분 내외입니다.<button class="sty" id=\"start\">상담시작</button></p></li>').appendTo($('.messages ul'));
				$(".messages").scrollTop($(".messages")[0].scrollHeight);
				webSocket.close();
				
			} //end if
			$.ajax({
			url : "/quick/json/updateConnect/"+state,
			method:"get",
			dataType :"json",
			success : function (data) {
			} //end success
			}) //end ajax
		}
	})	
	$(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, 500);
})


$(function () { //처음시작할때 상태 받아와서 상담가능인지 불가능인지 보여줌
	$.ajax({
		url:"/quick/json/getCurrentChatBot",
		method : "get",
		dataType :"json",
		success : function (data) {
			var connectAble = data.chatBot.connectAble;
			if(connectAble ==1){
				$("#isPossible").html('<i style="font-weight: bold;">상담사 부재중  </i><img style="position: fixed; margin-top: 25px; margin-left: 105px;" class="state" src="/images/redRight.png" width="10px" height="10px">')
				$("#isPossible2").html('<i style="font-size: 11px">상담 가능시간 : 14:00~16:00</i>')
			}
			if(connectAble ==2){
				$("#isPossible").html('<i style="font-weight: bold;">상담사 연결 가능  </i><img style="position: fixed; margin-top: 25px; margin-left: 105px;" class="state" src="/images/greenRight.png" width="10px" height="10px">')
				$("#isPossible2").html('<i style="font-size: 11px">보통 10분내에 응답합니다.</i>')
			}
		}
	})
})

$(function () { // 버튼 클릭시 내비게이션
	$(document).on("click", "#goHealingDog", function(){
		self.location = "/ash/listHealingDog"
	})
	$(document).on("click", "#goASHInfo", function(){
		self.location = "/ash/getASHInfo"
	})
	$(document).on("click", "#goAshReservation", function(){
		self.location = "/ash/listAsh"
	})
	$(document).on("click", "#goWithDog", function(){
		self.location = "/common/getCoInfo"
	})
	$(document).on("click", "#goAbandon", function(){
		self.location = "/abandDog/getAbandDogList"
	})
})



    </script>


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
	      
     	<img id="clickChatBot" class="top animated zoomIn" style="width: 175px; height: 60px;z-index:99;  cursor: pointer;" src="/images/oneone.png"/>
    
    

<div id="frame" class="animated zoomIn fast" style="display: none;">
	<div class="content">
		<div class="contact-profile">
			<img class="logo" src="/images/chat_icon.png" alt="" />
			<p class="one" style="color: white;">1:1 빠른상담</p><img id="closeButton" src="/images/close-button.png"  ><br>
			<c:if test="${!empty user&& user.role=='admin'}">
		        <select id="changState" style="text-align-last:center;  width: 112px;height: 39px; position: fixed; margin-left: -230px;border-radius: 20px">
			        <option value="0">상담상태</option>
			        <option value="1" >부재중</option>
			        <option value="2">대기중</option>
			        <option value="4">1:1종료</option>
		         </select>
	         </c:if>
			 <div class="social-media">
				<span id="isPossible2"><!-- <i style="font-size: 11px">보통 10분내에 응답합니다.</i> --></span>
				<span id="isPossible"><!-- <i style="font-weight: bold;">상담사 연결 가능  </i><img style="position: fixed; margin-top: 25px; margin-left: 105px;" class="state" src="/images/greenRight.png" width="10px" height="10px"> --></span>
			 </div>
		</div>
		<div class="messages">
			<ul>
<!-- 				<li class="sent"> -->
<!-- 					<img src="http://emilcarlsson.se/assets/mikeross.png" alt="" /> -->
<!-- 					빠른상담의 질문 들어갈곳 -->
<!-- 				</li> -->
<!-- 				<li class="replies"> -->
<!-- 					<img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" /> -->
<!-- 					사용자의 질문 들어갈곳 -->
<!-- 				</li> -->
			</ul>
		</div>
		<div class="message-input" >
			<div class="wrap" >
			<input type="text" placeholder="상담사 1:1 연결시에만 입력이 가능합니다." readonly="true" id="inputMessage"/>
	<!-- 			<i class="fa fa-paperclip attachment" aria-hidden="true"></i> -->
			<button class="submit" onclick="send()"><i class="fa fa-paper-plane" aria-hidden="true" ></i></button>
			</div>
		</div>
	</div>
</div>

        
</body>
</html>