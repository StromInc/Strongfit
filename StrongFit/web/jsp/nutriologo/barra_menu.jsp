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
        google.load("visualization", "1", {packages:["corechart"]});
             //notar el protocolo.. es 'ws' y no 'http'
        var wsUri = "<%=ws%>";
        var websocket = new WebSocket(wsUri); //creamos el socket
        var solicitud = '';
        var sesionDestinatario = '';
        var variableInutil = true;
        var idUsuario = '<%=idUsuarioBarra%>';
        var pos = "";
        var evitarRedundar = [];
        var idG = "";
        
        var meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
        var fecha = new Date();
        var dia = fecha.getDate();
        var dia2 = dia;
        var mes = fecha.getMonth();
        var mes2 = mes;
        var anio = fecha.getFullYear();
        var anio2 = anio;
        var diaSem = 0;
        
        var opciones = {};
        var datos = [];
        
        websocket.onopen = function(evt) { //manejamos los eventos...
            websocket.send(idUsuario);//... y aparecerá en la pantalla;
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
                else if(diferenciar[0] === 'j34546HRghTWEfs0978ñwEWHgdOIRifiue49854T5T40rdkglndf3'){
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
        function log(mensaje) { //aqui mostrará el LOG de lo que está haciendo el WebSocket
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
                $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula).removeClass('invisible');
                $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
                if(respuesta.amistad === "no"){
                    $('#botonSolicitud').val("Enviar solicitud de Nutriólogo").removeClass('invisible');
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
                $('#idEdad').html("Edad: " + resp.edad + "años");
                console.log(resp.sexo);
                if(resp.sexo === 1){
                    $('#idSexo2').html('Género: Masculino');
                }
                else{
                    $('#idSexo2').html('Género: Femenino');
                }
                $('#idOcupacion').html('Ocupación: ' + resp.ocupacion);
                
                /*Van estas
                 */
                $('#idActividad').html("Actividad Física: " + resp.actividad);
                
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
        if(evitarRepeticion !== evitarRedundar[2]){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sGetDietasPaciente',
                type: 'post',
                dataType: 'json',
                data: {
                    idOtro: evitarRepeticion
                },
                success: function(res){
                    evitarRedundar[2] = evitarRepeticion;
                    var contenedor = document.getElementsByClassName("contenedorDietasNutriologo")[1];
                    contenedor.innerHTML = "<p>Diestas del paciente</p><div id='divDietasPaciente'></div>";
                    for(var i = 0; i < res.asociadas.length; ++i){

                        if(res.asociadas[i].nombreN === idUsuario){
                            contenedor.innerHTML += '<div class="misDietas">'+res.asociadas[i].nombreD+'<input type="hidden" id="idDietaNutriologo" value="'+res.asociadas[i].idDieta+'"><input type="button" name="btnAgregar" class="btnAgregar invisible" value="Agregar" onclick="agregarDieta();"><input type="button" name="btnQuitar" class="btnQuitar" value="Quitar" onclick="quitarDieta();"></div>';
                        }
                        else{
                            contenedor.innerHTML += '<div class="misDietas"><span class="deRellenoIzquierda"></span><span>'+res.asociadas[i].nombreD+'</span><input type="hidden" id="idDietaNutriologo" value="'+res.asociadas[i].idDieta+'"></div>';
                        }
                    }
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

function drawChart() {
    $(function(){
        var data = google.visualization.arrayToDataTable(datos);

        var options = opciones;

        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));

        chart.draw(data, options);
    });
}

function nuevoPor(){
    if(idG !== ""){
        datosGrafica(idG);
    }
}

function cambiarDia(id){
    $(function(){
        if(id === 0){
            dia -= 1;
            if(dia <= 0){
                cambiarMes(0);
                if(mes === 0 || mes === 2 || mes === 4 || mes === 6 || mes === 7 || mes === 9 || mes === 11){
                    dia = 31;
                }
                else if(mes === 1){
                    dia = 28;
                    if(anio % 2 === 0){
                        dia = 29;
                    }
                }
                else{
                    dia = 30;
                }
            }
            $();
        }
        else{
            if(!(dia - dia2 === 0 && mes - mes2 === 0)){
                dia += 1;
                if(mes === 0 || mes === 2 || mes === 4 || mes === 6 || mes === 7 || mes === 9 || mes === 11){
                    if(dia === 32){
                        cambiarMes(1);
                    }
                }
                else if(mes === 1){
                    if(!(anio % 2 === 0)){
                        if(dia === 29){
                            cambiarMes(1);
                        }
                    }
                    else{
                        if(dia === 30){
                            cambiarMes(1);
                        }
                    }
                }
                else{
                    if(dia === 31){
                        cambiarMes(1);
                    }
                }
            }
        }
        
        if(dia - dia2 === 0 && mes - mes2 === 0){
            $('#spanInfoDia').html('Hoy');
        }
        else if(dia - dia2 === -1 && mes - mes2 ===0){
            $('#spanInfoDia').html('Ayer');
        }
        else{
            $('#spanInfoDia').html(dia + " de " + meses[mes]);
        }
        
        datosGrafica(idG);
    });
}

function cambiarMensual(id){
    $(function(){
        cambiarMes(id);
        
    });
}

function cambiarMes(id){
    $(function(){
        dia = 1;
        if(id === 0){
            mes -= 1;
            if(mes < 0){
                mes = 12;
                anio -= 1;
            }
        }
        else{
            if(!(mes - mes2 === 0 && anio - anio2 === 0)){
                mes += 1;
                if(mes >= 13){
                    mes = 0;
                    anio += 1;
                }
            }
            else
                dia = dia2;
        }
        if(mes - mes2 === 0 && anio - anio2 === 0){
            $('#spanInfoMes').html("Este mes");
        }
        else{
            $('#spanInfoMes').html(meses[mes] + " de " + anio);
        }
        
        if(dia - dia2 === 0 && mes - mes2 === 0){
            $('#spanInfoDia').html('Hoy');
        }
        else{
            $('#spanInfoDia').html(dia + " de " + meses[mes]);
        }
        
        datosGrafica(idG);
    });
}

function setDiaSemana(){
    
    //http://esquirladigital.blogspot.mx/2011/08/codigo-javascript-para-saber-el-dia-de.html
    //http://www.tutorialspoint.com/javascript/date_getutcday.htm
    
    //Vector para calcular día de la semana de un año regular.  
    var regular =[0,3,3,6,1,4,6,2,5,0,3,5];   
    //Vector para calcular día de la semana de un año bisiesto.  
    var bisiesto=[0,3,4,0,2,5,0,3,6,1,4,6];
    
    var m = 0;
    var semana = [1, 2, 3, 4, 5, 6 ,7];
    
    if(anio % 4 === 0){
        m = bisieto[mes];
    }
    else{
        m = regular[mes];
    }
    return semana[Math.ceil(Math.ceil(Math.ceil((anio-1)%7)+Math.ceil((Math.floor((anio-1)/4)-Math.floor((3*(Math.floor((anio-1)/100)+1))/4))%7)+m+dia%7)%7)]
}

function datosGrafica(id){
    idG = id;
    $(function(){
        datos = [];
        opciones = {};
        
        var cal = 1;
        var por = 0;
        
        $('.listaGraficas').removeClass('fondoGris');
        $('#'+id).addClass('fondoGris');
        
        if(!$('#caloriasEst').is(':checked')){
            cal = 0;
        }
        
        if(id === "labelG1"){
            por = 1;
        }
        else if(id === "labelG2"){
            por = 2;
        }
        else if(id === "labelG3"){
            por = 3;
        }
        else if(id === "labelG4"){
            por = 4;
        }
        else{
            por = 0;
        }
        
        diaSem = setDiaSemana();
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sGetDatosGrafica',
            type: 'post',
            dataType: 'json',
            data: {
                idPaciente: evitarRepeticion,
                cal: cal,
                por: por,
                dia: dia,
                mes: mes,
                anio: anio,
                diaSem: diaSem
            },
            success: function(res){
                console.log(res);
                    if(res.quees === 1){
                        datos[0] = ['Task', "Calorías por comida"];
                        
                        var con = 1;
                        for(var i = 0; i < 5; ++i){
                            datos[con] = [res.comidas[i][0], parseFloat(res.comidas[i][1])];
                            con++;
                        }
                        
                        if(res.valorT === "no"){
                            $('#div_chart').html("No has comido nada en este día.");
                        }
                    }
                    else{
                        datos[0] = ["Task", "Pro/Lip/Car por día"];
                        var con = 1;
                        for(var i = 0; i < 3; ++i){
                            datos[con] = [res.comidas[i][0], parseFloat(res.comidas[i][1])];
                            con++;
                        }
                    }
                    
                    opciones = {
                        chartArea: {
                            title: res.tituloG,
                            left: 45,
                            top:20,
                            width:'100%',
                            height:'100%',
                            fontSize: 16
                            
                        }
                    };
                    
                    drawChart();
            }
        });
    });
}


</script>
<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->
<header class = "Header">
    <p class="Header-title"><a href = "../../index.jsp">Strongfit</a></p>
    <ul class="Header-lista">
        <li class="Header-li"><a href="inicio.jsp" class="icon-house"></a></li><!--Inicio-->
        <li class="Header-li"><a href= "dietas_nutriologo.jsp" class="icon-food2"></a></li><!--Dieta-->
        <li class="Header-li" id="pacientes"><a href = "pacientes.jsp" class="icon-user"></a></li><!--Mi Nutriólogo-->
        <li class="Header-li user-name" ><a href = "usuario.jsp"><%=idUsuarioBarra%></a></li>
        <li class="Header-li"><a href = "../../index.jsp" class = "icon-sign-out" onclick="cerrarsesion()"></a></li><!--log out-->
    </ul>
</header>