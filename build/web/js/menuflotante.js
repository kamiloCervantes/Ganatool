onload=function()
 {
  alert('Hola');
	
  if(!NiftyCheck())
   return;
  Rounded("div.contenedorlista","#FFF","#115599","160px");

  cAyuda=document.getElementById("mensajesAyuda");
  cNombre=document.getElementById("ayudaTitulo");
  cTex=document.getElementById("ayudaTexto");
  form=document.getElementById("form1");
  ayuda=new Array();
  ayuda["NombreLogin"]="Ingresa tu nombre de usuario. De 1 a 20 caracteres. OBLIGATORIO";
  ayuda["PasswordLogin"]="Ingresa tu contraseña de usuario. De 1 a 20 caracteres. OBLIGATORIO";
  ayuda["Telefono"]="Ingresa un teléfono de contacto.";
  ayuda["Correo"]="Ingresa un e-mail válido. OBLIGATORIO";
  ayuda["Comentario"]="Ingresa tus comentarios. De 5 a 500 caracteres. OBLIGATORIO";

	
 }

if(navigator.userAgent.indexOf("MSIE")>=0) navegador=0;
else navegador=1;

function colocaAyuda(event)
{
 if(navegador==0)
 {
  var corX=window.event.clientX+document.documentElement.scrollLeft;
  var corY=window.event.clientY+document.documentElement.scrollTop;
 }
 else
 {
  var corX=event.clientX+window.scrollX;
  var corY=event.clientY+window.scrollY;
 }
 cAyuda.style.top=corY+-90+"px";
 cAyuda.style.left=corX+15+"px";
}

function ocultaAyuda()
{
 cAyuda.style.display="none";
 if(navegador==0)
 {
  document.detachEvent("onmousemove", colocaAyuda);
  document.detachEvent("onmouseout", ocultaAyuda);
 }
 else
 {
  document.removeEventListener("mousemove", colocaAyuda, true);
  document.removeEventListener("mouseout", ocultaAyuda, true);
 }
}

function muestraAyuda(event, campo)
{
 colocaAyuda(event);

 if(navegador==0)
 {
  document.attachEvent("onmousemove", colocaAyuda);
  document.attachEvent("onmouseout", ocultaAyuda);
 }
 else
 {
  document.addEventListener("mousemove", colocaAyuda, true);
  document.addEventListener("mouseout", ocultaAyuda, true);
 }

 cNombre.innerHTML=campo;
 cTex.innerHTML=ayuda[campo];
 cAyuda.style.display="block";
}



