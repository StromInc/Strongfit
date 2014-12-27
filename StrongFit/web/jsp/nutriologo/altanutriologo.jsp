<%-- 
    Document   : nutriologo
    Created on : 7/12/2014, 03:24:15 PM
    Author     : jorge pastrana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action = "/StrongFit/sAltaDeMedico" method="post" class="Section-form">
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <input type = "text" name = "txt-name" class="Section-nombre Section-txt" placeholder = "Nombre" required>
                    <input type = "email" name = "txt-mail" class="Section-mail Section-txt" placeholder = "Correo" required>
                    <input type = "password" name = "txt-pass" class = "Section-pass Section-txt" placeholder="Contraseña" required>
                    <hr>
                    <h2 class = "Article-title">Tu edad</h2>
                    <input type = "text" name = "edad" required class = "Section-usr" placeholder = "">
                    <hr>
                    <h2 class = "Article-title">Tu sexo</h2>
                    <select name = "sexo">
                        <option value="" >Seleccionar </option>
                        <option value="1" >Masculino </option>
                        <option value="2" >femenino </option>
                    </select>
                    <hr>
                    <h2 class = "Article-title">Tu dirección</h2>
                    <p class = "personal-p">Estado</p>
                    <input type = "text" name = "estado" required class = "Section-usr" placeholder = "">
                    <p class = "personal-p">Municipio</p>
                    <input type = "text" name = "municipio" required class = "Section-usr" placeholder = "">
                    <p class = "personal-p">Colonia</p>
                    <input type = "text" name = "colonia" required class = "Section-usr" placeholder = "">
                    <hr>
                     <h2>Informacion Profesional</h2>
                    <p class = "personal-p">Cédula profesional</p>
                    <input type = "text" name = "plicense" required class = "Section-usr">
                    <p class = "personal-p">Escuela de procedencia</p>
                    <input type = "text" name = "school" required class = "Section-usr">
                    <p class = "personal-p">Carrera</p>
                    <input type = "text" name = "carrier" required class = "Section-usr">
                    <hr>
                    <input type = "submit" name = "btn-signin" class="Section-submit" value="Unirse">                    
                </form>
    </body>
</html>