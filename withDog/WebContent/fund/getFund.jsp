<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<jsp:include page="/common/css.jsp" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>펀딩상세정보</title>
</head>

<script>


$(function(){
	
	$("span:contains('후원금결제')").on("click",function(){
		
		var Title = '${fund.fundTitle}';
		var No = '${fund.fundNo}'
		console.log(Title);
		
		if(document.getElementById("usePoint").value !=null){
			
			var usePoint = document.getElementById("usePoint").value;
			console.log(usePoint);
		}
		
		if(document.getElementById("fundMyPrice").value !=null){
			
			var price = document.getElementById("fundMyPrice").value;
			console.log(price);
		}
		
		
		
		/* self.location.href="/fund/kakaoPay?fundTitle="+Title+"&usePoint="+usePoint+"&fundMyPrice="+price; */
		
		 popWin 
		= window.open("/fund/kakaoPay?fundNo="+No+"&fundTitle="+Title+"&usePoint="+usePoint+"&fundMyPrice="+price,"popWin", "left=300,width=500,height=300,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
		
		
	});
	
	$("span:contains('펀딩수정')").on("click",function(){
		self.location.href="/fund/updateFund?fundNo=${fund.fundNo}";
	});
	$("span:contains('펀딩삭제')").on("click",function(){
		self.location.href="/fund/deleteFund?fundNo=${fund.fundNo}";
	});
	$("span:contains('펀딩완료')").on("click",function(){
		self.location.href="/fund/updateFundState?fundNo=${fund.fundNo}";
	});
});


</script>


<body>

	<jsp:include page="/layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/700_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">Fund Detail</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">Details of Crowd funding.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        

        <!-- content section -->
        <section>
            <div class="container">
            
            	<!-- fund title -->
            	<p class="col-md-10 col-sm-8 col-xs-11 text-center center-col fund-detail-title black-text">${fund.fundTitle}</p>
            	<!-- end fund title -->
            	
                <div class="row">
                
                    <!-- product images -->
                    <div class="col-md-6 col-sm-12 zoom-gallery sm-margin-bottom-ten">
                        <a href=""><img src="../images/fund/${fund.fundImage}" alt=""/></a>
                    </div>
                    <!-- end product images -->
                    
                    <div class="col-md-5 col-sm-12 col-md-offset-1">
                    
                        <!-- fund No -->
                         <%-- <span class="rating-text text-uppercase pull-right">펀딩번호: <span class="black-text">${fund.fundNo}</span></span> --%>
                        <div class="separator-line bg-black no-margin-lr margin-five no-margin-top"></div>
                        <!-- end fund No -->

                        <c:if test="${user.role=='admin'}">
                        <p class="no-margin-bottom">펀딩번호:</p>

                        <div class="fund-sub-title ">${fund.fundNo}</div>
                        </c:if>
                        <!-- fund detail 01 -->
                        <p class="no-margin-bottom">펀딩요청기관</p>
                        <div class="fund-sub-title ">${fund.fundCenter}</div>
                        <!-- end detail  -->
                        <!-- fund detail 02 -->
                        <p class="no-margin-bottom">펀딩기간</p>
                        <div class="fund-sub-title">${fund.fundTerm}</div>
                        <!-- end detail  -->
                        <!-- fund detail 03 -->
                        <p class="no-margin-bottom">현재후원금액</p>
                        <div class="fund-sub-title">${fund.fundRaising}<span class="fund-small">원</span></div>
                        <!-- end detail  -->
                        <!-- fund detail 03 -->
                        <p class="no-margin-bottom">후원자수</p>
                        <div class="fund-sub-title">${fund.fundPersonnel+50}<span class="fund-small">명</span></div>
                        <!-- end detail  -->
                        
                       <!-- 후원하기 모달팝업 -->
	                        <div class="col-md-9 col-sm-9 no-padding margin-five">
	                        
	                            <!-- button -->
	                            <c:if test="${fund.fundState=='0' &&!empty user.userId}">
		                        <a class="highlight-button btn btn-medium button no-margin-right popup-with-zoom-anim no-margin-bottom" href="#modal-popup2">후원하기</a>
	                            <!-- end button -->
	                            </c:if>
	                            <!-- modal popup -->
		                        <div class="col-lg-3 col-md-4 col-sm-5 center-col text-center">
			                        <!-- modal popup -->
			                        <div id="modal-popup2" class="zoom-anim-dialog mfp-hide col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main">
			                            <span class="fund-modal slider-subtitle5 black-text no-margin-bottom">후원하기</span>
			                            <div class="borderline-gray"></div>
			                            
			                            <form id="kakaoin">
                        
				                           <div class="form-group no-margin-bottom">
				                                <!-- label  -->
				                                <label class="pull-left">후원할 금액</label>
				                                <!-- end label  -->
				                                <!-- input  -->
				                                <input type="text" name="fundMyPrice" id="fundMyPrice"  class="big-input" value=0>
				                                <!-- end input  -->
				                            </div>
				                            
				                            <div class="form-group" style="margin-bottom:40px;">
				                                <!-- label  -->
				                                <label class="pull-left">사용할 포인트</label>
				                                <!-- end label  -->
				                                <!-- input  -->
				                                <input type="text" name="usePoint" id="usePoint"  class="big-input no-margin-bottom" value=0>
				                                <div class="pull-right">[현재 ${currentPoint} point 보유]</div>
				                                
				                                <!-- end input  -->
				                            </div>
				                            
			                            	
				                            <div class="form-group" style="margin-bottom:40px;">
				                            	<p class="borderline-gray"></p>
				                                <label class="pull-left">결제수단</label>
				                                <p class="pull-right"><input type="radio" name="kakaoPay" id="kakaoPay" value="kakaoPay" checked>카카오페이</p>
				                            </div>
				                            
				                       </form>
				                       	
				                            <span id="abc" class="highlight-button btn-small button center-col">후원금결제</span>
				                       
			                        </div>
			                        <!-- end modal popup -->
			                    </div>
		                        <!-- end modal popup -->
		                        
	                        </div>
		                <!-- end 후원하기 모닾팝업 --> 
		                
                        
                    </div>
                </div>
            </div>
        </section>

        <section class="border-top">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <!-- tab -->
                        <div class="tab-style1">
                            <div class="col-md-12 col-sm-12 no-padding">
                                <!-- tab navigation -->
                                <ul class="nav nav-tabs nav-tabs-light">
                                    <li class="active"><a href="#tab_sec1" data-toggle="tab">펀딩설명</a></li>
                                </ul>
                                <!-- tab end navigation -->
                            </div>
                            <!-- tab content section -->
                            <div class="tab-content">
                            
                            
                                <!-- 펀딩설명 -->
                                <div class="tab-pane med-text fade in active" id="tab_sec1">
                                    <div class="row">
                                        <div class="col-md-9 col-sm-12 center-col">
                                            <p>${fund.fundContent}</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- end 펀딩설명 -->
                                
                                 
                            </div>
                            <!-- end tab content section -->
                        </div>
                        <!-- end tab -->
                    </div>
                </div>
                <c:if test="${user.role=='admin'}">
                <div class="text-center">
					<span class="highlight-button btn btn-medium">펀딩수정</span>
					<span class="highlight-button btn btn-medium">펀딩삭제</span>
					<span class="highlight-button btn btn-medium">펀딩완료</span>
				</div>
			
				</c:if>
            </div>
        </section>
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
                            1. 해당 펀딩은 철저한 검토후 진행됩니다.</br>
                            2. 후원금액의 사용처는 완료된 펀딩 목록 카테고리에서 확인가능합니다.<br>
                            3. 후원한 금액은 불가피한 사유가 없는한 환불이 불가능합니다.<br>
                            4. 불가피한 사유로 환불요청시 전화상으로만 가능합니다.
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