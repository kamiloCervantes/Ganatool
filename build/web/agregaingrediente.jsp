<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.Ingrediente"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Ingredientes @ GANATOOL</title>
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
    RoundedTop("div#ingredientes-actions","#FFF","#112cab");
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
              // Variables a usar:
              int aviso = -1;
              Ingrediente I = new Ingrediente();
              Usuario U = new Usuario();
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
              } else {
                  response.sendRedirect("index.jsp");
              }
  %>
  <style type="text/css">
   <!--
   .Estilo2 {font-style: italic}
   .Estilo3 {
    color: #666666;
    font-style: italic;
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
     <div id="ingredientes-actions">
      <table>
       <tr id="acciones">
        <td><a href="listaringredientes.do">Listar ingredientes</a></td>
        <td class="current"><a href="agregaingrediente.jsp">Agregar ingrediente</a></td>
        <td><a href="buscaingrediente.jsp">Buscador de ingredientes</a></td>
       </tr>
      </table>
     </div>
     <div id="ingredientes-banner"></div>
     <div class="subsecciones">Agregar Ingrediente</div>
     <%
                 if (request.getParameter("aviso") != null) {
                     aviso = Integer.parseInt(request.getParameter("aviso"));
                     if (aviso == 0) {
                         I = new Ingrediente();
     %>
     <p class="msgok">Ingrediente almacenado satisfactoriamente.</p>
     <%
                          } else if (aviso == 1) {
                              I = (Ingrediente) request.getSession().getAttribute("datosIngrediente");
     %>
     <p class="msgerror">Ya existe un ingrediente con este nombre.</p>
     <%
                     }
                 }
     %>
     <div id="registro" align="center">
      <form action="agregaringrediente.do" method="post" enctype="multipart/form-data">
       <table width="600" cellspacing="0" class="estilo1_table">
        <tr valign="top">
         <td colspan="3"><em>(<span class="Estilo1">*</span>) Campo obligatorio.</em></td>
        </tr>
        <tr valign="top" class="Estilo1">
         <td colspan="3" bgcolor="#2F33CC">&nbsp;</td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td valign="top">Nombre:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield7">
            <input name="nombre" id="nombre" size="50" type="text" value="<%=I.getNombre()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td valign="top">Precio <span class="Estilo3">(en pesos colombianos)</span>:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield8">
            <input name="precio" id="precio" size="50" type="text" <%=(I.getPrecio() != 0 ? "value='" + I.getPrecio() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">Proveedor:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield9">
            <input name="proveedor" id="proveedor" size="50" type="text" value="<%=I.getProveedor()%>"/>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr valign="top" class="Estilo1">
         <td colspan="3" bgcolor="#2F33CC">&nbsp;</td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">Kcal:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield10">
            <input name="kcal" id="kcal" size="50" type="text" <%=(I.getKCal() != 0 ? "value='" + I.getKCal() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">Calcio <em class="Estilo3">(en gramos por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield11">
            <input name="calcio" id="calcio" size="50" type="text" <%=(I.getCalcio() != 0 ? "value='" + I.getCalcio() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">F&oacute;sforo <em class="Estilo3">(en gramos por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield12">
            <input name="fosforo" id="fosforo" size="50" type="text" <%=(I.getFosforo() != 0 ? "value='" + I.getFosforo() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">Prote&iacute;na <em class="Estilo3">(en gramos por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield13">
            <input name="proteina" id="proteina" size="50" type="text" <%=(I.getProteina() != 0 ? "value='" + I.getProteina() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">E<sub>d</sub><em class="Estilo3">&nbsp;&nbsp;&nbsp;(en Mcal. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield1">
            <input name="ed" id="ed" size="50" type="text" <%=(I.getED() != 0 ? "value='" + I.getED() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">E<sub>m</sub><em class="Estilo3">&nbsp;&nbsp;&nbsp;(en Mcal. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield14">
            <input name="em" id="em" size="50" type="text" <%=(I.getEM() != 0 ? "value='" + I.getEM() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">E<sub>ngan</sub><em class="Estilo3">&nbsp;&nbsp;&nbsp;(en Mcal. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield15">
            <input name="engan" id="engan" size="50" type="text" <%=(I.getENgan() != 0 ? "value='" + I.getENgan() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">E<sub>nlact</sub><em class="Estilo3">&nbsp;&nbsp;&nbsp;(en Mcal. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield16">
            <input name="enlact" id="enlact" size="50" type="text" <%=(I.getENlact() != 0 ? "value='" + I.getENlact() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">E<sub>nmant</sub><em class="Estilo3">&nbsp;&nbsp;&nbsp;(en Mcal. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield17">
            <input name="enmant" id="enmant" size="50" type="text" <%=(I.getENmant() != 0 ? "value='" + I.getENmant() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">NDT <em class="Estilo3">(en gramos por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield18">
            <input name="ndt" id="ndt" size="50" type="text" <%=(I.getNDT() != 0 ? "value='" + I.getNDT() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">Vitamina A <em class="Estilo3">(en U.I. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left"><span id="sprytextfield19">
            <input name="vita" id="vita" size="50" type="text" <%=(I.getVitaminaA() != 0 ? "value='" + I.getVitaminaA() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">
          <div align="center">*</div>
         </td>
         <td valign="top">Vitamina D <em class="Estilo3">(en U.I. por Kg.)</em>:</td>
         <td width="300">			  
          <div align="left"><span id="sprytextfield20">
            <input name="vitd" id="vitd" size="50" type="text" <%=(I.getVitaminaD() != 0 ? "value='" + I.getVitaminaD() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">Extracto et&eacute;reo:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield21">
            <input name="extetereo" id="extetereo" size="50" type="text" <%=(I.getExtEtereo() != 0 ? "value='" + I.getExtEtereo() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">Ceniza:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield22">
            <input name="ceniza" id="ceniza" size="50" type="text" <%=(I.getCeniza() != 0 ? "value='" + I.getCeniza() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">Fibra:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield23">
            <input name="fibra" id="fibra" size="50" type="text" <%=(I.getFibra() != 0 ? "value='" + I.getFibra() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">FDA:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield24">
            <input name="fda" id="fda" size="50" type="text" <%=(I.getFDA() != 0 ? "value='" + I.getFDA() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">FDS:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield25">
            <input name="fds" id="fds" size="50" type="text" <%=(I.getFDS() != 0 ? "value='" + I.getFDS() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">FDN:</td>
         <td width="300">			  
          <div align="left"><span id="sprytextfield26">
            <input name="fdn" id="fdn" size="50" type="text" <%=(I.getFDN() != 0 ? "value='" + I.getFDN() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td valign="top" class="Estilo1">&nbsp;</td>
         <td valign="top">Humedad:</td>
         <td width="300">			  
          <div align="left">
           <span id="sprytextfield27">
            <input name="humedad" id="humedad" size="50" type="text" <%=(I.getHumedad() != 0 ? "value='" + I.getHumedad() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
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
   var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7", "none", {maxChars:50, validateOn:["blur", "change"]});
   var sprytextfield8 = new Spry.Widget.ValidationTextField("sprytextfield8", "currency", {format:"dot_comma", validateOn:["blur", "change"], minValue:0});
   var sprytextfield9 = new Spry.Widget.ValidationTextField("sprytextfield9", "none", {isRequired:false, validateOn:["blur", "change"], maxChars:50});
   var sprytextfield10 = new Spry.Widget.ValidationTextField("sprytextfield10", "real", {validateOn:["blur", "change"]});
   var sprytextfield11 = new Spry.Widget.ValidationTextField("sprytextfield11", "real", {validateOn:["blur", "change"]});
   var sprytextfield12 = new Spry.Widget.ValidationTextField("sprytextfield12", "currency", {validateOn:["blur", "change"]});
   var sprytextfield13 = new Spry.Widget.ValidationTextField("sprytextfield13", "real", {validateOn:["blur", "change"]});
   var sprytextfield14 = new Spry.Widget.ValidationTextField("sprytextfield14", "real", {validateOn:["blur", "change"]});
   var sprytextfield15 = new Spry.Widget.ValidationTextField("sprytextfield15", "real", {validateOn:["blur", "change"]});
   var sprytextfield16 = new Spry.Widget.ValidationTextField("sprytextfield16", "real", {validateOn:["blur", "change"]});
   var sprytextfield17 = new Spry.Widget.ValidationTextField("sprytextfield17", "real", {validateOn:["blur", "change"]});
   var sprytextfield18 = new Spry.Widget.ValidationTextField("sprytextfield18", "real", {validateOn:["blur", "change"]});
   var sprytextfield19 = new Spry.Widget.ValidationTextField("sprytextfield19", "real", {validateOn:["blur", "change"]});
   var sprytextfield20 = new Spry.Widget.ValidationTextField("sprytextfield20", "real", {validateOn:["blur", "change"]});
   var sprytextfield21 = new Spry.Widget.ValidationTextField("sprytextfield21", "real", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield22 = new Spry.Widget.ValidationTextField("sprytextfield22", "real", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield23 = new Spry.Widget.ValidationTextField("sprytextfield23", "real", {validateOn:["blur", "change"], isRequired:false});
   var sprytextfield24 = new Spry.Widget.ValidationTextField("sprytextfield24", "real", {validateOn:["blur", "change"], isRequired:false});
   var sprytextfield25 = new Spry.Widget.ValidationTextField("sprytextfield25", "real", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield26 = new Spry.Widget.ValidationTextField("sprytextfield26", "real", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield27 = new Spry.Widget.ValidationTextField("sprytextfield27", "real", {isRequired:false, validateOn:["blur", "change"]});
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "real", {validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
