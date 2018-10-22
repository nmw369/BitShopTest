<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>footer</title>
  <style>
      div.a {
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
      a.top {
        position: fixed;
        left: 50%;
        bottom: 50px;
        display: none;
      }
    </style>
    <!-- <script src="//code.jquery.com/jquery-1.12.4.min.js"></script> -->
    <script>
      $( document ).ready( function() {
        $( window ).scroll( function() {
          if ( $( this ).scrollTop() > 200 ) {
            $( '.top' ).fadeIn();
          } else {
            $( '.top' ).fadeOut();
          }
        } );
        $( '.top' ).click( function() {
          $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
          return false;
        } );
      } );
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
            
             
            <div class="a">
		     	<a href="#" class="top">1:1 빠른상담</a>
		    </div>
            <!-- scroll to top End... --> 
        </footer>
        <!-- end footer -->
        
        
</body>
</html>