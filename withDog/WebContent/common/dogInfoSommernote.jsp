<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>withdogSommer</title>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
    
  </head>
  <script>

	var content;

	$(function(){
		
	
		$("span:contains('애견상식등록')").on("click",function(){
			test();
			fncAddDogInfo();
		});
		
		$("span:contains('애견상식수정')").on("click",function(){
			test();
			fncUpdateDogInfo();
		});
		
		
		
		$('#summernote').summernote({
			height: 500,
			lang : 'ko-KR',
			
					
			callbacks: {
				onImageUpload: function(files, editor, welEditable) {
					 for (var i = files.length - 1; i >= 0; i--) {
						
						 console.log("아래확인");
						 console.log(files[i]);	
						 sendFile(files[i], this);
			            }
		        }
			}
			
		});
		
	});
	
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	console.log(form_data);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: '/common/json/imageUpload',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(url) {
        		console.log(JSON.stringify(url));
        		console.log(url.url);
          		$(el).summernote('editor.insertImage',url.url);
        	}
      	});
    }
		
  </script>
    
  <body>

    <div id="summernote">${dogInfo.dogInfoContent}</div>
    

    
  </body>
</html>