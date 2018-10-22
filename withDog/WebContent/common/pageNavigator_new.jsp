<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">


	$(function() {
		$(".disabled").on("click", function() {
			return false;
		})
	})
	
	
</script>
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

