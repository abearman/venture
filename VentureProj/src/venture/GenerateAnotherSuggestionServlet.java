package venture;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GenerateAnotherSuggestionServlet
 */
@WebServlet("/GenerateAnotherSuggestionServlet")
public class GenerateAnotherSuggestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateAnotherSuggestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		double lat = Double.parseDouble((String)request.getAttribute("latitude"));
		double lng = Double.parseDouble((String)request.getAttribute("longitude"));
		
		DAL dal = (DAL)getServletContext().getAttribute("DAL");
		ArrayList<Activity> activities = dal.getSuggestions(lat, lng);
		Random generator = new Random();
		int randomInt = generator.nextInt(activities.size());
		
		request.setAttribute("activity", activities.get(randomInt));
		request.setAttribute("latitude", request.getAttribute("latitude"));
		request.setAttribute("longitude", request.getAttribute("longitude"));
		RequestDispatcher dispatch = request.getRequestDispatcher("suggestions.jsp");
		dispatch.forward(request,response);
	}

}
