<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.TablasNutricionalesCarne"%>
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
<script src="js/tablascarne.js" type="text/javascript" language="javascript"></script>
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
              ArrayList<TablasNutricionalesCarne> tablas = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
                  if(U.getRol()!= 'a'){
                      response.sendRedirect("panelvet.jsp");
                  }
                  else{
                      tablas = (ArrayList<TablasNutricionalesCarne>) request.getSession().getAttribute("tablas");
                      if (tablas == null) 
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
				<h2>Tablas nutricionales tipo c&aacute;rnico</h2>
				<hr>
				</div>
				<table id="reqnutricionales" class="gestion">
					<tr class="first-child">
                                                <td>Id</td>
						<td>Etapa</td>
						<td>Sexo</td>
						<td>Peso</td>
						<td>Ganancia</td>
						<td>Acciones</td>
					</tr>
                                        <% for(TablasNutricionalesCarne t: tablas){ %>
					<tr>
                                                <td><%=t.getId() %></td>
						<td><%=t.getEtapafisiologica() %></td>
						<td><%=t.getSexo() %></td>
						<td><%=t.getPeso() %></td>
						<td><%=t.getGanancia() %></td>
						<td>
							<select id="<%=t.getId() %>">
                                                                <option>Seleccione uno...</option>
								<option>Modificar</option>
							</select>
						</td>
					</tr>
                                        <% } %>
				</table>
			<!-- contenido de la pgina -->
                            
		         </div><!-- end #post -->
		</div> <!-- end #content -->
		<div id="sidebar">
			<div class="contenedorlistaadm">
				<ul>
  					<li><a href="paneladm.jsp">Home</a></li>
   					<li> <a href="listarusuarios.do">Usuarios</a></li>
  					 <li class="current"><a href="javascript:;" onclick="switchSubitem('contenedorsubitem2')">Tablas Nutricionales</a></li>
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
