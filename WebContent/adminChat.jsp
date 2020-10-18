<%@page import="bean.Prijava"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="util.Util"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.Socket"%>
<%@page import="model.Korisnik"%>
<%@page import="database.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.EntityManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pitanja korisnika</title>
<link rel="stylesheet" type="text/css" href="main.css">
<link rel="stylesheet" type="text/css" href="Chat.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<style>
.my-active{
	color:white;
	background-color:lightgray;
}
</style>
</head>
<body>
<%
	if(request.getSession().getAttribute("username") == null || !request.getSession().getAttribute("username").equals("admin"))
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

	EntityManager em = ConnectionProvider.getConnection();
	String sql = "select * from korisnik where korisnickoIme not like 'admin'";
	@SuppressWarnings("unchecked")
	List<Korisnik> lista = em.createNativeQuery(sql, Korisnik.class).getResultList();
	String listaKorisnika="";
	for(Korisnik k: lista)
	{
		listaKorisnika+="<li id='"+k.getKorisnickoIme()+"' onclick='popuniChat(this)' style='cursor: pointer' class='list-group-item d-flex justify-content-between align-items-center'>"+k.getKorisnickoIme()+"</li>";
		
	}
	//<span class='badge badge-primary badge-pill'>14</span>
%>

<!-- MENU -->
		<ul>
		  <li><a href="pocetna.jsp">Pocetna</a></li>
		  <li><a class="active" href="admin.jsp">Korisnici</a></li>
		  <li><a href="adminChat.jsp">Pitanja korisnika</a></li>
		  <li class="auth"><a href="LogoutServlet">Izloguj se</a></li>
  		  <li class="auth"><a href="mojprofil.jsp">Moj profil</a></li>
		</ul>
		
<div class="container">
<div class="row"><div class="col-md-12"></div></div>
	<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-9"><h2>Pitanja korisnika</h2><br></div>
	</div>
<div class="row">
<div class="col-md-3"></div>
<div class="col-md-3">
	<ul id='listaKorisnika' class="list-group">
	  <%=listaKorisnika %>
	</ul>
</div>
<div class="col-md-6">
	<ul id="chatLista" class="list-group">
	
	</ul>
</div>
</div>
</div>

<script>

var selektovanKorisnik="";
function popuniChat(elem_li)
{
	var elem=document.getElementById("chatLista");
	elem.innerHTML="<li id='oblacicPoruke' style='height:500px; overflow-y:scroll' style='cursor: pointer' class='list-group-item d-flex justify-content-between align-items-center'></li><li style='cursor: pointer' class='list-group-item d-flex justify-content-between align-items-center'><input type='text' style='width:430px; padding:5px' id='poruka'><button style='float: right; padding:5px; width:80px' onclick='posaljiPoruku()'>Posalji</buton></li>"
	
	var listaKorisnika=document.getElementById("listaKorisnika");
	$("#listaKorisnika>li").each(function(){
		$(this).removeClass("my-active");
	});
	
	elem_li.classList.add("my-active");
	selektovanKorisnik=elem_li.id;
	//console.log("sel kor: "+selektovanKorisnik);
	
	osveziPrikaz();
	
}

function osveziPrikaz()
{
	$.ajax({
		type: 'POST',
		url: 'ChatServlet',
		data: 'zahtev=getPoruke&kor1=admin&kor2='+selektovanKorisnik,
		success: function (data) {
			//console.log('Get poruke: ' + data);
			var str = "";
			var niz=data.split("&&");
			
			for(var i=0;i<niz.length-1;i++){
				var noviNiz=niz[i].split("&");
				if(noviNiz[0]!="1")
					str+="<div style='overflow:auto'><div style='float: left; border-radius:10px; background-color:lightgray; padding:10px; margin:5px'>"+noviNiz[2]+"</div></div>";
				else
					str+="<div style='overflow:auto'><div style='float: right; border-radius:10px; background-color:gray; padding:10px; margin:5px'>"+noviNiz[2]+"</div></div>";
			}
			
			document.getElementById("oblacicPoruke").innerHTML=str;
		}
	});
}

function posaljiPoruku() 
{
	var tekst=document.getElementById("poruka").value;
	if(tekst!="")
	{
		$.ajax({
			type: 'POST',
			url: 'ChatServlet',
			data: 'zahtev=write&poruka='+tekst+'&posiljalac=admin&primalac='+selektovanKorisnik,
			success: function (data) {
				//console.log('Pisanje adminu: ' + data);
				document.getElementById("oblacicPoruke").innerHTML+="<div style='overflow:auto'><div style='float: right; border-radius:10px; background-color:gray; padding:10px; margin:5px'>"+tekst+"</div></div>";
				document.getElementById("poruka").value="";
				//osveziPrikaz();
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
			console.log("uslo u funkciju primiPoruku na adminChatu");
			if(data[0]=='&' && data[1]=='&')
			{
				
				console.log("primljena lista korisnika na AdminChat-u:"+data);
				var niz=data.split('&&');
				$("#listaKorisnika>li").each(function(){
					var b=0;
					var i;
					console.log($(this));
					console.log($(this)[0].id);
					for(i=1;i<niz.length-1;i++){
						if($(this)[0].id==niz[i])
						{
							b=1;
							break;
						}
					}
					if(b==1)
						$(this).html(niz[i]+"<div style='background-color:green;border-radius:50%;float:right;width:10px;height:10px;margin-top:5px'></div>");
					else
						$(this).html($(this)[0].id);
				});
				//for(var i=1;i<niz.length-1;i++){
					//if(document.getElementById(niz[i])){
						//document.getElementById(niz[i]).innerHTML=niz[i]+"<span class='badge badge-primary badge-pill'>14</span>";
					//}
				//}
					
			}
			else
			{
				console.log("primljena poruka na AdminChat-u:"+data);
				var posiljalac=data.split("&&")[0];
				var por=data.split("&&")[1];
				if(document.getElementById("oblacicPoruke") && selektovanKorisnik==posiljalac)
					document.getElementById("oblacicPoruke").innerHTML+="<div style='overflow:auto'><div style='float: left; border-radius:10px; background-color:lightgray; padding:10px; margin:5px'>"+por+"</div></div>";	
			}
			primiPoruku();
		}
	});
}

primiPoruku();

</script>

</body>
</html>