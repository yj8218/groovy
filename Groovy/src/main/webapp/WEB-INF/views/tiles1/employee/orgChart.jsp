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
<title>Insert title here</title>

<style type="text/css">

.highcharts-figure,
.highcharts-data-table table {
    min-width: 360px;
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

#container h4 {
    text-transform: none;
    font-size: 14px;
    font-weight: normal;
}

#container p {
    font-size: 13px;
    line-height: 16px;
}

@media screen and (max-width: 600px) {
    #container h4 {
        font-size: 2.3vw;
        line-height: 3vw;
    }

    #container p {
        font-size: 2.3vw;
        line-height: 3vw;
    }
}

</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/sankey.js"></script>
<script src="https://code.highcharts.com/modules/organization.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">

$(document).ready(function(){
 
	
	 $.ajax({
	       
	        type: "GET",
	        url: "<%= ctxPath%>/orgChart2.groovy",
	        dataType: "json",
	        success: function (json) {
	        	
	        	
	        	/* let resultArr = [];
				
				for(let i=0; i<json.length; i++){
					
					let obj;
					
					if(i==0){
						obj = {
					            name: json[i].department_name,
					            y: Number(json[i].percentage),
					            sliced: true,
					            selected: true
					          }
					}
					else{
						obj = {
					            name: json[i].department_name,
					            y: Number(json[i].percentage),
					          }
					}
					
					resultArr.push(obj);  // 배열 속에 객체를 넣기
					
				}//end of for----------- */
	        	
	        	
	        	
	        	
	        	
	        	
	        	Highcharts.chart('container', {
	        	    
	        		
	        		chart: {
	        	        height: 600,
	        	        inverted: true
	        	    },
	        	
	        	    title: {
	        	        text: 'Highcharts Org Chart'
	        	    },
	        	
	        	    accessibility: {
	        	        point: {
	        	            descriptionFormatter: function (point) {
	        	                var nodeName = point.toNode.name,
	        	                    nodeId = point.toNode.id,
	        	                    nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
	        	                    parentDesc = point.fromNode.id;
	        	                return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
	        	            }
	        	        }
	        	    },
	        	
	        	    series: [{
	        	        type: 'organization',
	        	        name: 'Highsoft',
	        	        keys: ['from', 'to'],
	        	        data: [['Groovy', '사장'],
	        		            ['사장', '임원'],
	        		            ['사장', '인사'],
	        		            ['사장', '총무'],
	        		            ['사장', '회계'],
	        		            ['사장', '영업']],
	        	        levels: [{
	        	            level: 0,
	        	            color: 'silver',
	        	            dataLabels: {
	        	                color: 'black'
	        	            },
	        	            height: 25
	        	        }, {
	        	            level: 1,
	        	            color: 'silver',
	        	            dataLabels: {
	        	                color: 'black'
	        	            },
	        	            height: 25
	        	        }, {
	        	            level: 2,
	        	            color: '#980104'
	        	        }, {
	        	            level: 4,
	        	            color: '#359154'
	        	        }],
	        	        nodes: jsonArr,
	        	        colorByPoint: false,
	        	        color: '#007ad0',
	        	        dataLabels: {
	        	            color: 'white'
	        	        },
	        	        borderColor: 'white',
	        	        nodeWidth: 65
	        	    }],
	        	    tooltip: {
	        	        outside: true
	        	    },
	        	    exporting: {
	        	        allowHTML: true,
	        	        sourceWidth: 800,
	        	        sourceHeight: 600
	        	    }
	        	    
	        	    
	        	});
	        },

	        error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	      }
	    });        
	
	


});//end of $(document).ready(function(){}) -----------

</script>


</head>
<body>


	
<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
        Organization charts are a common case of hierarchical network charts,
        where the parent/child relationships between nodes are visualized.
        Highcharts includes a dedicated organization chart type that streamlines
        the process of creating these types of visualizations.
    </p>
</figure>
	

</body>
</html>