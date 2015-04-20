//notar el protocolo.. es 'ws' y no 'http'
        var wsUri = "ws://192.168.1.70:8080/StrongFit/endpoint";
        var websocket = new WebSocket(wsUri); //creamos el socket

        var solicitud = '';
        var sesionDestinatario = '';
        var idUsuario = '';
        
        function setUsuario(usr){
            idUsuario = usr;
            websocket.send(idUsuario);
        }

        websocket.onopen = function(evt) { //manejamos los eventos...
            if(idUsuario === ''){
                websocket.send(idUsuario);
            }//... y aparecerá en la pantalla
        };
        websocket.onmessage = function(evt) { // cuando se recibe un mensaje
            var diferenciar = evt.data.split(',');
            if(diferenciar[0] === 's3sI0NamIgO9321djzlqoicnzskaak1795edsklvsnd'){
                var amigos = document.getElementsByClassName(diferenciar[2])[0];
                amigos.value = diferenciar[1];
                if($('#destinatario').val() === diferenciar[2]){
                    sesionDestinatario = diferenciar[1];
                }
            }
            else{
                $('#log').animate({
                    scrollTop: $('.mensaje').last().height() * 200
                });
                log("<div class = 'destinatarioDiv'><div class = 'destinatario msj'>" + evt.data + "</div></div>");
            }
        };
        websocket.onerror = function(evt) {
            log("oho!.. error:" + evt.data);
        };
        function enviarMensaje() {

            $(function(){
                $('#log').animate({
                    scrollTop: $('.mensaje').last().height() * 200
                });
                websocket.send( idUsuario + ',' + $('#destinatario').val() + ',' + mensajeTXT.value + ',' + sesionDestinatario);
                log("<div class = 'remitenteDiv'><div class = 'remitente msj'>" + mensajeTXT.value + "</div></div>");
            });

        }
        function log(mensaje) { //aqui mostrará el LOG de lo que está haciendo el WebSocket
            var logDiv = document.getElementById("log");
            logDiv.innerHTML += (mensaje + '<br/>');
        }


        var evitarRepeticion = "";

        function activarMensajes(desti, cont, idS){    
            $(function(){
                $('#destinatario').val(desti);
                sesionDestinatario = $('#ses'+cont).val();

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

                            if(respuesta.tipo === "medico"){
                                $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula).removeClass('invisible');
                                $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                                $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
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
                                $('#cedulaChat').addClass('invisible');
                                $('#carreraChat').addClass('invisible');
                                $('#escuelaChat').addClass('invisible');
                                if(respuesta.amistad === "no"){
                                    $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
                                }
                                else{
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
    /*
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

        }*/

        function enviarEnter(e) {
                    var keynum;
                    if (window.event) {
                            /*IE*/
                            keynum=e.keyCode;
                    }
                    if (e.which) {
                            //Netscape Firefox Opera
                            keynum=e.which;
                    }
                    if (keynum===13) {
                        var enter = document.getElementById("enter");
                        if(enter.checked){
                            var txtarea = document.getElementById("mensajeTXT");
                            enviarMensaje();
                            txtarea.value="";
                            return false;
                        }
                    } 
                    else{
                            return true;
                    }
            }

        /*function str_replace($cambia_esto, $por_esto, $cadena) {
            return $cadena.split($cambia_esto).join($por_esto);
         }

         //Valida que no sean ingresado ENTER dentro del textarea
         function Textarea_Sin_Enter($char, $id){
            //alert ($char);
            $textarea = document.getElementById($id);

            if($char === 13){
                var enter = document.getElementById("enter");
                if(enter.checked || $textarea.value === ""){
                    $texto_escapado = escape($textarea.value);
                    if(navigator.appName === "Opera" || navigator.appName === "Microsoft Internet Explorer"){
                        $texto_sin_enter = str_replace("%0D%0A", "", $texto_escapado);
                    }
                    else {
                        $texto_sin_enter = str_replace("%0A", "", $texto_escapado);
                    }
                    $textarea.value = unescape($texto_sin_enter);

                }
            }
         }*/

    function buscarUsuario(){
        $(function(){
            $('#search').autocomplete({
    //busqueda del alimento
    source: function(request, response){
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sBusquedaUsuario',
            type: 'post',
            dataType: 'json',
            data: {
                info : request.term
            },
            //respuesta del servidor
            success: function(respuesta){
                response(respuesta);
            }
        });
    },
    //esta funcion se ejecuta al seleccionar
    select: ver
});
        });
    }

function ver(e, res){
    evitarRepeticion = "";
    solicitud = res.item.correo;
    $.ajax({
        url: 'http://localhost:8080/StrongFit/sGetInfoUsuario',
        type: 'post',
        dataType: 'json',
        data: {
            desti: res.item.correo
        },
        success: function(respuesta){
            document.getElementById("imagenDesti").src = respuesta.imagen;

            $('#nombreChat').html("Nombre: "+respuesta.nombre);
            $('#correoChat').html("Correo: "+respuesta.correo);

            if(respuesta.tipo === "medico"){
                $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula).removeClass('invisible');
                $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
                if(respuesta.amistad === "no"){
                    $('#botonSolicitud').val("Enviar solicitud de Nutriólogo").removeClass('invisible');
                }
            }
            else{
                $('#cedulaChat').addClass('invisible');
                $('#carreraChat').addClass('invisible');
                $('#escuelaChat').addClass('invisible');
                if(respuesta.amistad === "no"){
                    $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
                }
            }
        }
    });
}

function enviarSolicitud(){
    $(function(){
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sEnviarSolicitud',
            type: 'post',
            dataType: 'json',
            data: {
                idOtro: solicitud
            },
            success: function(respuesta){
                $('#botonSolicitud').addClass('invisible');
            }
        });
    });
}

function responderSolicitud(respuesta, idOtro, idEtiqueta){
    $(function(){
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sAceptaRechazaSolicitud',
            type: 'post',
            dataType: 'json',
            data: {
                idOtro: idOtro,
                respuesta: respuesta
            },
            success: function(res){
                console.log(idEtiqueta);
                $('#solicitud'+idEtiqueta).addClass('invisible');
            }
        });
    });
}
