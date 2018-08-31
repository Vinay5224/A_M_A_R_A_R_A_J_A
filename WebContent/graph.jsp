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
						
								<span><div id="graph_values" style="visibility: hidden;"></div></span>
						<span><div id="graph_dates" style="visibility: hidden;"></div></span>

						<br>
						<br>
						<div id="load" class="progress"
							style="width: 500px; margin-left: 325px;">
							<div class="progress-bar progress-bar-striped hide"
								role="progressbar" aria-valuenow="100" aria-valuemin="0"
								aria-valuemax="100" style="width: 100%"></div>
						</div>
						<div id="graph_div"
							style="margin-left: 13%; position: absolute; width: 1000px; height: 350px">
							<canvas id="pred_graph" width="150" height="150"></canvas>
						</div>
						

</body>
</html>