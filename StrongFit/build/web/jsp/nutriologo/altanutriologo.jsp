<%-- 
    Document   : nutriologo
    Created on : 7/12/2014, 03:24:15 PM
    Author     : jorge pastrana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!-- Descripción de la página -->
        <meta name="description" content="Mejora tu salud y vive plenamente" />
        <!-- Autor de la página -->
        <meta name="author" content="Strom" />
        <!-- Indexación para los motores de búsqueda -->
        <meta name="robots" content="index, follow, noarchive" />
        <!-- Para el responsive design de la página -->
        <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
        <!--<link rel="stylesheet" href="Estilos/estilo.css">-->
        <!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
        <link rel = "stylesheet" type ="text/css" href="../../Estilos/estilos_registro.css">
        <link rel="shortcut icon" href="../../Imagenes/logo_s.jpg">
        <title>Registrate</title>
    </head>
    <body>
        <section class="Section">
            <article class="Section-article">
            <h1 class="Section-title">Registrate</h1>
            <form action = "/StrongFit/sAltaDeMedico" method="post" class="Section-form">
                <h2 class = "Article-title">Información de cuenta</h2>
                <input type = "text" name = "txt-name" class="Section-nombre Section-txt" placeholder = "Nombre" required>
                <input type = "email" name = "txt-mail" class="Section-mail Section-txt" placeholder = "Correo" required>
                <input type = "password" name = "txt-pass" class = "Section-pass Section-txt" placeholder="Contraseña" required>
                <input type = "text" name = "edad" required class = "Section-txt" placeholder = "Edad">
                <select name = "sexo" class="Section-txt">
                    <option value="" >Seleccion de sexo</option>
                    <option value="1" >Masculino</option>
                    <option value="2" >femenino</option>
                </select>
                <h2 class="Article-title">Tu dirección</h2>
                <input type="text" name="estado" required class="Section-txt" placeholder="Estado">
                <input type="text" name="municipio" required class="Section-txt" placeholder="Municipio">
                <input type="text" name="colonia" required class="Section-txt" placeholder="Colonia">
                <h2>Informacion Profesional</h2>
                <input type= "text" name="plicense" required class= "Section-txt" placeholder="Cedula Profesional">
                <input type= "text" name="school" required class= "Section-txt" placeholder="Escuela">
                <input type= "text" name="carrier" required class= "Section-txt" placeholder="Carrera">
                <input type= "submit" name="btn-signin" class="Section-submit" value="Unirse">
                <p class="Section-login">¿Ya tienes cuenta? <a href = "../../index.jsp">Ingresa.</a></p>            
            </form>
            </article>          
        </section>
        <footer class = "Footer">
            <p class="Footer-parrafo Footer-parrafo1">Strongfit es un proyecto creado por <a href="#" class="Footer-link">Strom</a>.</p>
            <p class="Footer-parrafo"><a href="#" class = "Footer-link">Politicas de privacidad</a></p>
        </footer>
    </body>
</html>