<%@page import="Objetos.Finca"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objetos.Usuario"%>
<%@page import="Objetos.Res"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>Ganado @ GANATOOL</title>
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
  <script src="js/valores.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
   onload=function()
   {
    if(!NiftyCheck())
     return;
    Rounded("div.contenedorlista","#FFF","#115599","160px");
    RoundedTop("div#global-actions","#FFF","#112cab");
   }
  </script>
  <script type="text/javascript" src="js/valores.js"></script>
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
              Res R = new Res();
              Usuario U = null;
              ArrayList<Res> reses = null;
              ArrayList<Finca> fincas = new ArrayList<Finca>();
              if (request.getSession().getAttribute("usuario") != null) {
                  U = (Usuario) request.getSession().getAttribute("usuario");
                  if (request.getSession().getAttribute("fincas") != null) {
                      fincas = (ArrayList<Finca>) request.getSession().getAttribute("fincas");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }

                  if (request.getSession().getAttribute("res") != null) {
                      R = (Res) request.getSession().getAttribute("res");
                  } else {
                      response.sendRedirect("panelvet.jsp");
                  }

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
     <div id="global-actions">
      <table>
       <tr id="acciones">
        <td><a href="listarreses.do">Listar reses</a></td>
        <td class="current"><a href="nuevares.do">Agregar res</a></td>
        <td><a href="buscares.jsp">Buscador de reses</a></td>
       </tr>
      </table>
     </div>
     <div id="reses-banner"></div>
     <div class="subsecciones">Modificar Res <%=R.getCodigo()%></div>
     <div id="registro" align="center">
      <%
                  if (request.getParameter("aviso") != null) {
                      aviso = Integer.parseInt(request.getParameter("aviso"));
                      if (aviso == 1) {
      %>
      <p class="msgerror">Ya existe una Res con este codigo en esta finca.</p>
      <%                      }
                  }
                  if (fincas.size() == 0) {
      %>
      <p class="msgerror">No tiene fincas registradas por lo cual no puede agregar nuevas reses.</p>
      <%                        } else {
      %>
      <form name="form1" id="form1" action="modificarres.do" method="post">
          <input type="hidden" name="proposito" value="<%=R.getProposito()%>"/>
          <input type="hidden" name="codigo" value="<%=R.getCodigo()%>"/>
          <input type="hidden" name="nitfinca" value="<%=R.getNitFincaActual() %>"/>
       <table width="600" cellspacing="0" class="estilo1_table">
        <tr>
         <td colspan="3"><div align="left"><em>(<span class="Estilo1">*</span>) Campo obligatorio.</em></div></td>
        </tr>
        <tr>
         <td colspan="3" bgcolor="#2F33CC"><div align="center"></div></td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo1">*</div>
         </td>
         <td>Sexo:</td>
         <td width="300">
          <div align="left">
           <span id="spryselect5">
            <select name="sexo" if="sexo" style="width:325px" onchange="etapas()">
             <option>Seleccione uno...</option>
             <option <%=(R.getSexo() == 'M' ? "selected='selected'" : "")%> value="M">Macho</option>
             <option <%=(R.getSexo() == 'F' ? "selected='selected'" : "")%> value="F">Hembra</option>
            </select>
            <span class="selectRequiredMsg">Seleccione un elemento.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Peso Actual <span class="Estilo3">(en kilogramos)</span>:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield2">
            <input name="peso" id="peso" size="50" type="text" <%=(R.getPeso() != 0 ? "value='" + R.getPeso() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Cantidad de alimento<span class="Estilo3"> (en kilogramos)</span>:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield3">
            <input name="cantalimento" id="cantalimento" size="50" type="text" <%=(R.getCantAlimentoDiario() != 0 ? "value='" + R.getCantAlimentoDiario() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Edad <span class="Estilo3">(en meses)</span>:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield4">
            <input name="edad" id="edad" size="50" type="text" <%=(R.getEdad() != 0 ? "value='" + R.getEdad() + "'" : "")%>/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span>
           </span
           ></div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Etapa fisiol&oacute;gica:</td>
         <td width="300">
          <div align="left">
           <span id="spryselect2">
            <select name="etapa" id="etapa" style="width:325px">
             <% if (!R.getEtapaFisiologica().isEmpty()) {%>
             <option value="<%=R.getEtapaFisiologica()%>"><%=R.getEtapaFisiologica()%></option>
             <option disabled="true">---------------</option>
             <% } else {%>
             <option>Seleccione una...</option>
             <% }%>
            </select>
            <span class="selectRequiredMsg">Seleccione un elemento.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Raza:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield5">
            <input name="raza" id="raza" size="50" type="text" value="<%=R.getRaza()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
        <tr>
         <td class="Estilo1">
          <div align="center" class="Estilo2">*</div>
         </td>
         <td>Propietario:</td>
         <td width="300">
          <div align="left">
           <span id="sprytextfield6">
            <input name="propietario" id="propietario" size="50" type="text" value="<%=R.getPropietario()%>"/>
            <span class="textfieldRequiredMsg">Se necesita un valor.</span>
            <span class="textfieldMaxCharsMsg">M&aacute;ximo 50 caracteres.</span>
           </span>
          </div>
         </td>
        </tr>
      
        <tr>
         <% 
            if(R.getProposito()=='L'){
           %>   
         <td colspan="3" bgcolor="#2F33CC">
          <div align="center"></div>
         </td>
        </tr>
        <tr>
         <td>
         </td>
         <td>Cantidad de leche <span class="Estilo3">(en litros)</span>:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield7">
            <input name="cantleche3" id="cantleche3" size="50" type="text" <%=(R.getCantLecheDiaria() != 0 ? "value='" + R.getCantLecheDiaria() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span></span></div>
         </td>
        </tr>
        <tr>
         <td>&nbsp;</td>
         <td>% grasa de la leche:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield8">
            <input name="cantleche" id="cantleche" size="50" type="text" <%=(R.getPorcGrasaLeche() != 0 ? "value='" + R.getPorcGrasaLeche() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span><span class="textfieldMaxValueMsg">El valor debe estar entre 0 y 100.</span></span></div>
         </td>
        </tr>
        <tr>
         <td>&nbsp;</td>
         <td>&Uacute;ltimo parto<span class="Estilo3"> (aaaa-mm-dd)</span>:</td>
         <td width="300">
          <div align="left"><span id="sprytextfield9">
            <input name="cantleche2" id="cantleche2" size="50" type="text" <%=(R.getUltimoParto() != null ? "value='" + R.getUltimoParto() + "'" : "")%>/>
            <span class="textfieldInvalidFormatMsg">Formato no válido.</span></span></div>
         </td>
        </tr>
            <% } %>
       </table>
       <table width="600" cellpadding="2" cellspacing="2" class="estilo1_table">
        <tr>
         <th><input type="submit" id="enviar" value="Enviar" /></th>
         <th><input type="reset" id="limpiar" value="Borrar" /></th>
         <th><input type="button" id="enviar" value="Atr&aacute;s" onclick="history.back(-1)" /></th>
        </tr>
       </table>
      </form>
      <%
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
  <script type="text/javascript">
   <!--
   var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {validateOn:["blur", "change"]});
   var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "real", {validateOn:["blur", "change"], minValue:0});
   var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {validateOn:["blur", "change"]});
   var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "real", {validateOn:["blur", "change"], minValue:0});
   var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "integer", {validateOn:["blur", "change"], minValue:0});
   var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "none", {validateOn:["blur", "change"], maxChars:50});
   var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6", "none", {validateOn:["blur", "change"], maxChars:50});
   var spryselect5 = new Spry.Widget.ValidationSelect("spryselect5", {validateOn:["blur", "change"]});
   var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2", {validateOn:["change", "blur"]});
   var spryselect3 = new Spry.Widget.ValidationSelect("spryselect3", {validateOn:["blur", "change"]});
   var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7", "real", {minValue:0, validateOn:["blur", "change"], isRequired:false});
   var sprytextfield8 = new Spry.Widget.ValidationTextField("sprytextfield8", "real", {minValue:0, maxValue:100, validateOn:["blur", "change"], isRequired:false});
   var sprytextfield9 = new Spry.Widget.ValidationTextField("sprytextfield9", "date", {format:"yyyy-mm-dd", isRequired:false, validateOn:["blur", "change"]});
   //-->
  </script>
 </body>
</html>
