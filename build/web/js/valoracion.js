function putStar(idstar){
 star=document.getElementById(idstar);
 star.src='images/star.png';
}

function putSelectedStar(tidstar){
 star=document.getElementById(tidstar);
 star.style.border= "1px solid orange";
}

function removeStar(idstar){
 star=document.getElementById(idstar);
 star.src='images/starb.png';
}

function removeSelectedStar(tidstar){
 star=document.getElementById(tidstar);
 star.style.border= "0px";
}	

function QuitarValoracion(){
 removeStar('star1');
 removeStar('star2');
 removeStar('star3');
 removeStar('star4');
 removeStar('star5');
}

function QuitarSeleccion(){
 removeSelectedStar('tstar1');
 removeSelectedStar('tstar2');
 removeSelectedStar('tstar3');
 removeSelectedStar('tstar4');
 removeSelectedStar('tstar5');
}

function PonerValoracion(valoracion){
 QuitarValoracion();
 switch(valoracion){
  case '1':
   putStar('star1');
   break
  case '2':
   putStar('star1');
   putStar('star2');
   break
  case '3':
   putStar('star1');
   putStar('star2');
   putStar('star3');
   break
  case '4':
   putStar('star1');
   putStar('star2');
   putStar('star3');
   putStar('star4');
   break
  case '5':
   putStar('star1');
   putStar('star2');
   putStar('star3');
   putStar('star4');
   putStar('star5');
   break
 }
}

function GuardarValoracion(valoracion){
 QuitarSeleccion();
 val = document.getElementById('valoracion');
 switch(valoracion){
  case '1':
   val.value = '1';
   putSelectedStar('tstar1');
   break
  case '2':
   val.value = '2';
   putSelectedStar('tstar2');
   break
  case '3':
   val.value = '3';
   putSelectedStar('tstar3');
   break
  case '4':
   val.value = '4';
   putSelectedStar('tstar4');
   break
  case '5':
   val.value = '5';
   putSelectedStar('tstar5');
   break
 }
}
