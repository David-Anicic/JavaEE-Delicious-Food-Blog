package servlets;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Korisnik;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String username = request.getParameter("korisnickoIme");
		String password = request.getParameter("sifra");
		
		String sql = "SELECT * FROM korisnik WHERE korisnickoIme like '" + username + "' AND sifra like '" + password + "'";
		EntityManager em = database.ConnectionProvider.getConnection();
	
		@SuppressWarnings("unchecked")
		List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
		
		if(lista.size() > 0)
		{
			request.getSession().setAttribute("username", username);
			if(username.equals("admin"))
				response.sendRedirect("admin.jsp");
			else
				response.sendRedirect("pocetna.jsp");
		}
		else
		{
			request.getSession().setAttribute("greska","Pogresno korisnicko ime ili lozinka");
			response.sendRedirect("login.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
