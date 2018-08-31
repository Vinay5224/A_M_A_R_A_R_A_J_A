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

<body>
<%!
	// Declaring the static variables 
	
static String result;


%>

	<%
try{
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	 response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	 response.setDateHeader ("Expires", 0);
	response.setContentType("text/plain");
	response.setCharacterEncoding("UTF-8");
	
	//getting the values from DarshanTimeEstimation.jsp
	String locationDB=request.getParameter("typelocation").trim();
	String classDB=request.getParameter("typeclass").trim();
	
	System.out.println(locationDB+classDB);

		MongoClient mongoClient = new MongoClient("localhost", 27017);

	
	//Now connect to your database
	   MongoDatabase db1 = mongoClient.getDatabase("AmaraRaja");
	//Now connect to the Collection
	   MongoCollection<Document> coll1 = db1.getCollection("predict_frequency");
		System.out.println("Collection created  successfully...");	
		
		//Querying the collection based on the particular values
		BasicDBObject coun = new BasicDBObject("FunctionalLocation",locationDB);
	    coun.put("Class", classDB);

		FindIterable<Document> cursors = coll1.find(coun).limit(1);
		ArrayList<String> date = new ArrayList<String>();
		ArrayList<Integer> frequency = new ArrayList<Integer>();
		ArrayList<Integer> example = new ArrayList<Integer>();
		//Iterating the document
	    Iterator<Document> itr = cursors.iterator();
		 if(itr.hasNext())
		 { 
			
			Document doc = itr.next();
			 System.out.println("Working"+ doc);
			date = (ArrayList<String>) doc.get("date"); 
			 frequency = (ArrayList<Integer>) doc.get("frequency");
			 example = (ArrayList<Integer>) doc.get("Example");
			 
			 for(int j=0; j<date.size(); j++)
				 System.out.println(date.get(j)+"-----"+String.format ("%d", frequency.get(j)));
			String DateDB ="",FrequencyDB="", ExampleDB="";
			for(int i=0; i<date.size(); i++){
				
		/* 		String [] splitdate = date.get(i).split("-");
				String Dat = splitdate[2]+"-"+splitdate[1]+"-" +splitdate[0]; */
				DateDB +=""+date.get(i)+",";
				//Dat ="";
				int temp = frequency.get(i);
				int temp1 = example.get(i);
				//FrequencyDB +=""+Integer.toString(temp)+",";
				FrequencyDB +=""+String.format ("%d", temp)+",";
				ExampleDB +=""+String.format ("%d", temp1)+",";
				
			}
			DateDB = DateDB.substring(0, DateDB.length()-1);
			FrequencyDB = FrequencyDB.substring(0, FrequencyDB.length()-1);
			ExampleDB = ExampleDB.substring(0, ExampleDB.length()-1);

			 System.out.println(DateDB+"@"+FrequencyDB+"@"+ExampleDB);
			 result = FrequencyDB+"@"+DateDB+"@"+ExampleDB;
				
			
		}

		 response.getWriter().write(""+result);
result="";
			date.clear();
			frequency.clear();
			System.out.println("Values has been cleared");
		 }
		catch(Exception e)
    
{
System.out.println(e.getMessage());
e.getStackTrace();
}
    
%>
</body>
</html>