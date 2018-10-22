<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DevExtreme Demo</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    
<script>window.jQuery || document.write(decodeURIComponent('%3Cscript src="js/jquery.min.js"%3E%3C/script%3E'))</script>
    <link rel="stylesheet" type="text/css" href="/css/chart/dx.spa.css" />
    <link rel="stylesheet" type="text/css" href="/css/chart/dx.common.css" />
    <link rel="dx-theme" data-theme="generic.light" href="/css/chart/dx.light.css" />
    <script src="/js/chart/dx.all.js"></script>   
    
    <!-- 원래자리 -->
<style type="text/css">
#chart {
    height: 440px;
}

</style>
<script type="text/javascript">

$(function(){
	
	$.ajax({
		
		url : "/user/json/getCountUserCon",
		method : "get",
		dataType : "json",
		success : function(JSONData , status){
	
			//dataSource = JSONData.key.percent;
			var today= JSONData.key[0].state;
			var check1=JSONData.key[1].state;
			var check2=JSONData.key[2].state;
			var check3=JSONData.key[3].state;
			var check4=JSONData.key[4].state;
			
			var todayUserConZero= JSONData.key[0].zero;
			var check1UserConZero=JSONData.key[1].zero;
			var check2UserConZero=JSONData.key[2].zero;
			var check3UserConZero=JSONData.key[3].zero;
			var check4UserConZero=JSONData.key[4].zero;
			
			var todayUserConOne= JSONData.key[0].one;
			var check1UserConOne=JSONData.key[1].one;
			var check2UserConOne=JSONData.key[2].one;
			var check3UserConOne=JSONData.key[3].one;
			var check4UserConOne=JSONData.key[4].one;
			
			var todayUserConTwo= JSONData.key[0].two;
			var check1UserConTwo=JSONData.key[1].two;
			var check2UserConTwo=JSONData.key[2].two;
			var check3UserConTwo=JSONData.key[3].two;
			var check4UserConTwo=JSONData.key[4].two;
			
	
				var dataSource = [{
				    state: check4,
				    0: check4UserConZero,
				    2: check4UserConTwo,
				    1: check4UserConOne
				}, {
				    state: check3,
				    0: check3UserConZero,
				    2: check3UserConTwo,
				    1: check3UserConOne
				}, {
				    state: check2,
				    0: check2UserConZero,
				    2: check2UserConTwo,
				    1: check2UserConOne
				}, {
				    state: check1,
				    0: check1UserConZero,
				    2: check1UserConTwo,
				    1: check1UserConOne
				}, {
				    state: today,
				    0: todayUserConZero,
				    2: todayUserConTwo,
				    1: todayUserConOne
				}];
	
	
	
	
		    $("#chart").dxChart({
		        dataSource: dataSource,
		        commonSeriesSettings: {
		            argumentField: "state",
		            type: "bar",
		            hoverMode: "allArgumentPoints",
		            selectionMode: "allArgumentPoints",
		            label: {
		                visible: true,
		                format: {
		                    type: "fixedPoint",
		                    precision: 0
		                }
		            }
		        },
		        series: [
		            { valueField: "1", name: "가입" },
		            { valueField: "2", name: "탈퇴" },
		            { valueField: "0", name: "휴면" }
		        ],
		     
		        legend: {
		            verticalAlignment: "bottom",
		            horizontalAlignment: "center"
		        },
		        "export": {
		            enabled: true
		        },
		        onPointClick: function (e) {
		            e.target.select();
		        }
		    });
		    
		}    
	
	});//end ajax   	    
})



</script>

</head>
<body class="dx-viewport">
    <div class="demo-container">
        <div id="chart"></div>
    </div>
</body>
</html>