<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="/common/css.jsp" />
<link href='/css/fullcalendar.css' rel='stylesheet' />
<title>치유견 상세정보	</title>
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

<body>
<script type="text/javascript">

$(function() {

	  $('#calendar').fullCalendar({
		  header: {
		        right: 'prev,next today',
		        left: 'title',
		      },
		      //selectOverlap :false, //선택못하게함
		      eventLimit: true,
		      eventLimitText :"더보기",
			  events : getAllReservation(), //end ajax
		      eventRender: function(event, eventElement) { if (event.imageurl) { eventElement.find("span.fc-title").prepend("<img src='" + event.imageurl +"' width='20' height='20'>"); } },
			  
		  	  dayClick: function(date) {
		  		$($(".goModal")).html('')
		  			  $.ajax({
		  				  url : "/ash/json/getHealingDogListByDate/"+date.format(),
		  				  method : "GET",
		  				  dataType : "json",
			 			  headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
							},
		  				  success : function (data) {
		  					$("input[name=reservationDate]").val(date.format())
		  					  console.log(data)
		  					for(var i = 0; i<data.healingDogs.length; i++){
			  					  $($(".goModal")[i]).html('<input class="healingDogNo" type="hidden" value="'+data.healingDogs[i].healingDogNo+'"> <img src="/images/uploadFiles/healingDog/'+data.healingDogs[i].healingDogimage+'" width="400px" height="400px" alt=""><span class="name black-text">'+data.healingDogs[i].healingDogName+'</span> <p id="aaa" class="breed center-col width-90">'+data.healingDogs[i].healingDogBreed.dogBreedKO+' &nbsp; | &nbsp; '+data.healingDogs[i].healingDogBirth+'살 &nbsp; | &nbsp; '+data.healingDogs[i].healingDogChar+'</p> </a>');
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
	    				
							var date = moment(data[i].start);
								if (date.isValid()) {
									$('#calendar').fullCalendar('renderEvent', {
										title : data[i].title+" "+data[i].time,
										color: data[i].color,
										start : date,
										allDay : true,
										imageurl: "/images/uploadFiles/healingDog/"+data[i].image
										
								});
							} else {
								alert('Invalid date.');
							}
						}
   			}//end for
					})
	
}



$(function () {
	var dogNo2 = ${healingDog.healingDogBreed.dogNo}
	console.log(dogNo2)
	$.ajax({
		url : "/dogBreedDic/json/getDogBreed2",
		method:"POST",
		dataType :"json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		data:JSON.stringify({
			dogNo : dogNo2
		}),
		success : function (data) {
			console.log(data.key.dogBreedKO);
			$("#breed").text(data.key.dogBreedKO)
			
		}
	})
	
})

</script>
	<jsp:include page="/layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/302_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">HealingDog Detail</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">Details of HealingDog.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        

        <!-- content section -->
        <section>
            <div class="container">
            	
                <div class="row">
                
                    <!-- product images -->
                    <div class="col-md-6 col-sm-12  sm-margin-bottom-ten">
<!--                         <img src="http://placehold.it/700x583" alt=""/> -->
							<img  src = "/images/uploadFiles/healingDog/${healingDog.healingDogimage}" width="700px" height="583px" alt=""/>
                    </div>
                    <!-- end product images -->
                    
                    <div class="col-md-5 col-sm-12 col-md-offset-1">
                    
                        <div class="separator-line bg-black no-margin-lr margin-five no-margin-top"></div>
                        
                        <!-- healingDog detail 01 -->
                        <p class="no-margin-bottom">이름</p>
                        <div class="fund-sub-title ">${healingDog.healingDogName}</div>
                        <!-- end detail  -->
                        
                        <!-- healingDog detail 01 -->
                        <p class="no-margin-bottom">치유견종</p>
                        <div id="breed" class="fund-sub-title "></div>
                        <!-- end detail  -->
                        
                        <!-- healingDog detail 02 -->
                        <p class="no-margin-bottom">생년월일</p>
                        <div class="fund-sub-title">${healingDog.healingDogBirth}</div>
                        <!-- end detail  -->
                        
                        <!-- healingDog detail 03 -->
                        <p class="no-margin-bottom">성별</p>
                        <c:if test="${healingDog.healingDogGender=='0'}">
	                        <div class="fund-sub-title">수컷</div>
                        </c:if>
                        <c:if test="${healingDog.healingDogGender=='1'}">
	                        <div class="fund-sub-title">암컷</div>
                        </c:if>
                        <!-- end detail  -->
                        
                        <!-- healingDog detail 04 -->
                        <p class="no-margin-bottom">특징</p>
                        <div class="fund-sub-title">${healingDog.healingDogChar}</span></div>
                        <!-- end detail  -->
                        
                        <!-- healingDog detail 05 -->
                        <p class="no-margin-bottom">담당치유사</p>
                        <div class="fund-sub-title">${healingDog.healingDogHealer}</div>
                        <!-- end detail  -->
                        
		                
                        
                    </div>
                </div>
            </div>
        </section>

        <section class="border-top">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                    
                    		<!-- section title -->
		                    <div class="col-md-12 text-center corporate-slider sm-margin-bottom-seven">
		                        <p class="sub-title deep-red-text letter-spacing-4 no-margin-top xs-letter-spacing-2">HealingDog Schedule</p><br>
		                    </div>
		                    <!-- end section title -->
                            
                                <!-- content -->
                                <div class="med-text fade in">
                                    <div class="row">
                                        <div id="calendar" class="col-md-11 col-sm-12 center-col">
                                        </div>
                                    </div>
                                </div>
                                <!-- end content -->
                                 
                        </div>
                        <c:if test="${user.role=='admin'}">
                        <div class="text-center">
							<a href="/ash/updateHealingDog?healingDogNo=${healingDog.healingDogNo}" class="highlight-button-dark btn btn-medium">치유견 정보 수정</a>
						</div>
						</c:if>
                    </div>
                </div>
            </div>
        </section>


	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>