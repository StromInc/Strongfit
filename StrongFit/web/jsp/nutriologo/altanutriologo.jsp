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
                <div class="" id="formu1">             
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <input type="text" name="txt-name" class="Section-nombre Section-txt" placeholder="Nombre" id="inputNo1" required>
                    <input type="email" name = "txt-mail" class="Section-mail Section-txt" placeholder="Correo" id="inputNo2" required>
                    <input type= "password" name = "txt-pass" class = "Section-pass Section-txt" placeholder="Contraseña" id="inputNo3" required>
                    <input type="text" name="edad" required onkeypress="return justNumbers(event);" class = "Section-txt" id="inputNo4" placeholder = "Edad">
                    <select name = "idSexo" class="Section-txt" id="inputNo5" required>
                        <option value="" >Seleccion de sexo</option>
                        <option value="1" >Masculino</option>
                        <option value="2" >Femenino</option>
                    </select>
                </div>
                <div class="" id="formu2">        
                    <h2 class="Article-title">Tu dirección</h2>
                    <input type="text" name="estado" required class="Section-txt" id="inputNo6" placeholder="Estado">
                    <input type="text" name="municipio" required class="Section-txt" id="inputNo7" placeholder="Municipio">
                    <input type="text" name="colonia" required class="Section-txt" id="inputNo8" placeholder="Colonia">
                </div>
                <div class="" id="formu3">                   
                    <h2>Informacion Profesional</h2>
                    <input type= "text" name="plicense" required class= "Section-txt" id="inputNo9" placeholder="Cedula Profesional" onkeypress="return justNumbers(event);">
                    <input type= "text" name="school" required class= "Section-txt" id="inputNo10" placeholder="Escuela">
                    <input type= "text" name="carrier" required class= "Section-txt" id="inputNo11" placeholder="Carrera">
                </div>
                <input type= "submit" name="btn-signin" class="Section-submit" value="Unirse" id="envia">
                <p class="Section-login">¿Ya tienes cuenta? <a href = "../../index.jsp">Ingresa.</a></p>            
            </form>
            </article>          
        </section>
        <footer class = "Footer">
            <p class="Footer-parrafo Footer-parrafo1">Strongfit es un proyecto creado por <a href="#" class="Footer-link">Strom</a>.</p>
            <p class="Footer-parrafo"><a href="#" class = "Footer-link">Politicas de privacidad</a></p>
        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script type="text/javascript" src="../../js/acciones_registro.js"></script>
    </body>
</html>