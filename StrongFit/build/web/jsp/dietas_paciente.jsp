<%@page import = "java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session = "true" %>
<!DOCTYPE html>
<html>
    <%
        /*esto es temporal debido a que las variables de sesion como usrid y usrname se deben obtener en el momento del login*/
        HttpSession sesion = request.getSession();
        sesion.setAttribute("idUsr", 1);
    %>
    <head>
        <%@include file = "meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../Estilos/estilo_dietasusr.css">
        <script src = "../js/acciones_dietasPaciente.js"></script>
    </head>
    <body>
        <%
            int usrid = 1; //Provisional
            //Esto es provisional, despues se construira el metodo para extraer las dietas de la base de datos
        %>        
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
                        ResultSet rs = conecta.getDietasSugeridas(usrid);
                        String nombreD;
                        int idD;
                        while(rs.next())
                        {
                            nombreD = rs.getString("nombre");
                            idD = rs.getInt("idDieta");
                    %>
                    <!--Estas son de muestra-->
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-usr">
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                    <%
                        }
                    %>
                </div>
            </article>
            <article class = "Article-usr" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-user">
                <h2>Tus dietas</h2>
                <hr>
                <div id = "divForm">
                    <%ResultSet rs2 = conecta.getDietasRegistradas(usrid);%>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-usr">
                        <input type="hidden" name = "nombreDieta" value = "<%=1%>" >
                        <figcaption>Título de la dieta</figcaption>
                        <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                </div>
                <form id = "formularioDietasPaciente">
                    <input type = "hidden" id = "inputQuitar" name = "quitar" value = "">
                </form>
            </article>
        </section>
        
    </body>
</html>
