<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<jsp:include page="/common/css.jsp" />
<link href='/css/fullcalendar.css' rel='stylesheet' />
	<title>예약시간 선택</title>
	<style type="text/css">
	

	#calendarTool{
	position: absolute;
	left: 50%; 
	top: 50px;
	transform: translateX(-50%);
}
#writeField{
    top: 300px;
    left: 10px;
    right: 10px;
    bottom: 300px;
    border-color: black;
    border-style: solid;
}
.fc-sun {color:#e31b23; background-color: } /*일요일*/
.fc-sat {color:#007dc3;background-color: } /*토요일*/
	</style>
</head>
<script type="text/javascript">

</script>

<body>
<script type="text/javascript">
function close_pop(flag) {
    $('#notReservation').hide();
};

$(function () {
	$("#addReservationASH").on("click", function () {
		$("form").attr("method","post").attr("action","/ash/addReservationASH").submit();
	})
})

$(function() {
var healingDogNo = ${healingDog.healingDogNo};
	  $('#calendar').fullCalendar({
		  header: {
		        right: 'prev,next today',
		        left: 'title',
		      },
		      selectable: true,
		      //selectOverlap :false, //선택못하게함
		      eventLimit: true,
		      eventLimitText :"더보기",
			  events : getAllReservation(), //end ajax
		      eventRender: function(event, eventElement) { if (event.imageurl) { eventElement.find("span.fc-title").prepend("<img src='" + event.imageurl +"' width='20' height='20'>"); } },
			  
		  	  dayClick: function(date) {
		  		if(date<new Date()){
					swal("알 림", "해당 날짜는 예약 불가능합니다.");
		  			//$("#notReservation").show(); //해당날짜 예약 불가
		  			  return;
		  		  }
		  			  $.ajax({
		  				  url : "/ash/json/getAshReservationTimeCount/"+date.format()+"?healingDogNo="+healingDogNo,
		  				  method : "GET",
		  				  dataType : "json",
			 			  headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
							},
		  				  success : function (data) {
		  					  console.log(data.ash.ashReservationTime)
		  					  if(data.ash.ashReservationTime==0){
		  						  $("input[name=ashReservationDate]").val(date.format());
		  						  $("#ashReservationTime option").remove();
		  						  $("#ashReservationTime").append('<option value="1">오후 14:00~ 17:00</option>');
		  					  }else if(data.ash.ashReservationTime==1){
		  						  $("input[name=ashReservationDate]").val(date.format());
		  						  $("#ashReservationTime option").remove();
		  						  $("#ashReservationTime").append('<option value="0">오전 10:00~ 13:00</option>');
		  					  }else if(data.ash.ashReservationTime==2){
		  							$("#notReservation").show(); //해당날짜 예약 불가
		  					  }else if(data.ash.ashReservationTime==3){
		  						$("input[name=ashReservationDate]").val(date.format());
		  						$("#ashReservationTime option").remove();
		  						$("#ashReservationTime").append('<option value="0">오전 10:00~ 13:00</option>');
		  						$("#ashReservationTime").append('<option value="1">오후 14:00~ 17:00</option>');
		  					  }
						} //end success
		  			  })
			  },
		  monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		  dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
		  dayNamesShort: ["일","월","화","수","목","금","토"],
	  })
	  
		$("button.fc-next-button").click(function() { //다음 버튼 선택시
//				$('#calendar').fullCalendar ( 'removeEvents')
			$('#calendar').fullCalendar({
				   events : getAllReservation()
				   })
	    });
  
		$("button.fc-prev-button").click(function() { //이전 버튼 선택시
//				$('#calendar').fullCalendar ( 'removeEvents')
			$('#calendar').fullCalendar({
				   events : getAllReservation()
				   })
	    });
		
		$("button.fc-today-button").click(function() { //today 버튼 선택시
//				$('#calendar').fullCalendar ( 'removeEvents')
			$('#calendar').fullCalendar({
				   events : getAllReservation()
				   })
	    });
	  
}) //end function

function getAllReservation() { 	//////// 전체 이벤트 받아오기
	var healingDogNo = ${healingDog.healingDogNo}
	 $.ajax(
 	    		{
 	    			url : "/ash/json/getAshReservationByHealingDog/"+healingDogNo,
 	    			method : "GET",
 	    			dataType : "json",
 	    			success : function (data) {
   					console.log(data)
	    				for (var i = 0; i < data.length; i++) {
	    				
	    					var date = moment(data[i].start); // 시작날 2005년
							var date2 = moment(data[i].end); //오늘날
							if(i<data.length-1){
								if (date.isValid()) {
									$('#calendar').fullCalendar('renderEvent', {
										title : data[i].title+" "+data[i].time,
										color: data[i].color,
										start : date,
										allDay : true,
										imageurl: "/images/uploadFiles/healingDog/"+data[i].image,
										
								});
							} 
							}else if(i>=data.length-1){
								if (date.isValid()) {
									$('#calendar').fullCalendar('renderEvent', {
										title : data[i].title+" "+data[i].time,
										color: data[i].color,
										start : date,
										end : date2,
										allDay : true,
										imageurl: "/images/uploadFiles/healingDog/"+data[i].image,
										rendering: 'background',
										color: "#FCF5D1",
								});
							} 
							}
						}//end for
   			}
					})
	
}

</script>
		
	<jsp:include page="../layout/header.jsp" />

	<!-- head section -->
	<section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	   <img class="parallax-background-img" src="../images/sub/303_bg.jpg" alt="" />
	   <div class="container">
	       <div class="row">
	           <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
	               <!-- page title -->
	                <h1 class="white-text">서비스 예약일 &시간 선택</h1>
	               <!-- end page title -->
	               <!-- page title tagline -->
	               <span class="white-text xs-display-none">Reservation</span>
	               <!-- end title tagline -->
	            </div>
	        </div>
	    </div>
	</section>
	<!-- end head section -->
        
	<!--  내용  시작  -->
		<!--  예약 상단  -->
        <section class="no-padding-bottom no-padding-top margin-three">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">Reservation</span>
                        <h1>예약시간 선택</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                    </div>
                </div>
            </div>
        </section>
			<!--  치유견 정보  -->
			<div class="container">
			<div class="row no-margin-bottom">
				<div class="col-md-6 col-sm-6 text-center xs-margin-bottom-ten">
<!-- 					<img src="http://placehold.it/300x300" alt=""/> -->
					<img  src = "/images/uploadFiles/healingDog/${healingDog.healingDogimage}" width="300px" height="300px" alt=""/>
				</div>
				<div class="col-md-6 col-sm-6 sm-margin-bottom-ten">
					<div class="col-md-8 col-sm-12 no-padding">
						<ul class="list-line margin-ten text-med">
							<li id="dogBreed"><span class="font-weight-600">치유견종:</span>${healingDog.healingDogBreed.dogBreedKO}</li>
							<li id="dogName"><span class="font-weight-600">치유견 이름:</span>${healingDog.healingDogName} | ${healingDog.healingDogGender=='0'?'남아':'여아'}</li>
							<li id="dogAge"><span class="font-weight-600">치유견 나이: </span>${healingDog.healingDogBirth}살 </li>
							<li id="dogChar"><span class="font-weight-600">치유견 성격:</span>${healingDog.healingDogChar}</li>
							<li id="healer"><span class="font-weight-600">담당 치유사:</span>${healingDog.healingDogHealer}</li>
						</ul>
					</div>
				</div>
			</div>
			</div>
			<!--  치유견 정보 끝-->
		<!--  예약 상단 끝 -->
				
		<!--  예약 하단 시작 -->
		<section class="bg-gray margin-three padding-three">
            <div class="container">
                <div class="row">
                    <!-- section title -->
                     <div class="col-md-8 col-sm-8 center-col text-center">
                        <div>
                            <!--  <i class="icon-hotairballoon large-icon"></i> -->
                             <img class="width-10" src="../images/icon/icon_100_02.png">
                        	
                            <h1>치유견 스케줄</h1>
                            <span class="margin-one no-margin-top display-block letter-spacing-2">Healing dog schedule</span>
                        	<div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        </div>
                    </div>
                    <!-- end section title -->
                </div>
                <div class="row margin-five no-margin-bottom">
                    <!-- chef  -->
                    <div class="col-md-12">
                        <div style="min-height: 500px"class="col-md-6 chef-text bg-white">
                       		<form>
                        	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>서비스 예약일</strong></h6>
                        	<input type="hidden" id="textbox" name=healingDogNo class="input-round big-input" value="${healingDog.healingDogNo}">
                        	<input type="text" id="textbox" name="ashReservationDate" class="input-round big-input" value="${reservationDate}" readonly>
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                               <h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>시간선택</strong></h6>
                                <!-- end label  -->
                                <div class="select-style input-round big-input">
                                    <select id="ashReservationTime" name="ashReservationTime">
                                    	<c:if test="${ash.ashReservationTime=='3'}">
                                        <option value="0">오전 10:00~ 13:00</option>
                                        <option value="1">오후 14:00~ 17:00</option>
                                        </c:if>
                                    	<c:if test="${ash.ashReservationTime=='0'}">
                                        <option value="1">오후 14:00~ 17:00</option>
                                        </c:if>
                                    	<c:if test="${ash.ashReservationTime=='1'}">
                                        <option value="0">오전 10:00~ 13:00</option>
                                        </c:if>
                                    </select>
                                </div>
                            </div>
							<a id="addReservationASH" style="cursor: pointer;" class="highlight-button btn btn-medium button xs-margin-bottom-five">예약하러가기</a>
       						</form>
       					</div>	
       					<div style="min-height: 500px" class="col-md-6 chef-img">
                            <div style="height:100%; width: 100%; left: 0; top: 0" id="calendar" class="img-border">
                            
                            </div>
                        </div>
				   </div>
				</div>  
			</div>	 
	 </section> 
	<!--  예약 하단 끝 -->
	 <!-- 1. 날짜 예약 불가 모달 -->
    <div id="notReservation" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />해당 날짜는 예약 불가능합니다.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 1. 날짜 예약 불가 모달 -->
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>