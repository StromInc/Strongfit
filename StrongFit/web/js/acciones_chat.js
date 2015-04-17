var evitarRepeticion = "";

function activarMensajes(desti, ses, idS){    
    $(function(){
        $('#destinatario').val(desti);
        $('#ses').val(ses);
        
        if(evitarRepeticion !== desti){
            evitarRepeticion = desti;
            $('#log').html("");
            $('#log').html('<div class="mensaje" ></div>');
            $.ajax({
                url:'http://localhost:8080/StrongFit/sGetConversaciones',
                type: 'post',
                dataType: 'json',
                data:{
                    otroUsuario: desti
                },
                success: function(respuesta){
                    var $item = $('.mensaje').first();
                    var $clone;
                    var remitentes = [];
                    var mensajes = [];
                    for(var valor in respuesta){
                        remitentes.push(respuesta[valor].remitente);
                        mensajes.push(respuesta[valor].mensaje);
                    }

                    var idM =0;
                    for(var i = remitentes.length - 1; i >= 0; --i){
                        $clone = $item.clone();
                        idM = 'm' + i;

                        if(remitentes[i] === idS){
                            $clone.addClass('remitenteDiv');
                            $clone.html("<div class='remitente msj' id='"+idM+"'  >" + mensajes[i] + "</div>");
                            $clone.appendTo('#log'); 
                        }
                        else{
                            $clone.addClass('destinatarioDiv');
                            $clone.html("<div class='destinatario msj' id='"+idM+"' >" + mensajes[i] + "</div>");
                            $clone.appendTo('#log');
                        }
                    }
                    $('#log').animate({
                        scrollTop: $('#m0').height() * remitentes.length * 2
                    }, 200, function(){
                        traerDatos();
                        //$("html, body").animate({ scrollTop: $("#myID").scrollTop() }, 1000);
                    });
                }
            });
        }
        
        function traerDatos(){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sGetInfoUsuario',
                type: 'post',
                dataType: 'json',
                data: {
                    desti: desti
                },
                success: function(respuesta){
                    document.getElementById("imagenDesti").src = respuesta.imagen;
                    
                    $('#nombreChat').html("Nombre: "+respuesta.nombre);
                    $('#correoChat').html("Correo: "+respuesta.correo);
                    
                    console.log(respuesta.amistad);
                    if(respuesta.tipo === "medico"){
                        $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula);
                        $('#carreraChat').html("Carrera: "+respuesta.carrera);
                        $('#escuelaChat').html("Escuela: "+respuesta.escuela);
                        if(respuesta.amistad === "no"){
                            $('#botonSolicitud').val("Enviar solicitud de Nutriólogo").removeClass('invisible');
                        }
                        else{
                            if(!$('#botonSolicitud').hasClass('invisible')){
                                $('#botonSolicitud').addClass('invisible');
                            }
                        }
                    }
                    else{
                        if(respuesta.amistad === "no"){
                            $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
                        }
                        else{
                            alert('hola');
                            if(!$('#botonSolicitud').hasClass('invisible')){
                                $('#botonSolicitud').addClass('invisible');
                            }
                        }
                    }
                }
            });
        }
    });
}

function cargaSes(){
    
    setInterval(cSes, 60000);
    
}


function cSes(){
    

    $(function(){
        
        var valor = "";
        var con = 0;
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sConectarSes',
            type: 'POST',
            dataType: 'XML',
            data: valor,
            success: function(data){
                $(data).find('sesiones').each(function(){
                    $(this).find("usuario").each(function(){
                        var idU = "";
                        var ses = "";
                        $(this).find("idU").each(function(){
                            idU = $(this).text();
                        });
                        $(this).find("ses").each(function(){
                           ses = $(this).text();
                        });
                        if($('#usr'+con).val() !== idU){
                            $('#ses'+con).val(ses);
                            if($('#destinatario').val() === idU){
                                $('#ses').val(ses);
                            }
                        }
                        con = con + 1;
                    });
                });
            }
        });
        
    });
    
}

function enviarEnter(evento){
    $(function(){
        var keyCode;
        if (evento.which || evento.charCode) {
            keyCode = evento.which ? evento.which : evento.charCode;
            //return (keyCode != 13);
        }
        else if (window.event)
        {
            keyCode = event.keyCode;
            if (keyCode === 13)
            {
                if (event.keyCode)
                    event.keyCode = 9;
            }
        }

        if (keyCode === 13)
        {
            var enter = document.getElementById("enter");
            if(enter.checked){
                log($('#mensajeTXT').html());
                $('#mensajeTXT').val("");
                return false;
            }
        }
        return true;
    });
}

