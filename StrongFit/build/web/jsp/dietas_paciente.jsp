<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../Estilos/estilo_dietasusr.css">
        <script src = "../js/acciones_dietasusr.js"></script>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        
        <section class = "Section-dietas">
            <article class = "Article-dietas" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-dietas">
                <h2>Dietas sugeridas</h2>
                <hr>
                <!--Estas son de muestra-->
                <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-user">
                    <figcaption>Título de la dieta</figcaption>
                    <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                </figure>
                <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-user2">
                    <figcaption>Título de la dieta</figcaption>
                    <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                </figure>
                <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-user3">
                    <figcaption>Título de la dieta</figcaption>
                    <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                </figure>
                <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "figure-user4">
                    <figcaption>Título de la dieta</figcaption>
                    <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                </figure>
            </article>
            <article class = "Article-usr" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-user">
                <h2>Tus dietas</h2>
                <hr>
            </article>
        </section>
        
        <%@include file = "footer.jsp" %>
    </body>
</html>
