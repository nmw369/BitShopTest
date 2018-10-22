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


<title>펀딩신청문의</title>
<script>


$(function(){
	
	if('${req}'=="yes"){
		alert("신청이 완료되었습니다.");
	}
	
	
	$("span:contains('신청하기')").on("click",function(){
		console.log(1);
		
		var file = $("#fundReq").val();
		
		console.log(file);
				
		if(file==null||file.length<1){
			alert("신청서를 첨부해주세요");
			return;
		}
		
		$("form").submit();
		
		
	});
	
});


</script>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/703_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/704_tit.png"></h1>
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
        <section class="wow fadeIn">
            <div class="container">
                 <div class="row">
                    <div class="col-md-5 col-sm-8 col-xs-11 center-col xs-no-padding">
                    
                        <form method="post" action="/fund/fundReqSend" enctype="multipart/form-data">  
                        <div class="form-group no-margin-bottom">
                        		<hr/>
                        		
                        		<jsp:include page="/fund/tooltip.jsp"></jsp:include>
                        		<hr/>
                        </div>
                            <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <hr/>
                                <div align="center"><h3>신청서 파일 다운로드</h3></div>
                                <hr/>
                                <div align="center">
                                <a href="/fund/fundReqFile?sendfileExe=docx"><img alt="" src="../images/fund/word.png"></a>
                                <a href="/fund/fundReqFile?sendfileExe=xlsx"><img alt="" src="../images/fund/xlsx.png"></a>
                                <a href="/fund/fundReqFile?sendfileExe=pdf"><img alt="" src="../images/fund/pdf.png"></a>
                                <a href="/fund/fundReqFile?sendfileExe=hwp"><img alt="" src="../images/fund/hwp.png"></a>
                                </div>
								<!-- end input  -->
							</div>
							 
							 <div class="form-group no-margin-bottom">
                                <!-- label  -->
                                <hr/>
                                <div align="center"><h3>작성이 완료된 파일을 첨부해주세요</h3></div>
                                <hr/>
                                <!-- end label  -->
                                <!-- input  -->
                                <input type="file" name="fundReq" id="fundReq" class="input-round big-input">
								<!-- end input  -->
							</div>
                                
                        </form>
                       	
                       	<div class="text-right">
                                                 
                           <button class="btn highlight-button-dark btn-medium btn-round margin-five no-margin-right"><span>신청하기</span></button>
                  
                        </div>
                        
                        
                    </div>
                           
                </div>
                          
            </div>
        </section>
        <!-- end content section -->

	
	<jsp:include page="/layout/footer3.jsp" />
	
	<jsp:include page="/common/jsTooltip.jsp" />
	
</body>
</html>