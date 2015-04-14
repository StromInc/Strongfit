<%-- 
    Document   : minutriologo
    Created on : 25/02/2015, 06:32:11 PM
    Author     : ian
--%>

<%@page import="clases.cCifrado"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_chat.css" >
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
        <script src="../../js/acciones_chatBuscar.js"></script>
        <!--<script src = "../../js/acciones_chat.js"></script>-->
        <script src="../../js/salir.js"></script>
        
        <style>
            .Section-button{
                font-size:16px;
                background:#0070c8;
                border:none;
                -webkit-border-radius:3px;
                border-radius:3px;
                padding:.3rem 1rem;
                color:#fff;
                -webkit-box-shadow:0 1px 3px rgba(0,0,0,0.12),0 1px 2px rgba(0,0,0,0.24);
                box-shadow:0 1px 3px rgba(0,0,0,0.12),0 1px 2px rgba(0,0,0,0.24);
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%
            conecta.conectar();
            
            HttpSession sesion = request.getSession();
            String idUsr = (String)sesion.getAttribute("idUsr");
        %>
        <%@include file="barra_menu.jsp"%>
         <script>
            //notar el protocolo.. es 'ws' y no 'http'
            var wsUri = "ws://192.168.1.73:8080/StrongFit/endpoint";
            var websocket = new WebSocket(wsUri); //creamos el socket
            
            websocket.onopen = function(evt) { //manejamos los eventos...
                websocket.send('<%=idUsr%>');//... y aparecerá en la pantalla
            };
            websocket.onmessage = function(evt) { // cuando se recibe un mensaje
                log("<div class = 'destinatarioDiv'><div class = 'destinatario msj'>" + mensajeTXT.value + "</div></div>");
            };
            websocket.onerror = function(evt) {
                log("oho!.. error:" + evt.data);
            };
            function enviarMensaje() {
                
                $(function(){
                    websocket.send('<%=idUsr%>,' + $('#destinatario').val() + ',' + mensajeTXT.value + ',' + $('#ses').val());
                    log("<div class = 'remitenteDiv'><div class = 'remitente msj'>" + mensajeTXT.value + "</div></div>");
                });
                
            }
            function log(mensaje) { //aqui mostrará el LOG de lo que está haciendo el WebSocket
                var logDiv = document.getElementById("log");
                logDiv.innerHTML += (mensaje + '<br/>');
            }
            
            
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

                                if(respuesta.tipo === "medico"){
                                    $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula);
                                    $('#carreraChat').html("Carrera: "+respuesta.carrera);
                                    $('#escuelaChat').html("Escuela: "+respuesta.escuela);
                                    if(respuesta.amistad === "no"){
                                        $('#botonSolicitud').val("Enviar solicitud de Nutriólogo").removeClass('invisible');
                                    }
                                }
                                else{
                                    if(respuesta.amistad === "no"){
                                        $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
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
                            enviarMensaje();
                            log($('#mensajeTXT').html());
                            $('#mensajeTXT').val("");
                            return false;
                        }
                    }
                    return true;
                });
            }


        </script>
        
        <section class = "Section-tbl-usr">
            <article class="Article-tbl-usr2 issues">
                <div class="div-solicitud">Solicitudes</div>
                <hr>
                <div>
                    <div>
                        <img src="../../Imagenes/usr_sin_imagen.jpg" id="imagenDesti" class="imagenChat" >
                    </div>
                    <div>
                        <input type="submit" name="solicitud" id="botonSolicitud" class="invisible" >
                        <p id="nombreChat">Aun no has seleccionado a nadie</p>
                        <p id="correoChat"></p>
                        <p id="cedulaChat"></p>
                        <p id="escuelaChat"></p>
                        <p id="carreraChat"></p>
                        <input type="submit" value="Enviar Solicitud" class="Section-button invisible" >
                    </div>
                </div>
            </article>
            
            <article class = "Article-tbl-usr2 cajachat">
                <div class="mensajes" id = "log">
                    <div class="mensaje" ></div>
                </div>
                <form class="formularioChat">
                    <input type="hidden" name="desti" id="destinatario" value="">
                    <input type="hidden" name="ses" id="ses" value="">
                    <!--<textarea placeholder="Escribe un mensaje" id='mensajeTXT' name='mensajeTXT' onkeypress="return enviarEnter(this, event);" /></textarea>-->
                    <div contenteditable="true" placeholder="Escribe un mensaje" id='mensajeTXT' name='mensajeTXT' onkeypress="return enviarEnter(this, event);" /></div>
                    <div class="">
                        <span><input type="checkbox" name="enter" value="si" id="enter" ><label for="enter">Enviar mensaje al presionar Enter</label></span>&nbsp;&nbsp;&nbsp;
                              <button type="button" onclick="enviarMensaje()">Enviar</button>
                    </div>
                </form>
            </article>
            
            <article class = "Article-tbl-usr2 contactos">
                <div>
                    <p class="contenedor-search">
                        <input type="search" id="search" name="search" class="search" style="width:10em;"  placeholder="Buscar personas...">
                        <label class = "icon-search label-search" for = "buscar"></label>
                    </p>
                </div>
                <%
                    ResultSet rs = conecta.spGetConectados();
                    cCifrado seguro = new cCifrado();
                    seguro.AlgoritmoAES();
                    String usr = "";
                    String ses = ""; 
                    
                    int con = 0;
                    while(rs.next()){
                        usr = seguro.desencriptar(rs.getString("idUsuario"));
                        ses = rs.getString("sesion");
                        if(!usr.equals(idUsr)){
                        %>
                        <div style="cursor:pointer;" onclick="activarMensajes('<%=usr%>', '<%=ses%>', '<%=idUsr%>');">
                            <input type="hidden" id="ses<%=con%>" value="<%=ses%>" >
                            <p id="usr<%=con%>"><%=usr%></p>
                        </div>
                        <%
                        con++;
                        }
                    }
                %>
            </article>
            <script>cargaSes();</script>
        </section>
    </body>
</html>
