<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<html>
<head>

 
<!-- ȭ�� ���� -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>��ǰ �����ȸ</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css" >

 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
	  var availableTags;
	  $("#tags").on("keyup",function(){
		  console.log($(".form-control").val());
			$.ajax(
		  			{
				 url:"/product/json/getProdSearch", 
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

  <!-- ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<style>
		body{
			padding-top : 70px;
		}
	</style>



<script type="text/javascript">
var page = 1;	
$(window).scroll(function() {
	
	var scrollHeight = $(window).scrollTop() + $(window).height();
	var documentHeight = $(document).height();
	var currentScroll = 1;
	if (scrollHeight >= documentHeight){
	 $.ajax(
		{
			url:"/product/json/getScroll",
			method:"POST",
			data:JSON.stringify({
			currentPage:currentScroll
			}),
			dataType:"json",
			headers:{
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success:function(scroll,status){
				for (var i = 0; i < scroll.length; i++) {
					$("#scroll").append("<h1>Page " + page + scroll[i].prodName+"//"+scroll[i].fileName);
					$("#scroll").append("<img src = \"/images/uploadFiles/"+scroll[i].fileName+"\""+" width = \"150\">");
					
				}
				
			}
			
		}	 
	 
	 );
	
	
     
      
    }
});
</script>

  
 <script type="text/javascript">
	function fncGetList(currentPage){
		
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	 function fncGetList2(currentPage,sorting){
			
		document.getElementById("currentPage").value = currentPage;
		document.getElementById("sorting").value = sorting;
		document.detailForm.submit();
	}
	 $(function() {
		 
			
			//==> userId LINK Event ����ó��
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
			$( ".ct_list_pop td:nth-child(5)" ).on("click" , function() {
				
					//Debug..
					//alert(  $( this ).text().trim() );
					var index = $($(".ct_list_pop td:nth-child(5)")).index(this);
					console.log(index)
					var prodNo = $($("input[name=prodNo]")[index]).val();
					console.log(prodNo)
					self.location ="/product/getProduct?prodNo="+prodNo+"&lookup=yes"+"&menu=${param.menu}";
			});
			
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			/*  $("#searchKeyword").on("keyup",function(){
			
			
				$.ajax(
						{
					url:"/product/json/getListProduct",
					method:"POST",
					data:JSON.stringify({
						searchKeyword:$("#searchKeyword").val()
					}),
				dataType:"json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success:function(searchList,status){
												
						fncGetList('1');
					
					}
				 }
				);//ajax end
				
			}); */
			
			
			
			
				
		});
</script>


</head>


<body bgcolor="#ffffff" text="#000000">
<jsp:include page="../layout/menubar.jsp"/>
<div style="width:98%; margin-left:10px;">

	
		

<div class="container">
		<div class="page-header">
	        ���� ��ȸ�� ����
	     </div>
	      
	      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	        <ol class="carousel-indicators">
	          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	        </ol>
	        
	        <div class="carousel-inner" role="listbox">
	          <div class="item active">
	            <img src="../images/uploadFiles/cat.jpg"  width="500" height="100" alt="First slide">
	          </div>
	          <c:forEach var="pro" items="${list}">
	          <div class="item">
	            <c:if test="${!empty pro.fileName }">
			    <img src="/images/uploadFiles/${pro.fileName}" width="500" height="100"  align="left">
			    <td class="ct_write01">${pro.prodName}</td>
			    </c:if>
			    <c:if test="${empty pro.fileName }">
			    <img src="/images/uploadFiles/notimage.gif" width="500" height="100"  align="left">
			    </c:if>
	          </div>
	          
	          </c:forEach>
	        </div>
	        
	        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	          <span class="sr-only">Previous</span>
	        </a>
	        
	        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	          <span class="sr-only">Next</span>
	        </a>
	     </div>
	</div>



<form name="detailForm" action="/product/listProduct" method="post">
<input name="menu" value="${param.menu }" type="hidden">
<table width="100%" height="37" border="0"  cellpadding="0"	cellspacing="0" >
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<%-- <%if(menu.equals("manage")){ %>
							<td width="93%" class="ct_ttl01">��ǰ ����</td>
					<%}else{ %>
							<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
					<%} %> --%>
					
					<td width="93%" class="ct_ttl01">
					${param.menu== "manage"? "��ǰ����":"��ǰ �����ȸ"}
					</td>
									
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>


 <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition">
						<option id="check" value="0" ${search.searchCondition =="0"? "selected" : ""}>��ǰ��ȣ</option>
						<option id="check" value="1" ${search.searchCondition =="1"? "selected" : ""}>��ǰ��</option>
						<option id="check" value="2" ${search.searchCondition =="2"? "selected" : ""}>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <%-- <input type="text" class="form-control"  name="searchKeyword"  placeholder="�˻���" id="tags"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  onkeypress="if(event.keyCode == 13){ javascript:fncGetList('1')};"> --%>
				  </div>
				  <input type="text" id="tags">
				  
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
		��ü  ${resultPage.totalCount } ��, ���� ${resultPage.currentPage} ������ 
		<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ǰ���� 
		&nbsp;<input type="button" onClick="location.href='/listProduct.do?sorting=high'" value="������&nabla;">
		 <input type="button" onClick="location.href='/listProduct.do?sorting=low'" value="������&Delta;">  -->
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">��ǰ�̹���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100" >
		<c:if test="${sorting=='low'}">
		<input type="hidden" name="sorting" value="${sorting}">
		<input type="button" onClick="location.href='/product/listProduct?sorting=high'" value="���ݳ�����&Delta;">
		</c:if>
		<c:if test="${sorting=='high'}">
		<input type="hidden" name="sorting" value="${sorting}">
		<input type="button" onClick="location.href='/product/listProduct?sorting=low'" value="���ݳ�����&nabla;">
		</c:if> 
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
		<c:if test="${empty daysorting||daysorting=='lowDay'}">
		<input type="hidden" name="daysorting" value="${daysorting}">
		<input type="button" onClick="location.href='/product/listProduct?daysorting=highDay'" value="�ֽż�&Delta;">
				</c:if>
		<c:if test="${daysorting=='highDay'}">
		<input type="hidden" name="daysorting" value="${daysorting}">
		<input type="button" onClick="location.href='/product/listProduct?daysorting=lowDay'" value="�����ȼ�&nabla;">
		</c:if>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ����</td> 
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�������</td>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
	
		
	<c:set var="i" value="${currentPage}"></c:set>
	<c:set var="j" value="${pageSize}"></c:set>
	<c:set var="k" value="2"></c:set>
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${i+1}"></c:set>
		
		
	<tr class="ct_list_pop" bgcolor="#ffffff">
		<td align="center">${i}</td>
		<td></td>
		<td align="center">
		<c:if test="${!empty product.fileName}">
		<img src = "/images/uploadFiles/${product.fileName}" width = "150">
		</c:if>
		<c:if test="${empty product.fileName}">
		<img src = "/images/uploadFiles/notimage.gif" width = "150">
		</c:if>
		</td>
		<td></td>
		
		<td align="center">
		<c:if test="${user.role=='user' || empty user.role }">
		<%-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}&lookup=yes">${product.prodName}</a> --%>
		${product.prodName}
		
		</c:if>
		<c:if test="${user.role=='admin' }">
		<%-- <a href="/product/updateProductView?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a> --%>
		${product.prodName}
		</c:if>
		<input type="hidden" name="prodNo" value="${product.prodNo }">
		</td>
		<td></td>
		<td align="center">${product.price}</td>
		<td></td>
		<td align="center">${product.regDate}</td>
		<td></td>
		<td align="center">${product.nEA}</td>
		<td align="center">
					
				<c:if test="${product.eaCode != '0' && !empty user}">
						<td align="center">�Ǹ���</td>
					</c:if>
				
				<c:if test="${product.eaCode == '0' }">
						<c:if test="${user.role=='admin' }">
							<td align="center">������</td>
					
						</c:if>
						<c:if test="${user.role=='user' }">
							<td align="center">����</td>	
						</c:if>		
							
				</c:if>
						
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				

	
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>
</div>
<div id="scroll">
</div>
</body>
</html>