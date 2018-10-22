<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
  <head>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
   var address = encodeURIComponent('${careAddr}');
  /* var address = encodeURIComponent('강남역'); */
  
  $.ajax({
	  
		url : 'http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address='+address,
		method:'GET',
		headers:{
			'Accept' : 'application/json',
			'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
		},
		success:function(location,status){
			console.log(location)
			console.log(location.results[0].geometry.location)
			console.log(location.results[0].geometry.location.lat)
			console.log(location.results[0].geometry.location.lng)
			
			self.location.href="/quick/GeoMap?lat="+location.results[0].geometry.location.lat+"&lng="+location.results[0].geometry.location.lng;		
		}
	});
  </script>
  </head>
<body>

  </body>
</html>