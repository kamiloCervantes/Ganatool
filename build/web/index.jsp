<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
  <title>Ganatool Home</title>
  <meta name="keywords" content="herramientas, ganaderia, balanceo, dietas" />
  <meta name="description" content="herramienta para realizar balanceo de dietas de ganado con propósito crnico" />
  <link href="images/favicon.ico" rel="SHORCUT ICON" />
  <link rel="stylesheet" type="text/css" href="nifty/niftyCorners.css"/>
  <link rel="stylesheet" type="text/css" href="nifty/niftyPrint.css" media="print"/>
  <script src="nifty/nifty.js" type="text/javascript" language="javascript"></script>
  <link rel="stylesheet" type="text/css" href="style.css"/>
  <link href="style-jsp.css" rel="stylesheet" type="text/css" />
 </head>
 <script type="text/javascript">
  window.onload=function(){
   if(!NiftyCheck())
    return;
   Rounded("li#login","#FFF","#1a1eb2");
  }
 </script>
 <body <%=request.getParameter("onload")%>>
  <div id="header">
   <div id="menu">
    <ul>
     <li class="current_page_item"><a href="#">Home</a></li>
     <li><a href="cargarbanco.do">Banco de dietas</a></li>
     <li><a href="contacto.html">Contacto</a></li>
    </ul>
   </div>
   <!-- end #menu -->
   <div id="logo">
    <h1><a href="#"> Ganatool </a></h1>
    <h2>Herramienta para realizar balanceo de dietas de ganado vacuno</h2>
   </div>
   <!-- end #logo -->
  </div>
  <!-- end #header -->
  <div id="page">
   <div id="content">
    <div class="post">
     <h2 class="title"><a href="#">¿Qu&eacute; es Ganatool?</a></h2>
     <div class="entry">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" name="tech" width="640" height="480" align="middle" id="tech">
       <param name="allowScriptAccess" value="sameDomain" />
       <param name="movie" value="images/gallery.swf" />
       <param name="quality" value="high" />
       <embed src="images/gallery.swf" quality="high" width="640" height="480" name="tech" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
      </object>
      <p><strong>GANATOOL</strong>, es una herramienta web que le permite minimizar los costos de la alimentaci&oacute;n de los animales de su finca, usando t&eacute;cnicas de optimizaci&oacute;n matem&aacute;tica para que as&iacute; se facilite el c&aacute;lculo de la dieta &oacute;ptima para el mayor beneficio del ganado y del due&ntilde;o de la finca.</p>
      <p>Posee un panel de administraci&oacute;n en el cual se puede llevar el seguimiento de las dietas que se le aplica a cada una de las vacas y toros del hato ganadero. En esta fase del proyecto, la herramienta est&aacute; destinada a elaborar dietas para ganado con prop&oacute;sito c&aacute;rnico y lechero. Si es tu primera vez en el sitio te invitamos a que te registres <a href="registro.jsp">aqu&iacute;</a>.</p>
     </div> <!-- end div.entry -->
    </div> <!-- end div.post -->
   </div><!-- end #content -->
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
   <div style="clear: both;"></div>
  </div><!-- end #page -->
  <div id="footer-bgcontent">
   <div id="footer">
    <p>Copyright (c) 2010 Grupo 64 bits Dise&ntilde;o por FCT y Kamilo Cervantes
     <br />Desarrollado por: Jeyra Beltr&aacute;n Sierra | Kamilo Cervantes Salazar | Jes&uacute;s Miguel Herazo Hoyos</p>
   </div><!-- end #footer -->
  </div><!-- end #footer-bgcontent -->
 </body>
</html>
