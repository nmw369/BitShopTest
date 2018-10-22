<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>빠른 상담 통계</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

</script>

<style type="text/css">

</style>

</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />

	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/myPage_tit.png">
				</h1>
				<!-- end page title -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->
	
	
	<section class="wow fadeIn">
	<div class="container">
	<div class="row">
		
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/admin-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
			
			
			<!-- content -->
			<div class="col-md-10 col-sm-9 col-xs-12">
			
				<h1 align="center">빠른 상담</h1>
				
				<!-- search -->
				<div class="border-gray2 margin-two padding-two col-md-12 col-sm-10 col-xs-12">
				
					<div class="padding-two border-bottom col-md-11 col-xs-11 center-col text-center margin-two-bottom">
						<label class="text-small">이용자들의 <span class="magenta-text">빠른 상담</span>질문 통계입니다.</label>
					</div>
			        
		        </div>
		        <!-- end search -->
				<div style="width: 600px; height: 500px; margin-left: 200px">
					<canvas id="myChart" ></canvas>
				</div>
					<script>
					$.ajax({
						url : "/quick/json/getRateChatBot",
						method : "get",
						dataType : "json",
						success : function (data) {
							console.log(data)
							var insertData = new Array();
							var questionData = new Array();
							for (var i = 0; i < data.list.length; i++) {
								insertData.push(data.list[i].questionCount)
								questionData.push(data.list[i].question)
							}
							console.log(insertData)
							
							var ctx = document.getElementById("myChart");
							var myChart = new Chart(ctx, {
							    type: 'doughnut',
							    data: {
							        labels: questionData,
							        datasets: [{
							            label: '# of Votes',
							            data: insertData,
							            backgroundColor: [
							                'rgba(255, 99, 132, 0.2)',
							                'rgba(54, 162, 235, 0.2)',
							                'rgba(255, 206, 86, 0.2)',
							                'rgba(75, 192, 192, 0.2)',
							                'rgba(153, 102, 255, 0.2)',
							                'rgba(255, 159, 64, 0.2)'
							            ],
							            borderColor: [
							                'rgba(255,99,132,1)',
							                'rgba(54, 162, 235, 1)',
							                'rgba(255, 206, 86, 1)',
							                'rgba(75, 192, 192, 1)',
							                'rgba(153, 102, 255, 1)',
							                'rgba(255, 159, 64, 1)'
							            ],
							            borderWidth: 1
							        }]
							    },
							    options: {
							        layout: {
							            padding: {
							                left: 0,
							                right: 0,
							                top: 0,
							                bottom: 50
							            }
							        },
							    	legend : {
							    		position : 'right',
							    		labels: {
							    			boxWidth : 30,
							            }
							    	
							    	},
							        scales: {
							            yAxes: [{
							                ticks: {
							                    beginAtZero:true
							                }
							            }]
							        }
							    }
							});
							
							
							
						} //end success
					}) //end ajax
					
					
							
					</script>
			</div>
			<!--  end content -->
			
			</div>
		</div>
	</section>
	
 	
	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
 	
</body>

</html>