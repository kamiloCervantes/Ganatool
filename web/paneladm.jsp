<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Panel de Administraci&oacute;n @ GANATOOL</title>
<meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
<meta name="description" content="" />
<link href="images/favicon.ico" rel="SHORCUT ICON"/>
<link rel="stylesheet" type="text/css" href="style.css"/>
<link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css">
<link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print">
<script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" language="javascript">
onload=function()
{
	if(!NiftyCheck())
		return;
	Rounded("div.contenedorlistaadm","#FFF","#005e00","160px");
}
</script>
<style>
.titulo h2{
	margin: 0;
	padding: 0;
	font-family: Georgia, Arial, sans-serif;
	font-size: 32px;
}

.titulo hr{
	border: 1px solid green;
}

#menuadm{
	width: 100%;
	margin: 0;
	padding: 0;
	list-style: none;
	text-align: center;
	margin-top: 20px;
}

#menuadm li{
	padding: 5%;
	border: 1px dotted green;
	font-family: Arial, sans-serif;
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 10px;
	cursor: pointer;
}

#menuadm li#home{
	background: url('images/home.png') no-repeat 0px 20px, url('images/home.png') no-repeat 100% 20px;
	background-color: #fff;
	}

#menuadm li#users{
	background: url('images/users.png') no-repeat 0px 20px, url('images/users.png') no-repeat 100% 20px;
	background-color: #fff;
	}
	
#menuadm li#tablas{
	background: url('images/tablas.png') no-repeat 0px 20px, url('images/tablas.png') no-repeat 100% 20px;
	background-color: #fff;
	}

#menuadm li#salir{
	background: url('images/salir.png') no-repeat 0px 20px, url('images/salir.png') no-repeat 100% 20px;
	background-color: #fff;
	}

#menuadm li#home:hover, #menuadm li#users:hover, #menuadm li#tablas:hover, #menuadm li#salir:hover{
	background-color: #c4f6cf;
}
</style>
<script type="text/javascript">
//aparecer o desaparecer un subitem
function switchSubitem(item){
	subitem=document.getElementById(item);
		if(subitem.style.display=="block"){
			subitem.style.display="none";
}
		else{
			subitem.style.display="block";}
}
</script>
<%
              Usuario U = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
</head>
<body>
	<div id="header-admin">
		<div id="logo-user">
			<table>
				<tr>
					<td><h1><a href="#">Ganatool </a></h1></td>
					<td class="mid"><h2>Herramienta para realizar balanceo de dietas de ganado vacuno</h2></td>
					<td id="conexion"><a href="perfil.jsp">username</a></td>
				</tr>
			</table>
		</div> <!-- end #logo-user -->
	</div> <!-- end #header -->
	<div id="page">
		<div id="content">
			<div class="post">
			<div class="titulo">
				<h2>Panel de administraci&oacute;n del sistema</h2>
				<hr>
				</div>
			<ul id="menuadm">	
				<li id="home">Home</li>
				<li id="users" onclick="window.location='listarusuarios.do'">Usuarios</li>
				<li id="tablas">Tablas Nutricionales</li>
				<li id="salir">Salir</li>
				</ul>

		         </div><!-- end #post -->
		</div> <!-- end #content -->
		<div id="sidebar">
			<div class="contenedorlistaadm">
				<ul>
  					<li class="current"><a href="paneladm.jsp">Home</a></li>
   					<li> <a href="listarusuarios.do">Usuarios</a></li>
  					 <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem2')">Tablas Nutricionales</a></li>
   				<div id="contenedorsubitem2">
					<ul>
   						<li> <a href="#">Tabla nutricional leche</a></li>
   						<li> <a href="#"></a>Tabla nutricional carne</li>
 					</ul>
   				</div>
					<li><a href="cerrarsesion.do">Salir del sistema</a></li>
 				</ul>
			</div>
                <img src="images/apoyo.jpg" width="177" height="45" />
		<table width="180" border="0" cellspacing="1">
			<tr>
    				<td align="center"><a href="http://www.unicordoba.edu.co"><img src="images/logou.jpg" alt="" width="100" height="138" /></a></td>
			</tr>
      			<tr>
      				<td align="center"><img src="images/socrates.jpg" alt="" width="84" height="112" /></td>
			</tr>
		</table>
       		</div><!-- end #sidebar -->
		<div style="clear: both;">&nbsp;</div>
	</div><!-- end #page -->
	<div id="footer-bgcontent-adm">
		<div id="footer-adm">
		<p>Copyright (c) 2010 Grupo 64 bits Dise&ntilde;o por FCT y Kamilo Cervantes
	<br>Desarrollado por: Jeyra Beltr&aacute;n Sierra | Camilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>	
	</div><!-- end #footer -->
	</div> <!-- end #footer-bgcontent -->	
        <div id="mensajesAyuda">
	<div id="ayudaTitulo"></div>
	<div id="ayudaTexto"></div>
        </div>
</body>
</html>
