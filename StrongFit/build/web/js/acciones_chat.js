var idDieta = "";

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


//-------------------------Esto solo aplica al nutriologo-----------------------------------------------------------------------
function mostrarMenu(id){
    $(function(){
        var ids = ['contenedorChatNutriologo', 'contenedorInfoPaciente', 'contenedorEstaPaciente', 'contenedorDietPaciente'];
        for(var i = 0; i < ids.length; ++i){
            if(id === ids[i]){
                if($("#"+id).hasClass('invisible')){
                    $("#"+id).removeClass('invisible');
                }
            }
            else{
                if(!$("#"+ids[i]).hasClass('invisible')){
                    $("#"+ids[i]).addClass('invisible');
                }
            }
        }
    });
}


function allowDrop(ev) {
    ev.preventDefault();
}

/*se dispara cuando alguien arrastra un elemento*/
function drag(ev, id) {
    /*obtiene el tipo de dato que se esta arrastrando*/
    ev.dataTransfer.setData("text", ev.target.id);
    idDieta = id;
}

/*Se dispara cuando alguien suelta un elemento en el formulario, ademas activara la funcion ajax*/
function drop(ev) {
    $(function(){
        
        ev.preventDefault();
        
        var formulario = document.getElementById("divDietasPaciente");
        var dat = ev.dataTransfer.getData("text");
        
        formulario.appendChild(document.getElementById(dat));
    });
}

