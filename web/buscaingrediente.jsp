<%@page import="Objetos.Ingrediente"%>
<%@page import="Objetos.Usuario"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Ingredientes @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="style-jsp.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script type="text/javascript" language="javascript">
   function switchFileColor(){
    var color=false;
    tabla = document.getElementById('lista-ingredientes');
    for (i=0; ele = tabla.getElementsByTagName('tr')[i]; i++) {
     ele.style.background = (color) ? 'white' : '#77e4f9';
     color = !color;
    }
   }
   onload=function()
   {
    if(!NiftyCheck())
     return;
    Rounded("div.contenedorlista","#FFF","#115599","160px");
    RoundedTop("div#ingredientes-actions","#FFF","#112cab");
    switchFileColor();
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
              ArrayList<Ingrediente> ingredientes = null;
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
     <div id="ingredientes-actions">
      <table>
       <tr id="acciones">
        <td><a href="listaringredientes.do">Listar ingredientes</a></td>
        <td><a href="agregaingrediente.jsp">Agregar ingrediente</a></td>
        <td class="current"><a href="buscaingrediente.jsp">Buscador de ingredientes</a></td>
       </tr>
      </table>
     </div>
     <div id="ingredientes-banner"></div>
     <div class="subsecciones">Buscar Ingredientes</div>
     <div id="buscador-main" align="center">
      <form action="buscaringrediente.do" method="post">
       <table>
        <tr>
         <td><input type="text" name="parametrobusqueda"/></td><td><input id="buscarbtn" type="submit" value="Buscar"/></td>
        </tr>
       </table>
       <table>
        <tr class="opcionesbusqueda">
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="nombre" checked="checked"/>Buscar por nombre</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="proveedor" />Buscar por proveedor</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="codigo" />Buscar por c&oacute;digo</td>
        </tr>
       </table>
      </form>
     </div>
     <%
                 if (request.getSession().getAttribute("resultadoIngredientes") != null) {
                     ingredientes = (ArrayList<Ingrediente>) request.getSession().getAttribute("resultadoIngredientes");
                     request.getSession().removeAttribute("resultadoIngredientes");
                     if (ingredientes.size() == 0) {
     %>
     <p class="msgok">No se han encontrado resultados.</p>
     <%            } else {
     %>
     <div id="resultados">
      <div id="resultados-info">
       <table>
        <tr>
         <td>Resultados de la b&uacute;squeda</td>
         <td>(Paginacion)</td>
         <td>Total de resultados: <%=ingredientes.size()%></td>
        </tr>
       </table>
      </div>
      <div id="listaingredientes">
       <table cellspacing="0" id="lista-ingredientes">
        <tr>
         <th>Nombre ingrediente</th>
         <th>C&oacute;digo</th>
         <th>Precio por kilo</th>
         <th>Proveedor</th>
         <th>&nbsp;</th>
        </tr>
        <%
                                 for (int i = 0; i < ingredientes.size(); i++) {
                                     Ingrediente I = ingredientes.get(i);
        %>
        <tr>
         <td><%=I.getNombre()%></td>
         <td><%=I.getCodigo()%></td>
         <td><%=I.getPrecio()%></td>
         <td><%=I.getProveedor()%></td>
         <td><a href="detallesingrediente.do?id=<%=I.getCodigo()%>">Ver detalles</a></td>
        </tr>
        <%
                                 }
        %>
       </table>
      </div>
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
    <p>Copyright (c) 2010 Grupo 64 bits Diseño por FCT y Kamilo Cervantes
     <br />Desarrollado por: Jeyra Beltr&aacute;n Sierra | Kamilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <div id="mensajesAyuda">
   <div id="ayudaTitulo"></div>
   <div id="ayudaTexto"></div>
  </div>
 </body>
</html>

