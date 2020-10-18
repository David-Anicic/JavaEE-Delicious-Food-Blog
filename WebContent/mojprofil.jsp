<%@page import="database.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.Korisnik"%>
<%@page import="java.util.List"%>
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
<title>Moj profil</title>
</head>
<body>
	<%
	// ukoliko nije ulogovan redirektuj ga na login stranu
	if (request.getSession().getAttribute("username") == null)
	   {
			response.sendRedirect("login.jsp");
			return;
	   }
	
	String logovaniUser = request.getSession().getAttribute("username").toString();

	String ime="";
	String prezime="";
	String korisnickoIme=request.getSession().getAttribute("username").toString();
	String sifra="";
	String email="";
	Integer id;
	
	String sql="select * from korisnik where korisnickoIme like '"+korisnickoIme+"'";	
	EntityManager em = database.ConnectionProvider.getConnection();
	@SuppressWarnings("unchecked")
	List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
	Korisnik k = lista.get(0);
	ime = k.getIme();
	prezime = k.getPrezime();
	sifra = k.getSifra();
	email = k.getEmail();
	id = k.getId();
	
	String s="";
	if(request.getSession().getAttribute("greska")!=null)
		s="Greska: "+ request.getSession().getAttribute("greska").toString();
	 %>	
	 
	<!-- MENU -->
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
	  <% if(request.getSession().getAttribute("username") != null &&
	  			request.getSession().getAttribute("username").toString().equals("admin")) { %>
	  	  <li><a href="admin.jsp">Korisnici</a></li>
	  	  <li><a href="pitanja.jsp">Pitanja korisnika</a></li>
	  <% } else if (request.getSession().getAttribute("username") != null && 
	  				!request.getSession().getAttribute("username").toString().equals("admin")) { %>
  				<li><a href="napraviRecept.jsp">Napravi novi recept</a></li>
  				<li><a href="pitanja.jsp">Postavi pitanje</a></li>
			<% } %>
	  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
	  <li class="auth"><a class="active" href="mojprofil.jsp">Moj profil</a></li>
	</ul>
	
	<div class="container">
	
	<div class="row"><div class="col-md-12"></div></div>
	<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-9"><h2>Moji podaci</h2><br></div>
	</div>

	<form method="post" action="PromeniPodatkeServlet">
	<div class="row"><div class="col-md-12"><br></div></div>
		<div class="row">
			<input type="hidden" name="id" value="<%=id %>">
			<div class="col-md-3"></div>
			<div class="col-md-3">
				<div class="form-group">
				  <label for="usr">Ime:</label>
				  <input type="text" class="form-control" name="ime" value="<%=ime %>" pattern="^[a-zA-Z]{2, 15}$" title="Ime ne sme biti duze od 15 karaktera" required>
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
				  <label for="usr">Prezime:</label>
				  <input type="text" class="form-control" name="prezime" value="<%=prezime %>" pattern="^[a-zA-Z]{2, 15}$" title="Prezime ne sme biti duze od 15 karaktera" required>
				</div>
			</div>
			<!-- admin ne moze da menja korisnicko ime -->
			<% if(!korisnickoIme.equals("admin")) { %>
				<div class="col-md-3">
					<div class="form-group">
					  <label for="usr">Korisnicko ime:</label>
					  <input type="text" class="form-control" name="korisnickoIme" value="<%=korisnickoIme %>" name="korisnickoIme" pattern="^[A-Za-z0-9]{6,}$" title="Korisnicko ime moze sadrzati samo slova i brojeve i imate najmanje 6 karaktera." required>
					</div>
				</div>
			<% } %>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">
				<div class="form-group">
				  <label for="usr">Nova lozinka:</label>
				  <input type="password" class="form-control" name="sifra" pattern="[A-Za-z0-9]{6,12}" title="Sifra mora imati izmedju 6 i 12 slova i/ili cifara">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
				  <label for="usr">Ponovljena lozinka:</label>
				  <input type="password" class="form-control" name="sifra2">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
				  <label for="usr">Email:</label>
				  <input type="text" class="form-control" name="email" value="<%=email %>" pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" title="Nevalidna email adresa">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="submit" value="Promeni podatke" class="form-control" />
				</div>
			</div>
		</div>
	</form>
	<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-4"><h5 style="color:red"><%= s  %></h5></div>
	<% if(request.getSession().getAttribute("greska")!=null)
				request.getSession().setAttribute("greska", null);
	%>
	</div>
</div>
</body>
</html>