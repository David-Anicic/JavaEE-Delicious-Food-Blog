<%
	if((request.getSession().getAttribute("username") != null))
	{
		response.sendRedirect("pocetna.jsp");
	}
	else
	{
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="main.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<title>Registracija</title>
</head>
<body>
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
	  <li class="auth"><a href="login.jsp">Prijava</a></li>
	  <li class="auth"><a class="active" href="registracija.jsp">Registracija</a></li>
	</ul>

	<%
	String s = "";
	if(request.getSession().getAttribute("greska") != null)
		s = "Greska: " + request.getSession().getAttribute("greska").toString();
	%>
	
	<div>
		<h4><%= s %></h4>
		<% if(request.getSession().getAttribute("greska") != null)
				request.getSession().setAttribute("greska", null);
		%>
		<div class="container" style="margin:auto; width:500px;">
			<div class="row"><div class="col-md-12"></div></div>
			<form action="RegistracijaServlet" method="post">
				<div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Ime" required type="text" name="ime" pattern="^[a-zA-Z]{2, 15}$" title="Ime ne sme biti duze od 15 karaktera" /><br/>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Prezime" type="text" name="prezime" required pattern="^[a-zA-Z]{2, 15}$" title="Prezime ne sme biti duze od 15 karaktera" /><br/>
					</div>
				</div><div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Korisnicko ime" type="text" name="korisnickoIme" required pattern="^[A-Za-z0-9]{6,}$" title="Korisnicko ime moze sadrzati samo slova i brojeve i imate najmanje 6 karaktera." /><br/>
					</div>
				</div><div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Sifra" type="password" name="sifra" required pattern="[A-Za-z0-9]{6,12}" title="Sifra mora imati izmedju 6 i 12 slova i/ili cifara" /><br/>
					</div>
				</div><div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Email" type="text" name="email" required pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" title="Nevalidna email adresa" /><br/>
					</div>
				</div><div class="row">
					<div class="col-md-12">
						<input class="form-control" placeholder="Broj telefona" type="text" name="brojTelefona" required pattern="^[0-9]{9,10}$" title="Neispravan broj telefona. Broj telefona mora imati 9 ili 10 cifara" /><br/>
					</div>
				</div><div class="row">
					<div class="col-md-12">
						<input class="form-control" type="submit" name="posalji" value="Registruj se" /><br/>
					</div>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
<%
	}
%>