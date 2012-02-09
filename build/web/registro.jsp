<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Registro de Usuarios @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="style-jsp.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print"/>
  <%
              // Variables a usar:
              int aviso = -1;
              Usuario U = new Usuario();
  %>
  <script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
  <script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
  <link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
  <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script type="text/javascript">
   window.onload=function(){
    if(!NiftyCheck())
     return;
    Rounded("li#login","#FFF","#1a1eb2");
   }
  </script>
  <style>
   input#foto{
    width:170px;
   }
   table#botones tr{
    padding-left: 10px;
   }
   }
   .Estilo2 {
    color: #666666;
    font-style: italic;
   }
  </style>
 </head>
 <body>
  <div id="header">
   <div id="menu">
    <ul>
     <li class="current_page_item"><a href="#">Registro</a></li>
     <li><a href="index.jsp">Home</a></li>
     <li><a href="cargarbanco.do">Banco de dietas</a></li>
     <li><a href="FAQ.html">Info</a></li>
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
     <form id="registro" method="post" enctype="multipart/form-data" action="registrar.do">
      <%
                  if (request.getParameter("aviso") != null) {
                      aviso = Integer.parseInt(request.getParameter("aviso"));
                      if (aviso == 0) {
                          U = new Usuario();
      %>
      <p class="msgok">Usuario almacenado satisfactoriamente.</p>
      <%
                            } else if (aviso == 1) {
                                U = (Usuario) request.getSession().getAttribute("datosUsuario");
      %>
      <p class="msgerror">El nombre de usuario ya esta en uso.</p>
      <%
                            } else if (aviso == 2) {
                                U = (Usuario) request.getSession().getAttribute("datosUsuario");
      %>
      <p class="msgerror">Ya existe un usuario registrado con este e-mail.</p>
      <%
                            } else if (aviso == 3) {
                                U = (Usuario) request.getSession().getAttribute("datosUsuario");
      %>
      <p class="msgerror">Los campos de Contrase&ntilde;a no coinciden.</p>
      <%
                      }
                  }
      %>
      <div id="registro">
       <table width="600" align="center" cellspacing="0" class="estilo1_table">
        <tr>
         <th colspan="3" scope="col" class="head1_table"><div align="center"><p class="titulo">Registro de usuario</p></div></th>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td colspan="3"><div align="left"><em>(<span class="Estilo1">*</span>) Campo obligatorio.</em></div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Tipo de documento:</td>
         <td width="300">
          <div align="left"><span id="spryselect1">
            <select name="tipodoc" id="tipodoc" style="width:325px">
             <option>Seleccione uno...</option>
             <option <%=(U.getTipoDoc().equals("RC") ? "selected='selected'" : "")%> value="RC">Registro civil</option>
             <option <%=(U.getTipoDoc().equals("TI") ? "selected='selected'" : "")%> value="TI">Tarjeta de identidad</option>
             <option <%=(U.getTipoDoc().equals("CC") ? "selected='selected'" : "")%> value="CC">Cedula de ciudadania</option>
             <option <%=(U.getTipoDoc().equals("CE") ? "selected='selected'" : "")%> value="CE">Cedula de extranjeria</option>
             <option <%=(U.getTipoDoc().equals("OO") ? "selected='selected'" : "")%> value="OO">Otro...</option>
            </select>
            <span class="selectInvalidMsg">Seleccione un elemento.</span>
            <span class="selectRequiredMsg">Seleccione un elemento.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Nro. de documento:</td>
         <td width="300">
          <div align="left">
           <%
                       String nrodoc = "";
                       if (U.getNroDoc() != 0) {
                           nrodoc = U.getNroDoc() + "";
                       }
           %>
           <span id="sprytextfield1">
            <input name="nrodoc" type="text" id="nrodoc" value="<%=nrodoc%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Nombre:</td>
         <td width="300">

          <div align="left"><span id="sprytextfield2">
            <input name="nombre" type="text" id="nombre" value="<%=U.getNombre()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Apellidos:</td>
         <td width="300">

          <div align="left"><span id="sprytextfield3">
            <input name="apellidos" type="text" id="apellidos" value="<%=U.getApellidos()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Sexo:</td>
         <td width="300">

          <div align="left"><span id="spryselect2">
            <select name="sexo" id="sexo" style="width:325px">
             <option>Seleccione uno...</option>
             <option <%=(U.getSexo() == 'M' ? "selected='selected'" : "")%> value="M">Masculino</option>
             <option <%=(U.getSexo() == 'F' ? "selected='selected'" : "")%> value="F">Femenino</option>
            </select>
            <span class="selectInvalidMsg">Seleccione un elemento.</span>
            <span class="selectRequiredMsg">Seleccione un elemento.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Fecha de nacimiento <span class="Estilo2">(aaaa-mm-dd)</span>:</td>
         <td width="300">
          <div align="left">
           <%
                       String fecha = "";
                       if (U.getFechaNac() != null) {
                           fecha = U.getFechaNac().toString();
                       }
           %>
           <span id="sprytextfield4">
            <input name="fechanac" type="text" id="fechanac" value="<%=fecha%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span> </span> </div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Usuario:</td>
         <td width="300">

          <div align="left"><span id="sprytextfield5">
            <input name="user" type="text" id="user" value="<%=U.getUsuario()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Contrase&ntilde;a:</td>
         <td width="300">          
          <div align="left">
           <span id="sprytextfield6">
            <input name="passwd1" type="password" id="passwd1" size="50" />
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>
           </span>
          </div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Repetir contrase&ntilde;a:</td>
         <td width="300">          
          <div align="left"><span id="sprytextfield7">
            <input name="passwd2" type="password" id="passwd2" size="50" />
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span> </span> </div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Pregunta secreta:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield11">
            <input name="preg" type="text" id="preg" value="<%=U.getPregunta()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span><span class="textfieldMaxCharsMsg">M&aacute;ximo 100 caracteres.</span></span></div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>Respuesta secreta:</td>
         <td width="300">

          <div align="left"><span id="sprytextfield8">
            <input name="respuesta" type="text" id="respuesta" value="<%=U.getRespuesta()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 20 caracteres.</span>
           </span></div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo1">*</span></div></td>
         <td>E-mail:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield9">
            <input name="email" type="text" id="email" value="<%=U.getEMail()%>" size="50"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"></div></td>
         <td>Telefono:</td>
         <td width="300">
          <div align="left">
           <%
                       String tel = "";
                       if (U.getTelefono() != 0) {
                           tel = U.getTelefono() + "";
                       }
           %>
           <span id="sprytextfield10">
            <input name="telefono" type="text" id="telefono" value="<%=tel%>" size="50"/>
            <span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span> </span> </div></td>
        </tr>
        <tr>
         <td><div align="center"></div></td>
         <td>Direccion:</td>
         <td width="300">             <div align="left">
           <input name="direccion" type="text" id="direccion" value="<%=U.getDireccion()%>" size="50"/>            
          </div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center"></div></td>
         <td>Imagen:</td>
         <td width="300" align="center">             <div align="left">
           <input name="foto" type="file" id="foto" size="35"/>
          </div></td>
        </tr>
       </table>
       <table width="600" align="center" cellpadding="2" cellspacing="2" class="estilo1_table" id="botones">
        <tr>
         <td>
          <div align="center">
           <input type="submit" name="enviar" id="enviar" value="Registrar" />
          </div>
         </td>
         <td>
          <div align="center">
           <input type="reset" name="limpiar" id="limpiar" value="Limpiar" />
          </div>
         </td>
        </tr>
       </table>
     </form>
    </div><!-- end div#registro -->
   </div>  <!-- end #post -->
  </div> <!-- end #content -->
  <div id="sidebar">
   <ul>
    <li id="login">
     <ul>
      <li id="titulo"><p>Iniciar sesi&oacute;n</p></li>
      <form name="iniciosesion" method="post" action="iniciosesion.do">
       <li style="color: #FFFFFF">Usuario: <input type="text" name="username" id="username"/></li>
       <li style="color: #FFFFFF">Contrase&ntilde;a: <input type="password" name="passwd" id="passwd"/></li>
       <li><input id="entrar" type="submit" value="Entrar"/></li>
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
    <p>Desarrollado por: Jeyra Beltr&aacute;n Sierra | Camilo Cervantes Salazar | 
                Jes&uacute;s Miguel Herazo Hoyos<br/>&copy; 2012 Universidad de C&oacute;rdoba</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <script type="text/javascript">
   <!--
   var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {invalidValue:"0", validateOn:["blur", "change"]});
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {validateOn:["blur", "change"]});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "none", {validateOn:["blur", "change"], maxChars:50});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "none", {maxChars:50, validateOn:["blur", "change"]});
   var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2", {invalidValue:"0", validateOn:["blur", "change"]});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "date", {validateOn:["blur", "change"], format:"yyyy-mm-dd"});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "none", {validateOn:["blur", "change"], maxChars:20});
   var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7", "none", {validateOn:["blur", "change"], maxChars:20});
   var sprytextfield8 = new Spry.Widget.ValidationTextField("sprytextfield8", "none", {maxChars:20, validateOn:["blur", "change"]});
   var sprytextfield9 = new Spry.Widget.ValidationTextField("sprytextfield9", "email", {validateOn:["blur", "change"], maxChars:50});
   var sprytextfield10 = new Spry.Widget.ValidationTextField("sprytextfield10", "integer", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield11 = new Spry.Widget.ValidationTextField("sprytextfield11", "none", {maxChars:100, validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
