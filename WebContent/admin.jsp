<%@page import="database.ConnectionProvider"%>
<%@page import="javax.persistence.*" %>
<%@page import="model.Korisnik" %>
<%@page import="java.util.List" %>
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
<title>Admin</title>
</head>
<body>
	<%
		if(!(request.getSession().getAttribute("username") != null &&
				request.getSession().getAttribute("username").equals("admin")))
		{
			response.sendRedirect("login.jsp");
			return;
		}
		else
		{
			
		EntityManager em = ConnectionProvider.getConnection();
		String sql = "SELECT * FROM korisnik WHERE korisnickoIme not like 'admin'";
		@SuppressWarnings("unchecked")
		List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
		
		String tabelaStr = "";
		for(Korisnik k : lista)
		{
			tabelaStr += "<tr>";
			tabelaStr += "<th scope='row'>"+k.getId()+"</th>";
			tabelaStr += "<td>"+k.getIme()+"</td>";
			tabelaStr += "<td>"+k.getPrezime()+"</td>";
			tabelaStr += "<td>"+k.getKorisnickoIme()+"</td>";
			tabelaStr += "<td>"+k.getSifra()+"</td>";
			tabelaStr += "<td>"+k.getEmail()+"</td>";
			tabelaStr += "<td><i style='font-size:20px;color:black' class='fa fa-edit'></i></td>";
			tabelaStr += "<td><a href='ObrisiKorisnikaServlet?id="+k.getId()+"'><i style='font-size:20px;color:black' class='fa fa-trash-o'></i></td>";
			
			tabelaStr += "</tr>";
		}
	%>		
	
		<!-- MENU -->
		<ul>
		  <li><a href="pocetna.jsp">Pocetna</a></li>
		  <li><a class="active" href="admin.jsp">Korisnici</a></li>
		  <li><a href="adminChat.jsp">Pitanja korisnika</a></li>
		  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
  		  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
		</ul>
		
		<div class="container" style="margin:auto; width:700px;">
			<div class="row"><div class="col-md-12"></div></div>
			<div class="row">
				
				<div class="col-md-12"><h2>Spisak svih korisnika</h2>
			</div>
			<div class="row">
				
				<div class="col-md-12">
					<table class="table table-sm">
						<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Ime</th>
							<th scope="col">Prezime</th>
							<th scope="col">Korisnicko ime</th>
							<th scope="col">Lozinka</th>
							<th scope="col">Email</th>
							<th scope="col">Izmena</th>
							<th scope="col">Brisanje</th>
						</tr>
						</thead>
						<tbody>
							<%=tabelaStr %>
						</tbody>
					</table>
				</div>		
			</div>
		</div>
		</div>
		
	<%
		}
	%>
</body>
</html>
