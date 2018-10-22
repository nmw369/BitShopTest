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


<title>유기견 입양 공고 리스트</title>

</head>

<script type="text/javascript">
$(document).ready(function () {
    // Handler for .ready() called.
    $('html, body').animate({
        scrollTop: ($('#start').offset().top - 60) + 'px'
    }, 'slow');
});

$(function(){
	// 견종변경시 조회
	$("select[name='dogBreed']").on("change", function(){
		fncGetList(1);
	});
	
	// 시도변경시 조회
	$("select[name='sido']").on("change", function(){
		$("select[name='sigungu']").val("");
		fncGetList(1);
	});
	
	// 시도변경시 조회
	$("select[name='sigungu']").on("change", function(){
		fncGetList(1);
	});
	
	// 상세조회 모달창에서 확인버튼
	$("#searchModal").on("click", function(){
		var abandDogGender = $('input[name="abandDogGenderRadio"]:checked').val();
		$('input[name="abandDogGender"]').val(abandDogGender);
		var abandDogState = $('input[name="abandDogStateRadio"]:checked').val();
		$('input[name="abandDogState"]').val(abandDogState);
		fncGetList(1);
	});
	
	// 리스트 이미지 클릭
	$(document).on("click", "img[name='abandDogImg']", function(){
		var index = $("img[name='abandDogImg']").index(this);
		fncGetAbandDog(index);
	});
	
	$(document).on("click", "a[name='abandDog']", function(){
		var index = $("a[name='abandDog']").index(this);
		fncGetAbandDog(index);
	});
});

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("form").attr("method","POST").attr("action","/abandDog/getAbandDogList").submit();
}

function fncGetAbandDog(index){
	var desertionNo = $($('input[name="desertionNoList"]')[index]).val();
	var noticeNo = $($('input[name="noticeNoList"]')[index]).val();
	var abandDogBreed = $($('input[name="abandDogBreedList"]')[index]).val();
	var abandDogGender = $($('input[name="abandDogGenderList"]')[index]).val();
	var abandDogFeature = $($('input[name="abandDogFeatureList"]')[index]).val();
	var abandDogState = $($('input[name="abandDogStateList"]')[index]).val();
	var abandDogImage = $($('input[name="abandDogImageList"]')[index]).val();
	var happenPlace = $($('input[name="happenPlaceList"]')[index]).val();
	var abandDogAge = $($('input[name="abandDogAgeList"]')[index]).val();
	var abandDogWeight = $($('input[name="abandDogWeightList"]')[index]).val();
	var abandDogColor = $($('input[name="abandDogColorList"]')[index]).val();
	var abandDogNeuter = $($('input[name="abandDogNeuterList"]')[index]).val();
	var noticeSdt = $($('input[name="noticeSdtList"]')[index]).val();
	var noticeEdt = $($('input[name="noticeEdtList"]')[index]).val();
	var happenDt = $($('input[name="happenDtList"]')[index]).val();
	var careNm = $($('input[name="careNmList"]')[index]).val();
	var careTel = $($('input[name="careTelList"]')[index]).val();
	var orgNm = $($('input[name="orgNmList"]')[index]).val();
	var careAddr = $($('input[name="careAddrList"]')[index]).val();
	
	$('input[name="desertionNo"]').val(desertionNo);
	$('input[name="noticeNo"]').val(desertionNo);
	$('input[name="abandDogBreed"]').val(abandDogBreed);
	$('input[name="abandDogGender"]').val(abandDogGender);
	$('input[name="abandDogFeature"]').val(abandDogFeature);
	$('input[name="abandDogState"]').val(abandDogState);
	$('input[name="abandDogImage"]').val(abandDogImage);
	$('input[name="happenPlace"]').val(happenPlace);
	$('input[name="abandDogAge"]').val(abandDogAge);
	$('input[name="abandDogWeight"]').val(abandDogWeight);
	$('input[name="abandDogColor"]').val(abandDogColor);
	$('input[name="abandDogNeuter"]').val(abandDogNeuter);
	$('input[name="noticeSdt"]').val(noticeSdt);
	$('input[name="noticeEdt"]').val(noticeEdt);
	$('input[name="happenDt"]').val(happenDt);
	$('input[name="careNm"]').val(careNm);
	$('input[name="careTel"]').val(careTel);
	$('input[name="orgNm"]').val(orgNm);
	$('input[name="careAddr"]').val(careAddr);
	
	$("form").attr("method", "POST").attr("action", "/abandDog/getAbandDog").submit();
}

