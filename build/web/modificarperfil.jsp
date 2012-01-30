<%@page import="Objetos.Usuario"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Modificar perfil @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print" />
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
  <script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
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
  <%
              int aviso = -1;
              Usuario U = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
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
    <div class="post">
     <!-- contenido de la página -->
     <div id="perfil-actions">
      <table>
       <tr id="acciones">
        <td class="current"><a href="modificarperfil.jsp">Modificar perfil</a></td>
        <td><a href="modificarcuenta.jsp">Modificar cuenta</a></td>
        <td><a href="eliminarperfil.do" onclick="return confirm('Pulse ACEPTAR para eliminar la cuenta.');">Eliminar cuenta</a></td>
       </tr>
      </table>
     </div>
     <form action="modificarperfil.do" method="post"  enctype="multipart/form-data">
      <%
                  String foto = U.getFoto();
                  if (foto == null || foto == "") {
                      foto = "images/default.png";
                  }
      %>
      <div id="perfil-foto">
       <div id="fileinputs">
        <input id="foto" name="foto" type="file" class="file" />
        <img src="<%=foto%>" />
       </div>
       <p id="editimg">Click sobre la imagen para cambiarla</p>
      </div>
      <div id="perfil-datos">
       <%
                   if (request.getParameter("aviso") != null) {
                       aviso = Integer.parseInt(request.getParameter("aviso"));
                       if (aviso == 1) {
       %>
       <p class="msgerror">Ya existe un usuario con este correo electronico.</p>
       <%                  }
                   }
       %>
       <ul>
        <li><p id="user"><%=U.getUsuario()%></p></li>
        <li><p>Nombre: <span id="sprytextfield1">
           <input type="text" name="nombre" value="<%=U.getNombre()%>" />
           <span class="textfieldRequiredMsg"></span><span class="textfieldMaxCharsMsg"></span></span><span id="sprytextfield2">
           <input type="text" name="apellidos" value="<%=U.getApellidos()%>" />
           <span class="textfieldRequiredMsg"></span><span class="textfieldMaxCharsMsg"></span></span></p></li>
        <li><p>N&uacute;mero de documento: <span id="sprytextfield3">
           <input type="text" name="numerodoc" value="<%=U.getNroDoc()%>" />
           <span class="textfieldRequiredMsg"></span><span class="textfieldInvalidFormatMsg"></span></span></p></li>
        <li><p>Tipo de documento:
          <span id="spryselect1">
           <select name="tipodoc" id="tipodoc">
            <option>Seleccione uno...</option>
            <option <%=(U.getTipoDoc().equals("RC") ? "selected='selected'" : "")%> value="RC">Registro civil</option>
            <option <%=(U.getTipoDoc().equals("TI") ? "selected='selected'" : "")%> value="TI">Tarjeta de identidad</option>
            <option <%=(U.getTipoDoc().equals("CC") ? "selected='selected'" : "")%> value="CC">Cedula de ciudadania</option>
            <option <%=(U.getTipoDoc().equals("CE") ? "selected='selected'" : "")%> value="CE">Cedula de extranjeria</option>
            <option <%=(U.getTipoDoc().equals("OO") ? "selected='selected'" : "")%> value="OO">Otro...</option>
           </select>
           <span class="selectRequiredMsg"></span></span>
         </p></li>
        <li><p>Sexo: <span id="spryselect2">
           <select name="sexo" id="sexo">
            <option>Seleccione uno...</option>
            <option <%=(U.getSexo() == 'M' ? "selected='selected'" : "")%> value="M">Masculino</option>
            <option <%=(U.getSexo() == 'F' ? "selected='selected'" : "")%> value="F">Femenino</option>
           </select>
           <span class="selectRequiredMsg"></span></span></p></li>
        <li><p>Fecha de nacimiento: <span id="sprytextfield4">
           <input type="text" name="fechanacimiento" value="<%=U.getFechaNac().toString()%>" />
           <span class="textfieldRequiredMsg"></span><span class="textfieldInvalidFormatMsg"></span></span></p></li>
        <li><p>E-mail:<span id="sprytextfield5">
           <input type="text" name="email" value="<%=U.getEMail()%>" />
           <span class="textfieldRequiredMsg"></span><span class="textfieldInvalidFormatMsg"></span><span class="textfieldMaxCharsMsg"></span></span></p></li>
           <%
                       String tel = "";
                       if (U.getTelefono() != 0) {
                           tel = U.getTelefono() + "";
                       }
           %>
        <li><p>Tel&eacute;fono: <span id="sprytextfield6">
           <input type="text" name="telefono" value="<%=tel%>" />
           <span class="textfieldInvalidFormatMsg"></span></span></p></li>
           <%
                       String dir = U.getDireccion();
                       if (dir == null) {
                           dir = "";
                       }
           %>
        <li><p>Direcci&oacute;n: <span id="sprytextfield7">
           <input type="text" name="direccion" value="<%=dir%>" />
           <span class="textfieldMaxCharsMsg"></span></span></p></li>
        <li><input type="submit" value="Guardar" /></li>
       </ul>
      </div>
     </form>
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
    <p>Copyright (c) 2010 Grupo 64 bits Dise&ntilde;o por FCT y Kamilo Cervantes
     <br />Desarrollado por: Jeyra Beltr&aacute;n Sierra | Kamilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>
   </div><!-- end #footer -->
  </div> <!-- end #footer-bgcontent -->
  <div id="mensajesAyuda">
   <div id="ayudaTitulo"></div>
   <div id="ayudaTexto"></div>
  </div>
  <script type="text/javascript">
   <!--
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "none", {maxChars:50, validateOn:["blur", "change"]});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "none", {validateOn:["blur", "change"], maxChars:50});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "integer", {validateOn:["blur", "change"]});
   var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {validateOn:["change", "blur"]});
   var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2", {validateOn:["blur", "change"]});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "date", {format:"yyyy-mm-dd", validateOn:["blur", "change"]});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "email", {validateOn:["blur", "change"], maxChars:50});
   var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6", "integer", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7", "none", {maxChars:50, isRequired:false, validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
