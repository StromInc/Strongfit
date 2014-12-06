<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasnutriologo.css">
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        <section class="Section-todo">
            <article class="Article-dietas">
                <h2>Tus dietas</h2>
                <hr>
                <input type="button" name="nueva" value="Nueva" class="btn-act-usr">
            </article>
            <div class = "arrow-left invisible"></div>
        </section>
    </body>
</html>
