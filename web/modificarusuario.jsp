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
					<td id="conexion"><a href="perfil.jsp"><%=U.getUsuario()%></a></td>
				</tr>
			</table>
		</div> <!-- end #logo-user -->
	</div> <!-- end #header -->
	<div id="page">
		<div id="content">
			<div class="post">
				<div class="titulo">
				<h2>Modificar usuario</h2>
				<hr>
                                </div>
			
			<!-- contenido de la pgina -->
                            <% 
                                if (request.getSession().getAttribute("user_mod") != null){
                                    Usuario mod = (Usuario) request.getSession().getAttribute("user_mod"); %>
                             
                                <div id="moduserform" class="formbox">
                                    <form method="post" id="modificarusuario" name="modificarusuario" action="modificarusuario.do?action=2">
                                        <input name="usuario" id="usuario" type="hidden" value="<%=mod.getUsuario() %>"
                                    <p>
                                        <label for="password">Contrase&ntilde;a</label>
                                        <input name="password" id="password" value="<%=mod.getPassword()%>" class="validate[required,maxSize[20]]"/>
                                    </p>
                                    <p>
                                        <label for="email">Email</label>
                                        <input name="email" id="email" value="<%=mod.getEMail()%>" class="validate[required,custom[email],maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="nombre">Nombre</label>
                                        <input name="nombre" id="nombre" value="<%=mod.getNombre()%>" class="validate[required,custom[onlyLetterSp],maxSize[50]]"/>
                                    </p>
                                     <p>
                                        <label for="apellidos">Apellidos</label>
                                        <input name="apellidos" id="apellidos" value="<%=mod.getApellidos()%>" class="validate[required,custom[onlyLetterSp],maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="tipodoc">Tipo de documento</label>
                                        <select name="tipodoc" id="tipodoc">
                                            <option value="<%=mod.getTipoDoc()%>">Seleccione uno...</option>
                                            <option value="RC">Registro civil</option>
                                            <option value="TI">Tarjeta de identidad</option>
                                            <option value="CC">Cedula de ciudadania</option>
                                            <option value="CE">Cedula de extranjeria</option>
                                            <option value="OO">Otro...</option>
                                        </select>
                                    </p>
                                    <p>
                                        <label for="nrodoc">N&uacute;mero de documento</label>
                                        <input name="nrodoc" id="nrodoc" value="<%=mod.getNroDoc() %>" class="validate[required,custom[onlyNumberSp]]"/>
                                    </p>
                                    <p>
                                        <label for="pregunta">Pregunta de seguridad</label>
                                        <input name="pregunta" id="pregunta" value="<%=mod.getPregunta() %>" class="validate[required,maxSize[100]]"/>
                                    </p>
                                    <p>
                                        <label for="respuesta">Respuesta</label>
                                        <input name="respuesta" id="respuesta" value="<%=mod.getRespuesta()%>" class="validate[required,maxSize[20]]"/>
                                    </p>
                                    <p>
                                        <label for="foto">Imagen de perfil</label>
                                        <input name="foto" type="file" id="pregunta" value=""/>
                                    </p>
                                    <p>
                                        <label for="direccion">Direcci&oacute;n</label>
                                        <input name="direccion" id="direccion" value="<%=mod.getDireccion()%>" class="validate[optional,maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="telefono">Tel&eacute;fono</label>
                                        <input name="telefono" id="telefono" value="<%=mod.getTelefono()%>" class="validate[optional,custom[onlyNumberSp]]"/>
                                    </p>
                                     <p>
                                        <label for="fechanac">Fecha de nacimiento</label>
                                        <input name="fechanac" id="fechanac" value="<%=mod.getFechaNac()%>" class="validate[optional,custom[date],past[1999-12-31]]"/>
                                    </p>
                                    <p>
                                        <label for="sexo">Sexo</label>
                                        <select name="sexo" id="sexo">
                                            <option value="<%=mod.getSexo()%>">Seleccione uno...</option>
                                            <option value="M">Masculino</option>
                                            <option value="F">Femenino</option>
                                        </select>
                                    </p>
                                    <p>
                                        <input type="submit" class="btn" value="Modificar usuario"/>
                                        <input type="button" class="btn" value="Cancelar" onclick="window.location='listarusuarios.do'"/>
                                    </p>
                                    </form>
                                </div>
                            <%     
                                    }
                            %>
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
