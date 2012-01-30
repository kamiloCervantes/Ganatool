<%@page import="Objetos.Dieta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Dietas @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
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
   /*metodo para confirmar la eliminacion de una res,
    *aparecera la ventana de confirmacion y si se selecciona si
    *elimina la res que tiene como id la que se le pase por
    *parametro
    */
   function confirmarAccionEliminarRes(idres){
    if(confirm("Esta seguro que desea eliminar la res?"))
     document.location.href='eliminarres.do?id='+idres;
   }
  </script>
  <%
              Usuario U = null;
              ArrayList<Dieta> dietas = null;
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
        <td><a href="listardietas.do">Listar dietas</a></td>
        <td><a href="generardieta.do">Generar dieta</a></td>
        <td class="current"><a href="buscadieta.jsp">Buscador de dietas</a></td>
       </tr>
      </table>
     </div><!-- end div#global-actions -->
     <div id="dietas-banner"></div>
     <div class="subsecciones">Buscar Dieta</div>
     <form action="buscardieta.do" method="post">
      <div id="buscador-main" align="center">
       <table>
        <tr>
         <td><input type="text" name="parametrobusqueda"/></td><td><input id="buscarbtn" type="submit" value="Buscar"/></td>
        </tr>
       </table>
       <table>
        <tr class="opcionesbusqueda">
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="codigo" checked="checked"/>Buscar por c&oacute;digo de dieta</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="codigores"/>Buscar por c&oacute;digo de res</td>
        </tr>
       </table>
      </div>
     </form>
     <% if (request.getSession().getAttribute("resultadoDietas") != null) {%>
     <% dietas = (ArrayList<Dieta>) request.getSession().getAttribute("resultadoDietas");%>
     <% request.getSession().removeAttribute("resultadoDietas");%>
     <% if (dietas.size() == 0) {%>
     <p class="msgok">No se han encontrado resultados.</p>
     <% } else {%>
     <div id="resultados">
      <div id="resultados-info">
       <table>
        <tr>
         <td>Resultados de la b&uacute;squeda</td>
         <td>(Paginacion)</td>
         <td>Total de resultados: <%=dietas.size()%></td>
        </tr>
       </table>
      </div>
      <% for (int j = dietas.size() - 1; j >= 0; j--) {%>
      <% Dieta D = dietas.get(j);%>
      <table class="finca">
       <tbody>
        <tr>
         <td class="img-finca"><img src="images/dieta.png" width="127" height="123" /></td>
         <td class="data-finca">
          <ul>
           <li class="titulo">Dieta <%=D.getCodigo()%></li>
           <li class="subtitulo">Fecha de creaci&oacute;n: <%=D.getFecha()%></li>
           <li><b>Nit de la finca:</b> <%=D.getNitFinca()%></li>
           <li><b>Codigo de la res:</b> <%=D.getCodigoRes()%></li>
           <li><b>Elaborada por:</b> <%=D.getUsuario()%></li>
           <li><b>Publicada:</b> <%=(D.getPublicada() ? "Si" : "No")%></li>
           <li>
            <% if (D.getPublicada()) {%>
            <table>
             <tr>
              <td id="valoracion"><p>Valoraci&oacute;n Total:</p></td>
              <% for (int i = 0; i < D.valoracionTotal(); i++) {%>
              <td><img src="images/star.png" border="0" /></td>
              <% }%>
              <% for (int i = 5; i > D.valoracionTotal(); i--) {%>
              <td><img src="images/starb.png" border="0" /></td>
              <% }%>
             </tr>
            </table>
            <% }%>
           </li>
          </ul>
         </td>
         <td class="actions-finca">
          <ul>
           <li><a href="verdieta.do?id=<%=D.getCodigo()%>">Ver detalles</a></li>
           <li><a href="javascript:;" onclick="confirmarAccionEliminarDieta('<%=D.getCodigo()%>')">Eliminar dieta</a></li>
          </ul>
         </td>
        </tr>
       </tbody>
      </table>
      <% }%>
     </div>
     <% }%>
     <% }%>
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
        <li class="current"><a href="listardietas.do">Listado de dietas</a></li>
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

