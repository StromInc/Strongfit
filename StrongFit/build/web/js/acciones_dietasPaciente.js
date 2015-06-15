/*se dispara para evitar cualquier cosa por default que ocurra como que se envie un formulario con el boton submit*/
function allowDrop(ev) {
    ev.preventDefault();
}

/*se dispara cuando alguien arrastra un elemento*/
function drag(ev) {
    /*obtiene el tipo de dato que se esta arrastrando*/
    ev.dataTransfer.setData("text", ev.target.id);
}

/*Se dispara cuando alguien suelta un elemento en el formulario, ademas activara la funcion ajax*/
function drop(ev) {
    $(function(){
        
        ev.preventDefault();
        
        var formulario = document.getElementById("formularioDietasPaciente");
        var divF = document.getElementById("divForm");
        var dat = ev.dataTransfer.getData("text");
        
        
        
        var idD = $('#'+dat).children('.idDOculto').first().val();
        $('#inputQuitar').val("no");
        $('#spanIn').addClass("invisible");
        
        divF.appendChild(document.getElementById(dat));
        
        var primero = $('#divForm .Figure-dietas').first().children('.idDOculto').first().val();
        //funcion para enviar la dieta de una por una para su registro
        $.ajax({
            
            url:"http://localhost:8080/StrongFit/sDietasUsr",
            type: 'POST',
            dataType: 'json',
            data: {
                idDieta: idD,
                quitar: 'no',
                primero: primero
            },
            success: function(datos){
                console.log("Exito");
            }
            
        })
        .done(function(){
            console.log("Actualización exitosa");
        })
        .fail(function(){
            alert("Parece que hubo un error, por favor vuelve a intentarlo");
        })
        .always(function(){
            console.log("Proceso terminado exitoso o no.");
        });
    });
}

/*se dispara cuando alguien suelta un elementon en el contenedor de las dietas*/
function dropDiv(ev) {
    $(function(){
        
        ev.preventDefault();
        
        var form = document.getElementById("quitarForm");
        var div = document.getElementById("divDietasPaciente");
        var data = ev.dataTransfer.getData("text");
        
        var idDie = $('#'+data+' .siguiendo').first().val();
        
        var ocultas = document.getElementsByClassName("ocultas");
        var figure = document.getElementsByClassName("sugeridas");
        var idR;
//        console.log(figure[1]);
        for(var i = 0; i < figure.length; ++i){
            if(ocultas[i].value === idDie){
                idR = $('#'+figure[i].id).parent().attr("id");
            }
        }
        
        
        var idFineal = document.getElementById(idR);
        
        form.appendChild(document.getElementById(data));
        $('#inputQuitar2').val("si");
        
        idFineal.appendChild(document.getElementById(data));
        
        var idD = $('#'+data).children('.idDOculto').first().val();
        var primero = $('#divForm .Figure-dietas').first().children('.idDOculto').first().val();
        debugger;
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sDietasUsr',
            type: 'POST',
            dataType: 'json',
            data: {
                idDieta: idD,
                quitar: 'si',
                primero: primero
            }
            
        })
        .done(function(){
            console.log("Actualización exitosa");
        })
        .fail(function(){
            alert("Parece que hubo un error, por favor vuelve a intentarlo");
        })
        .always(function(){
            console.log("Proceso terminado exitoso o no.");
        });
        
        
        $('.img-dietas').removeClass("invisible");
        if ($('#divForm').innerHTML === "") 
        {
            $("#spanIn").removeClass("invisible");
        }
    });
}

function ocultarDietas(){
    $(function(){
        var ocultas = document.getElementsByClassName("ocultas");
        var siguiendo = document.getElementsByClassName("siguiendo");
        var figure = document.getElementsByClassName("sugeridas");
//        console.log(figure[1]);
        for(var i = 0; i < figure.length; ++i){
            for(var j = 0; j < siguiendo.length; ++j){
                if(ocultas[i].value === siguiendo[j].value){
                    figure[i].className += " invisible";
                }
            }
        }
//        verHijos();
    });
}

//function acomodarDietas(idD){
//    $(function(){
//        var ocultas = document.getElementsByClassName("ocultas");
//        var figure = document.getElementsByClassName("sugeridas");
////        console.log(figure[1]);
//        for(var i = 0; i < figure.length; ++i){
//            if(ocultas[i].value === idD){
//                console.log(($('#'+figure[i].id).parent().attr("id")));
//                
//                var lele = $('#'+figure[i].id).parent().attr("id");
//                return lele;
//            }
//        }
//    });
//}

function verHijos(){
    $(function(){
        var cont = document.getElementsByClassName("contenedoresDietas2");
        var texto = "";
        for(var i = 1; i <= cont.length; ++i){
//            console.log($('#contenedorDietas'+i+ ' .sugeridas').hasClass('invisible'));
            if($('#contenedorDietas'+i+ ' .sugeridas').hasClass('invisible')){
                texto = $('#contenedorDietas'+i).html();
                $('#contenedorDietas'+i).html(texto + "<p>Ya no hay más dietas sugeridas para tí por este nutriólogo.</p>");
            }
        }
    });
}

