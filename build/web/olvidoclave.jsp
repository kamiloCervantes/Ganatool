<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Recuperar contrase&ntilde;a @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link href="style-jsp.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print"/>
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
  <script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
  <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
  <link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">
   window.onload=function(){
    if(!NiftyCheck())
     return;
    Rounded("li#login","#FFF","#1a1eb2");
   }
  </script>
  <%
              int etapa = 0;
              int error = 0;
              if (request.getParameter("etapa") != null) {
                  etapa = Integer.parseInt(request.getParameter("etapa"));
              }
              if (request.getParameter("error") != null) {
                  error = Integer.parseInt(request.getParameter("error"));
              }
  %>
 </head>
 <body>
  <div id="header">
   <div id="menu">
    <ul>
     <li class="current_page_item"><a href="#">Recuperar contrase&ntilde;a</a></li>
     <li><a href="index.jsp">Home</a></li>
     <li><a href="cargarbanco.do">Banco de dietas</a></li>
     <li><a href="contacto.html">Contacto</a> </li>
    </ul>
   </div> <!-- end #menu -->
   <div id="logo">
    <h1><a href="#">Ganatool </a></h1>
    <h2>Herramienta para realizar balanceo de dietas de ganado vacuno</h2>
   </div> <!-- end #logo -->
  </div> <!-- end #header -->
  <div id="page">
   <div id="content">
    <div class="post">
     <!-- contenido de la página -->
     <form id="recuperarpw" method="post" action="recuperar.do">
      <table width="500" border="0" align="center" cellpadding="1" cellspacing="0" class="estilo1_table">
       <tr>
        <th colspan="2" class="head1_table" scope="col"><p class="titulo">Recuperar Contrase&ntilde;a</p></th>
       </tr>
       <% if (etapa == 0) {%>
       <tr>
        <td colspan="2"><em>Complete los siguientes campos para recuperar su contrase&ntilde;a:</em></td>
       </tr>
       <tr>
        <td width="322">Tipo de Documento:</td>
        <td width="170"><span id="spryselect1">
          <select name="tipodoc" id="tipodoc">
           <option>Seleccione uno...</option>
           <option value="RC">Registro civil</option>
           <option value="TI">Tarjeta de identidad</option>
           <option value="CC">Cedula de ciudadania</option>
           <option value="CE">Cedula de extranjeria</option>
           <option value="Otro">Otro...</option>
          </select>
          <span class="selectInvalidMsg">Seleccione un elemento.</span>
          <span class="selectRequiredMsg">Seleccione un elemento.</span>
         </span>        </td>
       </tr>
       <tr>
        <td>Numero de Documento:</td>
        <td width="170"><span id="sprytextfield1">
          <input type="text" name="nrodoc" id="nrodoc" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldInvalidFormatMsg">Formato no válido.</span></span></td>
       </tr>
       <% }%>
       <% if (error == 1) {%>
       <tr>
        <td colspan="2" class="msgerror">No existe un usuario con ese documento.</td>
       </tr>
       <% }%>
       <% if (etapa == 1) {%>
       <tr>
        <td colspan="2"><em>Responda la pregunta con la respuesta secreta que registro:</em></td>
       </tr>
       <%
            String[] preg = (String[]) request.getSession().getAttribute("pregunta");
       %>
       <tr>
        <td><strong><%=preg[0]%></strong></td>
        <td width="170">
         <span id="sprytextfield2">
          <input type="text" name="respuesta" id="respuesta" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span>
          <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>         </span>        </td>
       </tr>
       <% }%>
       <% if (error == 2) {%>
       <tr>
        <td colspan="2" class="msgerror">La respuesta es incorrecta, intentelo nuevamente.</td>
       </tr>
       <% }%>
       <% if (etapa == 2) {%>
       <% if (error != 3) {%>
       <tr>
        <td colspan="2"><em class="msgok">La respuesta es correcta.</em></td>
       </tr>
       <% }%>
       <tr>
        <td colspan="2"><em>Ingrese el nuevo usuario y la nueva contrase&ntilde;a de su cuenta:</em></td>
       </tr>
       <tr>
        <td>Nuevo Usuario:</td>
        <td>
         <span id="sprytextfield5">
          <input type="text" name="user" id="user" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span>
          <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>         </span>         </td>
       </tr>
       <tr>
        <td>Nueva Contrase&ntilde;a:</td>
        <td width="170">
         <span id="sprytextfield3">
          <input type="password" name="passwd" id="passwd" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span>
          <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>         </span>        </td>
       </tr>
       <tr>
        <td>Repetir Contrase&ntilde;a:</td>
        <td width="170">
         <span id="sprytextfield4">
          <input type="password" name="passwd2" id="passwd2" />
          <span class="textfieldRequiredMsg">Se necesita un valor.</span>
          <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>         </span>        </td>
       </tr>
       <% }%>
       <% if (error == 3) {%>
       <tr>
        <td colspan="2" class="msgerror">Las contrase&ntilde;as no coiciden.</td>
       </tr>
       <% }%>
      </table>
      <table width="500" align="center" class="estilo1_table">
       <tr>
        <td><div align="center">
          <input type="submit" name="enviar" id="enviar" value="Continuar" />
         </div></td>
       </tr>
      </table>
     </form>
    </div><!-- end #post -->
   </div> <!-- end #content -->
   <div id="sidebar">
    <ul>
     <li id="login">
      <ul>
       <li id="titulo"><p>Iniciar sesi&oacute;n</p></li>
       <form name="iniciosesion" method="post" action="iniciosesion.do">
        <li style="color: #FFFFFF">Usuario: <input type="text" name="username" id="username"/></li>
        <li style="color: #FFFFFF">Contrase&ntilde;a: <input type="password" name="passwd" id="passwd"/></li>
        <li><input type="submit" value="Entrar"/></li>
        <%
                    if (request.getParameter("error") != null) {
        %>
        <li style="color: #ffcc33">"Usuario y/o password incorrectos"</li>
        <%                                                    }
        %>
       </form>
       <li class="links"><p><a href="olvidoclave.jsp">Olvide mi contrase&ntilde;a</a></p></li>
       <li class="links"><p><a href="registro.jsp">Registro</a></p></li>
      </ul>
     </li>
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
    <p>Copyright (c) 2010 Grupo 64 bits Dise&ntilde;o por FCT y Kamilo Cervantes
     <br />Desarrollado por: Jeyra Beltr&aacute;n Sierra | Kamilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <script type="text/javascript">
   <!--
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {validateOn:["blur", "change"]});
   var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {invalidValue:"0", validateOn:["change", "blur"]});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "none", {maxChars:20, validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
