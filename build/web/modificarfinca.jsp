<%@page import="java.util.ArrayList"%>
<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.Finca"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Modificar Finca @ GANATOOL</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="" />
  <link href="images/favicon.ico" rel="SHORCUT ICON"/>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css" />
  <link href="style-jsp.css" rel="stylesheet" type="text/css" />
  <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
  <link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
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
    RoundedTop("div#global-actions","#FFF","#112cab");
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
              Finca F = null;
              Usuario U = null;
              ArrayList<Finca> fincas = null;
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");

                  if (request.getSession().getAttribute("fincas") != null) {
                      fincas = (ArrayList<Finca>) request.getSession().getAttribute("fincas");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }
              } else {
                  response.sendRedirect("index.jsp");
              }

              long idnit = 0;
              if (request.getParameter("id") != null) {
                  idnit = Long.parseLong(request.getParameter("id"));
                  request.getSession().setAttribute("viejonit", idnit);
                  for (int i = 0; i < fincas.size(); i++) {
                      if (fincas.get(i).getNit() == idnit) {
                          F = fincas.get(i);
                      }
                  }
              } else {
                  response.sendRedirect("listarfincas.do");
              }
  %>
  <style type="text/css">
   <!--
   .Estilo2 {color: #666666}
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
        <td><a href="listarfincas.do">Listar fincas</a></td>
        <td><a href="agregafinca.jsp">Agregar finca</a></td>
        <td><a href="buscafinca.jsp">Buscador de fincas</a></td>
       </tr>
      </table>
     </div>
     <div id="fincas-banner"></div>
     <div class="subsecciones">Modificar finca <%=F.getNombre()%></div>
     <div id="registro" align="center">
      <%
                  int aviso = -1;
                  if (request.getParameter("aviso") != null) {
                      aviso = Integer.parseInt(request.getParameter("aviso"));
                      if (aviso == 1) {
      %>
      <p class="msgerror">Ya existe una finca con este nit.</p>
      <%                      }
                  }
      %>
      <form action="modificarfinca.do" method="post" enctype="multipart/form-data">
       <table width="600" cellspacing="0" class="estilo1_table">
        <tr>
         <td colspan="3"><div align="left"><em>(<span class="Estilo1">*</span>) Campo obligatorio.</em></div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td><div align="center" class="Estilo1">*</div></td>
         <td>Nombre de finca:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield1">
            <input name="nombrefinca" id="nombre" size="50" type="text" value="<%=F.getNombre()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 100 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td><div align="center" class="Estilo1">*</div></td>
         <td>NIT <span class="Estilo2"><em>(no incluir el gui&oacute;n)</em></span>:</td>
         <td width="300">			  
          <div align="left">
           <%
                       String nit = "";
                       if (F.getNit() != 0) {
                           nit = F.getNit() + "";
                       }
           %>
           <span id="sprytextfield2">
            <input name="nit" id="nit" size="50" type="text" value="<%=nit%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td><div align="center" class="Estilo1">*</div></td>
         <td>Departamento:</td>
         <td width="300">
          <div align="left">
           <span id="spryselect1">
            <select name="dpto" if="dpto" style="width:325px" id="dpto">
             <%
                         if (!F.getDepartamento().isEmpty()) {
             %>
             <option value="<%=F.getDepartamento()%>" selected="selected"><%=F.getDepartamento()%></option>
             <%
                                      } else {
             %>
             <option value="-1">Seleccione uno... </option>
             <%                         }
             %>
             <option value="Amazonas">Amazonas</option>
             <option value="Antioquia">Antioquia</option>
             <option value="Arauca">Arauca</option>
             <option value="Atl&aacute;ntico">Atl&aacute;ntico</option>
             <option value="Bol&iacute;var">Bol&iacute;var</option>
             <option value="Boyac&aacute;">Boyac&aacute;</option>
             <option value="Caldas">Caldas</option>
             <option value="Caquet&aacute;">Caquet&aacute;</option>
             <option value="Casanare">Casanare</option>
             <option value="Cauca">Cauca</option>
             <option value="Cesar">Cesar</option>
             <option value="Choc&oacute;">Choc&oacute;</option>
             <option value="C&oacute;rdoba">C&oacute;rdoba</option>
             <option value="Cundinamarca">Cundinamarca</option>
             <option value="Guain&iacute;a">Guain&iacute;a</option>
             <option value="Guaviare">Guaviare</option>
             <option value="Huila">Huila</option>
             <option value="La Guajira">La Guajira</option>
             <option value="Magdalena">Magdalena</option>
             <option value="Meta">Meta</option>
             <option value="Nari&ntilde;o">Nari&ntilde;o</option>
             <option value="Norte de Santander">Norte de Santander</option>
             <option value="Putumayo">Putumayo</option>
             <option value="Quind&iacute;o">Quind&iacute;o</option>
             <option value="Risaralda">Risaralda</option>
             <option value="San Andr&eacute;s y Providencia">San Andr&eacute;s y Providencia</option>
             <option value="Santander">Santander</option>
             <option value="Sucre">Sucre</option>
             <option value="Tolima">Tolima</option>
             <option value="Valle del Cauca">Valle del Cauca</option>
             <option value="Vaup&eacute;s">Vaup&eacute;s</option>
             <option value="Vichada">Vichada</option>
            </select>
            <span class="selectInvalidMsg">Seleccione un elemento válido.</span>
            <span class="selectRequiredMsg">Seleccione un elemento.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td><div align="center" class="Estilo1">*</div></td>
         <td>Municipio:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield3">
            <input name="municipio" id="municipio" size="50" type="text" value="<%=F.getMunicipio()%>" />
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td>
          <div align="center" class="Estilo1">*</div>
         </td>
         <td>Direcci&oacute;n:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield4">
            <input name="direccion" id="direccion" size="50" type="text" value="<%=F.getDireccion()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC">
          <div align="center"></div>
         </td>
        </tr>
        <tr>
         <td>
          <div align="center" class="Estilo1">*</div>
         </td>
         <td>Propietario:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield5">
            <input name="propietario" id="propietario" size="50" type="text" value="<%=F.getNombreProp()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 100 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td><div align="center"><span class="Estilo2">*</span></div></td>
         <td>Tipo de documento:</td>
         <td width="300">
          <div align="left"><span id="spryselect2">
            <select name="tipodoc" id="tipodoc" style="width:325px">
             <option>Seleccione uno...</option>
             <option <%=(F.getTipoDocProp().equals("RC") ? "selected='selected'" : "")%> value="RC">Registro civil</option>
             <option <%=(F.getTipoDocProp().equals("TI") ? "selected='selected'" : "")%> value="TI">Tarjeta de identidad</option>
             <option <%=(F.getTipoDocProp().equals("CC") ? "selected='selected'" : "")%> value="CC">Cedula de ciudadania</option>
             <option <%=(F.getTipoDocProp().equals("CE") ? "selected='selected'" : "")%> value="CE">Cedula de extranjeria</option>
             <option <%=(F.getTipoDocProp().equals("OO") ? "selected='selected'" : "")%> value="OO">Otro...</option>
            </select>
            <span class="selectRequiredMsg">Seleccione un elemento.</span></span></div></td>
        </tr>
        <tr>
         <td>
          <div align="center" class="Estilo1">*</div>
         </td>
         <td>C.C.:</td>
         <td width="300">			 
          <div align="left">
           <%
                       String ccprop = "";
                       if (F.getCcProp() != 0) {
                           ccprop = F.getCcProp() + "";
                       }
           %>
           <span id="sprytextfield6">
            <input name="cedula" id="cedula" size="50" type="text" value="<%=ccprop%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td><div align="center"></div></td>
         <td>Tel&eacute;fono:</td>
         <td width="300">
          <div align="left">
           <%
                       String telprop = "";
                       if (F.getTelProp() == 0) {
                           ccprop = F.getTelProp() + "";
                       }
           %>
           <span id="sprytextfield7">
            <input name="telefono" id="telefono" size="50" type="text" value="<%=telprop%>"/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC">
          <div align="center"></div>
         </td>
        </tr>
        <tr>
         <td>
          <div align="center"></div>
         </td>
         <td>Imagen:</td>
         <td width="300">
          <div align="left">
           <input name="img" type="file" id="img" size="35"/>
          </div></td>
        </tr>
       </table>
       <table width="600" cellpadding="2" cellspacing="2" class="estilo1_table">
        <tr>
         <th><input type="submit" id="enviar" value="Enviar" /></th>
         <th><input type="reset" id="limpiar" value="Borrar" /></th>
         <th><input type="button" id="enviar" value="Atr&aacute;s" onclick="history.back(-1)" /></th>
        </tr>
       </table>
      </form>
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
  <script type="text/javascript">
   <!--
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "none", {validateOn:["blur", "change"], maxChars:100});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "integer", {validateOn:["blur", "change"]});
   var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {invalidValue:"-1", validateOn:["blur", "change"]});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "none", {maxChars:50, validateOn:["blur", "change"]});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "none", {maxChars:50, validateOn:["blur", "change"]});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "none", {maxChars:100, validateOn:["blur", "change"]});
   var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6", "integer", {validateOn:["blur", "change"]});
   var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7", "integer", {validateOn:["blur", "change"], isRequired:false});
   var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2", {validateOn:["change", "blur"]});
   //-->
  </script>
 </body>
</html>