/* 
$(function(){
	// 처음에 리스트 들고옴
	fncGetAbandDogList();
	
	// 처음 견종 리스트 들고오는 부분
	$.ajax({
		url : "/abandDog/json/dogBreed",
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {		
			for(var key in data){
				$("select[name='dogBreed']").append($('<option value='+key+'>'+data[key]+'</option>'));
			}
		}
		
	}); //end of ajax	
	
	// 처음 시도 리스트 들고오는 부분
	$.ajax({
		url : "/abandDog/json/sido",
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {		
			for(var key in data){
				$("select[name='sido']").append($('<option value='+key+'>'+data[key]+'</option>'));
			}
		}
		
	}); //end of ajax
	
	// 시도를 변경하면 해당 시군구를 들고오는 부분
	$("select[name='sido']").on("change", function(){
		$("select[name='sigungu']").val("");
		var sido = $("select[name='sido']").val();
		
		if(sido == ""){
			$('#sigungu').css('display', 'none');
		}
		
		$.ajax({
			url : "/abandDog/json/sigungu/"+sido,
			method : "GET",
			datatype : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function (data) {		
				$('#sigungu').css('display', 'block');
				for(var key in data){
					$("select[name='sigungu']").append($('<option value='+key+'>'+data[key]+'</option>'));
				}
			}
		}); //end of ajax
	});
});

$(function(){	
	// 페이지 네비
	$(document).on("click", ".pageNum", function(){
		var index = $(".pageNum").index(this);
		var page = $($(".pageNum")[index]).text();
		$('input[name="currentPage"]').val(page);
		fncGetAbandDogList();
	});
	
	// 견종 선택하면 조회
	$("select[name='dogBreed']").on("change", function(){
		$('input[name="currentPage"]').val('0');
		fncGetAbandDogList();
	});
	
	// 시도 - 시군구 선택하면 조회
	$("select[name='sido']").on("change", function(){
		$('input[name="currentPage"]').val('0');
		fncGetAbandDogList();
	});
	
	// 시도 - 시군구 선택하면 조회
	$("select[name='sigungu']").on("change", function(){
		$('input[name="currentPage"]').val('0');
		fncGetAbandDogList();
	});
	
	// 상세조회 모달창에서 확인버튼
	$("#searchModal").on("click", function(){
		$('input[name="currentPage"]').val('0');
		fncGetAbandDogList();
	});
	
	// 상세조회 모달창에서 취소버튼
	$("#cancelModal").on("click", function(){
		
	});
	
	// 리스트 이미지 클릭
	$(document).on("click", "img[name='abandDogImg']", function(){
		var index = $("img[name='abandDogImg']").index(this);
		fncGetAbandDog(index);
	});
	
	$(document).on("click", "a[name='abandDog']", function(){
		var index = $("a[name='abandDog']").index(this);
		fncGetAbandDog(index);
	});
});

function fncGetAbandDog(index){
	var desertionNo = $($('input[name="desertionNoList"]')[index]).val();
	var noticeNo = $($('input[name="noticeNoList"]')[index]).val();
	var abandDogBreed = $($('input[name="abandDogBreedList"]')[index]).val();
	var abandDogGender = $($('input[name="abandDogGenderList"]')[index]).val();
	var abandDogFeature = $($('input[name="abandDogFeatureList"]')[index]).val();
	var abandDogState = $($('input[name="abandDogStateList"]')[index]).val();
	var abandDogImage = $($('input[name="abandDogImageList"]')[index]).val();
	var happenPlace = $($('input[name="happenPlaceList"]')[index]).val();
	var abandDogAge = $($('input[name="abandDogAgeList"]')[index]).val();
	var abandDogWeight = $($('input[name="abandDogWeightList"]')[index]).val();
	var abandDogColor = $($('input[name="abandDogColorList"]')[index]).val();
	var abandDogNeuter = $($('input[name="abandDogNeuterList"]')[index]).val();
	var noticeSdt = $($('input[name="noticeSdtList"]')[index]).val();
	var noticeEdt = $($('input[name="noticeEdtList"]')[index]).val();
	var happenDt = $($('input[name="happenDtList"]')[index]).val();
	var careNm = $($('input[name="careNmList"]')[index]).val();
	var careTel = $($('input[name="careTelList"]')[index]).val();
	var orgNm = $($('input[name="orgNmList"]')[index]).val();
	var careAddr = $($('input[name="careAddrList"]')[index]).val();
	
	$('input[name="desertionNo"]').val(desertionNo);
	$('input[name="noticeNo"]').val(desertionNo);
	$('input[name="abandDogBreed"]').val(abandDogBreed);
	$('input[name="abandDogGender"]').val(abandDogGender);
	$('input[name="abandDogFeature"]').val(abandDogFeature);
	$('input[name="abandDogState"]').val(abandDogState);
	$('input[name="abandDogImage"]').val(abandDogImage);
	$('input[name="happenPlace"]').val(happenPlace);
	$('input[name="abandDogAge"]').val(abandDogAge);
	$('input[name="abandDogWeight"]').val(abandDogWeight);
	$('input[name="abandDogColor"]').val(abandDogColor);
	$('input[name="abandDogNeuter"]').val(abandDogNeuter);
	$('input[name="noticeSdt"]').val(noticeSdt);
	$('input[name="noticeEdt"]').val(noticeEdt);
	$('input[name="happenDt"]').val(happenDt);
	$('input[name="careNm"]').val(careNm);
	$('input[name="careTel"]').val(careTel);
	$('input[name="orgNm"]').val(orgNm);
	$('input[name="careAddr"]').val(careAddr);
	
	$("form").attr("method", "POST").attr("action", "/abandDog/getAbandDog").submit();
}


function fncGetAbandDogList(){
	var currentPage = $('input[name="currentPage"]').val();
	var dogBreed = $("select[name='dogBreed']").val();
	var sido = $("select[name='sido']").val();
	var sigungu = $("select[name='sigungu']").val();
	var abandDogGender = $('input[name="abandDogGender"]:checked').val();
	var abandDogState = $('input[name="abandDogState"]:checked').val();
	
	$.ajax({
		url : "/abandDog/json/getAbandDogList?currentPage="+currentPage+"&dogBreed="+dogBreed+"&sido="+sido+"&sigungu="+sigungu+"&abandDogGender="+abandDogGender+"&abandDogState="+abandDogState,
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function(JSONData , status) {							
			$("#abandDogList").html("");
			for(i=0; i<JSONData.list.length; i++){
				var str='<li>'
                	+'<figure>'
                	+'<div class="gallery-img" style="height: 200px"><img name="abandDogImg" src="'+JSONData.list[i].abandDogImage+'" alt="" style="width:100%; height:100%; margin:0 auto;"></div>'
                	+'<figcaption>'
                    +'<h3 class="dog margin-two-bottom"><a href="#" name="abandDog">'
                    +JSONData.list[i].abandDogBreed+' - '+JSONData.list[i].abandDogAge+JSONData.list[i].abandDogGender+'</a></h3>'
                    +'<p class="text-small">'+JSONData.list[i].orgNm+'</p>'
                    +'<input type="hidden" name="desertionNoList" value="'+JSONData.list[i].desertionNo+'"/>'
                    +'<input type="hidden" name="noticeNoList" value="'+JSONData.list[i].noticeNo+'"/>'
                    +'<input type="hidden" name="abandDogBreedList" value="'+JSONData.list[i].abandDogBreed+'"/>'
                    +'<input type="hidden" name="abandDogGenderList" value="'+JSONData.list[i].abandDogGender+'"/>'
                    +'<input type="hidden" name="abandDogFeatureList" value="'+JSONData.list[i].abandDogFeature+'"/>'
                    +'<input type="hidden" name="abandDogStateList" value="'+JSONData.list[i].abandDogState+'"/>'
                    +'<input type="hidden" name="abandDogImageList" value="'+JSONData.list[i].abandDogImage+'"/>'
                    +'<input type="hidden" name="happenPlaceList" value="'+JSONData.list[i].happenPlace+'"/>'
                    +'<input type="hidden" name="abandDogAgeList" value="'+JSONData.list[i].abandDogAge+'"/>'
                    +'<input type="hidden" name="abandDogWeightList" value="'+JSONData.list[i].abandDogWeight+'"/>'
                    +'<input type="hidden" name="abandDogColorList" value="'+JSONData.list[i].abandDogColor+'"/>'
                    +'<input type="hidden" name="abandDogNeuterList" value="'+JSONData.list[i].abandDogNeuter+'"/>'
                    +'<input type="hidden" name="noticeSdtList" value="'+JSONData.list[i].noticeSdt+'"/>'
                    +'<input type="hidden" name="noticeEdtList" value="'+JSONData.list[i].noticeEdt+'"/>'
                    +'<input type="hidden" name="happenDtList" value="'+JSONData.list[i].happenDt+'"/>'
                    +'<input type="hidden" name="careNmList" value="'+JSONData.list[i].careNm+'"/>'
                    +'<input type="hidden" name="careTelList" value="'+JSONData.list[i].careTel+'"/>'
                    +'<input type="hidden" name="orgNmList" value="'+JSONData.list[i].orgNm+'"/>'
                    +'<input type="hidden" name="careAddrList" value="'+JSONData.list[i].careAddr+'"/>'
                	+'</figcaption>'
            		+'</figure>'
        			+'</li>';
        			
				$("#abandDogList").append(str);
			}
			
			$("#abandDogListPage").html("");		
			str = '';
			
			 if (JSONData.resultPage.currentPage <= JSONData.resultPage.pageUnit){
				str = '<a class="disabled pagePre"><img src="../images/arrow-pre-small.png" alt="" /></a>';
			}else{
				str = '<a class="pagePre" aria-label="Previous"><img src="../images/arrow-pre-small.png" alt="" style="cursor:pointer;"/></a>';
			}
			
			for(i=JSONData.resultPage.beginUnitPage; i<=JSONData.resultPage.endUnitPage; i++){
				if(JSONData.resultPage.currentPage == i){
					str = str + '<a style="cursor:pointer;" class="active pageNum">'+i+'</a>';
				}else{
					str = str + '<a style="cursor:pointer;" class="pageNum">'+i+'</a>';
				}
			}

			 if (JSONData.resultPage.endUnitPage >= JSONData.resultPage.maxPage){
				 str = str + '<a class="disabled pageNxt"><img src="../images/arrow-next-small.png" alt="" /></a>';
				
			}else{
				str = str + '<a class="pageNxt" aria-label="Previous"><img src="../images/arrow-next-small.png" alt="" style="cursor:pointer;"/></a>';
			}

			$("#abandDogListPage").append(str);
			
			$('.pagePre').on('click', function(){
				if($(".pagePre").hasClass("disabled") == false){
					$('input[name="currentPage"]').val(JSONData.resultPage.currentPage-1);
					fncGetAbandDogList();
				}
			});
			$('.pageNxt').on('click', function(){
				if($(".pageNxt").hasClass("disabled") == false){
					$('input[name="currentPage"]').val(JSONData.resultPage.endUnitPage+1);
					fncGetAbandDogList();
				}
			});
		}
		
	}); //end of ajax	
}
 */
