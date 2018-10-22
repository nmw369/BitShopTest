<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	
<title>회원 관리 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>	  
<script type="text/javascript">

	$(function() {
		

		
		
		
		
		
	}); //제이쿼리 끝
		
	
	
</script>	

</head>

<body>
	
	<jsp:include page="/layout/common-header.jsp" />
     
     
     <!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/305_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/admin_tit.png">
				</h1>
				<!-- end page title -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->
	
	
	<section class="wow fadeIn">
	<div class="container">
	<div class="row">
		
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/admin-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
			
			
		    
		    
		    <!-- content -->
		    <div class="col-md-9 col-sm-9 col-md-offset-1">
		    
			  <jsp:include page="getAllUserRateAdmin.jsp" />
				
		
			</div>
			<!-- end content  -->
	
	</div>
	</div>
	</section>	
     
     <jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
	    
	
</body>

</html>