/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(init);

function init(){
    $('#reqnutricionales select').on('change',accionusuario);
    $("#modregnutricional").validationEngine();
    $("#modregform").on('scroll', function(){
        $("#modregnutricional").validationEngine('hide');
    });
}

function accionusuario(){
    if($(this).val()=="Modificar"){
         window.location='modificarregistrocarne.do?action=1&id='+$(this).attr('id');
        }
}

