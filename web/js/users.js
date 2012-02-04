/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(init);

function init(){
    $('#usuarios select').on('change',accionusuario);
    $("#adduser").fancybox();
    $("#agregarusuario").validationEngine();
    $("#adduserform").on('scroll', function(){
        $("#agregarusuario").validationEngine('hide');
    });
}

function accionusuario(){
    if($(this).val()=="Eliminar"){
        if(confirm("Esta a punto de eliminar el usuario "+$(this).attr('id'))){
             window.location='eliminarusuario.do?elim_user='+$(this).attr('id');
        }
    }
    else{
         if($(this).val()=="Modificar"){
            window.location='modificarusuario.do?action=1&username='+$(this).attr('id');
        }
    }
       
}

