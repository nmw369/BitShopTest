<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
<head>
<title>Bit Shop</title>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<style>
body{
    background: url("images/uploadFiles/mainBack.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    font-size: 2vw;
}
#test p{
    font-size: 8vw;
}
#test1 p{
    font-size: 8vw;
}

</style>
<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
</style>
<!-- 글자 반반 색상변경 -->
<style type="text/css">
   /* #test p{color:blue;} */
   #test p{
   position: relative;
  display: inline-block;
  background: linear-gradient(-90deg, #3498db 50%,#ffffff 50%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  white-space: nowrap;
   }
   #test1 p{
   position: relative;
  display: inline-block;
  background: linear-gradient(-90deg, #ffffff 50%,#3498db  50%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  white-space: nowrap;
   }
</style>
<!-- css편집을 위한 링크 -->
<link rel="stylesheet" href="/css/animate.css" />

</head>
<body>
<jsp:include page="layout/menubar.jsp"/>
<!-- <img src="images/uploadFiles/mainBack.jpg"> -->

<br/>
<br/>
<br/>
<br/>
<br/>
<div id="test">
<p>The Bit shop has</p>
<br/>
<br/>
</div>
<div id="test1" align="center">
<p>Everything you want.</p>
</div>

<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script>
  $(function(){
	  $('#test').removeClass().addClass("slideInDown animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    });
	  $('#test1').removeClass().addClass("slideInLeft animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    });
  });
  

</script>
 
</body>
</html>