</script>


<body>

	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/400_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/402_tit.png"></h1>
                        <!-- end page title -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section id="key-person" class="no-padding-top animate slow-mo even fadeIn" data-anim-type="fadeIn" data-anim-delay="200">
        
				<form>
	        	<!-- search -->
	        	<section class="bg-deep padding-two" id="start">
	            <div class="container ">
	                <div class="row sm-text-center no-margin">
	                                  	
	                                  	
	                    
	                    <div class="col-md-3 col-sm-3 pull-left no-margin" style="height:47px">
	                              <div class="select-style input-round med-input">
	                                  <select name="dogBreed">
	                                      <option value="">견종</option>
		  								  <c:forEach var="breed" items="${breed}">
	                                      	<option value="${breed.key}" ${search.dogBreed==breed.key?'selected':''}>${breed.value}</option>
	                                      </c:forEach>                                  	
	                                  </select>
	                              </div>
	                      </div>
	                      
	                      <div class="col-md-3 col-sm-3 pull-left no-margin"style="height:47px">
	                              <div class="select-style input-round med-input" >
	                                  <select name="sido">
	                                      <option value="">시도</option>
		  								  <c:forEach var="sido" items="${sido}">
	                                      	<option value="${sido.key}" ${search.sido==sido.key?'selected':''}>${sido.value}</option>
	                                      </c:forEach>
	                                  </select>
	                              </div>
	                      </div>
	                      
	                      <div class="col-md-3 col-sm-3 pull-left no-margin" style="height:47px; display:${empty search.sido?'none':'block'}" id="sigungu">
	                              <div class="select-style input-round med-input">
	                                  <select name="sigungu" >
	                                      <option value="">시군구</option>
		  								  <c:forEach var="sigungu" items="${sigungu}">
	                                      	<option value="${sigungu.key}" ${search.sigungu==sigungu.key?'selected':''}>${sigungu.value}</option>
	                                      </c:forEach>
	                                  </select>
	                              </div>
	                      </div>
	                      
	                       <a class="highlight-button btn btn-medium button xs-margin-bottom-five xs-no-margin-right input-round pull-right popup-with-zoom-anim" href="#modal-popup" >상세조건</a>

					</div>
					
	            </div>

	            </section>
		        <!-- end search -->
		        
				<section class="work-4col gutter work-with-title no-margin-top content-section no-padding">
		        <div class="container margin-five no-margin-bottom">
                <div class="row">
                    <div class="col-md-12 text-center" >
                        <div class="tab-content">
                            <!-- work grid -->
                            <ul class="grid masonry-items" id="abandDogList">
                                <!-- work item -->
                                <c:forEach var="list" items="${list}">
                                <li>
					                	<div class="gallery-img" style="height: 200px"><img name="abandDogImg" src="${list.abandDogImage}" alt="" style="width:100%; height:100%; margin:0 auto;"></div>
					                    
					                    <h3 class="dog margin-two-bottom"><a href="#" name="abandDog">
					                    ${list.abandDogBreed} <img src="../images/sub/${list.abandDogGender=='M'?'male':'female'}.png"  style="width:20px; position:relative; top:-2px;"/></a></h3>
					                    <p class="text-small">${list.orgNm}</p>
					                    <input type="hidden" name="desertionNoList" value="${list.desertionNo}"/>
					                    <input type="hidden" name="noticeNoList" value="${list.noticeNo}"/>
					                    <input type="hidden" name="abandDogBreedList" value="${list.abandDogBreed}"/>
					                    <input type="hidden" name="abandDogGenderList" value="${list.abandDogGender}"/>
					                    <input type="hidden" name="abandDogFeatureList" value="${list.abandDogFeature}"/>
					                    <input type="hidden" name="abandDogStateList" value="${list.abandDogState}"/>
					                    <input type="hidden" name="abandDogImageList" value="${list.abandDogImage}"/>
					                    <input type="hidden" name="happenPlaceList" value="${list.happenPlace}"/>
					                    <input type="hidden" name="abandDogAgeList" value="${list.abandDogAge}"/>
					                    <input type="hidden" name="abandDogWeightList" value="${list.abandDogWeight}"/>
					                    <input type="hidden" name="abandDogColorList" value="${list.abandDogColor}"/>
					                    <input type="hidden" name="abandDogNeuterList" value="${list.abandDogNeuter}"/>
					                    <input type="hidden" name="noticeSdtList" value="${list.noticeSdt}"/>
					                    <input type="hidden" name="noticeEdtList" value="${list.noticeEdt}"/>
					                    <input type="hidden" name="happenDtList" value="${list.happenDt}"/>
					                    <input type="hidden" name="careNmList" value="${list.careNm}"/>
					                    <input type="hidden" name="careTelList" value="${list.careTel}"/>
					                    <input type="hidden" name="orgNmList" value="${list.orgNm}"/>
					                    <input type="hidden" name="careAddrList" value="${list.careAddr}"/>
                                </li>
                                </c:forEach>
                                <!-- end work item -->
                            </ul>
                            <!-- end work grid -->
                        </div>
                    </div>
                </div>
            </div>
	        </section>
	        
	        
	            <input type="hidden" name="desertionNo" value=""/>
	            <input type="hidden" name="noticeNo" value=""/>
	            <input type="hidden" name="abandDogBreed" value=""/>
	            <input type="hidden" name="abandDogGender" value="${search.abandDogGender}"/>
	            <input type="hidden" name="abandDogFeature" value=""/>
	            <input type="hidden" name="abandDogState" value="${search.abandDogState}"/>
	            <input type="hidden" name="abandDogImage" value=""/>
	            <input type="hidden" name="happenPlace" value=""/>
	            <input type="hidden" name="abandDogAge" value=""/>
	            <input type="hidden" name="abandDogWeight" value=""/>
	            <input type="hidden" name="abandDogColor" value=""/>
	            <input type="hidden" name="abandDogNeuter" value=""/>
	            <input type="hidden" name="noticeSdt" value=""/>
	            <input type="hidden" name="noticeEdt" value=""/>
	            <input type="hidden" name="happenDt" value=""/>
	            <input type="hidden" name="careNm" value=""/>
	            <input type="hidden" name="careTel" value=""/>
	            <input type="hidden" name="orgNm" value=""/>
	            <input type="hidden" name="careAddr" value=""/>
	            
            	<input type="hidden" id="currentPage" name="currentPage" value="0"/>	
			</form>
                
     		<!-- pagination -->
            <!-- <div class="pagination margin-ten no-margin" id="abandDogListPage">
            </div> -->
            
			<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
				<!-- pagination -->
				<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
				<!-- end pagination -->
			</div> 
			
            <!-- end pagination -->
        </section>
        <!-- end content section -->
        
        <!-- 상세조건 팝업 -->
		<div class="col-md-12 col-sm-9 no-padding">
	
			<div class="col-lg-3 col-md-4 col-sm-5 center-col text-center">
				<div id="modal-popup"
					class="zoom-anim-dialog mfp-hide col-lg-4 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main">
	
					<div>
						<span class="black-text">상세조건 검색</span>
						<p class="borderline-gray"></p>
					</div>
					
						<!-- 조건 1 -->
						<div class="form-group no-margin-bottom">
							<!-- input  -->
							<div class="text-center col-md-12 clearfix">
								<div class="no-padding pull-left">
								<label class="font-weight-600" style="margin-top:14px;">성별</label>
								</div>
								<div class="pull-right no-padding" style="display: flex;  justify-content: center; align-items: center;	">
									<input type="radio" name="abandDogGenderRadio" id="abandDogGender1" class="checkbox" value="" ${empty search.abandDogGender?'checked':''}>
									<label for="abandDogGender1" class="input-label radio">전체</label>
									<input type="radio" name="abandDogGenderRadio" id="abandDogGender2" class="checkbox" value="M" ${search.abandDogGender=='M'?'checked':''}>
									<label for="abandDogGender2" class="input-label radio">남아</label>
									<input type="radio" name="abandDogGenderRadio" id="abandDogGender3" class="checkbox" value="F" ${search.abandDogGender=='F'?'checked':''}>
									<label for="abandDogGender3" class="input-label radio">여아</label>
								</div>
							</div>
							<!-- end input  -->
						</div>
						<!-- end 조건 1 -->
						
						<!-- 조건 2 -->
						<div class="form-group no-margin-bottom">
							<!-- input  -->
							<div class="text-center col-md-12 clearfix">
								<div class="no-padding pull-left">
								<label class="font-weight-600" style="margin-top:14px;">상태</label>
								</div>
								<div class="pull-right no-padding" style="display: flex;  justify-content: center; align-items: center;">
									<span class="pull-right text-right">
										<input type="radio" name="abandDogStateRadio" id="abandDogState1" class="checkbox" value="" ${empty search.abandDogState?'checked':''}>
										<label for="abandDogState1" class="input-label radio">전체</label>
										<input type="radio" name="abandDogStateRadio" id="abandDogState2" class="checkbox" value="notice" ${search.abandDogState=='notice'?'checked':''}>
										<label for="abandDogState2" class="input-label radio">공고중</label>
										<input type="radio" name="abandDogStateRadio" id="abandDogState3" class="checkbox" value="protect" ${search.abandDogState=='protect'?'checked':''}>
										<label for="abandDogState3" class="input-label radio">보호중</label>
									</span>
								</div>
							</div>
							<!-- end input  -->
						</div>
						<!-- end 조건 2 -->
						
						<!-- 조건 3 -->
						<div class="form-group no-margin-bottom">
							<!-- input  -->
							<!-- <div class="text-center col-md-12 clearfix">
								<div class="no-padding pull-left">
								<label class="font-weight-600" style="margin-top:14px;">출생년도(추정)</label>
								</div>
								<div class="slidecontainer">
								  <input type="range" min="1" max="100" value="50" class="slider" id="myRange" data-slider-step="2">
								</div>
							</div> -->
							<!-- end input  -->
						</div>
						<!-- end 조건 3 -->
	
					<!-- 버튼 -->
					<div class="text-center no-margin-bottom">
						<a href="#" class="highlight-button btn btn-medium no-margin-bottom popup-modal-dismiss" id="searchModal">적용</a>
						<a href="#" class="highlight-button-dark btn btn-medium no-margin popup-modal-dismiss" id="cancelModal">취소</a>
					</div>
					<!-- end 버튼 -->
	
				</div>
			</div>
	
		</div>
		<!-- end 상세조건 팝업 -->
        
        
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>