

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

/**
 * Servlet implementation class Resour
 */
@WebServlet("/Resour")
public class Resour extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static   HashSet<String> ClassDB=new HashSet<String>(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Resour() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("graph.jsp");
		
		dispatcher.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		 String resultClass ="<option id='wed_t' >--- Select Class ---";
		String locationJsp = request.getParameter("locat");
		
		MongoClient Client = new MongoClient("192.168.0.2", 27017);
		MongoDatabase Amara = Client.getDatabase("AmaraRaja");
		MongoCollection<Document> predict = Amara.getCollection("predict_frequency");
		BasicDBObject obj = new BasicDBObject("FunctionalLocation", locationJsp);
		FindIterable<Document> predictSearch = predict.find(obj);
		Iterator<Document> IterPredict = predictSearch.iterator();
		while(IterPredict.hasNext()){
			
			Document doc = IterPredict.next();
			
			String cla = (String) doc.get("Class");
			
			ClassDB.add(cla);
			
			
		}
   	  Iterator<String> itr=ClassDB.iterator();  
	  while(itr.hasNext()){  

		  
		  resultClass+="<option id='wed_t' >"+itr.next();
	 
	


	  }

	  response.getWriter().write(resultClass); 
	  ClassDB.clear();
	}

}
