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
<title>Login</title>
</head>
<body>
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
	  <li class="auth"><a class="active" href="login.jsp">Prijava</a></li>
	  <li class="auth"><a href="registracija.jsp">Registracija</a></li>
	</ul>

	<%
	String greska = "";
	if(request.getSession().getAttribute("greska") != null)
		greska= request.getSession().getAttribute("greska").toString();
	%>
	
	<div>
		<h4 style="color:red"><%= greska %></h4>
		<%
			if(request.getSession().getAttribute("greska") != null)
				request.getSession().setAttribute("greska", null);
		%>
		<div class="container" style="margin:auto; width:500px;">
		<form action="LoginServlet" method="get">
		<div class="row"><div class="col-md-12"><br></div></div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
					  <label for="usr">Korisnicko ime:</label>
					  <input class="form-control" placeholder="Korisnicko ime" required type="text" name="korisnickoIme">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
					  <label for="usr">Lozinka:</label>
					  <input class="form-control" placeholder="Lozinka" required type="password" name="sifra">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<button class="form-control" type="submit">Prijavi se</button>
					</div>
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