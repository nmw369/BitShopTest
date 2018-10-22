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


<title>펀딩 리스트</title>

</head>
<style>
	#banner {
		
		background-image: url("../images/fund/banner.png");
	}
</style>

<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/700_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/702_tit.png"></h1>
                        <!-- end page title -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
   <!--    <span class="about-number1 font-weight-400 letter-spacing-2 xs-no-border xs-no-padding-left xs-display-none">당신의 후원을 기다립니다.</span> -->  
        
        <!-- content section -->
 
         <!-- 영상삼담 소개 -->
        <section class="padding-two wow fadeIn">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <!-- <span class="margin-one no-margin-top display-block letter-spacing-2">THE CROWD FUND</span>
                        <h1>크라우드펀딩 목록</h1><hr/> -->
                        <img alt="" src="../images/fund/CrowdFundTitle.png">
                        <!-- <div class="separator-line bg-black margin-two no-margin-bottom"></div> -->
                        <!-- <p class="text-p width-120 center-col margin-two no-margin-bottom">크라우드펀딩은 군중 또는 다수를 의미하는 영어단어 크라우드(crowd)와 자금조달을 뜻하는 펀딩(funding)을 조합한 용어입니다. <br>  창의적 기업가를 비롯한 자금수요자가 인터넷 등의 온라인상에서 자금모집을 중개하는 자(온라앤소액투자중개업자)를 통하여 <br>불특정 다수의 소액투자자로부터 자금을 조달하는 행위를 의미합니다.  <br>이러한 크라우드펀딩은 자금모집 및 보상방식에 따라 통상 기부형, 후원형, 대출형, 증권형(투자형) 등으로 구분됩니다. </p> -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end 영상삼담 소개 -->
                          
        
            <div class="container margin-two wow fadeIn">
                <div class="row">
                    <!-- content  -->
                   
                    <div class="col-md-12 col-sm-12 margin-bottom center-col">
						<div class="row">
                            <!-- <div class="col-lg-6 col-md-6 case-study-img cover-background no-padding" style="background-image:url('http://placehold.it/800x400');"> --> 
                            <div class="col-lg-6 col-md-6 case-study-img cover-background no-padding">
                            <img src="../images/fund/${Bastfund.fundImage}" alt="">
                            </div>
                                                        <div class="col-lg-6 col-md-6 case-study-details2 no-margin-top" style="border: 1px solid #000000; border-left: 0px" id="banner">		
                             <%--  <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                    <span class="about-number1 font-weight-400 letter-spacing-2 xs-no-border xs-no-padding-left xs-display-none">${fund.fundTitle}</span>
                                </div> --%>
                                <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 about-text position-relative xs-text-center margin-nine">
                                    <h2 class="font-weight-700 text-center" style="margin-top:30px;" align="center">${Bastfund.fundTitle}</h2>
                                    <div class="borderline-1px"></div>
                                    <ul>
                                    <li class="text-p margin-two">모집기관 : ${Bastfund.fundCenter}</li>
                                    <li class="text-p margin-two">모집기간 : ${Bastfund.fundTerm}</li>
                                    <li class="text-p margin-two">모집금액 : ${Bastfund.fundRaising} 원</li>
                                    <p class="width-100 xs-width-100 margin-ten"></p>
                                    <%-- <a href="getFund?fundNo=${Bastfund.fundNo}"  class="highlight-button-dark3 btn no-margin sm-no-margin btn-round">상세정보</a> --%>
                                    <a href="getFund?fundNo=${Bastfund.fundNo}"><img alt="" src="../images/fund/eee2.png"></a>
                                    </ul>
                                </div>
                            </div>
                          </div>
                         </div>
                    <hr/>
                    <!-- 펀딩 item 01 -->
                    <c:forEach var="list" items="${list}">
                    <div class="col-md-4 col-sm-4">
                        <div class="blog-post">
                            <div class="blog-post-images"><a href="getFund?fundNo=${list.fundNo}"><img src="../images/fund/${list.fundImage}" alt=""></a></div>
                            <div class="post-details">
                                <a href="" class="fund-title">${list.fundTitle}</a>
                                <span class="fund-center">${list.fundCenter}</span>
                                <div class="borderline-1px"></div>
                                <span class="fund-term">후원모집기간 : ${list.fundTerm}</span><br/>
                                <span class="fund-raising">모인금액 : ${list.fundRaising} 원</span>
                                
                            </div>
                                <a class="highlight-button btn-medium button margin-five btn-round" href="getFund?fundNo=${list.fundNo}">상세정보</a>
                        </div>
                    </div>
                    </c:forEach>
                   
                </div>
                <c:if test="${user.role=='admin'}">
        		<div align="right">
        		     <a class="highlight-button btn-medium button margin-five" href="addFundView">등록하기</a>
        		</div>
        		</c:if>        
            </div>
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
                            1. 펀딩은 철저한 검토후 진행됩니다.</br>
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