<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
$(function(){
	$.ajax({
		url : 'https://www.googleapis.com/customsearch/v1?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8&cx=011598789325596039313:yaj05uya8oc&q=dog',
		method : "GET" ,
		dataType : "json",
		success : function (data) {
			console.log(data);			
		}
	});
});

</script>
</head>
<body>

</body>
</html>