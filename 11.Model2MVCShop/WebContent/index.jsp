<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html> 
    <head>
        <meta charset="utf-8">
        <title>남민우</title>
    	<meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/templatemo_misc.css">
        <link rel="stylesheet" href="css/templatemo_style.css">
        
        <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

        <script src="javascript/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
        
        
        <script type="text/javascript">
		$(function(){
			
			$.ajax({
				url : 'purchase/json/mainView',
				method : 'GET',
				dataType : 'json',
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(list,status){
					/* 새로고침을 한번실행하기위한 로직 */
					if (self.name != 'reload') {
				         self.name = 'reload';
				         self.location.reload(true);
				     }
				     else{
				    	 self.name = 'reload';		
				     }
					/* $('div.carousel-inner img').bind('click',function(){
						self.location.href = 'product/getProduct?menu=search&prodNo='+$(this).parent().find('input:hidden').val();
					});*/
				},
				fail: function(err) {
		              alert(11);
		        }
			});/* ajaxend */
			
		});
	</script>
    </head>
    <body>
    
      <jsp:include page="layout/menubar.jsp"/>

       <%--  <div class="site-main" id="sTop">
            <div class="site-header">
                <!-- <div class="container">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <ul class="social-icons">
                                <li><a href="#" class="fa fa-facebook"></a></li>
                                <li><a href="#" class="fa fa-twitter"></a></li>
                                <li><a href="#" class="fa fa-dribbble"></a></li>
                                <li><a href="#" class="fa fa-linkedin"></a></li>
                            </ul>
                        </div> /.col-md-12
                    </div> /.row
                </div> /.container -->
                <div class="main-header">
                    <div class="container">
                   
                    <div 	class="collapse navbar-collapse" id="target">

						<ul class="nav navbar-nav">
                        
                        <div id="menu-wrapper">
                            <div class="row">
                                <div class="logo-wrapper col-md-2 col-sm-2">
                                    <h1>
                                        <a href="#">남민우</a>
                                    </h1>
                                </div> <!-- /.logo-wrapper -->
                                <div class="col-md-10 col-sm-10 main-menu text-right">
                                    <div class="toggle-menu visible-sm visible-xs"><i class="fa fa-bars"></i></div>
                                    <ul class="menu-first">
                                        <li class="active"><a href="index.jsp">Home</a></li>
                                        <li><a href="#services">실시간채팅</a></li>
                                        
                                        <li class="dropdown">
                                                                                		
                                        		<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
													<span >상품구매</span>
													<span class="caret"></span>
												</a>
                                        
						                     <ul class="dropdown-menu">
												<li><a href="#">상품검색</a></li>
												<c:if test="${!empty user}">
													<li><a href="#">구매이력조회</a></li>
												</c:if>
											</ul>
										
                                        </li>
                                        
                                        <li><a href="#portfolio">유저</a></li>
                                        <li><a href="#our-team">관리자</a></li>
                                        <li><a href="http://plus.facebook.com/+templatemo" class="external" target="_parent" rel="nofollow">External</a></li> 
                                        <li><a href="#contact">Contact</a></li>                                 
                                    </ul>                                    
                                </div> <!-- /.main-menu -->
                            </div> <!-- /.row -->
                        </div> <!-- /#menu-wrapper --> 
                        
                        </ul>
                        </div><!-- 메뉴 --> --%>
                                               
                    </div> <!-- /.container -->
                </div> <!-- /.main-header -->
            </div> <!-- /.site-header -->
            <div class="site-slider">
                <div class="slider">
                    <div class="flexslider">
                        <ul class="slides">
                            <li>
                                <div class="overlay"></div>
                                <img src="images/uploadFiles/dog.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>BIT Shop has</h2>
                                    <p></p>
                                    <!-- <a href="#" class="slider-btn">Let us design!</a> -->
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <img src="images/uploadFiles/dog2.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>Everything you want</h2>
                                    <p></p>
                                    <!-- <a href="#" class="slider-btn">Go to Portfolio</a> -->
                                </div>
                            </li>
                            <li>
                                <div class="overlay"></div>
                                <img src="images/uploadFiles/dog3.jpg" alt="">
                                <div class="slider-caption visible-md visible-lg">
                                    <h2>Happy Shopping!</h2>
                           			<p></p>	
                                    <!-- <a href="#" class="slider-btn">Mobile Website</a> -->
                                </div>
                            </li>
                        </ul>
                    </div> <!-- /.flexslider -->
                </div> <!-- /.slider -->
            </div> <!-- /.site-slider -->
        </div> <!-- /.site-main -->


        <div class="content-section" id="services">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>이용가능 서비스</h2>
                        
                    </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-1">
                            <div class="service-icon">
                                <!-- <img src="images/uploadFiles/back.jpg" width="150" height= "150"
                                class="fa fa-file-code-o"> -->
                             	쇼핑
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>쇼핑</h3>
                                   <p>여러종류의 제품 정보를 무한스크롤과 앨범형 리스트를 활용해 보여줍니다.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-2">
                            <div class="service-icon">
                                <!-- <i class="fa fa-paper-plane-o"></i> -->
                                 	 실시간 채팅
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>실시간 채팅</h3>
                                   <p>로그인을 한 Client들만 이용이 가능하며 이용시 Brodcasting 방식을 사용한 다중채팅이 가능합니다.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-3">
                            <div class="service-icon">
                                <!-- <i class="fa fa-institution"></i> -->
                                	조회수순위
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>상품별조회수순위</h3>
                                   <p>각품목별 실시간 조회수를 Main 화면의 앨범형과 카테고리의 차트형식으로 보여줍니다.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                    <div class="col-md-3 col-sm-6">
                        <div class="service-item" id="service-4">
                            <div class="service-icon">
                                <!-- <i class="fa fa-flask"></i> -->
                                SNS로그인
                            </div> <!-- /.service-icon -->
                            <div class="service-content">
                                <div class="inner-service">
                                   <h3>SNS로그인,결제</h3>
                                   <p>네이버,카카오,페이스북을 통한 가입과 로그인이 가능하며 카카오 페이를 통해 결제가 가능합니다.</p> 
                                </div>
                            </div> <!-- /.service-content -->
                        </div> <!-- /#service-1 -->
                    </div> <!-- /.col-md-3 -->
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#services -->



        <div class="content-section" id="portfolio">
            <div class="container">
                <div class="row">
                    <div class="heading-section col-md-12 text-center">
                        <h2>실시간 조회수 순위</h2>
                                </div> <!-- /.heading-section -->
                </div> <!-- /.row -->
                <div class="row">
                	<c:if test="${!empty list}">
                    <%-- <c:forEach begin="0" end="7"> --%>
					<c:forEach var="pro" items="${list}" begin="0" end="7">
					
                    <div class="portfolio-item col-md-3 col-sm-6">
                        <div class="portfolio-thumb">
                            <a href="/product/getProduct?prodNo=${pro.prodNo}&lookup=yes&menu=search">
                            <img src="images/uploadFiles/${pro.fileName}" alt="">
                              <div class="portfolio-overlay">
                                <h3>${pro.prodName}</h3>
                                <p>상품가격 : ${pro.price}</p>
                                <p>상세정보 : ${pro.prodDetail}</p>
                                <p>남은수량 : ${pro.nEA}</p>
                                <p>조회수   : ${pro.lookup}</p>
                                
                                <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand">
                                    <i class="fa fa-search"></i>
                                </a>
                                </a>
                            </div> <!-- /.portfolio-overlay -->
                        </div> <!-- /.portfolio-thumb -->
                    </div> <!-- /.portfolio-item -->
                    </c:forEach>
                    </c:if>
                </div> <!-- /.row -->
            </div> <!-- /.container -->
        </div> <!-- /#portfolio -->

        <script src="javascript/vendor/jquery-1.11.0.min.js"></script>
        <script>window.jQuery || document.write('<script src="javascript/vendor/jquery-1.11.0.min.js"><\/script>')</script>
        <script src="javascript/bootstrap.js"></script>
        <script src="javascript/plugins.js"></script>
        <script src="javascript/main.js"></script>

		
    </body>
    <script type="text/javascript">
    	$(function(){
    		$("a:contains('실시간채팅')").bind("click",function(){
    			popWin 
    			= window.open("/product/chating","popWin", "left=300,top=200,width=500,height=250,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
    		});
    	});
    
    </script>
</html>