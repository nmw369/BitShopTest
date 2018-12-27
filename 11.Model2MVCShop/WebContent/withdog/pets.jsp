<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
	<head>
		<meta charset="EUC-KR">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<!--   jQuery , Bootstrap CDN  -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
		<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
		<style>
	        body {
	            padding-top : 70px;
background: url("images/uploadFiles/dog.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
     font-size: 1.5vw;
	        }
	        #test p{
    font-size: 7vw;
}
#test1 p{
    font-size: 8vw;
}
    	</style>
		<!-- ���� �ݹ� ���󺯰� -->
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
<!-- css������ ���� ��ũ -->
<link rel="stylesheet" href="/css/animate.css" />

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
	</head>
	
	<body>
	
		<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<!-- <a class="navbar-brand" href="/index.jsp">Pets Comming</a> -->
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target">

			<ul class="nav navbar-nav">
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >�� Ŀ��</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">��Ŀ���̶�?</a></li>
						<li><a href="#">�������Ұ�</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >userId</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">����������</a></li>
						<li><a href="#">��������</a></li>
						<li><a href="#">������Ծ系��</a></li>
						<li><a href="#">�����Ű�ġ�᳻��</a></li>
						<li><a href="#">����</a></li>
						<li><a href="#">��ٱ���</a></li>
						<li><a href="#">�Ŀ����</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >����ߺо�</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">�Ծ�ȳ�</a></li>
						<li><a href="#">�Ծ����</a></li>
						<li><a href="#">���⵿����ȣ����</a></li>
					</ul>
				</li>
				
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >�����Ű�ġ��</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">�����Ű�ġ���?</a></li>
						<li><a href="#">�����Ű�ġ��Ȱ��</a></li>
						<li><a href="#">�����Ű�ġ���û</a></li>
						<li><a href="#">�ǽð� ���� ���</a></li>
					</ul>
				</li>
				
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >�ְ߹��</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">�����������</a></li>
						<li><a href="#">�ְ߻��</a></li>						
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >��Ŀ�� �����</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">�ְ߿�ǰ</a></li>
						<li><a href="#">�ְ߽�ǰ</a></li>
						<li><a href="#">��ٱ���</a></li>						
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >Ŀ�´�Ƽ</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">�� Ŀ�� Ȱ��</a></li>
						<li><a href="#">�� Ŀ�� �ı�</a></li>
						<li><a href="#">�� Ŀ�� �ݷ��� ����</a></li>
					
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >������Ŀ�</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">���������</a></li>
						<li><a href="#">�Ŀ���Ȳ</a></li>
						<li><a href="#">�Ŀ��ı�</a></li>
						
					</ul>
				</li>
				
				
				
				
								
			</ul>
	      
	        	
	              </div> 	
	    		</div>
    	</div>
   	 	<!-- div : Block ���� ��������
   	 	span : Inline���� ��������
   	 	==>���� Tag�� Block/Inline���� Tag�� �����ϸ�
   	 	Block ���� Tag:div,h1~h6,p,ol,ul,li,table,form -->
   	 	
   	 	
 <div class="container">  	 	
   	 	<div class="row">
  <div class="col-md-3">
  	  
  	<div class="panel panel-info">
  		<div class="panel-heading">
  			<h3 class="panel-titel">
  				<i class="glyphicon glyphicon-heart">
  					Quick bar
  				</i>
  			</h3>
  		</div>
  	<ul class="list-group">
  		<li class="list-group-item"><a href="/petsmain.jsp">������</a></li>		
	  	<li class="list-group-item"><a href="#">ä�û��(ê��)</a></li>
		<li class="list-group-item"><a href="#">�ݷ��߽ǽð�����</a></li>
		<li class="list-group-item"><a href="#">������/��ȣ��</a></li>
  	</ul>
  	</div>
  	</div>
  
	</div>
	</div>	


<div id="test">
<p>Welcome to</p>
</div>
<div id="test1" align="right">
<p> The Pets Comming</p>
</div>
	
	
	</body>
</html>