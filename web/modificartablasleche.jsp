<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.TablasNutricionalesLeche"%>
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
<script src="js/tablasleche.js" type="text/javascript" language="javascript"></script>
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
              TablasNutricionalesLeche reg = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
                  if(U.getRol()!= 'a'){
                      response.sendRedirect("panelvet.jsp");
                  }
                  else{
                      reg = (TablasNutricionalesLeche) request.getSession().getAttribute("tablas");
                      if (reg == null) 
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
				<div id="modregform" class="formbox">
                                    <div class="titulo">
                                        <h2>Modificar registro nutricional</h2>
                                        <hr>
                                    </div>
                                    <form method="post" id="modregnutricional" action="modificarregistroleche.do?action=2">
                                        <input type="hidden" name="id" id="id" value="<%=reg.getId()%>"/> 
                                    <p>
                                        <label for="etapafisiologica">Etapa fisiol&oacute;gica</label>
                                        <input name="etapafisiologica" id="usuario" value="<%=reg.getEtapafisiologica() %>" class="validate[required,custom[onlyLetterSp],maxSize[50]]"/>
                                    </p>
                                    <p>
                                        <label for="sexo">Sexo</label>
                                        <input name="sexo" id="sexo" value="<%=reg.getSexo() %>" class="validate[required,maxSize[1]]"/>
                                    </p>
                                    <p>
                                        <label for="peso">Peso</label>
                                        <input name="peso" id="peso" value="<%=reg.getPeso() %>" class="validate[required,custom[number]"/>
                                    </p>
                                    <p>
                                        <label for="ganancia">Ganancia</label>
                                        <input name="ganancia" id="ganancia" value="<%=reg.getGanancia() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                     <p>
                                        <label for="cantalimento">Cantidad de alimento</label>
                                        <input name="cantalimento" id="cantalimento" value="<%=reg.getCantalimento() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="proteina">Prote&iacute;na</label>
                                        <input name="proteina" id="proteina" value="<%=reg.getProteina() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="ndt">NDT</label>
                                        <input name="ndt" id="ndt" value="<%=reg.getNdt() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="ed">ED</label><br/>
                                        <input name="ed" id="ed" value="<%=reg.getEd() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="em">EM</label><br/>
                                        <input name="em" id="em" value="<%=reg.getEm() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="enmant">Enmant</label>
                                        <input name="enmant" id="enmant" value="<%=reg.getEnmant() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                     <p>
                                        <label for="engan">Engan</label>
                                        <input name="engan" id="engan" value="<%=reg.getEngan() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                     <p>
                                        <label for="enlact">Enlact</label>
                                        <input name="enlact" id="enlact" value="<%=reg.getEngan() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="calcio">Calcio</label>
                                        <input name="calcio" id="calcio" value="<%=reg.getCalcio() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <label for="fosforo">F&oacute;sforo</label>
                                        <input name="fosforo" id="fosforo" value="<%=reg.getFosforo() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                     <p>
                                        <label for="vitaminaa">Vitamina A</label>
                                        <input name="vitaminaa" id="vitaminaa" value="<%=reg.getEngan() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                     <p>
                                        <label for="vitaminad">Vitamina D</label>
                                        <input name="vitaminad" id="vitaminad" value="<%=reg.getEngan() %>" class="validate[required,custom[number]]"/>
                                    </p>
                                    <p>
                                        <input type="submit" class="btn" value="Modificar registro"/>
                                        <input type="button" class="btn" value="Cancelar" onclick="window.location='cargarnecesidadesleche.do'"/>
                                    </p>
                                    </form>
                                </div>
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
