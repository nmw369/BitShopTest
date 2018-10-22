<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('img[name="healingDogimage"]').on('click', function(){
			var index = $('img[name="healingDogimage"]').index(this);
			var selectDog = $('input[name="selectDog"]').val();
			
			if(selectDog == ''){
				selectDog = 0;
			}
			
			$($('img[name="healingDogimage"]')[selectDog]).css("border", "");
			$($('img[name="healingDogimage"]')[index]).css("border", "6px solid");
			
			$('input[name="selectDog"]').val(index);
			
			var healingDogHealer = $($('input[name="healingDogHealer"]')[index]).val();
			var healingDogName = $($('input[name="healingDogName"]')[index]).val();

			$('#healingDogHealerModal').val(healingDogHealer);
			$('#healingDogNameModal').val(healingDogName);
		});
		
		
		$('#consulting').on('click', function(){
			var selectDog = $('input[name="selectDog"]').val();
			var userId = '${user.userId}';
			var healingDogNo = $($('input[name="healingDogNo"]')[selectDog]).val();
			
			var healingDogHealer = $('#healingDogHealerModal').val();
			var healingDogName = $('#healingDogNameModal').val();
			
			if(userId == null || userId.length<1){
				swal("알 림", "로그인 후 이용가능합니다.").then(function(value){
					self.location = "/user/loginUser";
				});
				return;
			}
			
			if(selectDog == null || selectDog.length<1){
				swal("알 림", "치유견을  선택해주세요.");
				return;
			}

			swal({
				  title: "영상상담 신청",
				  text: "신청자 : "+userId+"\n상담사 : "+healingDogHealer+"\n치유견 : "+healingDogName+"\n\n영상상담을 신청하시겠습니까?",
				  //icon: "warning",
				  buttons: true,
				  //dangerMode: true,
				}).then(function(value){
					if(value){
						var selectDog = $('input[name="selectDog"]').val();
						var healingDogNo = $($('input[name="healingDogNo"]')[selectDog]).val();
						$.ajax({
							url : "/ash/json/addConsulting/"+healingDogNo,
							method : "GET",
							datatype : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function (data) {		
								popWin = window.open("https://withdog.herokuapp.com/gettoken/${user.userId}/token", "popWin", "left=300, top=200, width=590, height=370, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
								$(self.location).attr("href","/ash/getMyConsultingList");
							}
						}); //end of ajax
					}
			});
			
		});
	});
</script>


<jsp:include page="/common/css.jsp" />


