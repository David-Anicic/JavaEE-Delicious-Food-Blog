<%@page import="bean.Prijava"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="util.Util"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.Socket"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.Korisnik"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.EntityManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Postavi pitanje</title>
<link rel="stylesheet" type="text/css" href="main.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<%
	if(request.getSession().getAttribute("username") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	
	String logovaniUser = request.getSession().getAttribute("username").toString();
	
	if(request.getSession().getAttribute("bw")==null){
		Socket socketKlijent = new Socket(InetAddress.getByName("localhost"),9090);
		BufferedReader br = Util.getBuffredReader(socketKlijent);
		BufferedWriter bw = Util.getBuffredWriter(socketKlijent);
		request.getSession().setAttribute("bw", bw);
		request.getSession().setAttribute("br", br);
		Prijava p=new Prijava(logovaniUser);
		bw.write(Util.getXmlFromObject(p));
		bw.flush();
	}

	
%>
	<!-- MENU -->
	<ul>
	  <li><a href="pocetna.jsp">Pocetna</a></li>
  	  <li><a href="napraviRecept.jsp">Napravi novi recept</a></li>
  	  <li><a class="active" href="pitanja.jsp">Postavi pitanje</a></li>
	  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
	  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
	</ul>
	
	<div class="containter">
	<div class="row"><div class="col-md-12"></div></div>
		<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-8"><h2>Postavi pitanje adminu</h2><br></div>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-6">
				<ul id="chatLista" class="list-group">
					<li id="oblacicPoruke" style='height:500px; overflow-y:scroll' style='cursor: pointer' class='list-group-item d-flex justify-content-between align-items-center'>
					</li>
					<li style='cursor: pointer' class='list-group-item d-flex justify-content-between align-items-center'>
					<input type='text' style='width:430px; padding:5px' id='poruka'><button style='float: right; padding:5px; width:80px' onclick="posaljiPoruku()">Posalji</buton>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>

<script>

var posiljalac="<%= logovaniUser %>";

function posaljiPoruku() 
{
	var tekst=document.getElementById("poruka").value;
	
	if(tekst!="")
	{
		$.ajax({
			type: 'POST',
			url: 'ChatServlet',
			data: 'zahtev=write&poruka='+tekst+'&posiljalac='+posiljalac+'&primalac=admin',
			success: function (data) {
				//console.log('Pisanje adminu: ' + data);
				document.getElementById("oblacicPoruke").innerHTML+="<div style='overflow:auto'><div style='float: right; border-radius:10px; background-color:gray; padding:10px; margin:5px'>"+tekst+"</div></div>";
				document.getElementById("poruka").value="";
			}
		});	
	}
	
}

function primiPoruku()
{
	$.ajax({
		type: 'POST',
		url: 'ChatServlet',
		data: 'zahtev=read',
		success: function (data) {
			//console.log('Primanje poruke gotovo: '+data);
			var por=data.split("&&")[1];
			document.getElementById("oblacicPoruke").innerHTML+="<div style='overflow:auto'><div style='float: left; border-radius:10px; background-color:lightgray; padding:10px; margin:5px'>"+por+"</div></div>";
			primiPoruku();
		}
	});
}

function osveziPrikaz()
{
	$.ajax({
		type: 'POST',
		url: 'ChatServlet',
		data: 'zahtev=getPoruke&kor1=admin&kor2='+posiljalac,
		success: function (data) {
			//console.log('Get poruke: ' + data);
			var str = "";
			var niz=data.split("&&");
			
			for(var i=0;i<niz.length-1;i++){
				var noviNiz=niz[i].split("&");
				if(noviNiz[0]=="1")
					str+="<div style='overflow:auto'><div style='float: left; border-radius:10px; background-color:lightgray; padding:10px; margin:5px'>"+noviNiz[2]+"</div></div>";
				else
					str+="<div style='overflow:auto'><div style='float: right; border-radius:10px; background-color:gray; padding:10px; margin:5px'>"+noviNiz[2]+"</div></div>";
			}
			
			document.getElementById("oblacicPoruke").innerHTML=str;
		}
	});
}



primiPoruku();
osveziPrikaz();

</script>
</html>