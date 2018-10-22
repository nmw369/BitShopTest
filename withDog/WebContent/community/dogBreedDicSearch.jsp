<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
 
<jsp:include page="/common/css.jsp" />

<title>견종백과 일반검색</title>
<style type="text/css">
  .ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    overflow-x: hidden;
  }
  * html .ui-autocomplete {
    height: 100px;
  }

  #dropzone
    {
        border:2px dotted #3292A2;
        width:1200px;
        height:500px;
        color:#92AAB0;
        text-align:center;
        vertical-align:middle;
        font-size:18px;
        margin-top:10px;
        padding-left: 15px;
		padding-right: 15px;
        display: inline-block;
        line-height: 300px;
        
    }
  #result_image
    {
        width:600px;
        height:400px;
        color:#92AAB0;
        text-align:center;
        vertical-align:middle;
        font-size:18px;
        margin-top:10px;
        display: inline-block;
        line-height: 300px;
        
    }
  #result_image2
    {
        width:500px;
        height:400px;
        color:#92AAB0;
        text-align:center;
        vertical-align:middle;
        font-size:18px;
        margin-top:10px;
        margin-left:60px;
        display: inline-block;
        line-height: 300px;
        
    }
    </style>

</head>


<body>

<script>

function close_pop(flag) {
    $('#noSearch').hide();
};



$(function () {
	
    var obj = $("#dropzone");
    var upload = $('input:file')[0]
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px solid #5272A0');
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
    $(obj).on("click" , function name() {
		$(upload).click();
	})
    
    /////1. 터치해서 업로드/////
    $(upload).on("change", function (e) {
		e.preventDefault();  // 기본적인 서브밋 행동을 취소합니다
		
	
		var file = upload.files[0]
		
		var reader = new FileReader();
	
		reader.onload = function (event) {
			obj.text("");
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			
			/////////
			googleVisionByContent(a)
			/////////
			$(obj).attr("src", img.src);

			
			}
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;
    });
	////////////////////////////////////////////////
	
	
	////2. 드래그앤 드롭 업로드 /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			console.log(a[1])
			
			//////////////
			
			googleVisionByContent(a)
			
			//////////////
			$(obj).attr("src", img.src);
			//obj.append(img);
			
		}
         //})
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;

    });

});


function googleVisionByContent(a) {
	$("#result_image").attr('src',"/images/result_image.png")
	$("#result_name").text("<분석 결과를 선택해보세요>")
	$("#result_lifeSpan").text("")
	$("#result_height").text("")
	$("#result_weight").text("")
	$("#result_place").text("")
	$("#result_color").text("")
	$("#result_personality").text("")
	$("#result_link").html("")
	var num = 0;
	var API_KEY = "AIzaSyCpd2pSdt8bSgAda5GLaVjeL8xxv4-Ma9M"
		//console.log("Base64 : " + result)
			$(function () {
				var p = {
						"requests" : [ {
							"image" : {
								"content" : a[1]
							},
							"features" : [ {
								"type" : "LABEL_DETECTION", //Web detection 어떨지
								"maxResults" : 20
							} ]
						} ]
					}
				$.ajax(
						{
							url : "https://vision.googleapis.com/v1/images:annotate?key="+API_KEY,
							method : "POST",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify(p),
							success : function(data,status) {
								$(".percent").text("0");
								$(".dog_nameKO").text("일치하는 견종이 없습니다");
								$(".dog_nameEN").text("-");
								console.log(data)
								$("#breed").empty();
								for (var i = 0; i < data.responses[0].labelAnnotations.length; i++) {
									var kind = data.responses[0].labelAnnotations[i].description
									var rate = Math.floor((data.responses[0].labelAnnotations[i].score)*100)
									console.log(kind)
									console.log(rate)
									console.log((kind.indexOf("dog")))
	
										///////자체번역
										$.ajax(
												{
													url : "/dogBreedDic/json/getDogBreed",
													method : "POST",
													dataType : "json",
													async: false,
													headers : {
														"Accept" : "application/json",
														"Content-Type" : "application/json"
													},
													data : JSON.stringify({
														dogBreedEN : kind
													}),
													success : function(data,status) {
														console.log(data)
														
														if (data.key==null || data.key==""){
														}else{
															$("#dog_nameKO"+num).text(data.key.dogBreedKO)
															$("#dog_nameEN"+num).text(data.key.dogBreedEN)
															$("#result"+num).text(rate)
															num++;
														}
													},//end success function
													fail : function (error) {
														alert(error)
													}
												});
										//자체번역
								} //end for
							}//end success function
						}); // end ajax
			})
}

