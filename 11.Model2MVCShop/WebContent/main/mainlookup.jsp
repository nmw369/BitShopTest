<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>

<html>
<head>
<!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script type="text/javascript">
<!--
function day(){
	//Form ��ȿ�� ����
 	
	var manuDate = document.detailForm.lookupday.value;
	
}
function lookuplist(){
	document.detailForm.submit();
}
-->
</script>
</head>
<body>
<form name="detailForm" method="post">
<h3 align="center">��ȸ�� ��¥�� �����ϼ���.</h3>
	<p align="center"><input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
				style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
		&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
		onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
	</p>
<p align="center"><input type="button" value="Ȯ��" onclick="location.href='/mainView.do?start=yes'"></p>
    </form>
   </body>
</html>