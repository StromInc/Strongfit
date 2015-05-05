function mostrarMsjSol(id){
    $(function(){
        if(id === 'divMenuMsj'){
            if($('#divMsj').hasClass('invisible')){
                $('#divMsj').removeClass('invisible');
            }
            $('#divSol').addClass('invisible');
        }
        else{
            if($('#divSol').hasClass('invisible')){
                $('#divSol').removeClass('invisible');
            }
            $('#divMsj').addClass('invisible');
        }
        
        $('.divGeneralSolMsj').animate({
            height: $('#articlePerfilMsjSol').height()
        }, 500, function(){
            $('#subir').removeClass('invisible');
        });
    });
}

function mostrarPerfilOtro(){
    $('#divSol').addClass('invisible');
    $('#divMsj').addClass('invisible');
}

function subirAlPerfil(){
    $(function(){
        $('#subir').addClass('invisible');
        $('#divSol').addClass('invisible');
        $('#divMsj').addClass('invisible');
        $('.divGeneralSolMsj').animate({
            height: 0
        }, 500);
    });
}