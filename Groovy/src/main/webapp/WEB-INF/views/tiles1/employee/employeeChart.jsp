<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
    String ctxPath = request.getContextPath();
%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조직도</title>

<style type="text/css">

	.highcharts-figure,
.highcharts-data-table table {
  min-width: 320px;
  max-width: 800px;
  margin: 1em auto;
}

.highcharts-data-table table {
  font-family: Verdana, sans-serif;
  border-collapse: collapse;
  border: 1px solid #ebebeb;
  margin: 10px auto;
  text-align: center;
  width: 100%;
  max-width: 500px;
}

.highcharts-data-table caption {
  padding: 1em 0;
  font-size: 1.2em;
  color: #555;
}

.highcharts-data-table th {
  font-weight: 600;
  padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
  padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}

.highcharts-data-table tr:hover {
  background: #f1f7ff;
}
	
</style>

</head>
<body>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/networkgraph.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script type="text/javascript">
		
$(document).ready(function(){
	
	
	var name = $("input.name").toArray();
	var dept = $("input.dept").toArray();
	var spot = $("input.spot").toArray();
	var sum = $("input.sum").toArray();
	
	var chartArr = [];
	
	chartArr.push(['Groovy', '임원']);
	chartArr.push(['Groovy', '회계']);
	chartArr.push(['Groovy', '영업']);
	chartArr.push(['Groovy', '총무']);
	chartArr.push(['Groovy', '인사']);
	
	for (var i = 0; i < name.length; i++) {
		if($("input#dept"+i).val() == '회계' ) {
			chartArr.push([$("input#dept"+i).val(),$("input#sum"+i).val()]);
			chartArr.push([$("input#sum"+i).val(),$("input#name"+i).val()]);
		}
		if($("input#dept"+i).val() == '영업' ) {
			chartArr.push([$("input#dept"+i).val(),$("input#sum"+i).val()]);
			chartArr.push([$("input#sum"+i).val(),$("input#name"+i).val()]);
		}
		if($("input#dept"+i).val() == '총무' ) {
			chartArr.push([$("input#dept"+i).val(),$("input#sum"+i).val()]);
			chartArr.push([$("input#sum"+i).val(),$("input#name"+i).val()]);
		}
		if($("input#dept"+i).val() == '인사' ) {
			chartArr.push([$("input#dept"+i).val(),$("input#sum"+i).val()]);
			chartArr.push([$("input#sum"+i).val(),$("input#name"+i).val()]);
		}
		if($("input#dept"+i).val() == '임원' ) {
			chartArr.push([$("input#dept"+i).val(),$("input#sum"+i).val()]);
			chartArr.push([$("input#sum"+i).val(),$("input#name"+i).val()]);
		}
		
	}
	 
	
	
		Highcharts.addEvent(
		Highcharts.Series,
		'afterSetOptions',
		function (e) {
		 var colors = Highcharts.getOptions().colors,
		   i = 0,
		   nodes = {};
		
		 if (
		   this instanceof Highcharts.seriesTypes.networkgraph &&
		   e.options.id === 'lang-tree'
		 ) {
		   e.options.data.forEach(function (link) {
		
		     if (link[0] === 'Groovy') {
		       nodes['Groovy'] = {
		         id: 'Groovy',
		         marker: {
		           radius: 40
		         }
		       };
		       nodes[link[1]] = {
		         id: link[1],
		         marker: {
		           radius: 30
		         },
		         color: colors[i++]
		       };
		     } else if (nodes[link[0]] && nodes[link[0]].color) {
		       nodes[link[1]] = {
		         id: link[1],
		         color: nodes[link[0]].color,
		         marker: {
			           radius: 10
			         }
		       };
		     }
		   });
		
		   e.options.nodes = Object.keys(nodes).map(function (id) {
		     return nodes[id];
		   });
		 }
		}
		);
		
		Highcharts.chart('container', {
			chart: {
			 type: 'networkgraph',
			 height: '100%'
			},
			title: {
			 text: 'Groovy 조직도'
			},
			subtitle: {
			 text: ''
			},
			plotOptions: {
			 networkgraph: {
			   keys: ['from', 'to'],
			   layoutAlgorithm: {
			     enableSimulation: true,
			     friction: -0.9
			   }
			 }
			},
			series: [{
			 accessibility: {
			   enabled: false
			 },
			 dataLabels: {
			   enabled: true,
			   linkFormat: ''
			 },
			 id: 'lang-tree',
			 data: chartArr
			}]
		});

});		
</script>

<figure class="highcharts-figure">
  <div id="container"></div>
</figure>


<c:forEach var="empList" items="${requestScope.employeeList}" varStatus="i">
	<input type="hidden" class="name" id="name${i.index}" value="${empList.name }" />
	<input type="hidden" class="dept" id="dept${i.index}" value="${empList.deptnamekor }" />
	<input type="hidden" class="spot" id="spot${i.index}" value="${empList.spotnamekor }" />
	<input type="hidden" class="sum" id="sum${i.index}" value="[${empList.deptnamekor }]${empList.spotnamekor }" />
</c:forEach>

</body>
</html>


