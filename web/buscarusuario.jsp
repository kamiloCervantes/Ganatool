<%@page import="Objetos.Usuario"%>
<%@page import="java.util.ArrayList"%>
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

table.gestion{
	width: 100%;
	border: 1px solid #ccc;
	font-family: Arial, sans-serif;
	font-size: 16px;
	text-align: center;
}

table.gestion tr.first-child{
	background: #000;
	color: #fff;
	border: none;
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
               ArrayList<Usuario> userbuscado = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
                  if(U.getRol()!= 'a'){
                      response.sendRedirect("panelvet.jsp");
                  }
                }
                  else {
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
				<h2>Resultados de la B&uacute;squeda</h2>
				<hr>
				</div>
                            <div id="controles" class="controls">
                                <form action="buscarusuario.do" method="POST">
                                <input type="text" name="busq_param" id="busq_param" />
                                <input type="submit" value="Buscar"/>
                                </form>
                            </div>
                            <table id="usuarios" class="gestion">
					<tr class="first-child">
						<td>Usuario</td>
						<td>Nombre</td>
						<td>Apellidos</td>
						<td>Email</td>
						<td>Rol</td>
						<td>Acciones</td>
					</tr>
                                                                    <% 
                                        if (request.getSession().getAttribute("userbuscado") != null){
                                            userbuscado = (ArrayList<Usuario>) request.getSession().getAttribute("userbuscado");
                                            for(Usuario u: userbuscado){
                                         %>
				

					<tr>
						<td><%=u.getUsuario()%></td>
						<td><%=u.getNombre() %></td>
						<td><%=u.getApellidos() %></td>
						<td><%=u.getEMail() %></td>
						<td><%=u.getRol()%></td>
						<td>
							<select>
								<option>Modificar</option>
								<option>Eliminar</option>
							</select>
						</td>
					</tr>
                                                
                                        <% } %>
                                        </table>
                                        <%}
                                           else {         
                                        %>
                                        <h2>No hay resultados.</h2>
                                        <%
                                           }
                                        %>
			<!-- contenido de la pgina -->

		         </div><!-- end #post -->
		</div> <!-- end #content -->
		<div id="sidebar">
			<div class="contenedorlistaadm">
				<ul>
  					<li><a href="paneladm.jsp">Home</a></li>
   					<li class="current"> <a href="listarusuarios.do">Usuarios</a></li>
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
		<p>Desarrollado por: Jeyra Beltr&aacute;n Sierra | Camilo Cervantes Salazar | 
                Jes&uacute;s Miguel Herazo Hoyos<br/>&copy; 2012 Universidad de C&oacute;rdoba</p>
	</div><!-- end #footer -->
	</div> <!-- end #footer-bgcontent -->	
        <div id="mensajesAyuda">
	<div id="ayudaTitulo"></div>
	<div id="ayudaTexto"></div>
        </div>
</body>
</html>
