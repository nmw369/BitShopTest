<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Summernote</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
</head>
<body>
<script type="text/javascript">

</script>




	<div id="summernote"><p>Hello Summernoteasdfasdasdf</p></div>
	<script>
// 	alert($("#sum").text())

// 	$($("#sum").text()).on("change", function (e) {
		
// 		alert("dd")
// 			var file = e.originalEvent.dataTransfer.files[0];
// 			console.log(file)
			
// 			var reader = new FileReader();

// 			reader.onload = function (event) {
// 				obj.text("");
// 				var img = new Image();
// 				img.src = event.target.result;
// 				var a = (img.src).split(',');
// 				console.log(img.src)
// 				console.log(a)
// 				}
// 			reader.readAsDataURL(file);// File에서 읽어 오는 역할
			
// 			return false;
		     
// 		     if(file.length < 1)
// 		          return;
// 		});
	
	
	
	
	
	
    $(document).ready(function() {
        $('#summernote').summernote({
        		height: 300,
        		callbacks: {
                   onImageUpload: function(files) {
                	   console.log(files)
                       sendFile(files[0]);
                   }
               }
    });
        
        function sendFile(file) {
        	 console.log(file)
        	 data2 = new FormData();
        	 data2.append("file", file);
        	 console.log(data2)
                $.ajax({
                    url: '/dogInfo/json/fileEncoding',
                    method: "POST",
                    enctype : 'multipart/form-data',
                    data : data2,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function(url) {
                    	console.log(url)
                        $('#summernote').summernote('insertImage', url);
                    }
                });
            }
    });
  </script>
</body>
</html>