<%@page import="database.ConnectionProvider"%>
<%@page import="javax.persistence.EntityManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.Korisnik"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="model.Recept"%>
<%@page import="model.Slike"%>
<%@page import="model.Kategorija"%>
<%@page import="model.Mera"%>
<%@page import="model.ReceptSastojci"%>
<%@page import="javax.persistence.EntityManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="main.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<title>Detalji recepta</title>
</head>
<body>
<% 
	if (request.getSession().getAttribute("username") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}

	String ulogovanKorisnik = request.getSession().getAttribute("username").toString();
	int idRecepta = Integer.parseInt(request.getParameter("idRecepta"));
	
	// deo za sokete
	//
	
	EntityManager em = ConnectionProvider.getConnection();

	String sql = "select * from recept where id="+idRecepta;
	@SuppressWarnings("unchecked")
	List<Recept> recepti = em.createNativeQuery(sql, Recept.class).getResultList();
	
	sql = "select * from korisnik";
	@SuppressWarnings("unchecked")
	List<Korisnik> korisnici = em.createNativeQuery(sql, Korisnik.class).getResultList();
	
	String vlasnikRecepta = "";
	for(Korisnik k : korisnici)
		if(k.getId() == recepti.get(0).getIdKorisnika())
		{
			vlasnikRecepta = k.getKorisnickoIme();
			break;
		}
	
	sql = "select * from slike where idRecepta="+idRecepta;
	@SuppressWarnings("unchecked")
	List<Slike> listaSlike = em.createNativeQuery(sql, Slike.class).getResultList();
	String urlSlike = "images/"; 
	urlSlike += listaSlike.get(0).getNazivSlike();
	
	sql = "select * from kategorija where id="+recepti.get(0).getIdKategorije();
	@SuppressWarnings("unchecked")
	List<Kategorija> kategorije = em.createNativeQuery(sql, Kategorija.class).getResultList();
	String kategorija = kategorije.get(0).getNaziv();
	
	sql = "select * from receptsastojci where idRecepta="+idRecepta;
	@SuppressWarnings("unchecked")
	List<ReceptSastojci> sastojci = em.createNativeQuery(sql, ReceptSastojci.class).getResultList();
	
	sql = "select * from mera";
	@SuppressWarnings("unchecked")
	List<Mera> listaMere = em.createNativeQuery(sql, Mera.class).getResultList();
	
	List<String> mere = new ArrayList<String>();
	for(ReceptSastojci rs : sastojci)
	{
		for(Mera m : listaMere)
			if(m.getId() == rs.getIdMere())
			{
				mere.add(m.getNaziv());
				break;
			}
	}
	
	//System.out.println(sastojci);
	//System.out.println(mere);
%>
	<!-- MENU -->
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
  	  <li><a href="napraviRecept.jsp">Napravi novi recept</a></li>
	  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
	  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
	</ul>

	<div class="container">
		<div class="row"><div class="col-md-12"></div></div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-9"><h2>Detaljan prikaz recepta</h2><br></div>
		</div>
		<div class="panel panel-warning" style="width:50%;margin:auto;padding:4px;"><img src="<%=urlSlike %>"></div><br><br>
		<div class="panel panel-warning" style="width:50%;margin:auto;padding:4px;">
			<div class="panel-body"><b>Recept: </b><%=recepti.get(0).getNaziv() %></div>
			<div class="panel-body"><b>Kategorija: </b><%=kategorija %></div>
			<div class="panel-body"><h3>Sastojci:</h3></div>
			<%
				for(int i = 0; i < sastojci.size(); i++)
				{
			%>
					<div class="panel-body"><b>Sastojak: </b><%=sastojci.get(i).getSastojak() %></div>
					<div class="panel-body"><b>Kolicina: </b><%=sastojci.get(i).getKolicina() %></div>
					<div class="panel-body"><b>Mera: </b><%=mere.get(i) %></div>
			<%
				}
			%>
			<div class="panel-body"><b>Opis: </b><%=recepti.get(0).getOpis() %></div>
		</div>
		<br><br>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6"><%if(vlasnikRecepta.equals(ulogovanKorisnik) || ulogovanKorisnik.equals("admin")){ %><button type="button" class="btn" onclick="brisanjeRecepta()">Obrisi ovaj oglas</button><% } %></div>
		</div>
		<br><br>
	</div>
	
	<script>
	
		var idRecepta = "<%= idRecepta %>";
	
		function brisanjeRecepta()
		{
			$.ajax({
				type: 'POST',
				url: 'BrisanjeReceptaServlet',
				data: 'idRecepta='+idRecepta,
				success: function(data) {
					window.location.replace("pocetna.jsp");
				}
			});
		}
	</script>
</body>
</html>