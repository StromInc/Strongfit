<%@page import="clases.cCifrado"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" errorPage="../nutriologo/error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <%
        /*esto es temporal debido a que las variables de sesion como usrid y usrname se deben obtener en el momento del login*/
        HttpSession sesion = request.getSession();
        cCifrado seguro = new cCifrado();
        seguro.AlgoritmoAES();
        String usrid = seguro.encriptar((String)sesion.getAttribute("idUsr"));
        int idPaciente = (Integer)sesion.getAttribute("idPaciente");
    %>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <script src = "../../js/acciones_dietasPaciente.js"></script>
        <script src="../../js/salir.js"></script>
        <style>
            .invisible
            {
                display: none;
            }
        </style>
    </head>
    <body>      
        <%@include file = "barra_menu.jsp" %>
        <script>setPosicion('dietas');</script>
        <section class = "Section-dietas">
            <article class = "Article-dietas sinP"  id = "Article-dietas" ondrop="dropDiv(event)" ondragover="allowDrop(event)" >
                <div class="Content-title">Dietas sugeridas</div>
                <%
                    conecta.conectar();
                %>
                <form id = "quitarForm">
                    <input type = "hidden" id = "inputQuitar2" name = "quitar" value = "">
                </form>
                <div id = "divDietasPaciente" >
                    <%
                        //llenando el campo de las dietas sugeridas
                        ResultSet rs = conecta.spGetAsociaciones(idPaciente);
                        String nombreD;
                        String nombreN="", nomNT="";
                        int idD, contador = 0, contadorid = 0;
                        
                        while(rs.next()){
                            nombreN = seguro.desencriptar(rs.getString("nomCreador"));
                            nombreD = rs.getString("nombre");
                            idD = rs.getInt("idDieta");
                            
                            if(!nomNT.equals(nombreN) && contador > 0){%></div><%}
                            if(!nomNT.equals(nombreN)){
                                nomNT = nombreN;
                                contador++;
                    %>
                        <div class="divNTitle">Por el nutriólogo: <%=nombreN%></div>
                        <div class="contenedoresDietas2" id="contenedorDietas<%=contador%>">
                    <% 
                            }  
                    %>
                        <figure class = "Figure-dietas sugeridas" draggable="true" ondragstart="drag(event)" id = "figure-usr<%=contadorid%>">
                            <input type="hidden" name = "idDieta" id="oculta" class="ocultas idDOculto" value = "<%=idD%>" >
                            <input type="hidden" class="nombresN">
                            <input type="hidden" class="acomodarEn" value="contenedorDietas<%=contador%>">
                            <figcaption><%=nombreD%></figcaption>
                            <img src = "../../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                        </figure>
                    <%
                            contadorid++;
                        }
                        contador++;
                        if(!nomNT.equals(nombreN) && contador > 0){%></div><%}
                    %>
                </div>
            </article>
            <article class = "Article-usr sinP" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-user">
                <div class="Content-title">Tus dietas</div>
                <div id = "spanIn" style="opacity: .5; text-align: center; margin-top: 2em;">
                    Arrastra aquí las dietas que te gustaría seguir, los datos se actualizaran automáticamente
                </div>
                <div id = "divForm">
                    <%
                        ResultSet rs3 = conecta.getDietasRegistradas(usrid);
                        while(rs3.next())
                        {                            
                            idD = rs3.getInt("idDieta");
                            nombreD = rs3.getString("nombre");
                    %>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "<%="figure-usr" + contadorid%>">
                        <input type="hidden" class="siguiendo idDOculto" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                    <%
                        contadorid += 1;
                        }  
                    %>
                </div>
                <form id = "formularioDietasPaciente">
                    <input type = "hidden" id = "inputQuitar" name = "quitar" value = "">
                </form>
            </article>
        </section>
    <script>ocultarDietas();</script>
    </body>
</html>
