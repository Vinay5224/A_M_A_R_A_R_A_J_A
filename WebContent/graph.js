

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


$("#graph_div").html('');

	   clas=$("#Thu :selected").val();
	  console.log("clas:::"+clas);
	  
	
	}

//submit script
$(document).on("click", "#submit", function(){
	 
	$.get("view.jsp",{typelocation:locat,typeclass:clas},graph_res)
}); 


function graph_res(response)
{
	console.log("wait:::"+ response);
	 if(response)
		 {
		 $("#load").hide();
		 response=response.trim();
		 
		  
		 $("#p").text(response);
		 
		  $("#graph_values").empty();
	var resp = response.split("@");
	document.getElementById("graph_values").innerHTML="";document.getElementById("graph_dates").innerHTML="";
	document.getElementById("graph_values").innerHTML=resp[0];//$("#graph_values").append(response);
	      document.getElementById("graph_dates").innerHTML=resp[1];//$("#graph_values").append(response);
	      
	      chartjs_graph();
		 }
}

var yvalue_length=0;
function chartjs_graph()
{
	var values=document.getElementById('graph_values').innerHTML;
	var values1=document.getElementById('graph_dates').innerHTML;
	//var values2=document.getElementById('demo').innerHTML;
 
	$("#graph_values").empty();$("#graph_dates").empty();
	
	$("#pred_graph").remove(); 
	$('#graph_div').html('');
	$('#graph_div').append('<canvas  id="pred_graph" width=950 height=500></canvas>');
	var context=$("#pred_graph");
	
	 var xval=new Array();
		values1=values1.trim();
		xval=values1.split(",");
	 	var xx = xval.slice(-3);
		var yval=new Array();
		values=values.trim();
		yval=values.split(",");
		
		yvalue_length=yval.length;
		yvalue_length=yvalue_length-1;
		
		
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
	 
	 for(x=1;x<=yval.length;x++)
		 {
		 if(x<=strlength)
			{
			 pointBackgroundColors.push("rgba(54, 162, 235, 0.2)");
			 pointBorderColors.push("rgba(54, 162, 235, 1)");
			}else{
				pointBackgroundColors.push("#FA8072");
				pointBorderColors.push("#FA8072");
			}
		 
		 }
 
		var chart_data={
		    		    labels: xval,	  	    	    
		      			datasets:[ 
		      		
		    		         {
		    		            
		    		        	 label:  "Real Time Failure",
		    		        	 
		    		            pointBackgroundColor: pointBackgroundColors,
		    			        backgroundColor:  'rgba(54, 162, 235, 0.2)' ,
		    			           
		    		            pointBorderColor:  pointBorderColors,        
		    		           borderColor:  'rgba(54, 162, 235, 1)' ,
		    		            borderWidth: 1,
		    		            data: yval
		    		        
		    		        }
	          ,
		         
		      { data: [],
	        	
	        	  label: " Predicted Failure ",
	        	  
	        	     backgroundColor: "rgba(255,160,122,0.2)",
			            borderColor: "Salmon",
		  
		          } 
		        
		    ]
		};

	var chart=new Chart(context,
			{
		      type : 'line',
				
		      data : chart_data,
	/* 	      tooltips: {
		         enabled: true,
		         mode:"single",
		         callbacks: {
		       
	                    label: function(tooltipItems, data) { 
	                        return tooltipItems.yLabel + ' : ' + tooltipItems.yLabel + " Files";
	                    }
	                }
		       
		     	      }, */
		      animation:{
		    	  animateScale:true
		      },
		      
		      options:{
		    	  tooltips: {
		    	        callbacks: {
		    	            label: function(tooltipItem) {
		    	            	if(tooltipItem.index >= (yvalue_length)-2)
		    	                    return "Predicted Failure: "+ Number(tooltipItem.yLabel) + " day(s)";
		    	            	else
		    	            		return "Realtime Failure: "+ Number(tooltipItem.yLabel) + " day(s)";
		    	            }
		    	        }
		    	  },
		    	    
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

