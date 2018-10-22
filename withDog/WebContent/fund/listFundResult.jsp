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


<title>완료된펀딩 리스트</title>



 <style>
  .ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
  }
  /* IE 6 doesn't support max-height
   * we use height instead, but this forces the menu to always be this tall
   */
  * html .ui-autocomplete {
    height: 100px;
  }
  </style>

  <script>
  $( function() {
	  var availableTags;
	  $("#tags").on("keyup",function(){
		  console.log($(".form-control").val());
			$.ajax(
		  			{
				 url:"/fund/json/getFundSearch", 
		  		 method:"POST",
		  		 data:JSON.stringify({
		  			searchCondition:$(".form-control").val(),
		  		    searchKeyword:$("#tags").val()
		  			
		  		 }),
		  		 dataType:"json",
		  		 headers:{
		  			 "Accept" : "application/json",
		  			 "Content-Type" : "application/json"
		  		 },
		  		 success:function(prodSearch,status){
		  		 	 availableTags=prodSearch;
		  		 	$( "#tags" ).autocomplete({
		  		      source: availableTags
		  		    });
		  		  }
		  		 }
		  		);//ajax end
		  
	    	  });
    
    
  } );
  </script>
  
<script type="text/javascript">

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("form").attr("method","POST").attr("action","/fund/getFundResultList").submit();
}


</script>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
	 
	 <%-- <input type="text" placeholder="Search..." class="search-input" name="search" value="${! empty search.searchKeyword ? search.searchKeyword : '' }" > --%>
    <form>
     <input type="hidden" id="currentPage" name="currentPage" value=""/>
     
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
        <!-- 영상삼담 소개 -->
        <section class="padding-two wow fadeIn">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">THE CROWD FUND</span>
                        <h1>완료된펀딩 목록</h1><hr/>
                        <!-- <div class="separator-line bg-black margin-two no-margin-bottom"></div> -->
                        <!-- <p class="text-p width-120 center-col margin-two no-margin-bottom">크라우드펀딩은 군중 또는 다수를 의미하는 영어단어 크라우드(crowd)와 자금조달을 뜻하는 펀딩(funding)을 조합한 용어입니다. <br>  창의적 기업가를 비롯한 자금수요자가 인터넷 등의 온라인상에서 자금모집을 중개하는 자(온라앤소액투자중개업자)를 통하여 <br>불특정 다수의 소액투자자로부터 자금을 조달하는 행위를 의미합니다.  <br>이러한 크라우드펀딩은 자금모집 및 보상방식에 따라 통상 기부형, 후원형, 대출형, 증권형(투자형) 등으로 구분됩니다. </p> -->
                        
                        <div class="form-group col-md-8" style="float: right;">
		                	
						    <select class="form-control" name="searchCondition" style="width: 20%;display:inline-block;">
								<option id="check" value="0" ${search.searchCondition =="0"? "selected" : ""}>펀딩제목</option>
								<option id="check" value="1" ${search.searchCondition =="1"? "selected" : ""}>펀딩번호</option>
							</select>
						    <label class="sr-only" for="searchKeyword">검색어</label>
						    <input type="text" class="form-control"  name="searchKeyword"  placeholder="검색어" id="tags"
						    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  onkeypress="if(event.keyCode == 13){ javascript:fncGetList('1')};" style=" width: 50%;display:inline-block;">
						     <button type="button" class="highlight-button btn-medium button margin-five" id="key" onclick="javascript:fncGetList('1')">검색</button>
						 </div>
					    </div>
					     
					
                    </div>
                    
                </div>
            
        </section>
        <!-- end 영상삼담 소개 -->
        <!-- content section -->
        <section class="wow fadeIn no-padding-top">
        
        
               <div class="container">   
                <div class="row">
                    <!-- content  -->
                   
                                       
                    <!-- 펀딩 item 01 -->
                    <c:forEach var="list" items="${list}">
                     
	                    <div class="col-md-4 col-sm-4">
	                        <div class="blog-post">
	                            <div class="blog-post-images"><a href="getFund?fundNo=${list.fundNo}"><img src="../images/fund/${list.fundImage}" alt=""></a></div>
	                            <div class="post-details">
	                                <a href="" class="fund-title">${list.fundTitle}</a>
	                                <span class="fund-center">${list.fundCenter}</span>
	                                <div class="borderline"></div>
	                                <span class="fund-term">후원모집기간 : ${list.fundTerm}</span><br/>
	                                <span class="fund-raising">모인금액 : ${list.fundRaising}</span>
	                                
	                            </div>
	                                <a class="highlight-button btn-medium button margin-five" href="getFund?fundNo=${list.fundNo}">상세정보</a>
	                        </div>
	                    </div>
	                    
                    </c:forEach>
                   
                </div>
        		<!-- <div align="right">
        		     <a class="highlight-button btn-medium button margin-five" href="addFundView">등록하기</a>
        		</div> -->
        		<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp">
                        <!-- pagination -->
						<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
                        <!-- end pagination -->
                    </div>        
            </div>
            
        </section>
        <!-- end content section -->
        
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
		
        
	</form>
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>