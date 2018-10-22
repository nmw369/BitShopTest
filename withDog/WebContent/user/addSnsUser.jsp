<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
	
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

	<title>SNS 간편 회원가입</title>
	
	<jsp:include page="../common/css.jsp" />
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->

	<!-- 제이쿼리 달력  -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  	<link rel="stylesheet" href="/resources/demos/style.css">
	  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- end 제이쿼리 달력 -->
	
	<!-- 오토컴플릿 -->
	  <style>
	  .custom-combobox {
	    position: relative;
	    display: block;
	    width : 500px;
	  }
	  .custom-combobox-toggle {
	    position: absolute;
	    top: 0;
	    bottom: 0;
	    margin-left: -1px;
	    padding: 0;
	  }
	  .custom-combobox-input {
	    margin: 0;
	    padding: 5px 10px;
	  }
	  
	    .ui-autocomplete {
	    max-height: 200px;
	    overflow-y: auto;
	    /* prevent horizontal scrollbar */
	    overflow-x: hidden;
  	  }


		* html .ui-autocomplete {
	    height: 200px;
	  }
  	</style>
  	<script src="../js/autocomplete.js"></script>
	<!-- end 오토컴플릿 -->
	
	
	<!--  이메일 선택 -->
	<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>-->

	<script type="text/javascript">
	
	//좋아하는 견종
	$(function () {
		

		//좋아하는 견종 셀렉박스
		$.ajax({
			url : "/dogBreedDic/json/getAllBreedInfoListByKo",
			method : "GET",
			datatype : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function (data) {
							
				console.log(data)
				//console.log(data.allDogBreedInfo[2].dogNo)
				for(var i = 0; i<data.allDogBreedInfo.length; i++){
					$("#combobox").append($('<option value='+data.allDogBreedInfo[i].dogNo+'>'+data.allDogBreedInfo[i].dogBreedKO+'</option>'));
					
				}
			}
			
		}); //end of ajax	
		
		//회원가입 연결
		$("#snsJoin").on("click" , function() {
			 
			///2.좋아하는 견종 :: option value값이 String => 도메인이 int 이므로 바꿔서
 			var dogNo = $("#combobox").val()*1;
 			$("#combobox option:selected").val(dogNo);
 			
 			//value
 			var userId = "${sessionScope.tempUser.userId}" ;
 			var phone = $("#phone").val();
 			var snsType ="${sessionScope.tempUser.snsType}";
 			//$("form").attr("method","POST").attr("action","/user/json/addSnsUser").submit();
 			
 			$.ajax({
				url : "/user/json/addSnsUser",
				method : "POST",
				dataType : "json",
				data: JSON.stringify({
					userId : userId,
					phone : phone,
					snsType : snsType,
					dogNo :	dogNo
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					
					//성공	
					if(JSONData){
						self.location = "/common/mainPage";
					}else{
						alert("다시 가입해주세요");
					}
					
				
				}
			});// end ajax
 			
			
		}); 
		
	
	});
	

		
		


</script>	
	
</head>

<body>

	<jsp:include page="../layout/common-header.jsp" />


		
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/join_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/join_tit.png"></h1>
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
      <!-- content section -->
        <section>
            <div class="container clearfix"><!-- container1 -->
                <div class="row margin-five no-margin-top"><!-- row1 -->
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                        <p class="black-text font-weight-600 text-uppercase text-large">SNS간편 회원 가입 정보</p>
                        
				<!-- form  -->
				<form>
					
					<div class="form-group">
				        <label for="textbox" class="text-uppercase">아이디 :</label>
				        <input type="text" id="userId" name="userId" class="input-round big-input" readonly value="${sessionScope.tempUser.userId}">
				        <input type="hidden" name="snsType" value="${sessionScope.tempUser.snsType}">
				          <span class="changeSpanId"></span>
				    </div>
					
					<div class="form-group">
				        <label for="textbox" class="text-uppercase">이름 :</label>
				        <input type="text" id="userName" name="userName" class="input-round big-input">
				    </div>
		   
				              
					<div class="form-group">
				        <label for="errortextbox" class="text-uppercase">휴대전화 :</label>
				        <input type="text" id="phone" name="phone" class="input-round big-input" placeholder="'-'제외하고 숫자만 입력 " >
				    </div>
				    

				    
				    <div class="form-group">
					    <div class="ui-widget">
						  <label>좋아하는 견종: </label><span style="color:gray">*입력 또는 선택이 가능합니다.</span>
						  <select id="combobox" name="dogNo">
						    <option value="">Select one...</option>
						  </select>
						</div>
					</div>
			                    
			    </form>
			    
			    <!-- end form  -->  
        
		         <div class="text-center">
                 	<button class="highlight-button-dark btn no-margin post-search" id="snsJoin" type="submit">SNS 간편회원 가입하기</button>
                 </div>
			             
            </div>
        </div><!-- row1 -->
    </div><!-- container1 -->
    
</section>
<!-- end content section -->
	    
        
  <jsp:include page="../common/js.jsp" />

	<jsp:include page="../layout/footer.jsp" />
</body>
</html>