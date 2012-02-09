<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Modificar cuenta @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
   onload=function()
   {
    if(!NiftyCheck())
     return;
    Rounded("div.contenedorlista","#FFF","#115599","160px");
    RoundedTop("div#perfil-actions","#FFF","#112cab");
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
  <style>
   div#perfil-actions td.current{
    color: orange;
   }
  </style>
  <%
              Usuario U = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <link href="style-jsp.css" rel="stylesheet" type="text/css" />
  <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
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
     <!-- contenido de la página -->

     <div id="perfil-actions">
      <table>
       <tr id="acciones">
        <td><a href="modificarperfil.jsp">Modificar perfil</a></td>
        <td class="current"><a href="#">Modificar cuenta</a></td>
        <td><a href="eliminarperfil.do" onclick="return confirm('Pulse ACEPTAR para eliminar la cuenta.');">Eliminar cuenta</a></td>
       </tr>
      </table>
     </div>
     <%
                 String foto = U.getFoto();
                 if (foto == null) {
                     foto = "images/default.png";
                 }
     %>
     <div id="perfil-foto"><img src="<%=foto%>" width="200" height="300" /></div>
     <div id="perfil-cuenta">
      <%
                  int aviso = -1;
                  if (request.getParameter("aviso") != null) {
                      aviso = Integer.parseInt(request.getParameter("aviso"));
                      if (aviso == 0) {
      %>
      <p class="msgok">Contrase&ntilde;a cambiada.</p>
      <%                              } else if (aviso == 1) {
      %>
      <p class="msgok">Pregunta secreta cambiada correctamente.</p>
      <%                              } else if (aviso == 2) {
      %>
      <p class="msgerror">Los campos de contrase&ntilde;a nueva no coinciden.</p>
      <%                       } else if (aviso == 3) {
      %>
      <p class="msgerror">Error en la contrase&ntilde;a antigua.</p>
      <%                      }
                  }
      %>
      <form action="cambiarCuenta.do" method="post">
       <ul>
        <li><p class="subtitulo">Cambiar contrase&ntilde;a <input type="submit" value="Cambiar" /></p></li>
        <li><p>Contrase&ntilde;a anterior</p></li>
        <li><span id="sprytextfield1">
          <input type="password" name="oldpass" size="50"/>
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span></span></li>
        <li><p>Contrase&ntilde;a nueva</p></li>
        <li><span id="sprytextfield2">
          <input type="password" name="newpass" size="50"/>
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span></span></li>
        <li><p>Repetir contrase&ntilde;a</p></li>
        <li><span id="sprytextfield3">
          <input type="password" name="newpass2" size="50" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span></span></li>
       </ul>
      </form>
      <form action="cambiarCuenta.do" method="post">
       <ul>
        <li><p class="subtitulo">Cambiar pregunta secreta <input type="submit" value="Cambiar" /></p></li>
        <li><p>Pregunta secreta</p></li>
        <li><span id="sprytextfield5">
          <input type="text" name="newpreg" size="50"/>
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 100 caracteres.</span></span></li>
        <li><p>Respuesta secreta</p></li>
        <li><span id="sprytextfield4">
          <input type="text" name="newresp" size="50"/>
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span></span></li>
       </ul>
      </form>
     </div>
    </div><!-- end #post -->
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
      <td align="center"><img src="images/socrates.jpg" border="0" width="84" height="112" /></td>
     </tr>
    </table>
   </div><!-- end #sidebar -->
   <div style="clear: both;">&nbsp;</div>
  </div><!-- end #page -->
  <div id="footer-bgcontent">
   <div id="footer">
    <p>Desarrollado por: Jeyra Beltr&aacute;n Sierra | Camilo Cervantes Salazar | 
                Jes&uacute;s Miguel Herazo Hoyos<br/>&copy; 2012 Universidad de C&oacute;rdoba</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <div id="mensajesAyuda">
   <div id="ayudaTitulo"></div>
   <div id="ayudaTexto"></div>
  </div>
  <script type="text/javascript">
   <!--
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "none", {maxChars:100, validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
