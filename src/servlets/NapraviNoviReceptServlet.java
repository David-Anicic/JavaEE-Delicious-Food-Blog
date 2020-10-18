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
import model.Recept;
import model.ReceptSastojci;
import model.Slike;

/**
 * Servlet implementation class NapraviNoviReceptServlet
 */
@WebServlet("/NapraviNoviReceptServlet")
public class NapraviNoviReceptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NapraviNoviReceptServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		EntityManager em = database.ConnectionProvider.getConnection();
		
		String korIme = request.getSession().getAttribute("username").toString();
		String sql = "SELECT * FROM korisnik WHERE korisnickoIme like '" + korIme + "'";
		@SuppressWarnings("unchecked")
		List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
		int id = lista.get(0).getId();
		
		Recept r = new Recept(request.getParameter("naziv"), request.getParameter("opis"), Integer.parseInt(request.getParameter("idKategorije")), id);
		em.getTransaction().begin();
		em.persist(r);
		em.getTransaction().commit();
		
		sql = "select * from recept";
		@SuppressWarnings("unchecked")
		List<Recept> recepti = em.createNativeQuery(sql, Recept.class).getResultList();
		int idRecepta = recepti.get(recepti.size()-1).getId();
		System.out.println(idRecepta);
		
		String[] sastojci = request.getParameterValues("sastojak");
		//System.out.println(sastojci[0] + "------" + sastojci[1]);
		String[] kolicine = request.getParameterValues("kolicina");
		String[] mere = request.getParameterValues("mera");

		em.getTransaction().begin();
		for (int i = 0; i < sastojci.length; i++)
		{
			int k = Integer.parseInt(kolicine[i]);
			int m = Integer.parseInt(mere[i]);
			
			ReceptSastojci rs = new ReceptSastojci(idRecepta, sastojci[i], k, m);
			em.persist(rs);
			
		}
		
		Slike s = new Slike(idRecepta, "default.jpg");
		em.persist(s);
		
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
