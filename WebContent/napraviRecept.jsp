<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="database.ConnectionProvider"%>
<%@page import="javax.persistence.*" %>
<%@page import="model.Korisnik" %>
<%@page import="model.Kategorija" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="main.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<title>Unos novog recepta</title>
</head>
<body>
	<!-- MENU -->
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
  	  <li><a class="active" href="napraviRecept.jsp">Napravi novi recept</a></li>
  	  <li><a href="pitanja.jsp">Postavi pitanje</a></li>
	  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
	  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
	</ul>

<% if(request.getSession().getAttribute("username") != null
		&& !request.getSession().getAttribute("username").equals("admin")) { 

	EntityManager em = ConnectionProvider.getConnection();
	
	// izdvajamo kategorije
	String sql = "SELECT * FROM kategorija";
	@SuppressWarnings("unchecked")
	List<Kategorija> kategorije = em.createNativeQuery(sql, Kategorija.class).getResultList();
	String options = "";
	for(Kategorija k : kategorije)
	{
		options += "<option value='"+k.getId()+"'>"+k.getNaziv()+"</option>";
	}
	
	String sastojciOpcije = "proba";

%>
	<script type="text/javascript">
		
		function dodajPolja()
		{
			var html = "";
			html += "<div class='row'><div class='col-md-3'><div class='form-group'><label for='nSastojka'>Naziv sastojka:</label><br><input class='form-control' type='text' name='sastojak' required></div></div>";
			html += "<div class='col-md-3'><div class='form-group'><label for='kolicina'>Kolicina:</label><br><input class='form-control' type='text' name='kolicina' required></div>";
			html += "<div class='col-md-3'><div class='form-group'><label for='mere'>Mera</label><select style='width:80px;' class='form-control' name='mera'><option value='1'>kg</option><option value='2'>l</option><option value='4'>gr</option></select></div>";
			html += "<div class='col-md-3'></div>";
			html += "</div>";
			document.getElementById("sastojciTagovi").innerHTML += html;
		}
	</script>
	
	<div class="container">
		<div class="row"><div class="col-md-12"></div></div>
		<div class="row"><div class="col-md-12"><h2>Unos novog recepta</h2></div></div>
		<form action="NapraviNoviReceptServlet" method="post">
			<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label for="naziv">Naziv recepta:</label>
						<input style="width: 200px;" class="form-control" required name="naziv" type="text" pattern="^[a-zA-Z]{2, 15}$" title="Ime ne sme biti duze od 15 karaktera">
					</div>
				</div>
				<div class="col-md3"></div>
				<div class="col-md3"></div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="naziv">Izaberite kategoriju:</label><br>
						<select class='form-control' name="idKategorije">
							<%= options %>
						</select>
					</div>
				</div>
			</div>
			<div id="sastojciTagovi">
				
			</div>
			<div class="row">
				<div class="col-md-12">
					<button style="width:200px;" onclick="dodajPolja();" class='form-control'>Dodaj polja za sastojak</button>
					<br>
				</div>
				</div>
			<div class="row">
				<div class="col-md-12">
					<label for="opis">Opis recepta:</label>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
						<textarea rows="5" cols="20" style="width:400px;" name="opis" class='form-control'></textarea>
				</div>
			</div><br>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
				    	<label for="exampleFormControlFile1">Dodajte slike Vaseg recepta:</label>
				    	<input type="file" class="form-control-file" id="file" multiple name="file">
				  </div>
			  </div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<br>
					<input style="width:200px;" type="submit" value="Dodaj recept" class='form-control'>
				</div>
			</div>
		</form>
	</div>
<% } else { response.sendRedirect("login.jsp"); return; } %>
</body>
</html>