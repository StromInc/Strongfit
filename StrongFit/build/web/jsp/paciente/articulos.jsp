<%@page contentType="text/html" pageEncoding="UTF-8" session="true" errorPage="../nutriologo/error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio2.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src = "../../js/acciones_inicio.js"></script>
        <script src = "../../js/acciones_articulo.js"></script>
         <script src="../../js/salir.js"></script>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        
        <section class="Section-todo">
            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->
            <article class = "Article-title Article-articulo">
                <div class = "Article-platillos">
                  
                    <div class = "faltante estadisticas"> 
                    </div>
                </div>
            </article>
            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->
            <span id="spanoculto" hidden></span>
            <article class = "Article-articulos Article-articulo">
                <%                                                         
                clases.cArticulos objarticulos = new clases.cArticulos();
                 HttpSession sesion = request.getSession();               
                 String idUsr = (String)sesion.getAttribute("idUsr");
                String articulos = objarticulos.construirlista(idUsr);
                out.println(articulos);              
                %>
                Aqui van los articulos que los medicos escriben para hacerse mas populares y asi tener mas clientes
            </article>
        </section>         
    </body>
</html>
