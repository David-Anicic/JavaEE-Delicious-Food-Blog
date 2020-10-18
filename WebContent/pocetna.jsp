<%@page import="database.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.List"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="model.Recept"%>
<%@page import="model.Slike"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="main.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<title>Pocetna</title>
</head>
<body>
	<!-- MENU -->
	<ul>
	  <li><a class="active" href="pocetna.jsp">Pocetna</a></li>
	  <% if(request.getSession().getAttribute("username") != null &&
	  			request.getSession().getAttribute("username").toString().equals("admin")) { %>
	  	  <li><a href="admin.jsp">Korisnici</a></li>
	  	  <li><a href="pitanja.jsp">Pitanja korisnika</a></li>
	  <% } else if (request.getSession().getAttribute("username") != null) { %>
	  	  <li><a href="napraviRecept.jsp">Napravi novi recept</a></li>
	  	  <li><a href="pitanja.jsp">Postavi pitanje</a></li>
	  <% } %>
	  <% if(request.getSession().getAttribute("username") == null) { %>
		  <li class="auth"><a href="login.jsp">Prijava</a></li>
		  <li class="auth"><a href="registracija.jsp">Registracija</a></li>
	  <% } else { %>
		  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
  		  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
	  <% } %>
	</ul>

	<%
	EntityManager em = ConnectionProvider.getConnection();
	String sql = "SELECT * FROM recept";
	List<Recept> recepti = em.createNativeQuery(sql, Recept.class).getResultList();
	
	sql = "SELECT * FROM slike";
	List<Slike> slike = em.createNativeQuery(sql, Slike.class).getResultList();
	
	for(Recept r : recepti)
	{
		String urlSlike = "images/";
		for(Slike s : slike)
		{
			if(r.getId() == s.getIdRecepta())
			{
				urlSlike += s.getNazivSlike();
				break;
			}
		}
		
		if(urlSlike.equals("images/"))
			urlSlike += "default.jpg";
		
	%>

	

	<div class="row" style="padding:4px;border:1px solid gray;margin:auto; border-radius: 5px;width:50%;">
					<div class="col-md-5" style="float:left;">
						<img style="height: 250px; width: 320px;" src="<%=urlSlike %>">
					</div>
					<div class="col-md-7" style="float:left;">
						<a href="detaljanPregled.jsp?idRecepta=<%=r.getId() %>"><h2 style="margin-left:150px;"><%= r.getNaziv()  %></h2></a>
						<br>
						<span style="margin-left:150px;"><%= r.getOpis() %></span>
					</div>
			</div><br><br>
	
	<%
	}
	
	
	%>
</body>
</html>