function googleVisionByImageURI(a) {
	var num = 0;
	var API_KEY = "AIzaSyCpd2pSdt8bSgAda5GLaVjeL8xxv4-Ma9M"
		//console.log("Base64 : " + result)
			$(function () {
				var p = {
						"requests" : [ {
							"image" : {
								"source" : {
							          "imageUri": a
								}
							},
							"features" : [ {
								"type" : "LABEL_DETECTION", //Web detection 어떨지
								"maxResults" : 3
							} ]
						} ]
					}
				$.ajax(
						{
							url : "https://vision.googleapis.com/v1/images:annotate?key="+API_KEY,
							method : "POST",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify(p),
							success : function(data,status) {
								var b = 0;
								for(var i= 0 ; i<data.responses[0].labelAnnotations.length; i++){
									 if((data.responses[0].labelAnnotations[i].description).indexOf("dog")==0){
										 b++;
									}
								}
								if(b==0){
									$("#result_image").attr('src','/images/noresult_image.png')
								}else{
									$("#result_image").attr('src',a)
								}
								
							}//end success function
						}); // end ajax
			})
}
function googleVisionByImageURI2(a) {
	var num = 0;
	var API_KEY = "AIzaSyCpd2pSdt8bSgAda5GLaVjeL8xxv4-Ma9M"
		//console.log("Base64 : " + result)
			$(function () {
				var p = {
						"requests" : [ {
							"image" : {
								"source" : {
							          "imageUri": a
								}
							},
							"features" : [ {
								"type" : "LABEL_DETECTION", //Web detection 어떨지
								"maxResults" : 3
							} ]
						} ]
					}
				$.ajax(
						{
							url : "https://vision.googleapis.com/v1/images:annotate?key="+API_KEY,
							method : "POST",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify(p),
							success : function(data,status) {
								var b = 0;
								for(var i= 0 ; i<data.responses[0].labelAnnotations.length; i++){
									 if((data.responses[0].labelAnnotations[i].description).indexOf("dog")==0){
										 b++;
									}
								}
								if(b==0){
									$("#result_image2").attr('src','/images/noresult_image.png')
								}else{
									$("#result_image2").attr('src',a)
								}
								
							}//end success function
						}); // end ajax
			})
}

$(function () {
	$(".getInfo").on("click", function () {
		$("#imageSearchResult").css('display',"")
		if($(".percent",this).text()=="0"){
			$('#noSearch').show();
			$("#imageSearchResult").css('display',"none")
			return;
		}
			//$("#result_image").attr('src',"/images/result_image.png")
			//$("#result_image").attr('src','')
			$("#result_image").attr('src','/images/loading2.gif');
		var name = $(".dog_nameKO",this).text()
		$.ajax({
			url : "/dogBreedDic/json/getDogBreedInfoList",
			method : "POST",
			dataType : "json",
			headers :{
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},	
			data : JSON.stringify({
				dogBreedKO : name
			}),
			success : function (data) {
				$("#result_name").text(data.dogBreedInfo[0].dogBreedKO+" ("+data.dogBreedInfo[0].dogBreedEN+")")
				$("#result_lifeSpan").text("수명 : " + data.dogBreedInfo[0].dogLifeSpan)
				$("#result_height").text("신장 : " + data.dogBreedInfo[0].dogHeight)
				$("#result_weight").text("체중 : " + data.dogBreedInfo[0].dogWeight)
				$("#result_place").text("출생지 : " + data.dogBreedInfo[0].dogPlace)
				$("#result_color").text("색상 : " + data.dogBreedInfo[0].dogColor)
				$("#result_personality").text("성격 : " + data.dogBreedInfo[0].dogPersonality)
				$("#result_link").html("관련 링크 : <a href="+data.dogBreedInfo[0].dogLink+">" + data.dogBreedInfo[0].dogLink+"</a>")
				imageSearch(data.dogBreedInfo[0].dogBreedEN);
		
			}
			
		})
	
	})
})
	///////구글 이미지 서치
			function imageSearch(keyword) {
					$.ajax({
						url : 'https://www.googleapis.com/customsearch/v1?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8&cx=011598789325596039313:yaj05uya8oc&q='+keyword,
						method : "GET" ,
						dataType : "json",
						success : function (data) {
							console.log(data)
							 googleVisionByImageURI(data.items[0].pagemap.cse_image[0].src)
							 
						}
				})
			}
			function imageSearch2(keyword) {
					$.ajax({
						url : 'https://www.googleapis.com/customsearch/v1?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8&cx=011598789325596039313:yaj05uya8oc&q='+keyword,
						method : "GET" ,
						dataType : "json",
						success : function (data) {
							 googleVisionByImageURI2(data.items[0].pagemap.cse_image[0].src)
							 
						}
				})
			}
			///////


