<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.dropdown:hover > .dropdown-menu{
		display : block;
	}
	
	.rightMenu{
		position:absolute;
		float:right;
		top:0;
		left:158px;
	}
</style>




<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Bit Shop</a>
		
		<a class="navbar-brand" href="#">�ǽð�ä��</a>
		<!-- <a  class="navbar-brand" href="callMyApp://search">�۽���</a> -->
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
				<c:if test="${sessionScope.user.role == 'admin'}">
					<li class="dropdown">
						<a	href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span>������ �޴�</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >ȸ������</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">ȸ��������ȸ</a></li>
								</ul>
							</li>
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >��ǰ����</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">�ǸŻ�ǰ���</a></li>
									<li><a href="#">�ǸŵȻ�ǰ����</a></li>
									<li><a href="#">������Ҹ��</a></li>
									<li><a href="#">��ǰ��ȸ�����</a></li>
								</ul>
							</li>
						<!-- 	<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >������������</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">�Ǹ��̷���ȸ</a></li>
								</ul>
							</li> -->
						</ul>
					</li>
				</c:if>

				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >��ǰ����</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">��ǰ�˻�</a></li>
						<li><a href="#">��ǰ��ȸ�����</a></li>
						<c:if test="${!empty user}">
							<li><a href="#">�����̷���ȸ</a></li>
						</c:if>
					</ul>
				</li>
								
			</ul>
			
			
			<c:if test="${empty user.password}">
				<form class="navbar-form navbar-right">
					<!-- <input type="text" class="form-control" name="userId" placeholder="ID" style="display:inline-block; width:120px;"/>
					<input type="password" class="form-control" name="password" placeholder="PASSWORD" style="display:inline-block; width:120px;"/> -->
					<button type="submit" class="btn btn-primary">Log in</button>
					<button type="button" class="btn btn-primary">Sign in</button>
					<!-- <button type="button" class="btn btn-primary">īī��</button> -->
				</form>
			</c:if>	
			<c:if test="${!empty user.password}">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" class="user-info">${sessionScope.user.userName}</a>
					<li><a href="#">�α׾ƿ�</a></li>
				</ul>
			</c:if>
		</div>
	    
	</div>
</div>

<script type="text/javascript">
	function loginCheck(){
		/* var id=$('input:text').val();
		var pw=$('input:password').val();
		
		if(id == null || id.length < 1){
			alert('���̵� �Է����� �ʾҽ��ϴ�.');
			$('input:text').focus();
			return;
		}
		
		if(pw == null || pw.length < 1){
			alert('��й�ȣ�� �Է����� �ʾҽ��ϴ�.');
			$('input:password').focus();
			return;
		} */
		
/* 		$('.navbar-form').attr('method','get').attr('action','${param.uri}user/login').submit(); */
		
		$('.navbar-form').attr('method','get').attr('action','user/NaverLogin').submit();
		
		/* $('.navbar-form').attr('method','get').attr('action','/NaverLogin').submit(); */
		
		/* $(window.parent.frames["rightFrame"].document.location).attr("href","/user/NaverLogin"); */
	}
	
	$(function(){
	
		$("a.user-info").bind("click",function(){
			self.location.href="/user/getUser?userId=${sessionScope.user.userId}";
		});
	
		$("a:contains('ȸ��������ȸ')").bind("click", function(){
			self.location.href="/user/listUser";
		});
		
		$("a:contains('�ǸŻ�ǰ���')").bind("click", function(){
			self.location.href="/product/addProductView";
		});
	
		$("a:contains('�ǸŻ�ǰ����')").bind("click", function(){
			self.location.href="/product/listProduct?menu=manage";
		});
	
		$("a:contains('�ǸŵȻ�ǰ����')").bind("click", function(){
			self.location.href="/purchase/listSale?cancelCode=0";
		});
		$("a:contains('��ǰ��ȸ�����')").bind("click", function(){
			self.location.href="/purchase/mainView";
		});
	
		$("a:contains('��ǰ�˻�')").bind("click", function(){
			self.location.href="/product/listProduct?menu=search";
		});
	
		$("a:contains('�����̷���ȸ')").bind("click", function(){
			self.location.href="/purchase/listPurchase?searchKeyword=purchaseList&searchCondition=${user.userId}";
		});
		
		$("a:contains('������Ҹ��')").bind("click", function(){
			self.location.href="/purchase/cancelList?cancelCode=1";
		});
		
		$("button:contains('Log in')").bind("click",function(){
			loginCheck();
		});
		
		$(".navbar-form button:contains('Sign in')").bind("click",function(){
			self.location.href="/user/addUser";
		});
		
		
		$("a:contains('�α׾ƿ�')").bind("click",function(){
			self.location.href="/user/logout";
		});
		
		$("a:contains('�ǽð�ä��')").bind("click",function(){
			popWin 
			= window.open("/product/chating","popWin", "left=300,top=200,width=500,height=250,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
		});
		
		
		/* $(".navbar-form button:contains('īī��')").bind("click",function(){
			self.location.href="${param.uri}purchase/kakaoPay";
		}); */
	
	});
</script>

