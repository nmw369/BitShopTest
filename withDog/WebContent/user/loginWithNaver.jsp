<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		var userId = "n"+"${map.id}";
		var snsType = 1;
		checkUserId(userId,snsType);
	    function checkUserId(userId,snsType){
	    	
	    	var snsType =snsType*1;
	    	
	    	$.ajax({
					url : "/user/json/checkSnsUserId",
					method : "POST" ,
					dataType : "json",
					data: JSON.stringify({
						userId : userId,
						snsType : snsType
					}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					
					success : function(JSONData , status) {
						
						if(JSONData){
							$(opener.parent.document.location).attr("href","/common/mainPage");
						}else{
							$(opener.parent.document.location).attr("href","/user/addSnsUser");
						}
						window.close();
					}
				});//end of ajax
				
	    }//end function checkUserId() 
		
	   
	});
	
</script>

</head>
<form>
<body>
<input type="hidden" name="birthday" value="${map.birthday}"><br/>
<input type="hidden" name="gender" value="${map.gender}"><br/>
<input type="hidden" name="userName" value="${map.name}"><br/>
<input type="hidden" name="userId2" value="na@${map.id}"><br/>
<input type="hidden" name="age" value="${map.age}"><br/>
<input type="hidden" name="email" value="${map.email}"><br/>
<input type="hidden" name="type" value="na"><br/>
</body>
</form>
</html>