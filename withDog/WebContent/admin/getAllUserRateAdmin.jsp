<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>회원전체통계</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
   
<script>window.jQuery || document.write(decodeURIComponent('%3Cscript src="js/jquery.min.js"%3E%3C/script%3E'))</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/event.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/supplemental.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/unresolved.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/message.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/number.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/currency.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/date.min.js"></script>
    
    <!-- 
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/18.1.4/css/dx.spa.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/18.1.4/css/dx.common.css" />
    <link rel="dx-theme" data-theme="generic.light" href="https://cdn3.devexpress.com/jslib/18.1.4/css/dx.light.css" />
    <script src="https://cdn3.devexpress.com/jslib/18.1.4/js/dx.all.js"></script> -->
	
	<link rel="stylesheet" type="text/css" href="/css/chart/dx.spa.css" />
    <link rel="stylesheet" type="text/css" href="/css/chart/dx.common.css" />
    <link rel="dx-theme" data-theme="generic.light" href="/css/chart/dx.light.css" />
    <script src="/js/chart/dx.all.js"></script>
	<style type="text/css">
	#pie {
    height: 540px;
	}
	</style>
	
	<script type="text/javascript">
	$(function() {
		
		
		
		

		//회원전체통계 가져오기
		$.ajax({
			
				url : "/user/json/getRateUserCon",
				method : "get",
				dataType : "json",
				success : function(JSONData , status){
			
					//dataSource = JSONData.key.percent;
					var userCon0= JSONData.key[0].percent;
					var userCon1=JSONData.key[1].percent;
					var userCon2=JSONData.key[2].percent;
					
					var dataSource =	[{
						
					    language: "정상회원",
					    percent: userCon1
					}, {
					    language: "휴면회원",
					    percent: userCon0
					}, {
					    language: "탈퇴회원",
					    percent: userCon2
					}];
				
				    $("#pie").dxPieChart({
				        type: "doughnut",
				        palette: "Soft Pastel",
				        title: "전체 회원 계정상태 통계",
				        dataSource: dataSource,
				        legend: {
				            horizontalAlignment: "center",
				            verticalAlignment: "bottom"
				        },
				        "export": {
				            enabled: true
				        },
				        series: [{
				            smallValuesGrouping: {
				                mode: "topN",
				                topCount: 3
				            },        
				            argumentField: "language",
				            valueField: "percent",
				            label: {
				                visible: true,
				                format: "fixedPoint",
				                customizeText: function (point) {
				                    return point.argumentText + ": " + point.valueText + "%";
				                },
				                connector: {
				                    visible: true,
				                    width: 1
				                }
				            }
				        }]
				});

					
					
				}
			});//end ajax
		

		
	}); //제이쿼리 끝
	
	
	</script>
</head>
<body class="dx-viewport"> 
    <div class="demo-container">
        <div id="pie"></div>
    </div>

</body> 
</html>