<%@page import="Objetos.Ingrediente"%>
<%@page import="Objetos.Res"%>
<%@page import="Objetos.Finca"%>
<%@page import="Objetos.Usuario"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Generador de dietas @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="style-jsp.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
   //intercalar dos colores en las filas de una tabla :D
   function switchFileColor(){
    var color=false;
    tabla = document.getElementById('ingrediente');
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
    switchFileColor();
   }
  </script>
  <style>
   div.selection-box{
    width: 100%;
    height: 60px;
    background-color: #d2f3f9;
   }

   div.selection-box table td{
    padding: 5px 5px 5px 5px;
   }

   div.selection-box p{
    font-family: Arial, Georgia, sans-serif;
    font-size:14px;
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
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
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
        <td class="current"><a href="generardieta.do?new=ok">Generar dieta</a></td>
        <td><a href="buscadieta.jsp">Buscador de dietas</a></td>
       </tr>
      </table>
     </div>
     <div id="dietas-banner"></div>
     <div class="subsecciones">Generador de Dietas</div>
     <div class="seccion-error">
      <% if (request.getParameter("error") != null) {%>
      <p class="msgerror">NO SE PUDO GENERAR LA DIETA.</p>
      <p>
       Las razones pueden ser:
       <li>Los ingredientes no son suficientes.</li>
       <li>Nuestra tabla nutricional no contiene informacion necesaria para sugerir una
        dieta a esa res.</li>
      </p>
      <% }%>
     </div>
     <%-- Seleccion de Finca: --%>
     <%
                 if (request.getSession().getAttribute("fincas") != null) {
                     ArrayList<Finca> fincas = (ArrayList<Finca>) request.getSession().getAttribute("fincas");
     %>
     <div class="subsubseccion"><p>Seleccionar finca</p>
      <% if (fincas.size() == 0) {%>
      <p class="msgerror">Usted no tiene fincas agregadas, <a href="agregafinca.jsp">agregue una</a> para continuar.</p>
      <% } else {%>
      <div class="selection-box" align="center">
       <form action="escogerfinca.do" method="post">
        <table>
         <tr align="center" valign="middle">
          <td><p>Finca:</p></td>
          <td>
           <select name="finca" class="select_generador" if="finca">
            <% for (int i = 0; i < fincas.size(); i++) {%>
            <option value="<%=fincas.get(i).getNit()%>"><%=fincas.get(i).getNombre()%></option>
            <% }%>
           </select>
          </td>
          <td><input type="submit" value="OK" /></td>
         </tr>
        </table>
       </form>
      </div>
      <% }%>
     </div>
     <%
                          if (request.getSession().getAttribute("fincaesc") != null) {
                              Finca F = (Finca) request.getSession().getAttribute("fincaesc");
     %>
     <div id="finca-info">
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
        </tr>
       </tbody>
      </table>
     </div>
     <% }%>
     <% }%>
     <%-- Seleccion de la Res: --%>
     <%
                 if (request.getSession().getAttribute("reses") != null) {
                     ArrayList<Res> reses = (ArrayList<Res>) request.getSession().getAttribute("reses");
     %>
     <div class="subsubseccion"><p>Seleccionar res</p>
      <% if (reses.size() == 0) {%>
      <p class="msgerror">Usted no tiene reses agregadas, <a href="nuevares.do">agregue una</a> para continuar.</p>
      <% } else {%>
      <div class="selection-box" align="center">
       <form action="escogerres.do" method="post">
        <table>
         <tr align="center" valign="middle">
          <td><p>Res:</p></td>
          <td>
           <select name="res" class="select_generador" style="width:325px" if="res">
            <% for (int i = 0; i < reses.size(); i++) {%>
            <option value="<%=reses.get(i).getCodigo()%>">Codigo res: <%=reses.get(i).getCodigo()%></option>
            <% }%>
           </select>
          </td>
          <td><input type="submit" value="OK" /></td>
         </tr>
        </table>
       </form>
      </div>
      <% }%>
     </div>
     <%
                          if (request.getSession().getAttribute("resesc") != null) {
                              Res R = (Res) request.getSession().getAttribute("resesc");
     %>
     <div id="finca-info">
      <table class="finca">
       <tbody>
        <tr>
         <td class="img-finca"><img src="images/cow.jpg" width="128" height="128" /></td>
         <td class="data-finca">
          <ul>
           <li class="titulo">C&oacute;digo <%=R.getCodigo()%></li>
           <li class="subtitulo">Pertenece a la finca <%=R.getNombreFincaActual()%></li>
           <%
                                         String Proposito = "";
                                         if (R.getProposito() == 'L') {
                                             Proposito = "Lechero";
                                         } else if (R.getProposito() == 'C') {
                                             Proposito = "Carnico";
                                         }
           %>
           <li><b>Prop&oacute;sito: </b><%=Proposito%></li>
           <li><b>Sexo:</b> <%=R.getSexo()%></li>
           <li><b>Peso:</b> <%=R.getPeso()%></li>
           <li><b>Edad:</b> <%=R.getEdad()%></li>
           <li><b>Etapa fisiol&oacute;gica:</b> <%=R.getEtapaFisiologica()%></li>
           <% if (R.getProposito() == 'L' && R.getSexo() == 'F') {%>
           <li><b>Cantidad de leche:</b> <%=R.getCantLecheDiaria()%></li>
           <li><b>Porcentaje de grasa en leche:</b> <%=R.getPorcGrasaLeche()%></li>
           <% }%>
           <li><b>Raza:</b> <%=R.getRaza()%></li>
           <li><b>Propietario:</b> <%=R.getPropietario()%></li>
          </ul>
         </td>
        </tr>
       </tbody>
      </table>
      <table id="finca-actions">
       <tr>
        <td id="modifica"><a href="modificares.do?id=<%=R.getCodigo()%>&idf=<%=R.getNitFincaActual()%>">Modificar res</a></td>
       </tr>
      </table>
     </div>
     <% }%>
     <% }%>
     <%-- Seleccion de Ingredientes: --%>
     <%
                 if (request.getSession().getAttribute("ingredientes") != null) {
                     ArrayList<Ingrediente> ingredientes = (ArrayList<Ingrediente>) request.getSession().getAttribute("ingredientes");
     %>
     <div class="subsubseccion"><p>Seleccionar ingredientes</p>
      <% if (ingredientes.size() == 0) {%>
      <p class="msgerror">Usted no tiene mas ingredientes agregados, <a href="agregaingrediente.jsp">agregue uno</a> para continuar.</p>
      <% } else {%>
      <div class="selection-box" align="center">
       <form action="escogeringrediente.do" method="post">
        <table>
         <tr align="center" valign="middle">
          <td><p>Ingrediente:</p></td>
          <td>
           <select name="ingrediente" class="select_generador" style="width:325px" if="ingrediente">
            <% for (int i = 0; i < ingredientes.size(); i++) {%>
            <option value="<%=ingredientes.get(i).getCodigo()%>"><%=ingredientes.get(i).getNombre()%></option>
            <% }%>
           </select>
          </td>
          <td><input type="submit" value="Agregar" /></td>
         </tr>
        </table>
       </form>
      </div>
      <% }%>
     </div>
     <%
                          if (request.getSession().getAttribute("escogidos") != null) {
                              ArrayList<Ingrediente> escogidos = (ArrayList<Ingrediente>) request.getSession().getAttribute("escogidos");
                              for (int i = 0; i < escogidos.size(); i++) {
                                  Ingrediente I = escogidos.get(i);
     %>
     <table class="finca">
      <tbody>
       <tr>
        <td class="img-finca"><img src="images/vacacomiendo.jpg" width="150" height="125" /></td>
        <td class="data-finca">
         <ul>
          <li class="titulo"><%=I.getNombre()%></li>
          <li><b>C&oacute;digo:</b> <%=I.getCodigo()%></li>
          <li><b>Precio por kilo:</b> $<%=I.getPrecio()%></li>
          <li><b>Proveedor:</b> <%=I.getProveedor()%></li>
         </ul>
        </td>
        <td id="quitaringrediente">
         <ul>
          <li><a href="quitaringrediente.do?id=<%=I.getCodigo()%>">Quitar de la lista</a></li>
         </ul>
        </td>
       </tr>
      </tbody>
     </table>
     <% }%>
     <% if (escogidos.size() > 1) {%>
     <div align="center" style="margin-top: 50px;">
      <a href="calculardieta.do" style="margin-left: 1em; margin-right: 1em;"><img height="60" width="140" onmouseout="javascript:this.src='images/btngenerardieta1.png'" onmouseover="javascript:this.src='images/btngenerardieta2.png'"  onclick="javascript:this.src='images/btngenerardieta1.png'" src="images/btngenerardieta1.png" title="Administrar perfil" border="0"/></a>
     </div>
     <% }%>
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
 </body>
</html>