////////////////////오토컴플릿

// $(function autoComplet() {
// 	$.ajax({
// 		url : "/dogBreedDic/json/getAllBreedInfoList",
// 		method : "POST",
// 		datatype : "json",
// 		headers : {
// 			"Accept" : "application/json",
// 			"Content-Type" : "application/json"
// 		},
// 		success : function (data) {
// 			var displayValue = new Array();
// 			for(var i = 0; i<data.allDogBreedInfo.length; i++){
// 				displayValue.push(data.allDogBreedInfo[i].dogBreedKO)
// 			}
// 			$("input:text.input-round").autocomplete({
// 			      source: displayValue
// 			    });
// 		}
// 	})
// })
////////////////////오토컴플릿

////////////////////검색버튼 눌렀을 시

			
/////////// 일반검색
$(function (data) {
			console.log(data)
			$("button:contains('검색')").on("click",function () {
				$("#jumpingDog").css('display','none')
				$("#normalSearchResult").css('display','');
				$("#result_image2").attr('src','/images/loading2.gif');
				$.ajax({
					url : "/dogBreedDic/json/getDogBreedInfoList",
					method : "POST",
					dataType : "json",
					headers :{
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},	
					data : JSON.stringify({
						dogBreedKO : $("#selecttt option:selected").val()
					}),
					success : function (data) {
						console.log(data)
						
						$("#result_name2").text(data.dogBreedInfo[0].dogBreedKO+" ("+data.dogBreedInfo[0].dogBreedEN+")")
						$("#result_lifeSpan2").text("수명 : " + data.dogBreedInfo[0].dogLifeSpan)
						$("#result_height2").text("신장 : " + data.dogBreedInfo[0].dogHeight)
						$("#result_weight2").text("체중 : " + data.dogBreedInfo[0].dogWeight)
						$("#result_place2").text("출생지 : " + data.dogBreedInfo[0].dogPlace)
						$("#result_color2").text("색상 : " + data.dogBreedInfo[0].dogColor)
						$("#result_personality2").text("성격 : " + data.dogBreedInfo[0].dogPersonality)
						$("#result_link2").html("관련 링크 : <a href="+data.dogBreedInfo[0].dogLink+">" + data.dogBreedInfo[0].dogLink+"</a>")
						imageSearch2(data.dogBreedInfo[0].dogBreedEN);
					}
				})
			})	
			
			
		})

</script>



	<jsp:include page="/layout/common-header.jsp" />
		
	<!-- head section -->
	       <section  class="page-title parallax3 parallax-fix page-title-blog">
	          <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
	          <img class="parallax-background-img" src="../images/sub/600_bg.jpg" alt="" />
	          <div class="container">
	              <div class="row">
	                  <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
	                      <div class="no-margin-top margin-one"></div>
	                      <!-- page title -->
	                      <h1 class="white-text tit_png"><img src="../images/sub/601_tit.png"></h1>
	                      <!-- end page title -->
	                      <!-- page title tagline -->
	                      <!-- 서브타이틀 <span class="white-text">1234</span>-->
	                      <!-- end title tagline -->
	                  </div>
	              </div>
	          </div>
	      </section>
	<!-- end head section -->
      
   <!-- 내용  section -->
	<section class="wow fadeIn">
		<div class="container"><!-- container --> 
			<div class="row marginFive"><!-- row --> 
					<div class="col-md-12 col-sm-12 center-col">
						<!-- tab   ///  tabs.html -->
							<div class="tab-style3">
								<div class="row">
									<div class="col-md-12 col-sm-12">
										<!-- tab navigation -->
										<ul class="nav nav-tabs nav-tabs-light text-center center-col">
											<li class="active"><a href="#tab3_sec1" data-toggle="tab">견종 검색</a></li>
											<li><a href="#tab3_sec2" data-toggle="tab">이미지 검색</a></li>
										</ul>
										<!-- end tab navigation -->
									</div>
								</div>
								
								<!-- tab  -->
                            	<div class="tab-content">
                            	
                                <!-- tab content 01 -->
                                <div class="tab-pane med-text fade in active" id="tab3_sec1">
                                    <div class="row">
                                    
                                        <!-- 검색 버튼 -->   
										<div class="col-md-8 col-sm-10 center-col text-center">
