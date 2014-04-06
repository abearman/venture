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
 * Servlet implementation class GenerateSuggestionsServlet
 */
@WebServlet("/GenerateSuggestionsServlet")
public class GenerateSuggestionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateSuggestionsServlet() {
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
		double lat = Double.parseDouble((String)request.getParameter("latitude"));
		double lng = Double.parseDouble((String)request.getParameter("longitude"));
		
		double boxSize = 0.0;
		
		if (request.getParameter("transport") != null) {
			boolean isWalk = request.getParameter("transport").equals("walk");
			boolean isBike = request.getParameter("transport").equals("bike");
			boolean isDrive = request.getParameter("transport").equals("car");
			boolean isBus = request.getParameter("transport").equals("bus");
			
			if (isWalk) {
				boxSize = 0.01;
				request.setAttribute("modeOfTransit", "walking");
			} else if (isBike) {
				boxSize = 0.05;
				request.setAttribute("modeOfTransit", "bicycling");
			} else if (isDrive) {
				boxSize = 0.5;
				request.setAttribute("modeOfTransit", "driving");
			} else if (isBus) {
				boxSize = 0.5;
				request.setAttribute("modeOfTransit", "transit");
			}
		} else {
			boxSize = 1;
		}
	
		boolean isHungry = (request.getParameter("hungry") != null);
		boolean isMovie = (request.getParameter("movie") != null);
		boolean isOutside = (request.getParameter("outside") != null);
		boolean isArts = (request.getParameter("arts") != null);
		if (isHungry) request.setAttribute("isHungry", "YES"); 
		if (isMovie) request.setAttribute("isMovie", "YES");
		if (isOutside) request.setAttribute("isOutside", "YES");
		if (isArts) request.setAttribute("isArts", "YES");
		
		//DO ALL OF THE THINGS
		DAL dal = (DAL)getServletContext().getAttribute("DAL");
		ArrayList<Activity> activities = dal.getSuggestions(lat, lng, boxSize, isHungry, isOutside, isArts);
		request.setAttribute("latitude", request.getParameter("latitude"));
		request.setAttribute("longitude", request.getParameter("longitude"));
		
		if (activities.isEmpty()) {
			RequestDispatcher dispatch = request.getRequestDispatcher("noSuggestions.jsp");
			dispatch.forward(request, response);
			return;
		}
		
		Random generator = new Random();
		int randomInt = generator.nextInt(activities.size());
		
		request.setAttribute("activity", activities.get(randomInt));
		RequestDispatcher dispatch = request.getRequestDispatcher("suggestions.jsp");
		dispatch.forward(request,response);
	}

}
