package servlets;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.RollbackException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Korisnik;

/**
 * Servlet implementation class PromeniPodatkeServlet
 */
@WebServlet("/PromeniPodatkeServlet")
public class PromeniPodatkeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PromeniPodatkeServlet() {
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
		String korisnickoIme = request.getParameter("korisnickoIme");
		String sifra = request.getParameter("sifra");
		String sifra2 = request.getParameter("sifra2");
		String email = request.getParameter("email");
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		EntityManager em = database.ConnectionProvider.getConnection();
		String sql = "SELECT * FROM korisnik WHERE korisnickoIme like '" + korisnickoIme + "'";
		List<Korisnik> lista = em.createNativeQuery(sql).getResultList();
		if(lista.size() > 0)
		{
			request.getSession().setAttribute("greska", "Korisnik sa unetim korisnickim imenom vec postoji!");
			response.sendRedirect("mojprofil.jsp");
		}
		else if(!sifra2.equals(sifra))
		{
			request.getSession().setAttribute("greska", "Lozinka i ponovljena lozinka se ne poklapaju");
			response.sendRedirect("mojprofil.jsp");
		}else
		{
			try
			{
				Korisnik k = em.find(Korisnik.class, id);
				em.getTransaction().begin();
				k.setIme(ime);
				k.setPrezime(prezime);
				k.setEmail(email);
				k.setKorisnickoIme(korisnickoIme);
				if(!sifra.equals(""))
					k.setSifra(sifra);
				em.getTransaction().commit();
				request.getSession().setAttribute("username", korisnickoIme);
				if(request.getSession().getAttribute("username").equals("admin"))
					response.sendRedirect("admin.jsp");
				else
				{
					request.getSession().setAttribute("promena", "Uspesno ste promenili podatke");
					response.sendRedirect("pocetna.jsp");
				}
				
			}catch (RollbackException e) {
				request.getSession().setAttribute("greska", "Korisnicko ime vec postoji");
				response.sendRedirect("mojprofil.jsp");
			}
			
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
