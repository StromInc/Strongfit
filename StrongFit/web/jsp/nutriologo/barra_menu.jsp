<%@page import="clases.cConexion" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<%!
    cConexion conecta = new cConexion();
%>
<%
    HttpSession sesion2 = request.getSession();
    conecta.conectar();
    String ws = conecta.getWS();
    String idUsuarioBarra = (String)sesion2.getAttribute("idUsr");
    String tipo = (String) sesion2.getAttribute("tipodeus");
    if(!tipo.equals("2")){
        %><script>alert('Upps, parece que no tienes permiso para acceder a esta parte');</script>");<%
        response.sendRedirect("../../index.jsp");        
    }
%>

<script>
             //notar el protocolo.. es 'ws' y no 'http'
        var wsUri = "<%=ws%>";
        var websocket = new WebSocket(wsUri); //creamos el socket
        var solicitud = '';
        var sesionDestinatario = '';
        var variableInutil = true;
        var idUsuario = '<%=idUsuarioBarra%>';
        var pos = "";
        var evitarRedundar = [];
        websocket.onopen = function(evt) { //manejamos los eventos...
            websocket.send(idUsuario);//... y aparecer� en la pantalla;
        };
        websocket.onmessage = function(evt) { // cuando se recibe un mensaje
            var diferenciar = evt.data.split(',');
            if(pos === "pacientes"){
                if(diferenciar[0] === 's3sI0NamIgO9321djzlqoicnzskaak1795edsklvsnd'){
                    var amigos = document.getElementsByClassName(diferenciar[2])[0];
                    amigos.value = diferenciar[1];
                    if($('#destinatario').val() === diferenciar[2]){
                        sesionDestinatario = diferenciar[1];
                    }
                }
                else if(diferenciar[0] === 'j34546HRghTWEfs0978�wEWHgdOIRifiue49854T5T40rdkglndf3'){
                    $.ajax({
                        url: 'http://localhost:8080/StrongFit/sGetSolicitudes',
                        type: 'post',
                        dataType: 'json',
                        data: {nada:'nada'},
                        success: function(res){
                            $('#divSol').html("<div class='divSolicitud'></div>");
                            $.each(res.solicitudes, function(i, item){
                                var $clonacion = $('.divSolicitud').first().clone();
                                $clonacion.id='divSolicitud'+item.contador;
                                $clonacion.removeClass("invisible");
                                $clonacion.html("<div class='divImagenSolicitud'><img src='"+item.imagen+"' class='imagenSolicitud' ></div><div class='generalSolicitud'><div class='correoSolicitud'>"+item.correo+"</div><br><div class='nombreSolicitud'>"+item.nombre+"</div><br><div class='tipoSolicitud'>"+item.tipo+"</div></div><div><input type='button' id='acepta"+item.contador+"' value='Aceptar' name='aceptar'><input type='button' id='rechaza"+item.contador+"' value='Rechazar' name='rechazar'></div></div>");          
                                $clonacion.appendTo('#divSol');
                                $('.divSolicitud').first().addClass("invisible");
                                document.getElementById('acepta'+item.contador).addEventListener("click", function(){responderSolicitud(1, item.correo, item.contador)});
                                document.getElementById('rechaza'+item.contador).addEventListener("click", function(){responderSolicitud(2, item.correo, item.contador)});
                            });
                        }
                    });
                }
                else{
                    if($('#destinatario').val() === diferenciar[0]){
                        $('#log').animate({
                            scrollTop: $('.mensaje').last().height() * 200
                        });
                        log("<div class = 'destinatarioDiv'><div class = 'destinatario msj'>" + sanar(diferenciar[1]) + "</div></div>");
                        $.ajax({
                            url: 'http://localhost:8080/StrongFit/sCambiarEstadoLeido',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                idOtro: diferenciar[0]
                            },
                            success: function(res){}
                        });
                    }
                    else{
                        var $msjPendientes = $('.msjOculto');
                        var si = true;
                        var posicion = 0;
                        
                        for(var i = 0; i < $msjPendientes.length; ++i){
                            console.log("Evaluando");
                            console.log($msjPendientes[i].value);
                            if($msjPendientes[i].value === diferenciar[0]){
                                console.log("Este fue el encontrado: " + $msjPendientes[i].value);
                                si = false;
                                posicion = i;
                            }
                        }
                        if(si){
                            var $inicial = $('.pendiente').first();
                            var $cloneMsj = $inicial.clone();
                            $.ajax({
                                url: 'http://localhost:8080/StrongFit/sGetInfoUsuario',
                                type: 'post',
                                dataType: 'json',
                                data:{
                                    desti: diferenciar[0]
                                },
                                success: function(respuesta){
                                    var msjCorto = diferenciar[1] + "";
                                    if(msjCorto.length > 20){
                                        msjCorto = "";
                                        for(var i = 0; i < 17; ++i){
                                            msjCorto += diferenciar[1].charAt(i);
                                        }
                                        msjCorto += "...";
                                    }
                                    $cloneMsj.removeClass('invisible');
                                    $cloneMsj.html("<div><div class='divImagenSolicitud'><input type='hidden' value='"+diferenciar[0]+"' class='msjOculto'><img src='"+respuesta.imagen+"' class='imagenSolicitud' ></div><div class='generalSolicitud'><div class='correoSolicitud'>"+respuesta.nombre+"</div><br><div class='msjP'>"+msjCorto+"</div></div></div>");
                                    //variableInutil = false;
                                    //$cloneMsj.onclick=activarMensajes(diferenciar[0], idUsuario, 'si');
                                    $cloneMsj.addClass(diferenciar[0]+"1");
                                    $cloneMsj.appendTo('#divMsj');
                                    $inicial.addClass('invisible');
                                    document.getElementsByClassName(diferenciar[0]+1)[0].addEventListener("click", function(){activarMensajes(diferenciar[0], idUsuario, 'si')});
                                }
                            });
                        }
                        else{
                            $('.msjP')[posicion].innerHTML = diferenciar[1];
                        }
                    }
                }
            }
            else{
                if(diferenciar[0] !== 's3sI0NamIgO9321djzlqoicnzskaak1795edsklvsnd'){
                    var repetir = true;
                    setInterval(function(){
                        if(repetir){
                            $('#pacientes').animate({
                                opacity: 0.6,
                                background: 000
                            }, 1000, function(){
                                repetir = false;
                                $('#tituloPagina').html("Strongfit");
                            });
                        }
                        else{
                            $('#pacientes').animate({
                                opacity: 1
                            }, 1000, function(){
                                repetir = true;
                                $('#tituloPagina').html("Nuevos mensajes");
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
                websocket.send( idUsuario + ',' + $('#destinatario').val() + ',' + sanar(mensajeTXT.value) + ',' + sesionDestinatario);
                log("<div class = 'remitenteDiv'><div class = 'remitente msj'>" + sanar(mensajeTXT.value) + "</div></div>");
                mensajeTXT.value= "";
            });
        }
        function log(mensaje) { //aqui mostrar� el LOG de lo que est� haciendo el WebSocket
            var logDiv = document.getElementById("log");
            logDiv.innerHTML += (mensaje + '<br/>');
        }
        var evitarRepeticion = "";
        function activarMensajes(desti, idS, indica){    
            $(function(){
                if(variableInutil){
                    if(indica === 'si'){
                        var remover = document.getElementsByClassName(desti+1)[0];
                        remover.remove();
                    }
                    
                    $('#destinatario').val(desti);
                    sesionDestinatario = document.getElementsByClassName(desti)[0].value;
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
                                
                                $.ajax({
                                    url: 'http://localhost:8080/StrongFit/sCambiarEstadoLeido',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {
                                        idOtro: desti
                                    },
                                    success: function(res){}
                                });
                                
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
                }
                variableInutil=true;
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
                    $('#sesionProximoAmigo').val(respuesta.sesion);
                }
            }
            else{
                $('#cedulaChat').addClass('invisible');
                $('#carreraChat').addClass('invisible');
                $('#escuelaChat').addClass('invisible');
                if(respuesta.amistad === "no"){
                    $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
                    $('#sesionProximoAmigo').val(respuesta.sesion);
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
                websocket.send(idUsuario + ',' + solicitud + ',' + $('#sesionProximoAmigo').val());
                location.reload();
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
                //console.log(idEtiqueta);
                alert("Nuevo amigo(a) " + res.res + "(a)");
                document.getElementsByClassName('divSolicitud')[idEtiqueta+1].remove();
                location.reload();
            }
        });
    });
}
function setPosicion(p){
    pos=p;
}

function getInfoNutricional(){
    if(evitarRepeticion !== evitarRedundar[1]){
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sGetInfoNutricional',
            type: 'post',
            dataType: 'json',
            data:{
                idOtro: evitarRepeticion
            },
            success: function(resp){
                evitarRedundar[1] = evitarRepeticion;
                /*
                 * Primero van esos
                 * <p id="idPeso"></p>
                    <p id="idEstatura"></p>
                    <p id="idCintura"></p>
                    <p id="idEdad"></p>
                    <p id="idSexo"></p>
                 */
                $('#idInfoSpan').addClass('invisible');
                $('#idPeso').html("Peso: " + resp.peso + "kg");
                $('#idEstatura').html("Estatura: " + resp.estatura + "cm");
                $('#idCintura').html("Cintura: " + resp.medidaCintura + "cm");
                $('#idEdad').html("Edad: " + resp.edad + "a�os");
                console.log(resp.sexo);
                if(resp.sexo === 1){
                    $('#idSexo2').html('G�nero: Masculino');
                }
                else{
                    $('#idSexo2').html('G�nero: Femenino');
                }
                $('#idOcupacion').html('Ocupaci�n: ' + resp.ocupacion);
                
                /*Van estas
                 */
                $('#idActividad').html("Actividad F�sica: " + resp.actividad);
                
                var hor = document.getElementsByClassName('diasTable');
                var posEliminar = [];
                var conta = 0;
                for(var i = 0; i < 7; ++i){
                    if(resp.horas[i] !== null && resp.horas[i] !== undefined && resp.horas[i] !== 0 && resp.horas[i] !==  '0' && resp.horas[i] !== ''){
                        hor[i].innerHTML = resp.horas[i];
                    }
                    else{
                        posEliminar[conta] = i;
                        conta++;
                    }
                }
                for(var i = 0; i < posEliminar.length; ++i){
                    document.getElementById('tupla'+posEliminar[i]).remove();
                }
                
                var cal = document.getElementsByClassName('tuplaCal');
                for(var i = 0; i < cal.length; ++i){
                    cal[i].innerHTML = resp.caloriasD[i];
                }
            }
        });
    }
}

