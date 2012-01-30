<%@page import="Objetos.Registro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objetos.Res"%>
<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Datos de res $nombre_res @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="js/graphs.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
   //intercalar dos colores en las filas de una tabla :D
   function switchFileColor(){
    var color=false;
    tabla = document.getElementById('ganado');
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
   function confirmarAccionEliminarRes(idres, idfinca){
    if(confirm("Esta seguro que desea eliminar la res?"))
     document.location.href='eliminarres.do?id='+idres+'&idf='+idfinca;
   }
  </script>
  <%
              Usuario U = null;
              Res R = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");

                  if (request.getSession().getAttribute("detallesR") != null) {
                      R = (Res) request.getSession().getAttribute("detallesR");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <link href="style-jsp.css" rel="stylesheet" type="text/css" />
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
        <td><a href="listarreses.do">Listar reses</a></td>
        <td><a href="nuevares.do">Agregar res</a></td>
        <td><a href="buscares.jsp">Buscador de reses</a></td>
       </tr>
      </table>
     </div>
     <div id="reses-banner"></div>
     <div class="subsecciones">Detalles de la res <%=R.getCodigo()%></div>
     <div class="subsubseccion"><p>Informaci&oacute;n de la res <%=R.getCodigo()%></p></div>
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
           <%
                       if (R.getProposito() == 'L' && R.getSexo() == 'F') {
           %>
           <li><b>Cantidad de leche:</b> <%=R.getCantLecheDiaria()%></li>
           <li><b>Porcentaje de grasa en leche:</b> <%=R.getPorcGrasaLeche()%></li>
           <%
                       }
           %>
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
        <td id="elimina"><a href="javascript:;" onclick="confirmarAccionEliminarRes('<%=R.getCodigo()%>','<%=R.getNitFincaActual()%>')">Eliminar res</a></td>
       </tr>
      </table>
     </div>
     <div class="subsubseccion"><p>Estad&iacute;sticas</p></div>
     <div align="center">
      <%
                  if (request.getSession().getAttribute("registrosR") != null) {
                      ArrayList<Registro> reg = (ArrayList<Registro>) request.getSession().getAttribute("registrosR");
                      if (R.getProposito() == 'L' && R.getSexo() == 'F') {
                          String valores = "";
                          String fechas = "";
                          for (int i = reg.size() - 1; i >= 0 && i >= (reg.size() - 8); i--) {
                              Registro r = reg.get(i);
                              valores = r.getLeche() + ";" + r.getPeso() + "," + valores;
                              fechas = r.getFecha() + "," + fechas;
                          }
                          valores = valores.substring(0, valores.length() - 1);
                          fechas = fechas.substring(0, fechas.length() - 1);
      %>
     </div>
     <p align="center" class="titulo_graph">Grafico de Leche, Peso vs Tiempo.</p>
     <div align="center">
      <script language="javascript">
       var graph = new BAR_GRAPH("vBar");
       graph.values = "<%=valores%>";
       graph.labels = "<%=fechas%>";
       graph.legend = "Leche (Lts.), Peso (Kg.)";
       graph.showValues = 2;
       graph.barWidth = 25;
       graph.barLength = 1;
       graph.labelSize = 10;
       graph.legendSize = 10;
       graph.absValuesSize = 10;
       graph.percValuesSize = 10;
       graph.graphPadding = 3;
       graph.graphBGColor = "#ABCDEF";
       graph.graphBorder = "1px solid blue";
       graph.barColors = "#A0C0F0";
       graph.barBGColor = "#E0F0FF";
       graph.barBorder = "2px outset white";
       graph.labelColor = "#000000";
       graph.labelBGColor = "#C0E0FF";
       graph.labelBorder = "2px groove white";
       graph.absValuesColor = "#000000";
       graph.absValuesBGColor = "#FFFFFF";
       graph.absValuesBorder = "2px groove white";
       document.write(graph.create());
      </script>
      <%
                            } else {
                                String valores = "";
                                String fechas = "";
                                for (int i = reg.size() - 1; i >= 0 && i >= (reg.size() - 8); i--) {
                                    Registro r = reg.get(i);
                                    valores = r.getPeso() + "," + valores;
                                    fechas = r.getFecha() + "," + fechas;
                                }
                                valores = valores.substring(0, valores.length() - 1);
                                fechas = fechas.substring(0, fechas.length() - 1);
      %>
     </div>
     <p align="center" class="titulo_graph">Grafica de Peso vs Tiempo</p>     
     <div align="center">
      <script language="javascript">
       var graph = new BAR_GRAPH("vBar");
       graph.values = "<%=valores%>";
       graph.labels = "<%=fechas%>";
       graph.legend = "Peso (Kg.)";
       graph.showValues = 2;
       graph.barWidth = 40;
       graph.barLength = 1;
       graph.labelSize = 10;
       graph.legendSize = 10;
       graph.absValuesSize = 10;
       graph.percValuesSize = 10;
       graph.graphPadding = 3;
       graph.graphBGColor = "#ABCDEF";
       graph.graphBorder = "1px solid blue";
       graph.barColors = "#A0C0F0";
       graph.barBGColor = "#E0F0FF";
       graph.barBorder = "2px outset white";
       graph.labelColor = "#000000";
       graph.labelBGColor = "#C0E0FF";
       graph.labelBorder = "2px groove white";
       graph.absValuesColor = "#000000";
       graph.absValuesBGColor = "#FFFFFF";
       graph.absValuesBorder = "2px groove white";
       document.write(graph.create());
      </script>
      <%
                      }
                  }
      %>
     </div>
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
