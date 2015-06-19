<%--
    Document   : minutriologo
    Created on : 25/02/2015, 06:32:11 PM
    Author     : ian
--%>

<%@page import="clases.cConexion"%>
<%@page import="clases.cCifrado"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_chat.css" >
        
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_pacientes.css" >
        <!--<script src="../../js/acciones_chatBuscar.js"></script>-->
        <script src = "../../js/acciones_chat.js"></script>
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
            cConexion conecta = new cConexion();
            conecta.conectar();
            conecta.conectar();
            
            HttpSession sesion = request.getSession();
            String idUsr = (String)sesion.getAttribute("idUsr");
        %>
        <%@include file="barra_menu.jsp"%>
         
        <script>setPosicion('pacientes');</script>
        <section class = "Section-tbl-usr">
            <article id="articlePerfilMsjSol" class="Article-tbl-usr2 issues sinP" style="overflow:hidden;">
                <div class="divGeneralSolMsj">
                <div class="menuMS Content-title">
                    <div id="divMenuMsj" style="cursor:pointer;" onclick="mostrarMsjSol(id);">Mensajes</div>
                    <div id="divMenuSol" style="cursor:pointer;" onclick="mostrarMsjSol(id);">Solicitudes</div>
                </div>
                <div class="conMjsSol">
                <div class="div-msjPendientes invisible" id="divMsj" >
                    <div class="pendiente invisible"></div>
                    <%
                        cCifrado seguridad = new cCifrado();
                        seguridad.AlgoritmoAES();
                        String idS = seguridad.encriptar(idUsr);
                        ResultSet msjNo = conecta.spGetMsjNoLeidos(idS);
                        
                        String clase="", idOtro = "", msj ="", nomb = "";
                        int sitiene = 0;
                        
                        while(msjNo.next()){
                            
                            clases.CImagen objimg = new clases.CImagen();
                            
                            idOtro = seguridad.desencriptar(msjNo.getString("idUsuario"));
                            msj = msjNo.getString("mensaje");
                            nomb = seguridad.desencriptar(msjNo.getString("nombre"));
                            clase = idOtro + 1;
                            
                            if(msj.length() > 20){
                                String temp = "";
                                for(int i = 0; i < 17; ++i){
                                    temp += msj.charAt(i);
                                }
                                msj = temp;
                                msj += "...";
                            }
                            
                            int verificacionimg = objimg.devuelveexistencia(idOtro, 1);
                            String ruta = "lel";
                            String ruta2 = "../../Imagenes/Usuarios/";
                            
                            switch(verificacionimg){
                                case 1: 
                                    ruta = ruta2 + idOtro + ".jpg";
                                    break;
                                case 2: 
                                    ruta = ruta2 + idOtro + ".png";
                                    break;
                                case 3: 
                                    ruta = ruta2 + idOtro + ".gif";
                                    break;
                                default: 
                                    ruta = "../../Imagenes/usr_sin_imagen.jpg";
                                    break;              
                            }
                            sitiene++;
                    %>
                    <div class="pendiente <%=clase%>" onclick="activarMensajes('<%=idOtro%>', '<%=idS%>', 'si');">
                        <div>
                            <div class="divImagenSolicitud"><input type='hidden' value="" class='msjOculto'><img src="<%=ruta%>" class="imagenSolicitud" ></div>
                            <div class="generalSolicitud">
                                <div class="correoSolicitud"><%=nomb%></div><br>
                                <div class="msjP"><%=msj%></div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                        if(sitiene == 0){
                            %><p id="noMsj" class="sinPendientes">No tienes mensajes pendientes.</p><% 
                        }
                    %>
                </div>
                <div class="div-solicitud invisible" id="divSol" >
                    <div class="divSolicitud invisible"></div>
                        <%
                        cCifrado seguro = new cCifrado();
                        seguro.AlgoritmoAES();
                        
                        String usrS = seguro.encriptar(idUsr);
                        ResultSet rs2 = conecta.spSeleccionarSolicitudes(usrS);
                        String correoSolicitud = "";
                        String tipoUs = "Paciente";
                        int contador = 0, si=0;
                        
                        while(rs2.next()){
                            if(usrS.equals(rs2.getString("amigo2")) && rs2.getInt("estado") == 1){
                                correoSolicitud = rs2.getString("amigo1");
                                ResultSet rs3 = conecta.spGetInfoUsuario(correoSolicitud);
                                if(rs3.next()){
                                    clases.CImagen objimg = new clases.CImagen();
                                    int verificacionimg = objimg.devuelveexistencia(seguro.desencriptar(rs3.getString("idUsuario")),1);
                                    String ruta = "lel";
                                    String ruta2 = "../../Imagenes/Usuarios/";
                                    String nom = seguro.desencriptar(rs3.getString("idUsuario"));
                                    String nombre = seguro.desencriptar(rs3.getString("nombre"));
                                    if(rs3.getInt("idMedico") > 0){
                                        tipoUs = "M�dico";
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
                                si++;
                            }
                        }
                        if(si == 0){
                            %><p id="noSol" class="sinPendientes">No tienes solicitudes pendientes.</p><%
                        }
                    %>
                </div>
                    </div> 
                <div class="btnSubir invisible" id="subir" onclick="subirAlPerfil();" >Subir</div>              
                </div>
                <div id="divPerfilOtro" class="divPerfilOtro" onclick="mostrarPerfilOtro();">
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
                        <input type="hidden" value="sinSesion" id="sesionProximoAmigo" >
                        <input type="submit" value="Enviar Solicitud" class="Section-button invisible" >
                    </div>
                </div>
            </article>
            
<!--===========================================================================================-->
            <article class = "Article-tbl-usr2 cajachat sinP">               
                <div class="Content-title">
                    <ul class="menuChatNutriologo ">
                        <li onclick="mostrarMenu('contenedorChatNutriologo');"><input type="radio" name="menuChat" id="chatN"><label id="cN" for="chatN">Chat</label></li>
                        <li onclick="mostrarMenu('contenedorInfoPaciente');"><input type="radio" onclick="getInfoNutricional();" name="menuChat" id="infoN"><label id="iN" for="infoN">Informaci�n</label></li>
                        <li onclick="mostrarMenu('contenedorEstaPaciente');"><input type="radio" name="menuChat" id="estaN"><label id="eN" for="estaN">Estad�sticas</label></li>
                        <li onclick="mostrarMenu('contenedorDietPaciente');"><input type="radio" onclick="getDietasPaciente();" name="menuChat" id="dietN"><label id="dN" for="dietN">Dietas</label></li>
                    </ul>
                </div>
                <div id="contenedorChatNutriologo" class="ventanasChat invisible" >
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
                </div>
                <div id="contenedorInfoPaciente" class="ventanasChat invisible">
                    <div id="divI">
                        <p id="idPeso"></p>
                        <p id="idEstatura"></p>
                        <p id="idCintura"></p>
                        <p id="idEdad"></p>
                        <p id="idSexo2"></p>
                        <p id="idOcupacion"></p>
                    </div>
                    <div id="divA">
                        <p id="idActividad"></p>
                        <table id="tablaA">
                            <tr>
                                <td>Dias</td>
                                <td>Horas</td>
                            </tr>
                            <tr id="tupla0" class="tupla">
                                <td>Domingo</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla1" class="tupla">
                                <td>Lunes</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla2" class="tupla">
                                <td>Martes</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla3" class="tupla">
                                <td>Mi�rcoles</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla4" class="tupla">
                                <td>Jueves</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla5" class="tupla">
                                <td>Viernes</td>
                                <td class="diasTable"></td>
                            </tr>
                            <tr id="tupla6" class="tupla">
                                <td>S�bado</td>
                                <td class="diasTable"></td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <p class="titulo">Calor�as diarias</p>
                        <table class="tableCal">
                            <tr>
                                <td></td>
                                <td>Domingo</td>
                                <td>Lunes</td>
                                <td>Martes</td>
                                <td>Mi�rcoles</td>
                                <td>Jueves</td>
                                <td>Viernes</td>
                                <td>S�bado</td>
                            </tr>
                            <tr>
                                <td>Calor�as</td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                                <td class="tuplaCal"></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!--============================ESTADISTICAS=================================================================-->
                <div id="contenedorEstaPaciente" class="ventanasChat invisible">
                    <div id="btnLabels" class="Estadisticas-header">
                        <input type="radio" checked name="estadistics" id="caloriasEst" onclick="nuevoPor();"><label for="caloriasEst" id="labelCalEst">Calor�as</label>
                        <input type="radio" name="estadistics" id="procarlip" onclick="nuevoPor();"><label for="procarlip" id="labelProCarLip">Pro/Car/Lip</label>
                    </div>
                    <div id="chart_div">
                        <br>
                        No has seleccionado ninguna opci�n.
                    </div>
                    <ul>
                        <li class="listaGraficas" id="labelG1" onclick="datosGrafica(id);"><span class="spanCambiarDia" onclick="cambiarDia(0);"><</span><span id="spanInfoDia">Hoy</span><span class="spanCambiarDia" onclick="cambiarDia(1);">></span></li>
                        <!--<li class="listaGraficas" id="labelG2" onclick="datosGrafica(id);"><span class="spanCambiarSemana"><</span><span id="spanInfoSem">Esta semana</span><span class="spanCambiarSemana">></span></li>-->
                        <li class="listaGraficas" id="labelG3" onclick="datosGrafica(id);"><span class="spanCambiarMensual" onclick="cambiarMensual(0);"><</span><span id="spanInfoMes">Este mes</span><span class="spanCambiarMensual" onclick="cambiarMensual(1);">></span></li>
                        <!--<li class="listaGraficas" id="labelG4" onclick="datosGrafica(id);"><span><</span>Alimentos<span>></span></li>-->
                    </ul>
                </div>
                <div id="contenedorDietPaciente" class="ventanasChat invisible">
                    <div class="contenedorDietasNutriologo">
                            <p>Dietas creadas por ti</p>
                            <div id="divTusDietas">
                            <%
                                ResultSet misdietas = conecta.getDietasRegistradas(idS);
                                String nomDieta = "";
                                int idD = 0;
                                int contadorD = 0;
                                while(misdietas.next()){
                                    nomDieta = misdietas.getString("nombre");
                                    idD = misdietas.getInt("idDieta");
                                    %>
                                    <div class="misDietas"><input type="hidden" id="idDietaNutriologo" value="<%=idD%>">
                                        <span name="btnAgregar" class="btnAgregar" value="Agregar" onclick="agregarDieta();">></span>
                                        <span><%=nomDieta%></span>
                                        <span name="btnQuitar" class="btnQuitar invisible" value="Quitar" onclick="quitarDieta();"><</span>
                                    </div>
                                    <%
                                    contadorD++;
                                }
                            %>
                        </div>
                    </div>
                    
                    <div class="contenedorDietasNutriologo" >
                        <p>Dietas del paciente</p>
                        <div id="divDietasPaciente"></div>
                    </div>
                </div>
            </article>
<!--===========================================================================================-->
            
            <article class = "Article-tbl-usr2 contactos sinP">
                <div>
                    <p class="contenedor-search">
                        <span class = "span-search"><label class = "icon-search label-search" for = "buscar"></label></span>
                        <input type="search" id="search" name="search" onkeypress="buscarUsuario();" class="search input-search" style="width:10em;"  placeholder="Buscar personas...">
                    </p>
                </div>
                <%
                    ResultSet amigos = conecta.spGetAmigos(usrS);
                    
                    String usr = "";
                    String ses = "";
                    String idAmigo = "";
                    int con = 0;
                    while(amigos.next()){
                        if(amigos.getString("amigo1").equals(usrS)){
                            idAmigo = amigos.getString("amigo2");
                        }
                        else{
                            idAmigo = amigos.getString("amigo1");
                        }
                        
                        ResultSet rs = conecta.spGetConectados(idAmigo);

                        if(rs.next()){
                            usr = seguro.desencriptar(rs.getString("idUsuario"));
                            ses = rs.getString("sesion");
                            if(!usr.equals(idUsr)){
                        %>
                        <div class="misDietas" style="cursor:pointer;" onclick="activarMensajes('<%=usr%>', '<%=idUsr%>', 'no');">
                            <input type="hidden" id="ses<%=con%>" class="<%=usr%>" value="<%=ses%>" >
                            <p class="noM" id="usr<%=con%>"><%=usr%></p>
                        </div>
                        <%
                            con++;
                            }
                        }
                    }
                %>
            </article>
        </section>
    </body>
</html>