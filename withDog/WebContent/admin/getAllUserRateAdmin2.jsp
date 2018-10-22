<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<script src= "https://cdn.zingchart.com/zingchart.min.js"></script>
		<script> zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
		ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9","ee6b7db5b51705a13dc2339db3edaf6d"];</script>
	
	<style type="text/css">
	@import 'https://fonts.googleapis.com/css?family=Montserrat';
	@import 'https://fonts.googleapis.com/css?family=Lato:400';
	 
	#myChart a {
	  display: none;
	}
	 
	.zc-ref {
	  display: none;
	}
	</style>
		
	</head>
	<body>
	  <section>
		  <div id='myChart'><a class="zc-ref" href="https://www.zingchart.com/">Powered by ZingChart</a></div>
		</section>
	</body>

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
					var userCon2=JSONData.key[2].percent*1;
					
			
				
					
				  //차트
					var myConfig = {
							backgroundColor:'#FBFCFE',
							 	type: "ring",
							 	title: {
							 	  text: "Monthly Page Views",
							 	  fontFamily: 'Lato',
							 	  fontSize: 14,
							 	  // border: "1px solid black",
							 	  padding: "15",
							 	  fontColor : "#1E5D9E",
							 	},
							 	subtitle: {
							 	  text: "today",
							 	  fontFamily: 'Lato',
							 	  fontSize: 12,
							 	  fontColor: "#777",
							 	  padding: "5"
							 	},
							 	plot: {
							 	  slice:'50%',
							 	  borderWidth:0,
							 	  backgroundColor:'#FBFCFE',
							 	  animation:{
							 	    effect:2,
							 	    sequence:3
							 	  },
							 	  valueBox: [
							 	    {
							 	      type: 'all',
							 	      text: '%t',
							 	      placement: 'out'
							 	    }, 
							 	    {
							 	      type: 'all',
							 	      text: '%npv%',
							 	      placement: 'in'
							 	    }
							 	  ]
							 	},
							  tooltip:{
							 	    fontSize:16,
							 	    anchor:'c',
							 	    x:'50%',
							 	    y:'50%',
							 	    sticky:true,
							 	    backgroundColor:'none',
							 	    borderWidth:0,
							 	    thousandsSeparator:',',
							 	    text:'<span style="color:%color">Page Url: %t</span><br><span style="color:%color">Pageviews: %v</span>',
							      mediaRules:[
							        {
							            maxWidth:500,
							       	    y:'54%',
							        }
							      ]
							  },
							 	plotarea: {
							 	  backgroundColor: 'transparent',
							 	  borderWidth: 0,
							 	  borderRadius: "0 0 0 10",
							 	  margin: "70 0 10 0"
							 	},
							 	legend : {
							    toggleAction:'remove',
							    backgroundColor:'#FBFCFE',
							    borderWidth:0,
							    adjustLayout:true,
							    align:'center',
							    verticalAlign:'bottom',
							    marker: {
							        type:'circle',
							        cursor:'pointer',
							        borderWidth:0,
							        size:5
							    },
							    item: {
							        fontColor: "#777",
							        cursor:'pointer',
							        offsetX:-6,
							        fontSize:12
							    },
							    mediaRules:[
							        {
							            maxWidth:500,
							            visible:false
							        }
							    ]
							 	},
							 	scaleR:{
							 	  refAngle:270
							 	},
								series : [
									{
									  text: "정상회원",
										values : userCon1,
										lineColor: "60a69f",
										backgroundColor: "60a69f",
										lineWidth: 1,
										marker: {
										  backgroundColor: '60a69f'
										}
									},
									{
									  text: "Gallery",
										values : [56711],
										lineColor: "#E80C60",
										backgroundColor: "#E80C60",
										lineWidth: 1,
										marker: {
										  backgroundColor: '#E80C60'
										}
									},
									{
									  text: "휴면회원",
										values : [userCon2],
										lineColor: "#9B26AF",
										backgroundColor: "#9B26AF",
										lineWidth: 1,
										marker: {
										  backgroundColor: '#9B26AF'
										}
									}
								]
							};
							 
							zingchart.render({ 
								id : 'myChart', 
							  data: {
							    gui:{
							      contextMenu:{
							        button:{
							          visible: true,
							          lineColor: "#2D66A4",
							          backgroundColor: "#2D66A4"
							        },
							        gear: {
							          alpha: 1,
							          backgroundColor: "#2D66A4"
							        },
							        position: "right",
							        backgroundColor:"#306EAA", /*sets background for entire contextMenu*/
							        docked: true, 
							        item:{
							          backgroundColor:"#306EAA",
							          borderColor:"#306EAA",
							          borderWidth: 0,
							          fontFamily: "Lato",
							          color:"#fff"
							        }
							      
							      },
							    },
							    graphset: [myConfig]
							  },
								height: '499', 
								width: '99%' 
							});

					
					
				} 
			});//end ajax
		

		
	}); //제이쿼리 끝
	
</script>
</html>