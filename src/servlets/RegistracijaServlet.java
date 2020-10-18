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
 * Servlet implementation class RegistracijaServlet
 */
@WebServlet("/RegistracijaServlet")
public class RegistracijaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistracijaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String ime = request.getParameter("ime");
		String prezime = request.getParameter("prezime");
		String username = request.getParameter("korisnickoIme");
		String pass = request.getParameter("sifra");
		String email = request.getParameter("email");
		String brTel = request.getParameter("brojTelefona");
		
		EntityManager em = database.ConnectionProvider.getConnection();
		
		String sql = "SELECT * FROM korisnik WHERE korisnickoIme like '" + username + "'";
		
		@SuppressWarnings("unchecked")
		List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
		// provera da li postoji uneti username
		if(lista.size() > 0)
		{
			request.getSession().setAttribute("greska", "Korisnicko ime vec postoji!");
			response.sendRedirect("registracija.jsp");
		}
		else
		{
			// pravimo novog usera
			Korisnik k = new Korisnik(ime, prezime, username, pass, email, brTel);
			em.getTransaction().begin();
			em.persist(k);
			em.getTransaction().commit();
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
