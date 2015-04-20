<%@page import="clases.cConexion"%>
<%@page session = "true" %>
<%!
    cConexion conecta = new cConexion();
%>
<%
    HttpSession sesion2 = request.getSession();
    conecta.conectar();
    String dom = conecta.getDominio();
    String idUsuarioBarra = (String)sesion2.getAttribute("idUsr");
    String tipo = (String) sesion2.getAttribute("tipodeus");
    if(!tipo.equals("1")){
        %><script>alert('Upps, parece que no tienes permiso para acceder a esta parte');</script>");<%
        response.sendRedirect("../../index.jsp");
    }
%>
<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->
<script src = "../../js/acciones_dietasusr.js"></script>
<script>
             //notar el protocolo.. es 'ws' y no 'http'
        var wsUri = "ws://192.168.1.70:8080/StrongFit/endpoint";
        var websocket = new WebSocket(wsUri); //creamos el socket

        var solicitud = '';
        var sesionDestinatario = '';
        var idUsuario = '<%=idUsuarioBarra%>';
        var posicion = '';

        websocket.onopen = function(evt) { //manejamos los eventos...
            websocket.send(idUsuario);//... y aparecer� en la pantalla
            console.log(websocket.readyState);
        };
        websocket.onmessage = function(evt) { // cuando se recibe un mensaje
            var diferenciar = evt.data.split(',');
            if(posicion === 'miNutriologo'){
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
            }
            else{
                if(diferenciar[0] !== 's3sI0NamIgO9321djzlqoicnzskaak1795edsklvsnd'){
                    var repetir = true;
                    setInterval(function(){
                        if(repetir){
                            $('#minutriologo').animate({
                                opacity: 0.6,
                                background: 000
                            }, 1000, function(){
                                repetir = false;
                            });
                        }
                        else{
                            $('#minutriologo').animate({
                                opacity: 1
                            }, 1000, function(){
                                repetir = true;
                            });
                        }
                    }, 1000);
                }
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
        function log(mensaje) { //aqui mostrar� el LOG de lo que est� haciendo el WebSocket
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
                                $('#cedulaChat').html("C�dula Profesional: "+respuesta.cedula).removeClass('invisible');
                                $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                                $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
                                if(respuesta.amistad === "no"){
                                    $('#botonSolicitud').val("Enviar solicitud de Nutri�logo").removeClass('invisible');
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
                $('#cedulaChat').html("C�dula Profesional: "+respuesta.cedula).removeClass('invisible');
                $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
                if(respuesta.amistad === "no"){
                    $('#botonSolicitud').val("Enviar solicitud de Nutri�logo").removeClass('invisible');
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

function setPosicion(pos){
    console.log(pos);
    posicion = pos;
}

         </script>
<header class = "Header">
    <script>
        cargarDia();
        cargarDiaCiclico();
    </script>
    <p class="Header-title"><a href = "../../index.jsp">Strongfit</a></p>
    <ul class="Header-lista">
        <li class="Header-li"><a href="inicio.jsp" class="icon-house"></a></li><!--Inicio-->
        <li class="Header-li"><a href= "dietas_paciente.jsp" class="icon-food2"></a></li><!--Dieta-->
        <li class="Header-li" id="minutriologo"><a href = "minutriologo.jsp" class="icon-uniE60D"></a></li><!--Mi Nutri�logo-->
        <li class="Header-li user-name"><a href = "usuario.jsp"><%=idUsuarioBarra%></a></li><!--Usuario-->
        <li class="Header-li"><a href = "../../index.jsp" class = "icon-sign-out" onclick="cerrarsesion()"></a></li><!--log out-->
    </ul>
</header>