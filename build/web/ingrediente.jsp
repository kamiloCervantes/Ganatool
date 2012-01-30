<%@page import="Objetos.Ingrediente"%>
<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Datos de ingrediente $nombre_ingrediente @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
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
    RoundedTop("div#ingredientes-actions","#FFF","#112cab");
    switchFileColor();
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

   /*metodo para confirmar la eliminacion de un ingrediente,
    *aparecera la ventana de confirmacion y si se selecciona si
    *elimina el ingrediente que tiene como id la que se le pase por
    *parametro
    */
   function confirmarAccionEliminarIngrediente(idingrediente){
    if(confirm("Esta seguro que desea eliminar el ingrediente?"))
     document.location.href='eliminaringrediente.do?id='+idingrediente;
   }
  </script>
  <%
              Usuario U = null;
              Ingrediente I = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");

                  if (request.getSession().getAttribute("detallesI") != null) {
                      I = (Ingrediente) request.getSession().getAttribute("detallesI");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
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
    <div class="post"><!-- contenido de la página -->
     <div id="ingredientes-actions">
      <table>
       <tr id="acciones">
        <td><a href="listaringredientes.do">Listar ingredientes</a></td>
        <td><a href="agregaingrediente.jsp">Agregar ingrediente</a></td>
        <td><a href="buscaingrediente.jsp">Buscador de ingredientes</a></td>
       </tr>
      </table>
     </div>
     <div id="ingredientes-banner"></div>
     <div class="subsecciones"><%=I.getNombre()%></div>
     <div class="subsubseccion"><p>Informaci&oacute;n del ingrediente <%=I.getNombre()%></p></div>
     <div id="finca-info">
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
        </tr>
       </tbody>
      </table>
      <table id="ingredientes-actions">
       <tr>
        <td id="modifica"><a href="modificaringrediente.jsp?id=<%=I.getCodigo()%>">Modificar ingrediente</a></td>
        <td id="elimina"><a href="javascript:;" onclick="confirmarAccionEliminarIngrediente('<%=I.getCodigo()%>')">Eliminar ingrediente</a></td>
       </tr>
      </table>
     </div>
     <div class="subsubseccion"><p>Informaci&oacute;n nutricional</p></div>
     <div id="lista-ganado">
      <table id="ingrediente" cellspacing="0">
       <tr>
        <th width="160">Componente nutricional</th>
        <th width="160"><p align="center">Cantidad</p></th>
       </tr>
       <tr>
        <td>Kcal</td>
        <td align="right"><%=I.getKCal()%></td>
       </tr>
       <tr>
        <td>Calcio</td>
        <td align="right"><%=I.getCalcio()%> gramos</td>
       </tr>
       <tr>
        <td>F&oacute;sforo</td>
        <td align="right"><%=I.getFosforo()%> gramos</td>
       </tr>
       <tr>
        <td>Prote&iacute;na</td>
        <td align="right"><%=I.getProteina()%> gramos</td>
       </tr>
       <tr>
        <td>E<sub>d</sub></td>
        <td align="right"><%=I.getED()%> Mcal/Kg.</td>
       </tr>
       <tr>
        <td>E<sub>m</sub></td>
        <td align="right"><%=I.getEM()%> Mcal/Kg.</td>
       </tr>
       <tr>
        <td>E<sub>ngan</sub></td>
        <td align="right"><%=I.getENgan()%> Mcal/Kg.</td>
       </tr>
       <tr>
        <td>E<sub>nlact</sub></td>
        <td align="right"><%=I.getENlact()%> Mcal/Kg.</td>
       </tr>
       <tr>
        <td>E<sub>nmant</sub></td>
        <td align="right"><%=I.getENmant()%> Mcal/Kg.</td>
       </tr>
       <tr>
        <td>NDT</td>
        <td align="right"><%=I.getNDT()%> gramos</td>
       </tr>
       <tr>
        <td>Vitamina A</td>
        <td align="right"><%=I.getVitaminaA()%> U.I.</td>
       </tr>
       <tr>
        <td>Vitamina D</td>
        <td align="right"><%=I.getVitaminaD()%> U.I.</td>
       </tr>
       <tr>
        <td>Extracto et&eacute;reo</td>
        <td align="right"><%=I.getExtEtereo()%></td>
       </tr>
       <tr>
        <td>Ceniza</td>
        <td align="right"><%=I.getCeniza()%> </td>
       </tr>
       <tr>
        <td>Fibra</td>
        <td align="right"><%=I.getFibra()%></td>
       </tr>
       <tr>
        <td>FDA</td>
        <td align="right"><%=I.getFDA()%></td>
       </tr>
       <tr>
        <td>FDS</td>
        <td align="right"><%=I.getFDS()%></td>
       </tr>
       <tr>
        <td>FDN</td>
        <td align="right"><%=I.getFDN()%></td>
       </tr>
       <tr>
        <td>Humedad</td>
        <td align="right"><%=I.getHumedad()%> %</td>
       </tr>
      </table>
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
