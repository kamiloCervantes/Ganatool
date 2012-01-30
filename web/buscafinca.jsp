<%@page import="Objetos.Finca"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Buscar finca @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="style-jsp.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script type="text/javascript" language="javascript">
   onload=function()
   {
    if(!NiftyCheck())
     return;
    Rounded("div.contenedorlista","#FFF","#115599","160px");
    RoundedTop("div#global-actions","#FFF","#112cab");
   }
    
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
              ArrayList<Finca> fincas = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
 </head>
 <body>
  <div id="header-user">
   <div id="logo-user">
    <table>
     <tr>
      <td><h1><a href="#">Ganatool </a></h1></td>
      <td class="mid"><h2>Herramienta para realizar balanceo de dietas de ganado vacuno</h2></td>
      <td id="logout"><a href="cerrarsesion.do">Salir</a></td>
      <td id="conexion"><a href="perfil.jsp"><%=U.getUsuario()%></a></td>
     </tr>
    </table>
   </div> <!-- end #logo-user -->
  </div> <!-- end #header -->
  <div id="page">
   <div id="content">
    <div class="post">
     <div id="global-actions">
      <table>
       <tr id="acciones">
        <td><a href="listarfincas.do">Listar fincas</a></td>
        <td><a href="agregafinca.jsp">Agregar finca</a></td>
        <td class="current"><a href="buscafinca.jsp">Buscador de fincas</a></td>
       </tr>
      </table>
     </div><!-- end div#global-actions -->
     <div id="fincas-banner"></div>
     <div class="subsecciones">Buscar Finca</div>
     <form action="buscarfinca.do" method="post">
      <div id="buscador-main" align="center">
       <table>
        <tr>
         <td><input type="text" name="parametrobusqueda"/></td><td><input id="buscarbtn" type="submit" value="Buscar"/></td>
        </tr>
       </table>
       <table>
        <tr class="opcionesbusqueda">
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="nombre" checked="checked"/>Buscar por nombre</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="nit" />Buscar por nit</td>
        </tr>
        <tr class="opcionesbusqueda">
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="municipio" />Buscar por municipio</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="nombreprop" />Buscar por propietario</td>
        </tr>
       </table>
      </div>
     </form>
     <% if (request.getSession().getAttribute("resultadoFincas") != null) {%>
     <% fincas = (ArrayList<Finca>) request.getSession().getAttribute("resultadoFincas");%>
     <% request.getSession().removeAttribute("resultadoFincas");%>
     <% if (fincas.size() == 0) {%>
     <p class="msgok">No se han encontrado resultados.</p>
     <% } else {%>
     <div id="resultados">
      <div id="resultados-info">
       <table>
        <tr>
         <td>Resultados de la b&uacute;squeda</td>
         <td>&nbsp;</td>
         <td>Total de resultados: <%=fincas.size()%></td>
        </tr>
       </table>
      </div>
      <% for (int i = 0; i < fincas.size(); i++) {%>
      <% Finca F = fincas.get(i);%>
      <table class="finca">
       <tbody>
        <tr>
         <%
              String foto = F.getFoto();
              if (foto == null || foto.equals("")) {
                  foto = "images/imagenfinca.png";
              }
         %>
         <td class="img-finca"><img src="<%=foto%>" width="127" height="88" /></td>
         <td class="data-finca">
          <ul>
           <li class="titulo"><%=F.getNombre()%></li>
           <li class="subtitulo"><%=F.getDepartamento()%>, <%=F.getMunicipio()%></li>
           <li><b>NIT: </b><%=F.getNit()%></li>
           <li><b>Direcci&oacute;n: </b><%=F.getDireccion()%></li>
           <li><b>Propietario: </b><%=F.getNombreProp()%>, <%=F.getTipoDocProp()%> <%=F.getCcProp()%></li>
           <%
                String tel = "-";
                if (F.getTelProp() != 0) {
                    tel = F.getTelProp() + "";
                }
           %>
           <li><b>Tel&eacute;fono: </b><%=tel%></li>
          </ul>
         </td>
         <td class="actions-finca">
          <ul>
           <li><a href="detallesfinca.do?id=<%=F.getNit()%>">Ver detalles</a></li>
           <li><a href="modificarfinca.jsp?id=<%=F.getNit()%>">Modificar finca</a></li>
           <li><a href="javascript:;" onclick="confirmarAccionEliminarFinca('<%=F.getNit()%>')">Eliminar finca</a></li>
          </ul>
         </td>
        </tr>
       </tbody>
      </table>
      <%
           }
      %>
     </div>
     <%
                     }
                 }
     %>
    </div>
    <!-- end #post -->
   </div> <!-- end #content -->
   <div id="sidebar">
    <div class="contenedorlista">
     <ul>
      <li><a href="panelvet.jsp">Home</a></li>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem1')">Tareas frecuentes</a></li>
      <div id="contenedorsubitem1">
       <ul>
        <li><a href="nuevares.do">Ingresar res</a></li>
        <li><a href="agregaingrediente.jsp">Ingresar ingrediente</a></li>
        <li><a href="generardieta.do">Generador de dieta</a> </li>
       </ul>
      </div>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem6')">Mi perfil</a></li>
      <div id="contenedorsubitem6">
       <ul>
        <li><a href="perfil.jsp">Ver mi perfil</a></li>
        <li><a href="modificarperfil.jsp">Modificar perfil</a></li>
        <li><a href="modificarcuenta.jsp">Modificar cuenta</a></li>
       </ul>
      </div>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem2')">Fincas</a></li>
      <div id="contenedorsubitem2">
       <ul>
        <li><a href="listarfincas.do">Listado de fincas</a></li>
        <li><a href="agregafinca.jsp">Agregar finca</a></li>
        <li><a href="buscafinca.jsp">Buscador de fincas</a></li>
       </ul>
      </div>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem3')">Ingredientes</a></li>
      <div id="contenedorsubitem3">
       <ul>
        <li><a href="listaringredientes.do">Listado de ingredientes</a></li>
        <li><a href="agregaingrediente.jsp">Agregar ingrediente</a></li>
        <li><a href="buscaingrediente.jsp">Buscador de ingredientes</a></li>
       </ul>
      </div>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem4')">Dietas</a></li>
      <div id="contenedorsubitem4">
       <ul>
        <li><a href="listardietas.do">Listado de dietas</a></li>
        <li><a href="generardieta.do">Generador de dietas</a></li>
        <li><a href="buscadieta.jsp">Buscador de dietas</a></li>
       </ul>
      </div>
      <li><a href="javascript:;" onclick="switchSubitem('contenedorsubitem5')">Ganado</a></li>
      <div id="contenedorsubitem5">
       <ul>
        <li><a href="listarreses.do">Listado de animales</a></li>
        <li><a href="nuevares.do">Agregar res</a></li>
        <li><a href="buscares.jsp">Buscador de reses</a></li>
       </ul>
      </div>
      <li><a href="cerrarsesion.do">Salir del sistema</a></li>
     </ul>
    </div>
    <img src="images/apoyo.jpg" width="177" height="45" />
    <table width="180" border="0" cellspacing="1">
     <tr>
      <td align="center"><a href="http://www.unicordoba.edu.co"><img src="images/logou.jpg" border="0" width="100" height="138" /></a></td>
     </tr>
     <tr>
      <td align="center"><a href="http://www.unicordoba.edu.co/grupos/socrates/semillero.html"><img src="images/socrates.jpg" border="0" width="84" height="112" /></a></td>
     </tr>
    </table>
   </div><!-- end #sidebar -->
   <div style="clear: both;">&nbsp;</div>
  </div><!-- end #page -->
  <div id="footer-bgcontent">
   <div id="footer">
    <p>Copyright (c) 2010 Grupo 64 bits Dise&ntilde;o por FCT y Kamilo Cervantes
     <br />Desarrollado por: Jeyra Beltr&aacute;n Sierra | Kamilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <div id="mensajesAyuda">
   <div id="ayudaTitulo"></div>
   <div id="ayudaTexto"></div>
  </div>
 </body>
</html>
