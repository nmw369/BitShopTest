<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/product/listProduct?prodType=0").submit();
	}
	
	//상품이미지 클릭시 이벤트 getProduct 연결
	$(function(){
		$(".prodImage").on("click", function(){
			var role = "${sessionScope.user.role}";
			var index = $(".prodImage").index(this);
			var prodNo = $($("input[name='prodNo']")[index]).val();

			 if(role == 'admin'){
				 self.location = "/product/updateProductAdmin?prodNo="+prodNo;
			}else{
				self.location = "/product/getProduct?prodNo="+prodNo;
			}
		});
	});


	//============= 상품소팅 처리부분 =============
	$(function(){
		
		//셀렉트박스 클릭시  
		$("#sorting").on("change", function(){
			var sort = $("#sorting").val();
			if(sort == 0){
				self.location = "/product/listProduct?sorting=0&prodType=0";
			}else if(sort == 1){
				self.location = "/product/listProduct?sorting=1&prodType=0";
			}else if(sort == 2 ){
				self.location = "/product/listProduct?sorting=2&prodType=0";
			}else{
				self.location = "/product/listProduct?sorting=3&prodType=0";
			}
		})
	});
	
	//"상품등록" 버튼 이벤트 연결
	$(function(){
		$("#add").on("click", function(){
			self.location = "/product/addProductAdmin";
		});
	});


</script>

<jsp:include page="/common/css.jsp" />


<title>애견용품 리스트</title>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />

		<!-- head section -->
			<section class="page-title parallax3 parallax-fix page-title-blog">
			<img class="parallax-background-img" src="../images/sub/500_bg.jpg"
				alt="" />
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
						<div class="no-margin-top margin-one"></div>
						<!-- page title -->
						<h1 class="white-text tit_png">
							<img src="../images/sub/501_tit.png">
						</h1>
						<!-- end page title -->
					</div>
				</div>
			</div>
			</section>
		<!-- end head section -->


	<!-- content section -->
        <section>
        
        <!-- 검색버튼 -->
 		<jsp:include page="/layout/search-quick.jsp" />
		<!-- 검색버튼 -->
		
            <div class="container">
                <div class="row">
                	
                    <div class="col-md-12 col-sm-12">
                    	<form>
                        <div class="shorting clearfix xs-margin-top-three">
                            <div class="col-md-8 col-sm-8 grid-nav">
                                <a href="shop-with-sidebar-list.html"><i class="fa fa-bars"></i></a>
                                <a href="#"><i class="fa fa-th"></i></a>
                                <p class="text-uppercase letter-spacing-1">전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지</p>
                            </div>
                            <div class="col-md-3 col-sm-3 pull-right">
                                <div class="select-style med-input shop-shorting-full no-border pull-right">
                                    <select id="sorting">
                                        <option value="0" ${search.sorting == 0? 'selected' : '' }>신상품순</option>
                                        <option value="1" ${search.sorting == 1? 'selected' : '' }>인기상품순</option>
                                        <option value="2" ${search.sorting == 2? 'selected' : '' }>낮은가격순</option>
                                        <option value="3" ${search.sorting == 3? 'selected' : '' }>높은가격순</option>
                                        <input type="hidden" name="sorting"  value="${search.sorting}"/>
                                    </select>
                                </div>
                                
                                <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				  				
                            </div>
                        </div>
                        </form>
                        
                        <div class="product-listing margin-three">
                        
                            <!-- shop item -->
                            <c:forEach var="product" items="${list}">
                            <div class="col-md-4 col-sm-6">
                                <div class="home-product text-center position-relative overflow-hidden margin-ten no-margin-top">
                                	<div class="blog-post-images margin-two-bottom">
                                    <a href="#"   class="prodImage">
                                    	<img src = "/images/store/${product.prodImage}" />
                                   	</a>
                                   	</div>
                                    <span class="product-name font-weight-600">
                                    		${product.prodName}
                                    		<input type="hidden" value="${product.prodNo}" name="prodNo" />
                                   	</span>
                                    <span class="price black-text"><del>${product.price+5000}원</del>${product.price}원</span>
                                    
                                    <c:set var="cnt" value="1" />
                                    <c:forEach begin="1" end="5">
                                    	<c:if test="${cnt <= product.avgScore}">
                                    		<i  class="fa fa-star yellow-light-text text-extra-large" style="margin:0"></i>
                                    	</c:if>
                                    	<c:if test="${cnt > product.avgScore}">
                                    		<i  class="fa fa-star-o yellow-light-text text-extra-large" style="margin:0"></i>
                                    	</c:if>
                                    	<c:set var="cnt" value="${cnt+1}" />
                                    </c:forEach>
                                    (${product.reviewCnt})
                                    
                                    <span class="onsale onsale-style-2">New</span>
                                </div>
                            </div>
                            </c:forEach>
                            <!-- end shop item -->
                            
                            </div>
                            
                            <c:if test="${sessionScope.user.role == 'admin'}">
                            <div class="text-right">
                          	  <button id="add" type="button" class="highlight-button btn btn-medium">상품등록</button>
                      	   </div>
                      	   </c:if>
                            
                    </div>
                </div>
            </div>
   			<div class="pagination">
	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		<a href="#" class="disabled"><img
			src="../images/arrow-pre-small.png" alt="" /></a>
	</c:if>
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
		<a href="javascript:fncGetList('${ resultPage.currentPage-1}')"
			aria-label="Previous"><img src="../images/arrow-pre-small.png"
			alt="" /></a>
		</a>
	</c:if>

	<c:forEach var="i" begin="${resultPage.beginUnitPage}"
		end="${resultPage.endUnitPage}" step="1">
		<c:if test="${ resultPage.currentPage == i }">
			<a class="active" href="javascript:fncGetList('${ i }');">${ i }</a>
		</c:if>
		<c:if test="${ resultPage.currentPage != i}">
			<a href="javascript:fncGetList('${ i }');">${ i }</a>
		</c:if>
	</c:forEach>

	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		<a href="#" class="disabled"><img
			src="../images/arrow-next-small.png" alt="" /></a>
	</c:if>
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<a></a>
		<a href="javascript:fncGetList('${resultPage.endUnitPage+1}')"><img
			src="../images/arrow-next-small.png" alt="" /> </a>
	</c:if>

</div>
        </section>
        <!-- end content section -->
        
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>