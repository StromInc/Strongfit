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
        <!--<script src="../../js/acciones_chatBuscar.js"></script>-->
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
            
            var solicitud = '';
            
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
                    $('#log').animate({
                        scrollTop: $('.mensaje').last().height() * 200
                    });
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
             
         </script>
        
        <section class = "Section-tbl-usr">
            <article class="Article-tbl-usr2 issues">
                <div class="div-solicitud">
                    Solicitudes
                    <%
                        cCifrado seguro = new cCifrado();
                        seguro.AlgoritmoAES();
                        
                        String usrS = seguro.encriptar(idUsr);
                        ResultSet rs2 = conecta.spSeleccionarSolicitudes(usrS);
                        String correoSolicitud = "";
                        String tipoUs = "Paciente";
                        int contador = 0;
                        
                        while(rs2.next()){
                            if(usrS.equals(rs2.getString("amigo2")) && rs2.getInt("estado") == 1){
                                correoSolicitud = rs2.getString("amigo1");
                                ResultSet rs3 = conecta.spGetInfoUsuario(correoSolicitud);
                                if(rs3.next()){
                                    clases.CImagen objimg = new clases.CImagen();
                                    int verificacionimg = objimg.devuelveexistencia(seguro.desencriptar(rs3.getString("idUsuario")));
                                    String ruta = "lel";
                                    String ruta2 = "../../Imagenes/Usuarios/";
                                    String nom = seguro.desencriptar(rs3.getString("idUsuario"));
                                    String nombre = seguro.desencriptar(rs3.getString("nombre"));
                                    if(rs3.getInt("idMedico") > 0){
                                        tipoUs = "Médico";
                                    }
                                    switch(verificacionimg){
                                        case 1: 
                                            ruta = ruta2 + nom + ".jpg";
                                            break;
                                        case 2: 
                                            ruta = ruta2 + nom + ".png";
                                            break;
                                        case 3: 
                                            ruta = ruta2 + nom + ".gif";
                                            break;
                                        default: 
                                            ruta = "../../Imagenes/usr_sin_imagen.jpg";
                                            break;              
                                    }
                                    %>
                                    <div class="divSolicitud" id="solicitud<%=contador%>" >
                                        <div class="divImagenSolicitud"><img src="<%=ruta%>" class="imagenSolicitud" ></div>
                                        <div class="generalSolicitud">
                                            <div class="correoSolicitud"><%=nom%></div><br>
                                            <div class="nombreSolicitud"><%=nombre%></div><br>
                                            <div class="tipoSolicitud"><%=tipoUs%></div>
                                        </div>
                                        <div>
                                            <input type="button" id="acepta<%=contador%>" onclick="responderSolicitud(1, '<%=nom%>', <%=contador%>);" value="Aceptar" name="aceptar" id="aceptar" >
                                            <input type="button" id="rechaza<%=contador%>" onclick="responderSolicitud(2, '<%=nom%>', <%=contador%>);" value="Rechazar" name="rechazar" id="rechazar" >
                                        </div>
                                    </div>
                                    <%
                                }
                                contador++;
                            }
                        }
                    %>
                </div>
                <hr>
                <div>
                    <div>
                        <img src="../../Imagenes/usr_sin_imagen.jpg" id="imagenDesti" class="imagenChat" >
                    </div>
                    <div>
                        <input type="submit" name="solicitud" id="botonSolicitud" onclick="enviarSolicitud();" class="invisible" >
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
                    <!--<textarea contenteditable="true" placeholder="Escribe un mensaje" id='mensajeTXT' name='mensajeTXT' onkeyup="Textarea_Sin_Enter(event.keyCode, this.id);" onkeydown="Textarea_Sin_Enter(event.keyCode, this.id);" onkeypress="Textarea_Sin_Enter(event.keyCode, this.id);" /></textarea>-->
                    <textarea contenteditable="true" placeholder="Escribe un mensaje" id='mensajeTXT' name='mensajeTXT' onkeypress="return enviarEnter(event);" /></textarea>
                    <div class="">
                        <span><input type="checkbox" name="enter" value="si" id="enter" ><label for="enter">Enviar mensaje al presionar Enter</label></span>&nbsp;&nbsp;&nbsp;
                              <button type="button" onclick="enviarMensaje()">Enviar</button>
                    </div>
                </form>
            </article>
            
            <article class = "Article-tbl-usr2 contactos">
                <div>
                    <p class="contenedor-search">
                        <input type="search" id="search" name="search" onkeypress="buscarUsuario();" class="search" style="width:10em;"  placeholder="Buscar personas...">
                        <label class = "icon-search label-search" for = "buscar"></label>
                    </p>
                </div>
                <%
                    ResultSet rs = conecta.spGetConectados();
                    
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
