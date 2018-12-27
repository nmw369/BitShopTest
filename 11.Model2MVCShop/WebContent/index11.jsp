<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>
<head>
	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		body{
			padding-top : 70px;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			
			$.ajax({
				url : 'purchase/json/mainView',
				method : 'GET',
				dataType : 'json',
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(list,status){
					/* ���ΰ�ħ�� �ѹ������ϱ����� ���� */
					if (self.name != 'reload') {
				         self.name = 'reload';
				         self.location.reload(true);
				     }
				     else{
				    	 self.name = 'reload';		
				     }
					/* $('div.carousel-inner img').bind('click',function(){
						self.location.href = 'product/getProduct?menu=search&prodNo='+$(this).parent().find('input:hidden').val();
					});*/
				},
				fail: function(err) {
		              alert(11);
		        }
			});/* ajaxend */
			
		});
	</script>
</head>

   <!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />



	<link rel="stylesheet" href="/css/admin.css" type="text/css" >
  <link rel="stylesheet" href="https://cdn.jsdelivr.net\/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
  
    <script type="text/javascript">
   /*  playAlert = setInterval(function() {
		   alert('��ũ��Ʈ���âȮ��');
	}, 30000000); */
    </script>
  
  
<c:if test="${user.role!= 'admin' }">
  <script type="text/javascript">
    $(document).ready(function(){
      $('.slider').bxSlider();
    });
  </script>
  </c:if>

  <c:if test="${user.role=='admin'}">
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	<!-- �޷¿� ��ũ��Ʈ -->
	<script type="text/javascript" src="../javascript/calendar.js">
	</script>
	
	<script type="text/javascript">
	
	function day(){
		//Form ��ȿ�� ����
	 	
		var manuDate = document.detailForm.manuDate.value;
		
	}
	function lookuplist(){
		var start = "yes";
		document.getElementById("start").value = start;
		document.detailForm.submit();
	}
	function chart(){
		var start = "chart";
		document.getElementById("start").value = start;
		document.detailForm.submit();
	}

	</script>
	
	
	
	
	<script>
	// ��Ʈ�� ����ϱ� ���� �غ��Դϴ�.
		google.charts.load('current', {packages:['corechart']});	
	</script>

	<!-- ���⿡ ��Ʈ�� �����˴ϴ�. -->
	
	<%-- <c:if test="${start=='chart' || empty manuDate}"> --%>
		<%-- <c:if test="${!empty lookuplist}"> --%>
	<script type="text/javascript">
		
		
	// �ε� �Ϸ�� �Լ� �����Ͽ� ��Ʈ ����
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
		
		/* var test = "${a}";
		alert(test);
		 */
		
	// ��Ʈ ������ ����
		var data = google.visualization.arrayToDataTable([
			['��ǰ��', '��ȸ��'], // �׸� ����
			<c:forEach var="lookup" items="${lookuplist}" varStatus="status">
			
				<c:if test="${!status.last}">
				['${lookup.prodName}', parseInt('${lookup.lookup}')], // �׸�, �� (���� ���ڷ� �Է��ϸ� �׷����� ������)
				</c:if>				
				<c:if test="${status.last}">
				['${lookup.prodName}', parseInt('${lookup.lookup}')]
				</c:if>
			</c:forEach>
			]);

	// �׷��� �ɼ�
				var options = {
				title : '�ǽð� ��ǰ�� ��ȸ��', // ����
				width : 1100, // ���� px
				height : 400, // ���� px
				bar : {
					groupWidth : '80%' // �׷��� �ʺ� ���� %
				},
				legend : {
					position : 'none' // �׸� ǥ�� ���� (���� ������ ����)
				}
			};

		var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
		chart.draw(data, options);
		}
		
	
	</script>
		</c:if>
<body>

	<jsp:include page="layout/menubar.jsp"/>
	
	
	<c:if test="${user.role== 'admin' }">
		
		<form name="detailForm" method="post" action="/purchase/mainView">
			<h3 align="center">��ȸ�� ��¥�� �����ϼ���.</h3>
				
				<p align="center"><input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
							style="width: 100px; height: 19px"	maxLength="10" minLength="6"
							id="manuDate" value="${pday}"/>
					&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
					onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
				</p>
	   	<input type="hidden" name="start" id="start" value="${start}">
				
		<p align="center">
		<input type="button" value="��ǰ��ȸ����Ʈ" onclick="chart()">
		<input type="button" value="��ǰ��ȸ�����" onclick="lookuplist()">
		</p>
		<c:if test="${start=='chart'}">		
		<h4 align="center">${day} �� ��ȸ�� ��Ʈ�Դϴ�.</h4>
		
		<!-- ��Ʈȣ�� -->
		<div id="chart_div"></div>
		</c:if>
		
		</form>
		
				
		<c:if test="${!empty lookuplist}">
		<c:if test="${!empty start && start=='yes'}">
			<h4 align="center">${day} �� ��ȸ�� ����Դϴ�.</h4>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td class="ct_list_b" width="100">��ǰ��</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="100">��ȸ��</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">�Ǹŷ�</td>
				<td class="ct_line02"></td>
			</tr>
				
			<c:forEach var="lookup" items="${lookuplist}">
			<tr>
			<td align="center">${lookup.prodName}</td>
			<td></td>
			<td align="center">${lookup.lookup }</td>
			<td></td>
			<td align="center"></td>
			<td></td>
			</tr>
			</c:forEach>
		
		</table>
		</c:if>
		
		</c:if>
		
		<c:if test="${empty lookuplist && user.role== 'admin'}">
			<h3 align="center">���õ� ��¥�� �����Ͱ� �����ϴ�. �ٸ� ��¥�� ������ �ּ���</h3>
		</c:if>
		</c:if>
		
<c:if test="${user.role!= 'admin' }">
		<h3 align="center">�ڿ����� �α��ǰ��</h3>
		  <div class="slider">
		  	<c:forEach var="pro" items="${list}">
		    <div>
			
			<c:if test="${!empty pro.fileName }">
		    <img src="/images/uploadFiles/${pro.fileName}" width="40%"  align="left">
		    </c:if>
		    <c:if test="${empty pro.fileName }">
		    <img src="/images/uploadFiles/notimage.gif" width="40%"  align="left">
		    </c:if>
		  
		    <table width="40%" height="60%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				
				<td width="104" class="ct_write">
					��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">${pro.prodNo}</td>
							<td>	</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td width="104" class="ct_write">
					��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pro.prodName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">��ǰ������</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pro.prodDetail}</td>
			</tr>
		
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">��������</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="26">${pro.manuDate}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td width="104" class="ct_write">����</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pro.price}</td>
			</tr>
			
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			
			<tr>
				<td width="104" class="ct_write">�������</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${pro.regDate}</td>
			</tr>
		
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			</table>
   	 </div>
    </c:forEach>
    
 	 </div>

 </c:if> 
 
  </body>


</html>