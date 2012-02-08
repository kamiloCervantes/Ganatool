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
<link rel="stylesheet" type="text/css" href="js/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<link rel="stylesheet" href="validationEngine.jquery.css" type="text/css"/>
<script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
<script src="js/jquery-1.7.1.min.js" type="text/javascript" language="javascript"></script>
<script type="text/javascript" src="js/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
<script type="text/javascript" src="js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script src="js/users.js" type="text/javascript" language="javascript"></script>
<script src="js/jquery.validationEngine-es.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
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

#controles form{
    display: inline;
}

.formbox{
    width: 600px;
    height: 500px;
    overflow-x: hidden;
    overflow-y:scroll;
}

.formbox label{
    font-family: Arial, sans-serif;
    font-size: 16px;
}

.formbox input,.formbox select{
    width: 550px;
}

.formbox input.btn{
    width: auto;
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
              ArrayList<Usuario> users = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
                  if(U.getRol()!= 'a'){
                      response.sendRedirect("panelvet.jsp");
                  }
                  else{
                      if (request.getSession().getAttribute("users") != null) 
                      users = (ArrayList<Usuario>) request.getSession().getAttribute("users");
                   else 
                      response.sendRedirect("paneladm.jsp");
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
                                        <td id="conexion"><a href="#"><%=U.getUsuario()%></a></td>
				</tr>
			</table>
		</div> <!-- end #logo-user -->
	</div> <!-- end #header -->
	<div id="page">
		<div id="content">
			<div class="post">
				<div class="titulo">
				<h2>Gesti&oacute;n de usuarios</h2>
				<hr>
				</div>
                            <div id="controles" class="controls">
                               <a id="adduser" href="#adduserform">Nuevo usuario</a>              
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
                                        <% for(Usuario u: users){ %>
					<tr>
						<td><%=u.getUsuario()%></td>
						<td><%=u.getNombre() %></td>
						<td><%=u.getApellidos() %></td>
						<td><%=u.getEMail() %></td>
						<td><%=u.getRol()%></td>
						<td>
							<select id="<%=u.getUsuario()%>">
                                                                <option>Seleccione uno...</option>
								<option>Modificar</option>
								<option>Eliminar</option>
							</select>
						</td>
					</tr>
                                        <% } %>
				</table>
			<!-- contenido de la pgina -->
                            <div style="display: none;">
                                <div id="adduserform" class="formbox">
                                    <div class="titulo">
                                        <h2>Nuevo usuario</h2>
                                        <hr>
                                    </div>
                                    <form method="post" id="agregarusuario" action="agregarusuario.do">
                                    <p>
                                        <label for="usuario">Nombre de usuario</label>
                                        <input name="usuario" id="usuario" value="" class="validate[required,custom[onlyLetterNumber],maxSize[20]]"/>
                                    </p>
                                    <p>
                                        <label for="password">Contrase&ntilde;a</label>
                                        <input name="password" type="password" id="password" value="" class="validate[required,maxSize[20]]"/>
                                    </p>
                                    <p>
                                        <label for="email">Email</label>
                                        <input name="email" id="email" value="" class="validate[required,custom[email],maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="nombre">Nombre</label>
                                        <input name="nombre" id="nombre" value="" class="validate[required,custom[onlyLetterSp],maxSize[50]]"/>
                                    </p>
                                     <p>
                                        <label for="apellidos">Apellidos</label>
                                        <input name="apellidos" id="apellidos" value="" class="validate[required,custom[onlyLetterSp],maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="tipodoc">Tipo de documento</label>
                                        <select name="tipodoc" id="tipodoc">
                                            <option value="CC">Seleccione uno...</option>
                                            <option value="RC">Registro civil</option>
                                            <option value="TI">Tarjeta de identidad</option>
                                            <option value="CC">Cedula de ciudadania</option>
                                            <option value="CE">Cedula de extranjeria</option>
                                            <option value="OO">Otro...</option>
                                        </select>
                                    </p>
                                    <p>
                                        <label for="nrodoc">N&uacute;mero de documento</label>
                                        <input name="nrodoc" id="nrodoc" value="" class="validate[required,custom[onlyNumberSp]]"/>
                                    </p>
                                    <p>
                                        <label for="pregunta">Pregunta de seguridad</label>
                                        <input name="pregunta" id="pregunta" value="" class="validate[required,maxSize[100]]"/>
                                    </p>
                                    <p>
                                        <label for="respuesta">Respuesta</label>
                                        <input name="respuesta" id="respuesta" value="" class="validate[required,maxSize[20]]"/>
                                    </p>
                                    <p>
                                        <label for="foto">Imagen de perfil</label>
                                        <input name="foto" type="file" id="pregunta" value=""/>
                                    </p>
                                    <p>
                                        <label for="direccion">Direcci&oacute;n</label>
                                        <input name="direccion" id="direccion" value="" class="validate[optional,maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="telefono">Tel&eacute;fono</label>
                                        <input name="telefono" id="telefono" value="" class="validate[optional,custom[onlyNumberSp]]"/>
                                    </p>
                                     <p>
                                        <label for="fechanac">Fecha de nacimiento</label>
                                        <input name="fechanac" id="fechanac" value="" class="validate[optional,custom[date],past[1999-12-31]]"/>
                                    </p>
                                    <p>
                                        <label for="sexo">Sexo</label>
                                        <select name="sexo" id="sexo">
                                            <option>Seleccione uno...</option>
                                            <option value="M">Masculino</option>
                                            <option value="F">Femenino</option>
                                        </select>
                                    </p>
                                    <p>
                                        <input type="submit" class="btn" value="Agregar usuario"/>
                                        <input type="button" class="btn" value="Cancelar" onclick="window.location='listarusuarios.do'"/>
                                    </p>
                                    </form>
                                </div>
                            </div>
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
   						<li> <a href="cargarnecesidadesleche.do">Tabla nutricional leche</a></li>
   						<li> <a href="cargarnecesidadescarne.do">Tabla nutricional carne</a></li>
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
