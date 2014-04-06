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

		DAL dal = (DAL)getServletContext().getAttribute("DAL");
		
		if (request.getParameter("rejectedid") != null) {
			User user = (User) request.getSession().getAttribute("user");
			dal.setUserRating(user, Integer.parseInt(request.getParameter("rejectedid")), 0);
		}
		
		double lat = Double.parseDouble((String)request.getParameter("latitude"));
		double lng = Double.parseDouble((String)request.getParameter("longitude"));
		
		double boxSize = 1.0;
		
		request.setAttribute("modeOfTransit", "driving");
		if (request.getParameter("transport") != null) {
			boolean isWalk = request.getParameter("transport").equals("walking");
			boolean isBike = request.getParameter("transport").equals("bicycling");
			boolean isDrive = request.getParameter("transport").equals("driving");
			boolean isBus = request.getParameter("transport").equals("transit");
			
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
		} 
		System.out.println(boxSize);
		
		boolean isParks = (request.getParameter("parks") == null || request.getParameter("parks").equals("YES"));
		boolean isBars = (request.getParameter("bars") == null || request.getParameter("bars").equals("YES"));
		boolean isFood = (request.getParameter("food") == null || request.getParameter("food").equals("YES"));
		boolean isMovies = (request.getParameter("movies") == null || request.getParameter("movies").equals("YES"));
		boolean isShopping = (request.getParameter("shopping") == null || request.getParameter("shopping").equals("YES"));
		boolean isOther = (request.getParameter("other") == null || request.getParameter("other").equals("YES"));
		
		request.setAttribute("isParks", isParks ? "YES" : "NO");
		request.setAttribute("isFood", isFood ? "YES" : "NO");
		request.setAttribute("isMovies", isMovies ? "YES" : "NO");
		request.setAttribute("isShopping", isShopping ? "YES" : "NO");
		request.setAttribute("isOther", isOther ? "YES" : "NO");
		request.setAttribute("isBars", isBars ? "YES" : "NO");
		
		//DO ALL OF THE THINGS
		System.out.println(isParks + " " + isFood + " " + isMovies + " " + isShopping + " " + isOther);
		ArrayList<Activity> activities = dal.getSuggestions(lat, lng, boxSize, isParks, isBars, isFood, isMovies, isShopping, isOther);
		request.setAttribute("latitude", request.getParameter("latitude"));
		request.setAttribute("longitude", request.getParameter("longitude"));
		
		if (activities.isEmpty()) {
			RequestDispatcher dispatch = request.getRequestDispatcher("noSuggestions.jsp");
			dispatch.forward(request, response);
			return;
		}
		
		Random generator = new Random();
		
		Activity activity;
		
		while (true) {
			
			// Do a quick check to make sure that we're not in an infinite-loop case
			
			int i;
			for (i = 0; i < activities.size(); i++) {
				if (activities.get(i).theme.equals("movie-theatre")) {
					if (dal.getMovieForTheatre(activities.get(i)).size() != 0) break;
				}
				else break;
			}
			// It's impossible to find a good match here
			if (i >= activities.size()-1) {
				RequestDispatcher dispatch = request.getRequestDispatcher("noSuggestions.jsp");
				dispatch.forward(request, response);
				return;
			}
			
			// Otherwise, keep trying until we get a good one
			
			int randomInt = generator.nextInt(activities.size());
			activity = activities.get(randomInt);
			if (activity.theme.equals("movie-theatre")) {
				ArrayList<Movie> movies = dal.getMovieForTheatre(activity);
				if (movies.size() > 0) {
					int nextRandom = generator.nextInt(movies.size());
					activity = movies.get(nextRandom);
					break;
				}
			}
			else break;
		}
		
		double roughDistanceMiles = (Math.sqrt(Math.pow(lat-activity.latitude,2)+Math.pow(lng-activity.longitude,2)))*69;
		double roughTimeMinutes = roughDistanceMiles;
		
		request.setAttribute("", activity);
		
		request.setAttribute("activity", activity);
		RequestDispatcher dispatch = request.getRequestDispatcher("suggestions.jsp");
		dispatch.forward(request,response);
	}

}
