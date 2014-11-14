<%-- 
    Document   : usuario
    Created on : 6/11/2014, 03:06:37 PM
    Author     : Ian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "meta.html" %>
        <link rel="stylesheet" type="text/css" href="../Estilos/estilo_usuario.css">
    </head>
    <body>
        <%@include file="barra_menu.jsp"%>       
        <section class = "Section-tbl-usr">
            <article class = "Article-tbl-usr2" style = "margin-left: 0">
                <img src = "../Imagenes/usr-sin-img.jpg" class ="img-usr" alt = "foto de usuario">
                <input type = "button" value="cambiar" class="btn-imagen">
            </article> 
            <article class = "Article-tbl-usr">
                <form action = "" method = "post">
                    <hr>
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <p class = "personal-p">Nombre</p>
                    <input type = "text" name = "name" required class = "Section-usr">
                    <p class = "personal-p">Correo</p>
                    <input type = "email" name = "email" required class = "Section-usr">
                    <p class = "personal-p">Contraseña</p>
                    <input type = "text" name = "contra" required class = "Section-usr">
                    <hr>
                    <h2 class = "Article-title">Información nutrimental</h2>
                    <p class = "m1 medidas-p">Peso</p>
                    <p class = "m2 medidas-p">Estatura</p>
                    <p class = "m3 medidas-p">Cintura</p>
                    <input type = "text" name = "peso" required class = "Section-m" placeholder = "(Kg)">
                    <input type = "text" name = "estatura" required class = "Section-m" placeholder = "(m)">
                    <input type = "text" name = "cintura" required class = "Section-m" placeholder = "(m)">
                    <hr>
                    <h2 class = "Article-title">Tu dirección</h2>
                    <p class = "personal-p">Estado</p>
                    <input type = "text" name = "estado" required class = "Section-usr">
                    <p class = "personal-p">Municipio</p>
                    <input type = "text" name = "municipio" required class = "Section-usr">
                    <p class = "personal-p">Colonia</p>
                    <input type = "text" name = "colonia" required class = "Section-usr">
                    <hr>
                    <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-act-usr">
                </form>
            </article>
        </section>
        <%@include file = "footer.jsp" %>
    </body>
</html>
