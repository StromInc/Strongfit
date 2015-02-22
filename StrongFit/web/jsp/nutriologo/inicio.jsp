<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio2.css">
        <script src = "../../js/acciones_inicio.js"></script>
         <script src="../../js/salir.js"></script>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        
        <section class="Section-todo">
            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->
            <article class = "Article-title Article-articulo">
                <div class = "Article-platillos">
                    <div class = "meta estadisticas">
                        Escribir un artículo
                    </div>
                    <div class = "faltante estadisticas"> 
                    </div>
                </div>
            </article>
            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->
            <article class = "Article-articulos Article-articulo">
                Aqui van los articulos que los medicos escriben para hacerse mas populares y asi tener mas clientes
            </article>
        </section>         
    </body>
</html>
