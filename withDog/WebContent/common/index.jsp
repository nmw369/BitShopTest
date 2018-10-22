<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<jsp:include page="/common/css.jsp" />
<title>함께할개</title>

<script>
function nearmap(){
	popWin = window.open("/quick/ARMap","popWin", "left=300,width=1060,height=790,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}

</script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- <script>
$(function(){
    var filter = "win16|win32|win64|mac|macintel";
    
	 if( navigator.platform  ){
	
		if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
	
			console.log("모바일 기기에서 접속");
			
						
								
		}else{
	
			console.log("PC에서 접속");
		}
		
</script> -->
<style type="text/css">


@media only screen and (min-width:400px){
background: url(../images/main-visual1.jpg) no-repeat center center fixed; -webkit-background-size: cover;-moz-background-size: cover;-o-background-size: cover;background-size: cover;

}



</style>


</head>
<body>
	<jsp:include page="/layout/common-header.jsp" />
	
		
			<video autoplay="true" loop="loop" muted>
			
			    <source src="../images/login/Withdog.mp4" />
			
			</video>
	
	<!-- slider -->
<!--         <section id="slider" class="no-padding"> -->
<!--             <div id="owl-demo" class="owl-carousel owl-theme light-pagination square-pagination dark-pagination-without-next-prev-arrow main-slider"> -->
<!--                 slider item -->
<!--                 <div class="item owl-bg-img" style="background-image:url('../images/main-visual1.jpg')"> -->
<!--                     <div class="bg-dark-gray"></div> -->
<!--                     <div class="container full-screen position-relative"> -->
<!--                         <div class="slider-typography text-center"> -->
<!--                             <div class="slider-text-middle-main"> -->
<!--                                 <div class="slider-text-middle slider-text-middle6 padding-left-right-px wow fadeInUp"> -->
<!--                                     <span class="slider-title-big6 white-text text-uppercase font-weight-700 letter-spacing-3">withdog</span> -->
<!--                                     <span class="white-text text-small text-uppercase letter-spacing-10 margin-three no-margin-bottom display-block xs-letter-spacing-6">we craft experiences that help brands</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 end slider item -->
<!--                 slider item -->
<!--                 <div class="item owl-bg-img" style="background-image:url('http://placehold.it/1920x1100');"> -->
<!--                     <div class="opacity-full bg-dark-gray"></div> -->
<!--                     <div class="container full-screen position-relative"> -->
<!--                         <div class="slider-typography text-center"> -->
<!--                             <div class="slider-text-middle-main"> -->
<!--                                 <div class="slider-text-middle slider-text-middle6 padding-left-right-px wow fadeInUp"> -->
<!--                                     <span class="slider-title-big6 white-text text-uppercase font-weight-700 letter-spacing-3">Leadership</span> -->
<!--                                     <span class="white-text text-small text-uppercase letter-spacing-10 margin-three no-margin-bottom display-block">we work hard - we play hard</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 end slider item -->
<!--                 slider item -->
<!--                 <div class="item owl-bg-img" style="background-image:url('http://placehold.it/1920x1100');"> -->
<!--                     <div class="opacity-full bg-dark-gray"></div> -->
<!--                     <div class="container full-screen position-relative"> -->
<!--                         <div class="slider-typography text-center"> -->
<!--                             <div class="slider-text-middle-main"> -->
<!--                                 <div class="slider-text-middle slider-text-middle6 padding-left-right-px wow fadeInUp"> -->
<!--                                     <span class="slider-title-big6 white-text text-uppercase font-weight-700 letter-spacing-3">Expertise</span> -->
<!--                                     <span class="white-text text-small text-uppercase letter-spacing-10 margin-three no-margin-bottom display-block">We craft unique digital experiences</span> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--                 end slider item -->
<!--             </div> -->
<!--         </section> -->
<!--         end slider -->
        
        
        

  
             
        
        <!-- work process section 01 02 03 04-->
        <section id="work-process" class="work-process wow fadeIn">
            <div class="container">
                <div class="row">
                	<!-- 01 -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-center work-process-sub position-relative overflow-hidden sm-margin-bottom-eight wow fadeIn">
                        <div class="work-process-text">
                            <span class="work-process-number font-weight-100 display-block">01</span>
                            <span class="text-uppercase letter-spacing-2 font-weight-600 black-text">Community</span>
                            <div class="separator-line-thick bg-mid-gray margin-three"></div>
                        </div>
                        <div class="work-process-details position-absolute display-block">
                            <i class="icon-chat medium-icon fast-yellow-text display-block"></i>
                            <span class="text-small text-uppercase">Patience is the greatest of all virtues.<br> The will of a man is his happiness.</span>
                        </div>
                    </div>
                    
					<!-- 02 -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-center work-process-sub position-relative overflow-hidden sm-margin-bottom-eight wow fadeIn">
                        <div class="work-process-text">
                            <span class="work-process-number font-weight-100 display-block">02</span>
                            <span class="text-uppercase letter-spacing-2 font-weight-600 black-text">withDog</span>
                            <div class="separator-line-thick bg-mid-gray margin-three"></div>
                        </div>
                        <div class="work-process-details position-absolute display-block">
                            <i class="icon-toolbox medium-icon fast-yellow-text display-block"></i>
                            <span class="text-small text-uppercase">Everything is good for something.<br>Whatever you undertake, think of the end.</span>
                        </div>
                    </div>

					<!-- 03 -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-center work-process-sub position-relative overflow-hidden wow fadeIn">
                        <div class="work-process-text">
                            <span class="work-process-number font-weight-100 display-block">03</span>
                            <span class="text-uppercase letter-spacing-2 font-weight-600 black-text">Store</span>
                            <div class="separator-line-thick bg-mid-gray margin-three"></div>
                        </div>
                        <div class="work-process-details position-absolute display-block">
                            <i class="icon-desktop medium-icon fast-yellow-text display-block"></i>
                            <span class="text-small text-uppercase">The best things in life are free<br> Like he's bewitched by a goblin</span>
                        </div>
                    </div>

					<!-- 04 -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-center work-process-sub position-relative overflow-hidden wow fadeIn">
                        <div class="work-process-text">
                            <span class="work-process-number font-weight-100 display-block">04</span>
                            <span class="text-uppercase letter-spacing-2 font-weight-600 black-text">AR</span>
                            <div class="separator-line-thick bg-mid-gray margin-three"></div>
                        </div>
                        <div class="work-process-details position-absolute display-block">
                            <i class="icon-hotairballoon medium-icon fast-yellow-text display-block"></i>
                            <span class="text-small text-uppercase">The getting out of the door <br> is the greatest part of the journey.</span>
                        </div>
                    </div>

                </div><!-- end of row  --> 
            </div><!-- end of container  -->
        </section>
        <!-- end work process section -->
        
        
        
        <div class="container-fluid no-margin-bottom">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 bg-fast-yellow padding-three text-center">
                    <span class="text-small text-uppercase font-weight-600 black-text letter-spacing-2">
                    so hyun &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    jang won &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    sung hee &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    joo yeon &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    min woo</span>
                </div>
            </div>
        </div>
        
        
        
         <section class="bg-gray">
            <div class="container">
                <div class="row">
                    <!-- text block -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-block text-center">
                        <div class="text-block-inner">
                            <p class="text-large text-uppercase no-margin-bottom">near</p>
                            <p class="title-small text-uppercase font-weight-600 black-text letter-spacing-1">With Map</p>
                            <a class="highlight-button btn btn-small no-margin" href="javascript:nearmap();">start</a>
                        </div>
                    </div>
                    <!-- end text block -->
                    <!-- text block -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-block text-center">
                        <div class="text-block-inner">
                        	<p class="text-large text-uppercase no-margin-bottom">video</p>
                            <p class="title-small text-uppercase font-weight-600 black-text width-70 center-col letter-spacing-1">consulting</p>
                            <a class="highlight-button btn btn-small no-margin" href="shop-with-sidebar.html">apply</a>
                        </div>
                    </div>
                    <!-- end text block -->
                    <!-- text block -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-block text-center">
                        <div class="text-block-inner">
                            <p class="text-large text-uppercase no-margin-bottom">Make with</p>
                            <p class="title-small text-uppercase font-weight-600 black-text width-70 center-col letter-spacing-1">With AR</p>
                            <a class="highlight-button btn btn-small no-margin" href="Intent://searchWithAR#Intent;scheme=WithAR;package=com.WithProject.WithAR;end">Start</a>
                        </div>
                    </div>
                    <!-- end text block -->
                    <!-- text block -->
                    <div class="col-md-3 col-sm-6 col-xs-12 text-block text-center">
                        <div class="text-block-inner">
                            <p class="text-large text-uppercase no-margin-bottom">Last 2 Days!</p>
                            <p class="title-small text-uppercase font-weight-600 black-text letter-spacing-1">Crowd Funding</p>
                            <a class="highlight-button btn btn-small no-margin" href="shop-with-sidebar.html">support</a>
                        </div>
                    </div>
                    <!-- end text block -->
                </div>
            </div>
        </section>
        
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>