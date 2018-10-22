<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>나의 예약내역</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<!-- 민우 -->	  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

</script>

<style type="text/css">
table th, td{text-align:center; font-size:13px;}
table td{font-size:12px;}
</style>

</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />

	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/myPage_tit.png">
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
			<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-1">
			
				<h1 align="center">빠른 상담</h1>
				
				<!-- search -->
				<div class="border-gray2 margin-two padding-two col-md-12 col-sm-10 col-xs-12">
				
					<div class="padding-two border-bottom col-md-11 col-xs-11 center-col text-center margin-two-bottom">
						<label class="text-small"><span class="magenta-text">모든 회원들</span>의 예약내역입니다. 지난 예약확인을 원하시면 조회조건을 선택해주세요.</label>
					</div>
			        
		        </div>
		        <!-- end search -->


				<!--  table Start /////////////////////////////////////-->
				<table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>질문</th>
                                    <th>응답</th>
                                </tr>
                            </thead>
                            <tbody>
<%--                             	<c:set var="i" value="0"/> --%>
<%-- 								<c:forEach var="list" items="${list}"> --%>
								<c:set var="i" value="${i+1}"/>
	                                <tr>
	                                    <td><div>${i}</div></td>
	                                    <td><textarea>현재 저희 함께할개에 등록된 치유견 수는 총 8종 입니다. 등록된 치유견으로는 "포메라니안", "스피츠", "말티즈·····."가 있습니다. 자세한 확인은 아래 링크를 클릭하여 확인하세요 Http://~~~.~~.~~"</textarea></td>
	                                    <td><div>"현재 저희 함께할개에 등록된 치유견 수는 총 8종 입니다. 등록된 치유견으로는 "포메라니안", "스피츠", "말티즈·····."가 있습니다. 자세한 확인은 아래 링크를 클릭하여 확인하세요 Http://~~~.~~.~~"</div></td>
	                                </tr>
<%--                                 </c:forEach> --%>
                            </tbody>
                        </table>
				<!--  table End /////////////////////////////////////-->
			</div>
			<!--  end content -->
			
			</div>
		</div>
	</section>
 	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
 	
</body>

</html>