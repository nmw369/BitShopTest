<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="/common/css.jsp" />


<title>치유견 소개</title>

</head>




<body>
<script type="text/javascript">
$(function () {
	$("#addHealingDog").on("click", function () {
// 		var userId = "${user.userId}";
// 		if(userId==null || userId=="" || userId==" "){
// 			alert("로그인 하세요")
// 			return;
// 		}
// 		else{
		self.location="/ash/addHealingDog";
// 		}
	})
	
})



</script>

	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/302_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/302_tit.png"></h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section>
        
        	<div class="text-center" style="margin-bottom:65px;">
           		<img src="../images/title/t2_2.png">	
            </div>
            
            <div class="container">
                <div class="row">
                
                    <!-- dog 01 -->
                    <c:forEach var="list" items="${list}">
                    <a href="/ash/getHealingDog?healingDogNo=${list.healingDogNo}">
                    <div id="detail" class="col-md-3 col-sm-3 healingdog-style text-center xs-margin-bottom-ten blog-post">
<!--                         <img src="http://placehold.it/400x400" alt=""/> -->
						<img  src = "/images/uploadFiles/healingDog/${list.healingDogimage}" width="400px" height="400px" alt=""/>
                        <span class="name black-text">${list.healingDogName}</span>
                        <p   class="center-col width-90">${list.healingDogBreed.dogBreedKO} &nbsp; | &nbsp; ${list.healingDogBirth}살 &nbsp; | &nbsp; ${list.healingDogChar}</p>
                    </div>
                    </a>
                    </c:forEach>
                    <!-- end dog 01 -->
                    
                    <!-- 나중에 관리자만 할수있도록 수정 -->
			<c:if test="${user.role=='admin'}">
				<div class="text-center">
						<a style="cursor: pointer;" id="addHealingDog" ><span class="highlight-button btn btn-medium pull-right">치유견등록</span></a>
					</div>
			</c:if>
				<!-- 나중에 관리자만 할수있도록 수정 -->
		</div>
            </div>
        </section>
        <!-- end content section -->
        
        
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>