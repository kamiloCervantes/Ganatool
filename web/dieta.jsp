<%@page import="Objetos.IngSuministrado"%>
<%@page import="Objetos.Registro"%>
<%@page import="Objetos.Res"%>
<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.Dieta"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Datos de dieta @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="js/valoracion.js" type="text/javascript" language="javascript"></script>
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="SpryAssets/SpryValidationTextarea.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
   //intercalar dos colores en las filas de una tabla :D
   function switchFileColor(tabla){
    var color=false;
    tabla = document.getElementById(tabla);
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
    RoundedTop("div#global-actions","#FFF","#112cab");
    switchFileColor('ingredientesdieta');
    switchFileColor('estadores');
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

   /*metodo para confirmar la eliminacion de una dieta,
    *aparecera la ventana de confirmacion y si se selecciona si
    *elimina la dieta que tiene como id la que se le pase por
    *parametro
    */
   function confirmarAccionEliminarDieta(iddieta){
    if(confirm("Esta seguro que desea eliminar la dieta?"))
     document.location.href='eliminardieta.do?id='+iddieta;
   }
  </script>
  <%
              Usuario U = null;
              Dieta D = null;
              Res R = null;
              Registro Reg = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");

                  if (request.getSession().getAttribute("dieta") != null) {
                      D = (Dieta) request.getSession().getAttribute("dieta");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
                  if (request.getSession().getAttribute("resaplicada") != null) {
                      R = (Res) request.getSession().getAttribute("resaplicada");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
                  if (request.getSession().getAttribute("registros") != null) {
                      Reg = (Registro) request.getSession().getAttribute("registros");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <link href="SpryAssets/SpryValidationTextarea.css" rel="stylesheet" type="text/css" />
  <style type="text/css">
   <!--
   .Estilo1 {
    color: #FFFFCC;
    font-weight: bold;
    font-style: italic;
    font-size: 18px;
   }
   -->
  </style>
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
    <div class="post"><!-- contenido de la página -->
     <div id="global-actions">
      <table>
       <tr id="acciones">
        <td><a href="listardietas.do">Listar dietas</a></td>
        <td><a href="generardieta.do?new=ok">Generar dieta</a></td>
        <td><a href="buscadieta.jsp">Buscador de dietas</a></td>
       </tr>
      </table>
     </div>
     <div id="dietas-banner"></div>
     <div class="subsecciones">Dieta <%=D.getCodigo()%></div>
     <div class="subsubseccion"><p>Informaci&oacute;n de la dieta</p></div>
     <div id="finca-info">
      <table class="finca">
       <tbody>
        <tr>
         <td class="img-finca"><img src="images/dieta.png" width="127" height="123" /></td>
         <td class="data-finca">
          <ul>
           <li class="titulo">Dieta <%=D.getCodigo()%></li>
           <li class="subtitulo">Fecha de creaci&oacute;n: <%=D.getFecha()%></li>
           <li><b>Aplicada en la finca:</b> <%=R.getNombreFincaActual()%></li>
           <li><b>Aplicada en la res:</b> <%=R.getCodigo()%></li>
           <li><b>Elaborada por:</b> <%=D.getUsuario()%></li>
           <li><b>Publicada:</b> <%=(D.getPublicada() ? "Si" : "No")%></li>
           <li>
            <% if (D.getPublicada()) {%>
            <% if (D.getUsuario().equals(U.getUsuario())) {%>
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
            <% } else {%>
            <table>
             <tr>
              <td id="valoracion"><p>Tu Valoraci&oacute;n:</p></td>
              <% if (D.valoracionDe(U.getUsuario()) == 0) {%>
              <form action="agregarvaloracion.do" method="post">
               <td id="tstar1"><img src="images/starb.png" border="0" id="star1" onmouseover="PonerValoracion('1')" onclick="GuardarValoracion('1')"/></td>
               <td id="tstar2"><img src="images/starb.png" border="0" id="star2" onmouseover="PonerValoracion('2')" onclick="GuardarValoracion('2')"/></td>
               <td id="tstar3"><img src="images/starb.png" border="0" id="star3" onmouseover="PonerValoracion('3')" onclick="GuardarValoracion('3')"/></td>
               <td id="tstar4"><img src="images/starb.png" border="0" id="star4" onmouseover="PonerValoracion('4')" onclick="GuardarValoracion('4')"/></td>
               <td id="tstar5"><img src="images/starb.png" border="0" id="star5" onmouseover="PonerValoracion('5')" onclick="GuardarValoracion('5')"/></td>
               <td><input type="submit" value="Valorar"/></td>               
               <input type="hidden" name="valoracion" id="valoracion" value="0" />
              </form>
              <% } else {%>
              <% for (int i = 0; i < D.valoracionDe(U.getUsuario()); i++) {%>
              <td><img src="images/star.png" border="0" /></td>
              <% }%>
              <% }%>
             </tr>
            </table>
            <% }%>
            <% }%>
           </li>
          </ul>
         </td>
        </tr>
       </tbody>
      </table>
      <table id="finca-actions">
       <tr>
        <!-- que no aparezca el boton de publicar dieta si ya esta publicada -->
        <% if (!D.getPublicada()) {%>
        <td id="modifica"><a href="publicardieta.do">Publicar dieta</a></td>
        <% }%>
        <% if (D.getUsuario().equals(U.getUsuario())) {%>
        <td id="elimina"><a href="javascript:;" onclick="confirmarAccionEliminarDieta('<%=D.getCodigo()%>')">Eliminar dieta</a></td>
        <% }%>
       </tr>
      </table>
     </div>
     <div class="subsubseccion"><p>Ingredientes de la dieta</p></div>
     <div id="lista-ganado">
      <table id="ingredientesdieta" cellspacing="0">
       <tr>
        <th>Nombre del Ingrediente</th>
        <th>Cantidad Diaria</th>
        <th>Valor</th>
       </tr>
       <% float total = 0;%>
       <% for (int i = 0; i < D.getIngredientes().size(); i++) {%>
       <% IngSuministrado I = D.getIngredientes().get(i);%>
       <tr>
        <td><%=I.getIngrediente().getNombre()%></td>
        <td><%=I.getCantidad()%> <%=(I.getIngrediente().getNombre().equals("Forraje") ? "%" : "Kg.")%></td>
        <td align="right">$ <%=(int) (I.getIngrediente().getPrecio() * I.getCantidad())%></td>
        <% total += (I.getIngrediente().getPrecio() * I.getCantidad());%>
       </tr>
       <% }%>
       <tr>
        <th>&nbsp;</th>
        <th align="right">Valor Total:</th>
        <th align="right">$ <%=(int) total%></th>
       </tr>
      </table>
     </div>
     <div class="subsubseccion"><p>Informaci&oacute;n de la res</p></div>
     <div id="lista-ganado">
      <table id="estadores" cellspacing="0">
       <tr>
        <th width="220">Factor</th>
        <th width="220">Estado actual</th>
        <th width="220">Estado a la fecha</th>
       </tr>
       <tr>
        <td>Edad</td>
        <td><%=R.getEdad()%> Meses.</td>
       <td><%=Reg.getEdad()%> Meses.</td>
       </tr>
       <tr>
        <td>Estado fisiol&oacute;gico</td>
        <td><%=R.getEtapaFisiologica()%></td>
        <td><%=Reg.getEtapa()%></td>
       </tr>
       <tr>
        <td>Peso actual</td>
        <td><%=R.getPeso()%> Kg.</td>
        <td><%=Reg.getPeso()%> Kg.</td>
       </tr>
       <% if (R.getProposito() == 'L' && R.getSexo() == 'F') {%>
       <tr>
        <td>Produccion Lechera</td>
        <td><%=R.getCantLecheDiaria()%> Lts.</td>
        <td><%=R.getCantAlimentoDiario()%> Lts.</td>
       </tr>
       <% }%>
      </table>
     </div>
     <!-- add comentarios si la dieta es publica -->
     <% if (D.getPublicada()) {%>
     <form action="agregarcomentario.do" method="post">
      <div id="addcomentario">
       <ul id="commentform">
        <li><p>A&ntilde;adir Comentario</p></li>
        <li>
         <span id="sprytextarea1">
          <textarea id="styled" name="comentario"></textarea><br />
          <span class="textareaMinCharsMsg">El comentario debe tener minimo 10 caracteres.</span>
          <span class="textareaMaxCharsMsg">El comentario debe tener maximo 200 caracteres.</span>
          <span class="textareaRequiredMsg">Escriba su comentario antes de enviarlo.</span>
         </span>
        </li>
        <li><input type="submit" value="Enviar comentario"/></li>
       </ul>
      </div>
     </form>
     <!-- comentarios de los usuarios, el mas reciente primero -->
     <% for (int i = D.getComentarios().size() - 1; i >= 0; i--) {%>
     <div class="comments">
      <div class="fecha">
       <ul>
        <li><p><%=D.getComentarios().get(i).getFecha()%></p></li>
       </ul>
      </div>
      <div class="user">
       <table>
        <tr>
         <td><img src="images/default.png" width="32" height="32" border="0"></img></td>
         <td><span class="Estilo1"><%=D.getComentarios().get(i).getUsuario()%></span></td>
        </tr>
       </table>
      </div>
      <div class="contenidocomment">
       <p><%=D.getComentarios().get(i).getComentario()%></p>
      </div>
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
      <td align="center"><a href="http://www.unicordoba.edu.co"><img src="images/logou.jpg" alt="" width="100" height="138" /></a></td>
     </tr>
     <tr>
      <td align="center"><img src="images/socrates.jpg" alt="" width="84" height="112" /></td>
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
  <script type="text/javascript">
   <!--
   var sprytextarea1 = new Spry.Widget.ValidationTextarea("sprytextarea1", {minChars:10, maxChars:200});
   //-->
  </script>
 </body>
</html>
