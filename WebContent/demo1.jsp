<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Map"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import=" com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.Document"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="java.util.Iterator"%>
<%@page import=" com.mongodb.client.FindIterable"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import=" java.text.ParseException"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@page import=" java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script src=" https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.min.js"></script>
  
 <script src="graph.js"></script>
  
   <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.min.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.min.js" type="text/javascript"></script> 
  
</head>
<body>

<%

MongoClient client = new MongoClient("localhost", 27017);
MongoDatabase amararaja = client.getDatabase("AmaraRaja");
MongoCollection<Document> freqColl = amararaja.getCollection("predict_frequency");

FindIterable<Document> search = freqColl.find();
Iterator<Document> Iter = search.iterator(); 
HashSet<String> locClass = new HashSet<String>();
while(Iter.hasNext()){
	
 	Document doc = Iter.next();
	String temp = doc.getString("FunctionalLocation").trim();
	//String temp1 = doc.getString("Class").trim();
	//System.out.println(temp);
	locClass.add(temp); 	
	
}



%>

<nav class="navbar navbar-default">
  <div class="container-fluid">
     <div  >
<a href="index.html"><img src="img/exflogo.png" class="pull-left"></a>
</div>
    <ul class="nav navbar-nav">
    
      <li><a href="#"></a><h1 style="margin-left: 110px" ><b>Problems Occurrence Prediction Report</b></h1></li>
    </ul>
      <div  style="margin-top: -20px;
    margin-left: 900px;">
<a href="index.html"><img src="img/download.png" class="pull-right"></a>
</div>
  </div>

</nav>

<!--   <div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Dropdown Example
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">HTML</a></li>
      <li><a href="#">CSS</a></li>
      <li><a href="#">JavaScript</a></li>
    </ul>
  </div> -->
   <label style="margin-top: 5px;margin-left: 80px">Location:</label>
  			<select class="btn btn-primary dropdown-toggle" data-toggle="dropdown" data-style="btn-primary"
							style="color: white margin-left:4%; overflow: scroll; id="wed_ts"
							onchange="ntwkinit()">
							<option id="value1" value="--Select--">--Select Location--
							<%
							for(String lc : locClass){
							%>
							<option id="wed_ts" ><%out.print(lc);%>
							<%} %>
					<!-- 		<option id="wed_ts" value="IBD2-ASS-ASM-LN1-ENVS001">IBD2-ASS-ASM-LN1-ENVS001
							<option id="wed_ts" value="IBD2-ASS-ASM-LN1-NPMC001">IBD2-ASS-ASM-LN1-NPMC001 -->
							
						</select> 
<!-- 						  <div class="ccms_form_element cfdiv_custom" id="style_container_div" style="float:left">
<label  style="margin-top: 5px;margin-left: 80px">   Select the  Division:  </label>
<select size="1" id="wed_ts" class=" validate['required'] btn btn-primary" title="" type="select" name="style" >
<option value="">   -- All Divisions --</option>

