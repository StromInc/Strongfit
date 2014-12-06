<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
    </head>
    <body>
        <%@include file="barra_menu.jsp"%>       
        <section class = "Section-tbl-usr">
            <article class = "Article-tbl-usr2" style = "margin-left: 0">
                <img src = "../../Imagenes/usr-sin-img.jpg" class ="img-usr" alt = "foto de usuario">
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
                    <h2>Información pública</h2>
                    <p class = "personal-p">Cédula profesional</p>
                    <input type = "text" name = "plicense" required class = "Section-usr">
                    <p class = "personal-p">Escuela de procedencia</p>
                    <input type = "email" name = "school" required class = "Section-usr">
                    <p class = "personal-p">Carrera</p>
                    <input type = "text" name = "carrier" required class = "Section-usr">
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
        
    </body>
</html>
