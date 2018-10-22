<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
  <head>
  <meta name="viewport"	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script type="text/javascript" src="../js/bootstrap.js"></script>
  <link rel="stylesheet" href="../css/bootstrap.css" />
   <meta charset="utf-8">
    <title>Marker animations with <code>setTimeout()</code></title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
     #map {
        height: 100%;
        align-left:100;
        /* left: 100%; */

      }
      #list{
      	height: 70%;
        align-left:100;
        /* right: 75%; */
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 112%;
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
    
    <script>
	
	    $(function(){
		    var filter = "win16|win32|win64|mac|macintel";
			if( navigator.platform  ){
			
				if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
			
					console.log("����� ��⿡�� ����");
					
					$("#top").append("<img alt=\"\" src=\"../images/quick/title.png\" width=\"100%\" height=\"40px\">");
					
					$("#place").append("<p class=\"bg-info\" align=\"center\">�� &nbsp;&nbsp;&nbsp;&nbsp; �� &nbsp;&nbsp;&nbsp;&nbsp; �� &nbsp;&nbsp;&nbsp;&nbsp; ��</p>");
					$("#place").append("<a href=\"javascript:dropAnimal('veterinary_care');\"><img alt=\"\" src=\"../images/quick/dogicon.png\" width=\"65\" height=\"75\"></a>&nbsp;");
					$("#place").append("<a href=\"javascript:dropAnimal('park');\"><img alt=\"\" src=\"../images/quick/park.png\" width=\"65\" height=\"75\"></a>&nbsp;");
					$("#place").append("<a href=\"javascript:dropAnimal('convenience_store');\"><img alt=\"\" src=\"../images/quick/pun.png\" width=\"60\" height=\"75\"></a>&nbsp;");
					$("#place").append("<a href=\"javascript:dropAnimal('restaurant');\"><img alt=\"\" src=\"../images/quick/ret.png\" width=\"65\" height=\"75\"></a>&nbsp;");
					$("#place").append("<a href=\"javascript:dropAnimal('subway_station');\"><img alt=\"\" src=\"../images/quick/sub.png\" width=\"65\" height=\"75\"></a>");
					
										
				}else{
			
					console.log("PC���� ����");
					
					$("#top").append("<img alt=\"\" src=\"../images/quick/title.png\" width=\"100%\" height=\"100px\">");
					
					$("#place").append("<p class=\"bg-info\">�� �� �� ��</p>");
					$("#place").append("<a href=\"javascript:dropAnimal('veterinary_care');\"><img alt=\"\" src=\"../images/quick/dogicon.png\" width=\"90\" height=\"100\"></a><hr/>");
					$("#place").append("<a href=\"javascript:dropAnimal('park');\"><img alt=\"\" src=\"../images/quick/park.png\" width=\"90\" height=\"100\"></a><hr/>");
					$("#place").append("<a href=\"javascript:dropAnimal('convenience_store');\"><img alt=\"\" src=\"../images/quick/pun.png\" width=\"90\" height=\"100\"></a><hr/>");
					$("#place").append("<a href=\"javascript:dropAnimal('restaurant');\"><img alt=\"\" src=\"../images/quick/ret.png\" width=\"90\" height=\"100\"></a><hr/>");
					$("#place").append("<a href=\"javascript:dropAnimal('subway_station');\"><img alt=\"\" src=\"../images/quick/sub.png\" width=\"90\" height=\"100\"></a><hr/>");
		 
				}
			
			}
	    });
	</script>
  </head>
  		<div align="center" id="top">
  		<!-- <button type="button" class="btn btn-primary btn-lg btn-block">�� �� �� ��</button> -->
  		<!-- <img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Golden_Retriever_Carlos_%2810581910556%29.jpg/1200px-Golden_Retriever_Carlos_%2810581910556%29.jpg"> -->
  		</div>
		<div class="container2" id="list">
		
		<div id="map" class="col-md-10 col-sm-10"></div>
		
			<div class="col-md-2 col-sm-2">
				<div class="row" align="center" id="place">
																				
				</div>
			</div>
			
			
		</div>
		<div id="mv">
			
	   	</div>
	   	
	   	<!-- ���â -->
	   	<script type="text/javascript" src="../js/jquery.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.js"></script>
		<link rel="stylesheet" href="../css/bootstrap.css" />
				
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">��</span></button>
		        <h1 class="modal-title bg-primary" id="myModalLabel" align="center">����������</h1>
		      </div>
		      <div class="modal-body" id="timg">
		        
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
	   	
	   	<!-- ��޳� -->
	   	
		                
	    
	
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
      
      
      
      ////////////////////////////////
      

      var markers = [];
      var map;
     
      /* ��μ����� ���� ������ġ */
      var culat;
      var culng;
 
      
      function initMap() {
    	  directionsService = new google.maps.DirectionsService;
          directionsDisplay = new google.maps.DirectionsRenderer;
    	  map = new google.maps.Map(document.getElementById('map'), {
              center: {lat: -34.397, lng: 150.644},
              zoom: 15
            });
            var infoWindow = new google.maps.InfoWindow({map: map});
		
            // Try HTML5 geolocation.
            if (navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
                };
                
                culat=position.coords.latitude;
                culng=position.coords.longitude;
                
                console.log("aaaa");
                console.log(pos);
                console.log(culat);
                console.log(culng);
                
                	
                /* infoWindow.setPosition(pos);
                infoWindow.setContent('������ġ.'); */
                var uluru = {lat:parseFloat(culat),lng:parseFloat(culng)}
                var marker = new google.maps.Marker({position: uluru, map: map});
                marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png')
                
                map.setCenter(pos);
              }, function() {
                handleLocationError(true, infoWindow, map.getCenter());
              });
            } else {
              // Browser doesn't support Geolocation
              handleLocationError(false, infoWindow, map.getCenter());
            }
            directionsDisplay.setMap(map);
           
      }
      
      
     
        
      var neighborhoods = new Array();
      var tempname;
      var tempplace;
      var tempList = new Array();
      
     var templat = new Array();
     var templng = new Array();
     
      
       
       
      function dropAnimal(type) {
        	console.log(placelat.length+":������")
        	var near = {
                  lat: parseFloat(culat),
                  lng: parseFloat(culng),
                  type: type
                };
        	console.log(near)
        	
        	$.ajax({
                		url : '/quick/json/GoogleMapSearch',
                		method:'POST',
                		data:JSON.stringify({
                			place:near
                		}),
                		dataType:"json",
                		async:false,
                		headers:{
                			'Accept' : 'application/json',
        					'Content-Type' : 'application/json'
                		},
                		success:function(location,status){
                			console.log("location")
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
        	
        	
        	for(var i=0; i<placelat.length;i++){
            	
            	neighborhoods.push({lat:placelat[i],lng:placelng[i]});	
            	
            }
        console.log("neighborhoods")
        console.log(neighborhoods)
    	  clearMarkers();
       
        
        for (var i = 0; i < neighborhoods.length; i++) {
          addMarkerWithTimeout(neighborhoods[i], i * 200);
          console.log(neighborhoods[i])
        }
        
        for (var i = 0; i < placelat.length; i++) {
            templat.push(placelat[i])
            templng.push(placelng[i])
            
          }
                
        
        placelat = new Array;
    	placelng = new Array;
      	neighborhoods = new Array; 
        
      }
      
      var distance;
      var time;
      var end_address;
      var steps = new Array();
      
      
      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
          directionsService.route({
            origin: culat+","+culng,
            destination: arlat+","+arlng,
            travelMode: 'TRANSIT'
          }, function(response, status) {
          	console.log("�뼱ǥ��")
          	console.log(response)
          	console.log(response.routes[0].legs[0].distance.value)
          	
          	distance=response.routes[0].legs[0].distance.value;
          	time=response.routes[0].legs[0].duration.text;
          	end_address=response.routes[0].legs[0].end_address;
          	steps=response.routes[0].legs[0].steps;
          	
          	modalinfo(distance,time,end_address,steps);
          	
            if (status === 'OK') {
              directionsDisplay.setDirections(response);
            } else {
              window.alert('Directions request failed due to ' + status);
            }
          });
        }
      
      
      
      var plcontentString = new Array();
      
      
      
      var infowindow = [];
      var marker =[];
      var temp=0;
      var i=0;
      
      /* ��ιޱ� �ڿ� */
      var dislng;
      var dislat;
      var arlng;
      var arlat;
      /* ������� */
      var tempName = new Array();
      var tempaddress = new Array();
      var tempimg = new Array();
      var tem1;
      var tem2;
       /* ��ũ�ݱ� */
      
      
       function addMarkerWithTimeout(position, timeout) {
    	
        window.setTimeout(function() {
          plcontentString[i] = plname[temp]+"<br/>"+plplace[temp];
      	  tempName[i]= plname[temp];       
      	  tempaddress[i]= plplace[temp];         
          
        	temp+=1;
             console.log("�������̸�")
        	console.log(tempName);
            console.log(tempaddress);
        	
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
        	  
        	  
        	  
        	  for(var i=0;i<templat.length;i++){
        	  infowindow[i].close();      	  
        	  }
        	  console.log("���� Index")
        	  console.log(this.index)
        	  infowindow[this.index].open(map, marker[this.index]);
              
              arlat=templat[this.index];
              arlng=templng[this.index];
              
              
              
              calculateAndDisplayRoute(directionsService, directionsDisplay);
             
              /* console.log("���⺸����!")
              console.log(tempName[this.index])
              console.log(tempaddress[this.index])
              console.log(arlat+","+arlng) */
              tem1 = tempName[this.index];
              tem2 = tempaddress[this.index];
              console.log("���⺸����!")
              console.log(tem1+":::"+tem2);
              
              
              $.ajax(
						{
							url : "https://translation.googleapis.com/language/translate/v2?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8",
							method : "POST",
							dataType : "json",
							
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify(
									{
										'q' : tem1,
										'source': 'en',
										  'target': 'ko',
										  'format': 'text'
									}
							),
							success : function(data,status) {
								console.log("���۹���")																
								tem1 = data.data.translations[0].translatedText;
								console.log(tem1)
							},//end success function
							fail : function (error) {
								
								alert(error)
							}
						});
              
            /*   $.ajax(
						{
							url : "https://translation.googleapis.com/language/translate/v2?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8",
							method : "POST",
							dataType : "json",
							async: false,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify(
									{
										'q' : tem2,
										'source': 'en',
										  'target': 'ko',
										  'format': 'text'
									}
							),
							success : function(data,status) {
																								
								tem2 = data.data.translations[0].translatedText;
								console.log(tem2)
							},//end success function
							fail : function (error) {
								
								alert(error)
							}
						}); */

              
              /* modalinfo(tem1,tem2); */
              
             /*  $.ajax({
						url : 'https://www.googleapis.com/customsearch/v1?key=AIzaSyDY67FTw3lBX8Xc3oIFei_nXw4vsTS6ib8&cx=011598789325596039313:yaj05uya8oc&q='+tem1,
						method : "GET" ,
						dataType : "json",
						success : function (data) {
							modalinfo(data.items[0].pagemap.cse_image[0].src,tem1,tem2);
						}
              }); *//* ajax End */
              
            });
          
          i+=1;
          
        }, timeout);
       
              
      }
      
      function modalinfo(distance,time,end,steps){
    	   
    	  /* console.log("�������")
    	   console.log(name)
    	  console.log(address) */
    	  
    	  $("#timg").empty();
    	  
    	  $("#timg").append("<h1 >������:"+tem1+"</h1>");
    	  $("#timg").append("<h4 >�Ÿ�: "+distance+"M "+"���������ð�: "+time+"</h4>");
    	  $("#timg").append("<h4 >�������ּ�: "+end+"</h4><hr/>");
    	  for(var i=0;i<steps.length;i++){
    		  $("#timg").append("<p class=\"bg-primary\" align=\"center\">�߰���� "+(i+1)+" </p>");
    		  $("#timg").append("<h4 >������:"+steps[i].instructions+"</h4>");
    		  $("#timg").append("<h4 >�Ÿ�: "+steps[i].distance.value+"m , ����ҿ�ð�:"+steps[i].duration.text+"</h4>");
    		}
    	  
    	     	  	  
    	  /* ���â���� �ڵ� */
    	  $("#myModal").modal('show');
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
      
        
        
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyJUiL4ifUuucPRfc1SDXbO1kv-ci_CtE&callback=initMap">
    </script>
        
    
  </body>
</html>