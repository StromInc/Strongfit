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
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <script src = "../../js/acciones_chat.js"></script>
        <script src="../../js/salir.js"></script>
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
            var wsUri = "ws://192.168.1.70:8080/StrongFit/endpoint";
            var websocket = new WebSocket(wsUri); //creamos el socket
            
            websocket.onopen = function(evt) { //manejamos los eventos...
                websocket.send('<%=idUsr%>');//... y aparecerá en la pantalla
            };

            websocket.onmessage = function(evt) { // cuando se recibe un mensaje
                log("Mensaje recibido:" + evt.data);
            };

            websocket.onerror = function(evt) {
                log("oho!.. error:" + evt.data);
            };


            function enviarMensaje() {
                
                $(function(){
                    websocket.send('<%=idUsr%>,' + $('#destinatario').val() + ',' + mensajeTXT.value + ',' + $('#ses').val());
                    log("Enviado: " + mensajeTXT.value);
                });
                
            }
            function log(mensaje) { //aqui mostrará el LOG de lo que está haciendo el WebSocket
                var logDiv = document.getElementById("log");
                logDiv.innerHTML += (mensaje + '<br/>');
            }
        </script>
        <section class = "Section-tbl-usr">
            <article class = "Article-tbl-usr2">
                <div style = "height:10em;" id = "log"></div>
                <form>
                    <input type="hidden" name="desti" id="destinatario" value="">
                    <input type="hidden" name="ses" id="ses" value="">
                    <label for="mensajeTXT">Mensaje:</label>
                    <input id='mensajeTXT' name='mensajeTXT'/><br/>
                    <button type="button" onclick="enviarMensaje()">Enviar</button>
                </form>
            </article>
            
            <article class = "Article-tbl-usr2">
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
                        <div style="cursor:pointer;" onclick="activarMensajes('<%=usr%>', '<%=ses%>');">
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
