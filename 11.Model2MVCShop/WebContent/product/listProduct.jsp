<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<html>
<head>

 
<!-- 화면 변경 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>상품 목록조회</title>
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

<script>
$(function(){
$(".efg1").on("click",function(){
    	alert(1);
    	var index = $($(".efg")).index(this);
		
		var prodNo = $($("input[name=prodNo]")[index]).val();
		
		self.location ="/product/getProduct?prodNo="+prodNo+"&lookup=yes"+"&menu=search";
    	
    });
    
    
  } );
  
 
  </script>
<script type="text/javascript">
var page = 1;
var currentScroll=1;
var k=0;
$(window).scroll(function() {
	
	var scrollHeight = $(window).scrollTop() + $(window).height();
	var documentHeight = $(document).height();
	
	if (scrollHeight >= documentHeight){
		currentScroll++;
		$.ajax(
		{
			url:"/product/json/listProduct",
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
				
				console.log(currentScroll);
				for (var i = 0; i < scroll.length; i++) {
					/* $("#scroll").append("<h1>Page " + page + scroll[i].prodName+"//"+scroll[i].fileName); */
					
					if(scroll[i].fileName!=null){
						
						/* $("#gallery").append("<li class=\"ui-widget-content1 ui-corner-tr\">");
						$(".ui-widget-content1").append("<h5 class=\"ui-widget-header\">${product.prodName}</h5>");
						$(".ui-widget-content1").append("<img src=\"../images/uploadFiles/"+scroll[i].fileName+"\" alt=\"The peaks of High Tatras\" width=\"96\" height=\"72\">");
						$(".ui-widget-content1").append("<a href=\"../images/uploadFiles/"+scroll[i].fileName+"\" title=\"View larger image\" class=\"ui-icon ui-icon-zoomin\">View larger</a>");
						$(".ui-widget-content1").append("<a href=\"link/to/trash/script/when/we/have/js/off\" title=\"Delete this image\" class=\"ui-icon ui-icon-trash\">Delete image</a>");
						$("#gallery").append("</li>"); */
						
						
						$("#gallery").append("<li class=\"ui-widget-content ui-corner-tr\" name=\"a"+k+"\">");
						$("#gallery li[name='a"+k+"']").append("<h5 class=\"ui-widget-header\">"+scroll[i].prodName+"</h5>");
						
						
						
						/* $("#gallery li[name='a"+k+"']").append("<a href=\"/product/getProduct?prodNo="+scroll[i].prodNo+"&lookup=yes&menu=${param.menu}\"><img src=\"../images/uploadFiles/"+scroll[i].fileName+"\" alt=\"The peaks of High Tatras\" width=\"70\" height=\"72\" class=\"efg\"></a>"); */
						$("#gallery li[name='a"+k+"']").append("<img src=\"../images/uploadFiles/"+scroll[i].fileName+"\" alt=\"The peaks of High Tatras\" width=\"70\" height=\"72\" class=\"efg1\">");
						
						$("#gallery li[name='a"+k+"']").append("<a href=\"../images/uploadFiles/"+scroll[i].fileName+"\" title=\"View larger image\" class=\"ui-icon ui-icon-zoomin\">View larger</a>");
						
						$("#gallery li[name='a"+k+"']").append("<a href=\"link/to/trash/script/when/we/have/js/off\" title=\"Delete this image\" class=\"ui-icon ui-icon-trash\">Delete image</a>");
						
						
						$("#gallery li[name='a"+k+"']").append("<br/>");
						$("#gallery li[name='a"+k+"']").append("<p>상품가격 : "+scroll[i].price+"</p>");
						$("#gallery li[name='a"+k+"']").append("<br/>");
						$("#gallery li[name='a"+k+"']").append("<p>남은수량 : "+scroll[i].nEA+"</p>");
						$("#gallery li[name='a"+k+"']").append("<br/>");
						$("#gallery li[name='a"+k+"']").append("<p>현재조회수 : "+scroll[i].lookup+"</p>");				
						
						$("#gallery").append("</li>");
						
						
						
						
						
						
					}else{
						/* $("#scroll").append("<img src = \"/images/uploadFiles/notimage.gif\"width = \"150\">"); */
						
						
										
						
						$("#gallery").append("<li class=\"ui-widget-content ui-corner-tr\" name=\"a"+k+"\">");
						$("#gallery li[name='a"+k+"']").append("<h5 class=\"ui-widget-header\">"+scroll[i].prodName+"</h5>"+"a");
						
						$("#gallery li[name='a"+k+"']").append("<img src = \"../images/uploadFiles/notimage.gif \"width = \"150\" class=\"efg\">");
						/* $("#gallery li[name='a"+k+"']").append("<a href=\"/product/getProduct?prodNo="+scroll[i].prodNo+"&lookup=yes&menu=${param.menu}\"><img src=\"../images/uploadFiles/notimage.gif\" alt=\"The peaks of High Tatras\" width=\"70\" height=\"72\" class=\"efg\">"); */
						
						$("#gallery li[name='a"+k+"']").append("<a href=\"../images/uploadFiles/notimage.gif \" title=\"View larger image\" class=\"ui-icon ui-icon-zoomin\">View larger</a>");
						$("#gallery li[name='a"+k+"']").append("<a href=\"link/to/trash/script/when/we/have/js/off\" title=\"Delete this image\" class=\"ui-icon ui-icon-trash\">Delete image</a>");
						
						$("#gallery li[name='a"+k+"']").append("<br/><br/>");
						$("#gallery li[name='a"+k+"']").append("<p>상품가격 : "+scroll[i].price+"</p>");
						$("#gallery li[name='a"+k+"']").append("<br/>");
						$("#gallery li[name='a"+k+"']").append("<p>남은수량 : "+scroll[i].nEA+"</p>");
						$("#gallery li[name='a"+k+"']").append("<br/>");
						$("#gallery li[name='a"+k+"']").append("<p>현재조회수 : "+scroll[i].lookup+"</p></a>");
											
						
						$("#gallery").append("</li>");
					}
					
					
				    k++;
					
				    
				    
				  
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
	
	 $(function() {
		 
			
			//==> userId LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
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


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  <style>
  #gallery { float: left; width: 65%; min-height: 12em; }
  .gallery.custom-state-active { background: #eee; }
  .gallery li { float: left; width: 350px; height: 200px; padding: 0.4em; margin: 0 0.4em 0.4em 0; text-align: center; }
  .gallery li h5 { margin: 0 0 0.4em; cursor: move; }
  .gallery li a { float: right; }
  .gallery li a.ui-icon-zoomin { float: left; }
  .gallery li img { width: 50%; height: 80%; cursor: move; float: left;}
 
  #trash { float: right; width: 32%; min-height: 18em; padding: 1%; }
  #trash h4 { line-height: 16px; margin: 0 0 0.4em; }
  #trash h4 .ui-icon { float: left; }
  #trash .gallery h5 { display: none; }
  
  </style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
 
    // There's the gallery and the trash
    var $gallery = $( "#gallery" ),
      $trash = $( "#trash" );
 
    // Let the gallery items be draggable
    $( "li", $gallery ).draggable({
      cancel: "a.ui-icon", // clicking an icon won't initiate dragging
      revert: "invalid", // when not dropped, the item will revert back to its initial position
      containment: "document",
      helper: "clone",
      cursor: "move"
    });
 
    // Let the trash be droppable, accepting the gallery items
    $trash.droppable({
      accept: "#gallery > li",
      classes: {
        "ui-droppable-active": "ui-state-highlight"
      },
      drop: function( event, ui ) {
        deleteImage( ui.draggable );
      }
    });
 
    // Let the gallery be droppable as well, accepting items from the trash
    $gallery.droppable({
      accept: "#trash li",
      classes: {
        "ui-droppable-active": "custom-state-active"
      },
      drop: function( event, ui ) {
        recycleImage( ui.draggable );
      }
    });
 
    // Image deletion function
    var recycle_icon = "<a href='link/to/recycle/script/when/we/have/js/off' title='Recycle this image' class='ui-icon ui-icon-refresh'>Recycle image</a>";
    function deleteImage( $item ) {
      $item.fadeOut(function() {
        var $list = $( "ul", $trash ).length ?
          $( "ul", $trash ) :
          $( "<ul class='gallery ui-helper-reset'/>" ).appendTo( $trash );
 
        $item.find( "a.ui-icon-trash" ).remove();
        $item.append( recycle_icon ).appendTo( $list ).fadeIn(function() {
          $item
            .animate({ width: "48px" })
            .find( "img" )
              .animate({ height: "36px" });
        });
      });
    }
 
    // Image recycle function
    var trash_icon = "<a href='link/to/trash/script/when/we/have/js/off' title='Delete this image' class='ui-icon ui-icon-trash'>Delete image</a>";
    function recycleImage( $item ) {
      $item.fadeOut(function() {
        $item
          .find( "a.ui-icon-refresh" )
            .remove()
          .end()
          .css( "width", "350px")
          .append( trash_icon )
          .find( "img" )
            .css( "height", "200px" )
          .end()
          .appendTo( $gallery )
          .fadeIn();
      });
    }
 
    // Image preview function, demonstrating the ui.dialog used as a modal window
    function viewLargerImage( $link ) {
      var src = $link.attr( "href" ),
        title = $link.siblings( "img" ).attr( "alt" ),
        $modal = $( "img[src$='" + src + "']" );
 
      if ( $modal.length ) {
        $modal.dialog( "open" );
      } else {
        var img = $( "<img alt='" + title + "' width='384' height='288' style='display: none; padding: 8px;' />" )
          .attr( "src", src ).appendTo( "body" );
        setTimeout(function() {
          img.dialog({
            title: title,
            width: 400,
            modal: true
          });
        }, 1 );
      }
    }
 
    // Resolve the icons behavior with event delegation
    $( "ul.gallery > li" ).on( "click", function( event ) {
      var $item = $( this ),
        $target = $( event.target );
 
      if ( $target.is( "a.ui-icon-trash" ) ) {
        deleteImage( $item );
      } else if ( $target.is( "a.ui-icon-zoomin" ) ) {
        viewLargerImage( $target );
      } else if ( $target.is( "a.ui-icon-refresh" ) ) {
        recycleImage( $item );
      }
 
      return false;
    });
    
    
    
    $(".efg").on("click",function(){
    	
    	var index = $($(".efg")).index(this);
		
		var prodNo = $($("input[name=prodNo]")[index]).val();
		
		self.location ="/product/getProduct?prodNo="+prodNo+"&lookup=yes"+"&menu=${param.menu}";
    	
    });
    
    
  } );
  
 
  </script>



</head>


<body bgcolor="#ffffff" text="#000000">
<jsp:include page="../layout/menubar.jsp"/>
<div style="width:98%; margin-left:10px;">


<div class="row">
	    
		   <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition">
						<option id="check" value="0" ${search.searchCondition =="0"? "selected" : ""}>상품번호</option>
						<option id="check" value="1" ${search.searchCondition =="1"? "selected" : ""}>상품명</option>
						<option id="check" value="2" ${search.searchCondition =="2"? "selected" : ""}>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control"  name="searchKeyword"  placeholder="검색어" id="tags"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  onkeypress="if(event.keyCode == 13){ javascript:fncGetList('1')};">
				  </div>
				  
				  
				  
				  <button type="button" class="btn btn-default" id="key">검색</button>
		<c:if test="${sorting=='low'}">
		<input type="hidden" name="sorting" value="${sorting}">
		<input type="button" onClick="location.href='/product/listProduct?sorting=high'" value="가격높은순&Delta;">
		</c:if>
		<c:if test="${sorting=='high'}">
		<input type="hidden" name="sorting" value="${sorting}">
		<input type="button" onClick="location.href='/product/listProduct?sorting=low'" value="가격낮은순&nabla;">
		</c:if> 
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
		<c:if test="${empty daysorting||daysorting=='lowDay'}">
		<input type="hidden" name="daysorting" value="${daysorting}">
		<input type="button" onClick="location.href='/product/listProduct?daysorting=highDay'" value="최신순&Delta;">
				</c:if>
		<c:if test="${daysorting=='highDay'}">
		<input type="hidden" name="daysorting" value="${daysorting}">
		<input type="button" onClick="location.href='/product/listProduct?daysorting=lowDay'" value="오래된순&nabla;">
		</c:if>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>




<div class="ui-widget ui-helper-clearfix">
 
<ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix">
  
<c:forEach var="product" items="${list}"> 
  <li class="ui-widget-content ui-corner-tr">
    <h5 class="ui-widget-header">${product.prodName}</h5>
    <img src="../images/uploadFiles/${product.fileName}" alt="The peaks of High Tatras" width="70" height="72" class="efg">
    <a href="../images/uploadFiles/${product.fileName}" title="View larger image" class="ui-icon ui-icon-zoomin">View larger</a>
    <a href="link/to/trash/script/when/we/have/js/off" title="Delete this image" class="ui-icon ui-icon-trash">Delete image</a>
    
    
    <br/>
    <p>상품가격 : ${product.price}</p>
    <br/>
    <p>남은수량 : ${product.nEA}</p>
    <br/>
    <p>현재 조회수 : ${product.lookup}</p>
    
    <%-- <a href="/product/getProduct?prodNo="+${prodcut.prodNo}+"&lookup=yes"><img src="../images/uploadFiles/"+${product.fileName} alt="The peaks of High Tatras" width="96" height="72" class="efg"></a> --%>
    
    <input type="hidden" name="prodNo" value="${product.prodNo }">
  </li>
 </c:forEach>
  
</ul>

 
<div id="trash" class="ui-widget-content ui-state-default" style="position:fixed; right:85px;">
  <h4 class="ui-widget-header" align="center"><span class="ui-icon ui-icon-trash">상품찜하기</span> 상품찜하기</h4>
</div>
 
</div>
	

</div>
<div id="scroll">
</div>


</body>
</html>