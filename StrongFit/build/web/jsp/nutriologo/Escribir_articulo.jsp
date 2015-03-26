<%-- 
    Document   : Escribir_articulo
    Created on : 17/03/2015, 11:19:46 AM
    Author     : jorge pastrana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio2.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src = "../../js/acciones_inicio.js"></script>
        <script src = "../../js/acciones_articulo.js"></script>
         <script src="../../js/salir.js"></script>
    </head>
    <%@include file = "barra_menu.jsp" %>
    <body>
        <section class="Section-todo">
            <form action="" method="post">
            <span>
                Nombre:<br><input type="text" id="txtnombre"><br><br>
                Texto:<br><textarea rows="30" cols="100" id="txtarticulo"></textarea><br>
                <input type="button" value="Enviar" onclick=escribearticulo('escribe')>                
            </span>
                <span id="misarticulos" onload="buscamisarticulos()">  
                </span>   
            </form>    
        </section> 
    </body>
</html>
