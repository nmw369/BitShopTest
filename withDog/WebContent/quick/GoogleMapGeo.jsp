<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!DOCTYPE html>
<html>
  <head>
    <style>
       /* Set the size of the div element that contains the map */
               
      #map {
        height: 100%;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
       }
        html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        
      }
    </style>
  </head>
  <body>
  	
  	   
  	
        <!--The div element for the map -->
    <div id="map"></div>
    <script>
// Initialize and add the map
function initMap() {
  // The location of Uluru
  var uluru = {lat: parseFloat("${lat}"), lng: parseFloat("${lng}")};
  // The map, centered at Uluru
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 19, center: uluru});
  // The marker, positioned at Uluru
  var marker = new google.maps.Marker({position: uluru, map: map});
  marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png')
}
    </script>
    <!--Load the API from the specified URL
    * The async attribute allows the browser to render the page while the API loads
    * The key parameter will contain your own API key (which is not needed for this tutorial)
    * The callback parameter executes the initMap() function
    -->
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyJUiL4ifUuucPRfc1SDXbO1kv-ci_CtE&callback=initMap">
    </script>
  </body>
</html>