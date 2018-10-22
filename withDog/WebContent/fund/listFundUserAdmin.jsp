<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
<title>내 후원 내역</title>
	<meta charset="EUC-KR">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	  
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
  
  <script type="text/javascript">

function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("form").attr("method","POST").attr("action","/fund/getFundUserListAdmin").submit();
}


</script>

</head>

<body>
	
	 <%-- <input type="text" placeholder="Search..." class="search-input" name="search" value="${! empty search.searchKeyword ? search.searchKeyword : '' }" > --%>
     
     
	<!-- 숫자증가 스크립트 -->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <script src="/js/jquery.counterup.min.js"></script>
    <!--end  -->
	<!-- ToolBar Start /////////////////////////////////////-->
	
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<!-- <div class="container" style="width: 921px;"> -->
	<div class="container" style="width: 980px;">
	
		
	       <h1 align="center">회원별후원내역</h1>
	    <hr/>
	    
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	   <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<!-- <button type="button" class="btn btn-default">진행중</button>
		    	<button type="button" class="btn btn-default">완료</button> -->
		    	
		    </div>
		    
		    <div class="col-md-6 text-right">
			   <form>
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>펀딩제목</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="tags" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }" onkeypress="if(event.keyCode == 13){ javascript:fncGetList('1')};" >
				  </div>
				  
				  <button type="button" class="highlight-button btn-medium button margin-five">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>  
				
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<hr/>
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <td align="center">회원ID</td>
            <td align="center">후원날짜</td>
            <td align="center">펀딩제목</td>
            <td align="center">결제금액</td>
            <td align="center">포인트</td>
         </tr>
        </thead>
       
		<tbody>
		
		  
		  <c:forEach var="list" items="${list}">
			<tr>
			  <td align="center" style="white-space: nowrap;">${list.user.userId}</td>
			  <td align="center" style="white-space: nowrap;">${list.fundMyDate}</td>
			  <td align="center" style="white-space: nowrap;">${list.fundTitle}</td>
			  <td align="center" style="white-space: nowrap;">${list.fundMyPrice}원</td>
			  <td align="center" style="white-space: nowrap;">${list.point.usePoint} Point 사용</td>
			  			 
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
                        <!-- pagination -->
						<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
                        <!-- end pagination -->
                    </div> 
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	
	<!-- PageNavigation End... -->
	
</body>

</html>