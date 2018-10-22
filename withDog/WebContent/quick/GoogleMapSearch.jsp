<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  
   <meta charset="utf-8">
    <title>Marker animations with <code>setTimeout()</code></title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
        align-left:100;

      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        
      } 
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #floating-panel {
        margin-left: -52px;
      }
      /* #move{
      width:100%;
      } */
    </style>
  </head>
  <body>
    <div id="floating-panel">
      <!-- <button id="drop" onclick="dropAnimal()"><h1>주변검색(1km)</h1></button> -->
      
    </div>
    
     <div id="map" ></div>
     
     <!-- <div >
       <button id="move" onclick="move()"><h1>안내시작</h1></button>
    </div> -->
     <div align="right">
     </div>
    <script>

      // If you're adding a number of markers, you may want to drop them on the map
      // consecutively rather than all at once. This example shows how to use
      // window.setTimeout() to space your markers' animation.
	  function move(){
    	  self.location.href="http://maps.google.com/maps";
      }
      
       
      
      var placelat = new Array();
      var placelng = new Array();
      
      var plname = new Array();
      var plplace = new Array();
      
      var plcontentString = new Array();
      
      ////////////////////////////////
      

      var markers = [];
      var map;
     
      /* 경로설정을 위한 현재위치 */
      var culat;
      var culng;
 
      var cnl ="${lat}";
      var cln ="${lng}";
      
      /* 주변검색 */
      var neighborhoods = new Array();
      var tempname;
      var tempplace;
      var tempList = new Array();
      
    /* 주변 마커 경로 */  
	var contentString = "Hi";
      
      var infowindow = [];
      var marker =[];
      var temp=0;
      var i=0;
      
      /* 경로받기 자원 */
      var dislng;
      var dislat;
      var arlng;
      var arlat;
      /* 여기까지 */
      
      function initMap() {
    	  
    	  directionsService = new google.maps.DirectionsService;
          directionsDisplay = new google.maps.DirectionsRenderer;
          
          console.log(cnl+":::"+cln)
          
    	  map = new google.maps.Map(document.getElementById('map'), {
              center: {lat: parseFloat(cnl), lng: parseFloat(cln)},
              zoom: 15
            });
          
            var infoWindow = new google.maps.InfoWindow({map: map});
            
                   
          
                var pos = {
                  lat: "${lat}",
                  lng: "${lng}",
                  type:"${type}"
                };
                
                culat="${lat}";
                culng="${lng}";
                                
                console.log("여기봐봐");
                console.log(pos);
                
                
                	$.ajax({
                		url : 'json/GoogleMapSearch',
                		method:'POST',
                		data:JSON.stringify({
                			place:pos
                		}),
                		dataType:"json",
                		async:false,
                		headers:{
                			'Accept' : 'application/json',
        					'Content-Type' : 'application/json'
                		},
                		success:function(location,status){
                			console.log(JSON.stringify(location.all))
                			console.log(JSON.stringify(location.all[0].placeinfo.name))
                			
                			for(var i=0; i<location.all.length; i++) {
                				placelat.push(Number(location.all[i].placeinfo.lat));
                				placelng.push(Number(location.all[i].placeinfo.lng));
                				
                				name1 = JSON.stringify(location.all[i].placeinfo.name);
                				plname.push(JSON.stringify(location.all[i].placeinfo.name));
                				plplace.push(JSON.stringify(location.all[i].placeinfo.place));
        				
                			}
                			console.log(placelat);
                			console.log(placelng);
                			console.log(plname);
                			console.log(plplace);
                			
                		}
                		
                	});
               var uluru = {lat:parseFloat("${lat}"),lng:parseFloat("${lng}")}
                /* infoWindow.setPosition(uluru); */
                /* infoWindow.setContent('현재위치.'); */
                map.setCenter(uluru);
            directionsDisplay.setMap(map);
                                    
             var marker = new google.maps.Marker({position: uluru, map: map});
             marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png')
             
             document.getElementById("mapStart").value ="yes";
             console.log($("#mapStart").val());
             dropAnimal(); 
             
      }
      
      
     /*  var k ="37.5172363,127.04732480000007";
      var m ="SeoulStation"; */
      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        directionsService.route({
          origin: culat+","+culng,
          destination: arlat+","+arlng,
          travelMode: 'TRANSIT'
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }
  
      function dropAnimal() {
        	console.log(placelat.length+":ㅋㅋㅋ")
        	
        	for(var i=0; i<placelat.length;i++){
            	
            	neighborhoods.push({lat:placelat[i],lng:placelng[i]});	
            	
            }
        	
        console.log(neighborhoods)
    	  clearMarkers();
       
        
        for (var i = 0; i < neighborhoods.length; i++) {
          addMarkerWithTimeout(neighborhoods[i], i * 200);
          console.log(neighborhoods[i])
        }
      }
      
                
      
      
      function addMarkerWithTimeout(position, timeout) {
    	
        window.setTimeout(function() {
          plcontentString[i] = plname[temp]+"<br/>"+plplace[temp]
      	  
        	temp+=1;
        	console.log(temp);
        	
          markers.push(marker[i]=new google.maps.Marker({
            position: position,
            map: map,
            animation: google.maps.Animation.DROP
          }),
          
          infowindow[i] = new google.maps.InfoWindow({
            content: plcontentString[i]
          }));
          marker[i].index=i;
          console.log(marker[i].index);
          
          marker[i].addListener('click', function() {
        	  
              console.log(this.index)
        	  infowindow[this.index].open(map, marker[this.index]);
              
              arlat=placelat[this.index];
              arlng=placelng[this.index];
              calculateAndDisplayRoute(directionsService, directionsDisplay);
             
              console.log("여기보세요!")
              console.log(culat+","+culng)
              console.log(arlat+","+arlng)
              
            });
          i+=1;
        }, timeout);
       
              
      }

      function clearMarkers() {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
        }
        markers = [];
      }
      
      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
          infoWindow.setPosition(pos);
          infoWindow.setContent(browserHasGeolocation ?
                                'Error: The Geolocation service failed.' :
                                'Error: Your browser doesn\'t support geolocation.');
        }
      
      
  
       /* function initMap() {
          var directionsService = new google.maps.DirectionsService;
          var directionsDisplay = new google.maps.DirectionsRenderer;
          var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 7,
            center: {lat: 41.85, lng: -87.65}
          });
          directionsDisplay.setMap(map);

          var onChangeHandler = function() {
            calculateAndDisplayRoute(directionsService, directionsDisplay);
          };
          document.getElementById('start').addEventListener('change', onChangeHandler);
          document.getElementById('end').addEventListener('change', onChangeHandler);
        } */

        
        
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyJUiL4ifUuucPRfc1SDXbO1kv-ci_CtE&callback=initMap">
    </script>
    
	<input type="hidden" id="mapStart" value="">
   <!--  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDtcSEcdHGiegaBuhxvS3eWzGJBmPgLCiY&callback=initMap">
    </script> -->
    
      
    
  </body>
</html>