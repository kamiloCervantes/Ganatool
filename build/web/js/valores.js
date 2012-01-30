// Funcion para la carga de etapas fisiologicas.
function etapas() {
 etapa = document.forms['form1'].elements['etapa'];
 prop = document.forms['form1'].elements['produccion'].value;
 sexo = document.forms['form1'].elements['sexo'].value;
 if (prop == "L") {
  etapa.options[0] = new Option("Seleccione una...","");
  etapa.options[1] = new Option("Cria","Cria");
  etapa.options[2] = new Option("Levante","Levante");
  etapa.options[3] = new Option("Madurez","Madurez");
  if (sexo == 'F') {
   etapa.options[4] = new Option("Preñez ultimos meses","Preñez ultimos meses");
   etapa.options[5] = null;
  } else if (sexo == 'M'){
   etapa.options[5] = null;
   etapa.options[4] = null;
  }
 } else if (prop == "C") {
  etapa.options[0] = new Option("Seleccione una...","");
  etapa.options[1] = new Option("Cria","Cria");
  etapa.options[2] = new Option("Finalizacion","Finalizacion");
  if (sexo == 'F') {
   etapa.options[3] = new Option("Preñez 4 - 6 meses","Preñez 4 - 6 meses");
   etapa.options[4] = new Option("Preñez ultimos meses","Preñez ultimos meses");
   etapa.options[5] = new Option("Postparto","Postparto");
  } else if (sexo == 'M') {
   etapa.options[5] = null;
   etapa.options[4] = null;
   etapa.options[3] = new Option("Madurez","Madurez");
  }
 } else {
  while (etapa.options.length > 0)
   etapa.options[0] = null;
  etapa.options[0] = new Option("Seleccione una...","");
 }
}