</select><div class="clear"> </div><div id="error-message-style"></div></div> -->

 <label>Class:</label>
  			<select class="btn btn-primary dropdown-toggle" data-toggle="dropdown" data-style="btn-primary" align="center"
							style="color: white margin-left:4%; overflow: scroll" id="Thu"
							onchange="ntwki()">
							<option id="" value="--Select--">--Select Class--
			<!-- 				<option id="wed_t" value="temperature problem">temperature problem
							<option id="wed_t" value="temperature variation">temperature variation
							<option id="wed_t" value="number punching problem">number punching problem -->
							
						</select>
						<button class="btn btn-primary" id="submit">Show Graph</button>
						<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Metrics</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="margin-top:80px">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Fitness Graph</h4>
        </div>
        <div class="modal-body " style="height: 400px">
          				<span><div id="graph_valuesModel" style="visibility: hidden;"></div></span>
						<span><div id="graph_datesModel" style="visibility: hidden;"></div></span>
						<span><div id="graph_val2Model" style="visibility: hidden;"></div></span>

						<br>
						<br>
				
						<div id="graph_divModel"
							style="margin-left: 13%; position: absolute; width: 1000px; height: 350px">
							<canvas id="pred_graphModel" width="150" height="150"></canvas>
						</div>
        </div>
        </div>
    </div>
  </div>
						
				
						
						
		<script>
		


		var locat;
		var clas;

		function ntwkinit() {

			   locat=$(":selected").val();
			   console.log("phone:::"+locat);
			   
		  	 
		  	 $.ajax({
		  			url: "Resour",
		  			type: "POST",
		  			data: {locat:locat},
		   	 
		  	 success : function(responseText) {
						
					//	console.log(responseText);
						var s1 = responseText;
						$("#Thu").html(s1);
			
		  	 } 
		  		});
			}
		function ntwki() {


		$("#graph_divModel").html('');

			   clas=$("#Thu :selected").val();
			  console.log("clas:::"+clas);
			  
			
			}

		//submit script
		$(document).on("click", "#submit", function(){
			 
			$.get("view1.jsp",{typelocation:locat,typeclass:clas},graph_res)
		}); 


		function graph_res(response)
		{
			console.log("wait:::"+ response);
			 if(response)
				 {
				 $("#load").hide();
				 response=response.trim();
				 
				  
				 $("#p").text(response);
				 
				  $("#graph_valuesModel").empty();
			var resp = response.split("@");
			document.getElementById("graph_valuesModel").innerHTML="";document.getElementById("graph_datesModel").innerHTML="";
			document.getElementById("graph_valuesModel").innerHTML=resp[0];//$("#graph_valuesModel").append(response);
			      document.getElementById("graph_datesModel").innerHTML=resp[1];//$("#graph_valuesModel").append(response);
			      document.getElementById("graph_val2Model").innerHTML=resp[2];
			    		      
			      chartjs_graph();
				 }
		}

		var yvalue_length=0;
		function chartjs_graph()
		{
			var values=document.getElementById('graph_valuesModel').innerHTML;
			var values1=document.getElementById('graph_datesModel').innerHTML;
			var values2 = document.getElementById('graph_val2Model').innerHTML;
			//var values2=document.getElementById('demo').innerHTML;
		 
			$("#graph_valuesModel").empty();$("#graph_datesModel").empty();$("#graph_val2Model").empty();
			
			$("#pred_graphModel").remove(); 
			$('#graph_divModel').html('');
			$('#graph_divModel').append('<canvas  id="pred_graphModel" width=950 height=500></canvas>');
			var context=$("#pred_graphModel");
			
			 var xval=new Array();
				values1=values1.trim();
				xval=values1.split(",");
				xval = xval.slice(0,-3);
				
			 	var xx = xval.slice(-3);
				var yval=new Array();
				values=values.trim();
				yval=values.split(",");
				yval = yval.slice(0,-3);
				
				yvalue_length=yval.length;
				yvalue_length=yvalue_length-1;
				
				
				var zval=new Array();
				values2=values2.trim();
				zval=values2.split(",");
				zval=zval.slice(0,-3);
			/* 	 
				for(i=0;i<yval.length;i++)
					yval[i]=parseInt(yval[i]); */
				
		/* 	   var leng = yval.length - 3;	
				
				var yval1=yval.slice(0,leng);
				var yval2=yval.slice(-3); */
				 console.log("Dates::::"+ xval.length+"    Days:::::"+yval.length);
			var pointBackgroundColors = [];
			var pointBorderColors = [];
			 var strlength = yval.length-3;
			 
/* 			 for(x=1;x<=yval.length;x++)
				 {
				 if(x<=strlength)
					{
					 pointBackgroundColors.push("rgba(54, 162, 235, 0.2)");
					 pointBorderColors.push("rgba(54, 162, 235, 1)");
					}else{
						pointBackgroundColors.push("#FA8072");
						pointBorderColors.push("#FA8072");
					}
				 
				 } */
		 
				var chart_data={
				    		    labels: xval,	  	    	    
				      			datasets:[ 
				      		
				    		         {
				    		        	 type: 'bubble',
				    		        	 label:  "Actual Value",
				    		        	 
				    		            pointBackgroundColor: "rgba(0, 0, 255, 0)",
				    			        backgroundColor:  'rgba(54, 162, 235, 0.2)' ,
				    			           
				    		            pointBorderColor:  "rgba(54, 162, 235, 1)",        
				    		           borderColor:  'rgba(54, 162, 235, 1)' ,
				    		            borderWidth: 1,
				    		            data: yval
				    		        
				    		        }
			          ,
				         
				      { 
			        	  type: 'line',
			        	  data: zval,
				             	 
			        	  label: " Predicted Trend ",
			        	  
			        	     backgroundColor: "rgba(255, 255,255,0.2)",
					            borderColor: "Salmon",
				  
				          } 
				        
				    ]
				};

			var chart=new Chart(context,
					{
				      type : 'line',
						
				      data : chart_data,
			      tooltips: {
				         enabled: true
				       
				  			       
				     	      }, 
				      animation:{
				    	  animateScale:true
				      },
				      
				      options:{
		/* 		     	  tooltips: {
				    	        callbacks: {
				    	            label: function(tooltipItem) {
				    	            	if(tooltipItem.index >= (yvalue_length)-2)
				    	                    return "Predicted Failure: "+ Number(tooltipItem.yLabel) + " day(s)";
				    	            	else
				    	            		return "Realtime Failure: "+ Number(tooltipItem.yLabel) + " day(s)";
				    	            }
				    	        }
				    	  }, 
				    	     */
				    	  responsive:true,
				    	 	
				    	  hover: {
				              mode: 'label'
				          },
				          
				          title: {
				              display: true,
				              text: '',
				            },
			               
			               
			               scales:
			            	   {
			            	   yAxes:[{
				            		 display: true,
				            		 scaleLabel: {
				            			 display: true,
				            			 labelString: "Number of Days",
				            		 }
				            	         }
				            	        ],
			              
		       	                  xAxes:[{
			            		    display: true,
			            			 scaleLabel: {
				            			 display: true,
				            			 labelString: "Dates", //+values2+"'s",
				            		 }
			            	         }   
			            	        ]
				            	        
			            	   }
			            	   
				      }
			            	   
					}
					);  
			 
		}


		
		
		</script>				
						

</body>
</html>