<!-- 										<form id="normalSearch"> -->
											<div class="form-group" style="white-space: nowrap;">
												<!-- select -->
												<div class="col-md-10 col-sm-12 no-margin-right">
													<div>
														<div id="searchKeyword" class="select-style input-round big-input">
															<select id="selecttt">
																<c:forEach var="list" items="${list}">
																	<option value="${list.dogBreedKO}">
																		${list.dogBreedKO}
																	</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
												<!-- end select -->
												<button class="btn btn-black no-margin-bottom btn-large2 btn-round no-margin-top">검색</button>
											</div>
												<img id="jumpingDog" alt="" src="/images/jumpingdog.gif" style="width: 80%;height: 80%">
<!-- 										</form> -->
										</div>
										<!-- end 검색 버튼 --> 
					
										<!-- 검색 후 나오는 이미지 및 정보  -->  
						                <div id="normalSearchResult" class="row" style="display: none;margin-top: 80px;">
						                    <!-- content  -->
						                    <div class="col-md-6 col-sm-12 sm-margin-bottom-four">
						                        <img id="result_image2" src="" alt="" /> <!-- adfsdfasfsafsadfdsafds -->
						                    </div>
						                    <div style="padding-top: 10px" class="col-md-6 col-sm-12">
						                        <p id="result_name2" class="text-large font-weight-600 text-black margin-three no-margin-top"></p>
						                        <p id="result_height2" class="text-med"></p>
						                        <p id="result_weight2" class="text-med"></p>
						                        <p id="result_lifeSpan2" class="text-med"></p>
						                        <p id="result_place2" class="text-med"></p>
						                        <p id="result_color2" class="text-med"></p>
						                        <p id="result_personality2" class="text-med"></p>
						                        <p id="result_link2" class="text-med"></p>
						                    </div>
						                    <!-- end content  -->
						                </div>
			                             <!-- end 검색 후 나오는 이미지 및 정보-->   
			                             
									</div>	
								
									</div>
						            <!-- end tab content 01 -->
				            
				            <!-- tab content 02 -->
                                <div class="tab-pane fade in" id="tab3_sec2">
                                    <div class="row" >
                                    	
                                    	<div class="col-md-12 text-center">
											<h3 class="title-large font-weight-400 margin-three">이미지를 드래그 또는 파일선택을 클릭해주세요</h3>
										</div>
                                    
                                    	<!-- 유저가 올린 이미지 나오는 영역 -->
                                        <div  class="col-md-8 col-sm-12 wow fadeIn center-col">
                                        <input style="display: none;" type="file" id="testfile" name="testfile" >
					                        <!-- photo item -->
					                        <img id="dropzone" alt="" class="project-img-gallery">
					                        <!-- end photo item -->
					                    </div>
					                    <!-- end 유저가 올린 이미지 나오는 영역-->
					                    
					                    <!--일치율 결과 영역 시작-->
					                    
				                    	<!--  title -->
						            	<div class="col-md-12 text-center" al	>
											<h3 class="title-large font-weight-400" style="margin-top: 50px">해당 이미지와 강아지의 일치율입니다.</h3>
											<h6 class="font-weight-400" style="margin-top: 20px;margin-bottom: 50px;"><분석 결과를 선택해보세요></h6>
										</div>
										<!--  end title -->
											
							                    <div  id="ddd" class="text-center center-col">
							                        <!-- pie charts -->
							                        <div class="col-md-3 col-sm-3 chart-style2 wow zoomIn xs-margin-bottom-ten">
							                        	<a style="cursor:pointer" class="getInfo" ><!-- 일치율 클릭시 해당 강아지 결과 오징어씨 맘대로 링크 걸기  -->
							                            <div class="chart-percent"><span   class="chart2 black-text" data-percent="0" ><span  id="result0" class="percent"></span></span></div>
							                            <div class="chart-text">
							                                <h5 id="dog_nameKO0" style="white-space: nowrap;" class="dog_nameKO black-text text-extra-large"></h5>
							                                <p id="dog_nameEN0" style="white-space: nowrap;" class="dog_nameEN"></p>
							                            </div>
							                            </a>
							                        </div>
							                        <!-- end pie charts -->
							                        <!-- pie charts -->
							                        <div class="col-md-3 col-sm-3 chart-style2 wow zoomIn xs-margin-bottom-ten">
							                        	<a style="cursor:pointer" class="getInfo" ><!-- 일치율 클릭시 해당 강아지 결과 오징어씨 맘대로 링크 걸기  -->
							                            <div class="chart-percent"><span class="chart2 black-text" data-percent="0"><span id="result1" class="percent"></span></span></div>
							                            
							                            <div class="chart-text">
							                                <h5 id="dog_nameKO1" style="white-space: nowrap;" class="dog_nameKO black-text text-extra-large"></h5>
							                                <p id="dog_nameEN1" style="white-space: nowrap;" class="dog_nameEN"></p>
							                            </div>
							                            </a>
							                        </div>
							                        <!-- end pie charts -->
							                        <!-- pie charts -->
							                        <div class="col-md-3 col-sm-3 chart-style2 wow zoomIn xs-margin-bottom-ten">
							                        	<a style="cursor:pointer" class="getInfo" ><!-- 일치율 클릭시 해당 강아지 결과 오징어씨 맘대로 링크 걸기  -->
							                            <div class="chart-percent"><span class="chart2 black-rtext" data-percent="0" ><span id="result2"  class="percent"></span> </span></div>
							                            <div class="chart-text">
							                            	<h5 id="dog_nameKO2"  style="white-space: nowrap;"class="dog_nameKO black-text text-extra-large"></h5>
							                                <p id="dog_nameEN2" style="white-space: nowrap;" class="dog_nameEN"></p>
							                            </div>
							                            </a>
							                        </div>
							                        <!-- end pie charts -->
							                        <!-- pie charts -->
							                        <div class="col-md-3 col-sm-3 chart-style2 wow zoomIn">
							                        	<a style="cursor:pointer" class="getInfo" ><!-- 일치율 클릭시 해당 강아지 결과 오징어씨 맘대로 링크 걸기  -->
							                            <div class="chart-percent"><span   class="chart2 black-text" data-percent="0"><span id="result3" class="percent"></span> </span></div>
							                            <div class="chart-text">
							                                <h5 id="dog_nameKO3"   style="white-space: nowrap;"class="dog_nameKO black-text text-extra-large"></h5>
							                                <p id="dog_nameEN3" style="white-space: nowrap;" class="dog_nameEN"></p>
							                            </div>
							                            </a>
							                        </div>
							                        <!-- end pie charts -->
							                    </div>
										<!--일치율 결과 영역 끝-->
										
										<!-- 검색 후 나오는 이미지 및 정보  -->  
						                <div id="imageSearchResult" class="row" style="display: none;">
						                    <!-- content  -->
						                    <div class="col-md-6 col-sm-12 sm-margin-bottom-four">
										<img id="result_image" src="/images/result_image.png" alt="" />
									</div>
						                    <div style="padding-top: 10px" class="col-md-6 col-sm-12">
						                        <p id="result_name" class="text-large font-weight-600 text-black margin-three no-margin-top"> <분석 결과를 선택해보세요></p>
						                        <!-- <p id="result_height"  class="text-large text-black margin-three no-margin-top">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.</p> -->
						                        <p id="result_height" class="text-med"></p>
						                        <p id="result_weight" class="text-med"></p>
						                        <p id="result_lifeSpan" class="text-med"></p>
						                        <p id="result_place" class="text-med"></p>
						                        <p id="result_color" class="text-med"></p>
						                        <p id="result_personality" class="text-med"></p>
						                        <p id="result_link" class="text-med"> </p>
						                    </div>
						                    <!-- end content  -->
						                </div>
			                             <!-- end 검색 후 나오는 이미지 및 정보-->  
			                             
			                             
			                             	
                                        
                                    </div>
                                </div>
                                <!-- end tab content 02 -->
				            
				            
							</div>
							<!-- end tab  -->

			</div><!-- end row --> 	
		</div><!-- end container --> 
	</section>
	<!-- end 내용  section -->
    <!-- 1. 이미지서치 결과없음 모달 -->
    <div id="noSearch" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />이미지 분석결과가 없습니다.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
  <!-- 1. 이미지서치 결과없음 모달 -->
  
    <jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>