<title>영상상담 신청</title>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/304_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/304_tit.png"></h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
                
        <!-- 영상삼담 소개 -->
        <section class="no-padding-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">THE VIDEO CONSULTATION</span>
                        <h1>영상상담 소개</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        <p class="text-p width-120 center-col margin-two no-margin-bottom">영상상담 서비스를 활용하면 동물교감치유서비스 신청전 치유견을 만나볼 수 있습니다. <br> 고객은 상담사에게 전화통화만으로는 설명하기 어려웠던 불편사항을 실시간 영상으로 쉽게 설명할 수 있습니다.  <br> 또한 상담사도 고객과 함께 현상을 눈으로 보면서 문제를 정확하게 파악할 수 있습니다.</p>
                    </div>
                </div>
            </div>
        </section>
        <!-- end 영상삼담 소개 -->

        <!-- 영상신청방법 --> 
        <section id="approach" class="approach bg-green margin-five no-margin-bottom">
            <div> 
                <div class="container">
                    <div class="row">
                        <!-- section title -->
                        <div class="col-md-12 text-center">
                            <h2 class=".font-weight-400 title-med white-text no-padding-bottom">영상신청방법</h2>
                        </div>
                        <!-- end section title -->
                    </div>
                    <div class="margin-three no-margin-bottom">
                        <!-- slider item -->
                        <div class="item active"> 
                            <div class="row">
                                <div class="col-md-4 col-sm-4 text-center margin-four no-margin-top sm-margin-bottom-ten"><img class="width-20" src="../images/icon/video_01.png"><h5 class="white-text margin-five no-margin-bottom title-small">1단계</h5><span class="white-text text-p">만나고 싶은 치유견 선택</span></div>
                                <div class="col-md-4 col-sm-4 text-center margin-four no-margin-top sm-margin-bottom-ten"><img class="width-20" src="../images/icon/video_02.png"><h5 class="white-text margin-five no-margin-bottom title-small">2단계</h5><span class="white-text text-p">신청하기 버튼 클릭</span></div>
                                <div class="col-md-4 col-sm-4 text-center margin-four no-margin-top sm-margin-bottom-ten"><img class="width-20" src="../images/icon/video_03.png"><h5 class="white-text margin-five no-margin-bottom title-small">3단계</h5><span class="white-text text-p">알람메시지 수락</span></div>
                            </div>
                        </div>
                        <!-- end slider item -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end 영상신청방법 --> 

        <!-- 강아지 소개 -->
        <div class="container">
        <section class="no-padding-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">OUR HEALING DOG</span>
                        <h1>치유견 선택</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                    </div>
                </div>
            </div>

            <div class="wow fadeIn container margin-two">
                <div class="row">
                  
                  <input type="hidden" value="" name="selectDog"/>
                  <c:forEach var="healingDog" items="${list}">
                    <div class="col-md-3 col-sm-6 healingdog-style text-center wow fadeInUp no-margin-top" style="margin-bottom: 30px">
                        <img class="margin-two" src="/images/uploadFiles/healingDog/${healingDog.healingDogimage }" name="healingDogimage" alt="" style="cursor:pointer;"/>
                        <!-- <img class="checkImg" src="" name="checkImg" alt="" style="cursor:pointer;"/> -->
                        <div class="no-margin-bottom">
                            <!-- radio button  -->
                            <label class="font-weight-700 text-p black-text"> ${healingDog.healingDogName }
                            </label>
                            <!-- end radio button  -->
                        </div>
                        <p class="no-margin-top no-margin-bottom center-col width-90">${healingDog.healingDogBirth }세 ${healingDog.healingDogGender }, ${healingDog.healingDogBreed.dogBreedKO }</p>
                        <span class="margin-five black-text">치유사 ${healingDog.healingDogHealer }</span>
                        <input type="hidden" name="healingDogNo" value="${healingDog.healingDogNo }"/>
                        <input type="hidden" name="healingDogHealer" value="${healingDog.healingDogHealer }"/>
                        <input type="hidden" name="healingDogName" value="${healingDog.healingDogName }"/>
                    </div>
                  </c:forEach>
                  
                  <input type="hidden" id="healingDogHealerModal" value=""/>
                  <input type="hidden" id="healingDogNameModal" value=""/>
                  
                </div>
            </div>
        </section>
        <!-- end 강아지 소개 -->

        <!--신청하기-->
        <div class="row text-center margin-two">
                <!-- <a class="highlight-button-dark2 btn btn-big no-margin-right btn-round" href="#">신청하기</a> -->
                <!-- <button class="highlight-button-dark2 btn btn-big no-margin-right btn-round" id="addConsulting">신청하기</button> -->
                <a style="cursor: pointer;"class="popup-with-zoom-anim highlight-button-dark2 btn btn-big no-margin-right btn-round" id="consulting">신청하기</a>
         </div>
        <!-- end 신청하기-->

        <!--안내사항-->
        <section class="no-padding-top margin-two">
            <div class="container bg-gray border-round padding-one">
                <div class="row">
                    <div class="col-md-3 col-sm-6"></div>           
                    <div class="col-md-1 col-sm-6">
                    <i class="icon-megaphone"></i><br>
                    <strong>안내사항</strong>
                    </div>
                    <div class="col-md-8 col-sm-6">   
                        <p class="no-margin-bottom">
                            1. 영상상담 신청 후 일정 시간이 소요 될 수 있습니다.</br>
                            2. 치유견과 치유담당사의 변동이 있을 수 있습니다.<br>
                            3. 치유견 및 치유사 영상 상담 준비 후 영상상담 신청 알람을 발송합니다.<br>
                            4. 알람을 수락한 후 영상상담 연결이 됩니다.
                        </p>
                    </div>  
                </div>
            </div>
        </section>
		</div>
        <!-- end 안내사항-->
		
		
        
    <jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>