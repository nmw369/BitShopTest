<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Tooltip - Custom content</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  <style>
  .photo {
    width: 450px;
    text-align: center;
  }
  .photo .ui-widget-header {
    margin: 1em 0;
  }
  .guide {
    width: 500px;
    height: 500px;
  }
  .ui-tooltip {
    max-width: 500px;
  }
  </style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( document ).tooltip({
      items: "[data-geo]",
      content: function() {
        var element = $( this );
        if ( element.is( "[data-geo]" ) ) {
          var text = element.text();
          return "<img class='guide' alt='" + text +
            "' src='../images/fund/fundReq.png'>";
       }
     }
    });
  } );
  </script>
</head>
<body>
 
			<div align="center" style="display:inline;">
	       <h1 data-geo="" class="ui-widget photo">크라우드 펀딩 신청방법</h1>
	       <p>(마우스를 올려주세요)</p>
    		</div>
  
 
</body>
</html>