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
    RoundedTop("div#banco-actions","#FFF","#112cab");
    Rounded("li#login","#FFF","#1a1eb2");
   }
  </script>
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
              ArrayList<Dieta> dietas = new ArrayList<Dieta>();
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              }
              if (request.getSession().getAttribute("bancodietas") != null) {
                  dietas = (ArrayList<Dieta>) request.getSession().getAttribute("bancodietas");
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
      <% if (U != null) {%>
      <td id="logout"><a href="cerrarsesion.do">Salir</a></td>
      <td id="conexion"><a href="perfil.jsp"><%=U.getUsuario()%></a></td>
      <% } else {%>
      <td id="conexion">Invitado</td>
      <% }%>
     </tr>
    </table>
   </div> <!-- end #logo-user -->
  </div> <!-- end #header -->
  <div id="page">
   <div id="content">
    <div class="post">
     <div id="banco-actions">
      <table>
       <tr id="acciones"></tr>
      </table>
     </div><!-- end div#global-actions -->
     <div id="bancodietas-banner"></div>
     <form action="buscarbanco.do" method="post">
      <div id="buscador-main" align="center" style="margin-top: 30px;">
       <table>
        <tr>
         <td><input type="text" name="parametrobusqueda"/></td><td><input id="buscarbtn" type="submit" value="Buscar"/></td>
        </tr>
       </table>
       <table>
        <tr class="opcionesbusqueda">
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="codigo" checked="checked"/>Buscar por c&oacute;digo de dieta</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="codigores"/>Buscar por c&oacute;digo de res</td>
         <td class="opcbusqueda"><input type="radio" name="tipobusqueda" value="fecha"/>Buscar por fecha</td>
        </tr>
       </table>
      </div>
     </form>
     <% if (request.getSession().getAttribute("resultadosBanco") != null) {%>
     <% dietas = (ArrayList<Dieta>) request.getSession().getAttribute("resultadosBanco");%>
     <% request.getSession().removeAttribute("resultadosBanco");%>
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
     </div>
     <!-- end resultados -->
     <% }%>
     <% for (int j = dietas.size() - 1; j >= 0; j--) {%>
     <% Dieta D = dietas.get(j);%>
     <% if (U != null) {%>
     <table class="finca" <%=(U.getUsuario().equals(D.getUsuario()) ? "bgcolor='#d4f3f7'" : "")%>>
      <% } else {%>
      <table class="finca">
       <% }%>
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
           <li>
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
           </li>
          </ul>
         </td>
         <td class="actions-finca">
          <ul>
           <% if (U != null) {%>
           <li><a href="verdieta.do?id=<%=D.getCodigo()%>">Ver detalles</a></li>
           <% } else {%>
           <li style="color: #112cab">Inicie sesion para</li>
           <li style="color: #112cab">ver los detalles.</li>
           <% }%>
          </ul>
         </td>
        </tr>
       </tbody>
      </table>
      <% }%>      
    </div>
    <!-- end #post -->
   </div> <!-- end #content -->
   <div id="sidebar">
    <ul>
     <% if (U != null) {%>
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
     <% } else {%>
     <li id="login">
      <ul>
       <li id="titulo"><p>Iniciar sesi&oacute;n</p></li>
       <form name="iniciosesion" method="post" action="iniciosesion.do">
        <li style="color: #FFFFFF">Usuario: <input type="text" name="username" id="username"/></li>
        <li style="color: #FFFFFF">Contrase&ntilde;a: <input type="password" name="passwd" id="passwd"/></li>
        <li><input id="entrar" type="submit" value="Entrar"/></li>
       </form>
       <li class="links"><p><a href="olvidoclave.jsp">Olvide mi contrase&ntilde;a</a></p></li>
       <li class="links"><p><a href="registro.jsp">Registro</a></p></li>
      </ul>
     </li>
     <% }%>
     <li>
      <img src="images/apoyo.jpg" width="177" height="45" />
      <table width="180" border="0" cellspacing="1">
       <tr>
        <td><a href="http://www.unicordoba.edu.co"><img src="images/logou.jpg" border="0" width="100" height="138" /></a></td>
       </tr>
       <tr>
        <td><a href="http://www.unicordoba.edu.co/grupos/socrates/semillero.html"><img src="images/socrates.jpg" border="0" width="84" height="112" /></a></td>
       </tr>
      </table>
     </li>
    </ul>
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
