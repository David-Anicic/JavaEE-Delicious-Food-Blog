package servlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ListaKorisnika;
import bean.Poruka;
import model.Korisnik;
import util.Util;

/**
 * Servlet implementation class ChatServlet
 */
@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String zahtev = request.getParameter("zahtev");
		//System.out.println(zahtev+" --zahtev");
		if(zahtev.equals("write"))
		{
			String tekst=request.getParameter("poruka");
			String primalac=request.getParameter("primalac");
			String posiljalac=request.getParameter("posiljalac");
			Poruka p = new Poruka(tekst, primalac, posiljalac);
			
			BufferedWriter bw = (BufferedWriter)request.getSession().getAttribute("bw");
			bw.write(Util.getXmlFromObject(p));
			bw.flush();
			
			sendResponse(response, "servlet primio poruku");
		}else if(zahtev.equals("read"))
		{
			//System.out.println("servlet usao u read zahtev");
			System.out.println("chatServlet pre readlinea");
			BufferedReader br = (BufferedReader)request.getSession().getAttribute("br");
			Object o = Util.getObjectFromString(br.readLine());
			System.out.println("chatServlet nakon readlina");
			if(o instanceof Poruka)
			{
				System.out.println("chatservlet if poruka");
				Poruka p = (Poruka)o;
				sendResponse(response, p.getPosiljalac()+"&&"+p.getTekstPoruke());
			}else if(o instanceof ListaKorisnika)
			{
				System.out.println("chatservlet if lista korisnika");
				String odg="&&";
				ListaKorisnika l=(ListaKorisnika)o;
				for(String s:l.getOnlineKorisnici()) {
					System.out.println("Korisnik u listi: "+s+"\n");
					odg+=s+"&&";
				}
				sendResponse(response, odg);
			}
		}else if(zahtev.equals("getPoruke"))
		{
			String kor1=request.getParameter("kor1");
			String kor2=request.getParameter("kor2");
			
			EntityManager em = database.ConnectionProvider.getConnection();
			String sql = "select * from korisnik where korisnickoIme like '"+kor1+"'";
			
			@SuppressWarnings("unchecked")
			List<Korisnik> korisnik1 = em.createNativeQuery(sql, Korisnik.class).getResultList(); 
			
			sql = "select * from korisnik where korisnickoIme like '"+kor2+"'";
			
			@SuppressWarnings("unchecked")
			List<Korisnik> korisnik2 = em.createNativeQuery(sql, Korisnik.class).getResultList();
			
			int id1 = korisnik1.get(0).getId();
			int id2 = korisnik2.get(0).getId();
			
			sql = "select * from poruka where (idPrimaoca="+id1+" and idPosiljaoca="+id2+") or (idPrimaoca="+id2+" and idPosiljaoca="+id1+")";
			@SuppressWarnings("unchecked")
			List<model.Poruka> poruke = em.createNativeQuery(sql, model.Poruka.class).getResultList();
			
			String res = "";
			for(model.Poruka p: poruke)
			{
				res+=p.getIdPosiljaoca()+"&"+p.getIdPrimaoca()+"&"+p.getTekst()+"&&";
			}
			
			sendResponse(response, res);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void sendResponse(HttpServletResponse response, String message) throws ServletException, IOException {
		response.setContentType("text/plain"); 
		response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(message);
	}

}