function getDietasPaciente(){
    $(function(){
        if(evitarRepeticion !== evitarRedundar[1]){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sGetDietasPaciente',
                type: 'post',
                dataType: 'json',
                data: {
                    idOtro: evitarRepeticion
                },
                success: function(res){
                    evitarRedundar[1] = evitarRepeticion;
                }
            });
        }
    });
}

function agregarDieta(){
    $(function(){
        $('.btnAgregar').on('click', function(){ 
            $(this).addClass('invisible');
            $(this).siblings().removeClass('invisible');
            $('#divDietasPaciente').append($(this).parent());
            var idDN = $(this).siblings('#idDietaNutriologo').val();
            //$(this).parent().remove();
            asociar(1, idDN);
        });
    });
}

function quitarDieta(){
    $(function(){
        $('.btnQuitar').on('click', function(){
            $(this).addClass('invisible');
            $(this).siblings().removeClass('invisible');
            $('#divTusDietas').append($(this).parent());
            var idDN = $(this).siblings('#idDietaNutriologo').val();
            asociar(0, idDN);
        });
    });
}

function asociar(accion, idD){
    $(function(){
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sAsociarDietas',
            type: 'post',
            dataType: 'json',
            data: {
                idPa: evitarRepeticion,
                accion: accion,
                idDieta: idD
            },
            success: function(res){
                console.log(res);
            }
        });
    });
}

