package servlets;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Recept;

/**
 * Servlet implementation class BrisanjeReceptaServlet
 */
@WebServlet("/BrisanjeReceptaServlet")
public class BrisanjeReceptaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrisanjeReceptaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int idR = Integer.parseInt(request.getParameter("idRecepta"));
		
		EntityManager em = database.ConnectionProvider.getConnection();
		Object o = em.find(Recept.class, idR);
		
		em.getTransaction().begin();
		em.remove(o);
		em.getTransaction().commit();
		
		response.sendRedirect("pocetna.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
