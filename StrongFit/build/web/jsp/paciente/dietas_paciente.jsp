<%@page import="clases.cCifrado"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        /*esto es temporal debido a que las variables de sesion como usrid y usrname se deben obtener en el momento del login*/
        HttpSession sesion = request.getSession();
        cCifrado seguro = new cCifrado();
        seguro.AlgoritmoAES();
        String usrid = seguro.encriptar((String)sesion.getAttribute("idUsr"));
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
        
        <section class = "Section-dietas">
            <article class = "Article-dietas"  id = "Article-dietas" ondrop="dropDiv(event)" ondragover="allowDrop(event)" >
                <h2>Dietas sugeridas</h2>
                <hr>
                <%
                    conecta.conectar();
                %>
                <form id = "quitarForm">
                    <input type = "hidden" id = "inputQuitar2" name = "quitar" value = "">
                </form>
                <div id = "divDietasPaciente" >
                    <%
                        //llenando el campo de las dietas sugeridas
                        ResultSet rs = conecta.getDietasSugeridas(2000);
                        String nombreD;
                        int idD, contador = 0, contadorid = 0;
                        
                        while(rs.next())
                        {
                            ResultSet rs2 = conecta.getDietasRegistradas(usrid);
                            contador = 0;
                            while(rs2.next())
                            {
                                if(rs.getInt("idDieta") == rs2.getInt("idDieta"))
                                {
                                    contador++;
                                }
                            }
                            
                            if(contador == 0)
                            {
                                nombreD = rs.getString("nombre");
                                idD = rs.getInt("idDieta");
                    %>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "<%="figure-usr" + contadorid%>">
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                    <%
                                contadorid += 1;
                            }
                        }
                    %>
                </div>
            </article>
            <article class = "Article-usr" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-user">
                <h2>Tus dietas</h2>
                <hr>
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
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
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
        
    </body>
</html>