function sanar(cadenaMala){
    var cadenaBuena = "";
    for (c in cadenaMala){
            if(cadenaMala[c] === "<"){
                cadenaBuena += "&lt;";
            }
            else if(cadenaMala[c] === ">"){
                cadenaBuena += "&gt;";
            }
            else if(cadenaMala[c] === "\""){
                cadenaBuena += "&quot;";
            }
            else if(cadenaMala[c] === "'"){
                cadenaBuena += "&#39;";
            }
            else{
                cadenaBuena += cadenaMala[c];
            }
    }
    return cadenaBuena;
}
</script>
<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->
<header class = "Header">
    <p class="Header-title"><a href = "../../index.jsp">Strongfit</a></p>
    <ul class="Header-lista">
        <li class="Header-li"><a href="inicio.jsp" class="icon-house"></a></li><!--Inicio-->
        <li class="Header-li"><a href= "dietas_nutriologo.jsp" class="icon-food2"></a></li><!--Dieta-->
        <li class="Header-li" id="pacientes"><a href = "pacientes.jsp" class="icon-user"></a></li><!--Mi Nutri�logo-->
        <li class="Header-li user-name" ><a href = "usuario.jsp"><%=idUsuarioBarra%></a></li>
        <li class="Header-li"><a href = "../../index.jsp" class = "icon-sign-out" onclick="cerrarsesion()"></a></li><!--log out-->
    </ul>
</header>