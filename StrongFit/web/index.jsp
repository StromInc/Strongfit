<%-- 
    Document   : index
    Created on : 3/11/2014, 08:38:03 PM
    Author     : Ian
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
        <title>StrongFit</title>
        <link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
        <link rel = "stylesheet" type ="text/css" href="Estilos/estilos_login.css">
        <link rel="shortcut icon" href="Imagenes/logo_s.jpg"> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    </head>
    <body class="fondo" onload="mandar()">
        <header class = "Header">
            <h1 class="Header-title"><a href = "index.jsp">Strongfit</a></h1>
            <button class="Header-button is-active" id="show">Login</button>
            <button class="Header-button" id="hide">Ocultar</button>
            <form action = "sLogIn" method="post" class="Header-form" id="formu" onsubmit="guardarsesion()">
                <input type = "email" name = "txt-mail" class="Header-mail Header-txt" placeholder = "Correo" required id="email1">
                <input type = "password" name = "txt-pass" class = "Header-pass Header-txt" placeholder="Contraseña" required id="psw1">
                <input type = "submit" name = "btn-signin" class="Header-submit" value="Entrar"><br>
                <!--<p class="Header-content">--><input type="checkbox" id="chek1"><label for="chek1" class="Header-label">Mantener sesión iniciada.</label><!--</p>-->
            </form>
        </header>
        <div class="Background" id="background">
            <script type="text/javascript">
                $('#background').hide();
            </script>
            <div class="active" id="back1"></div>
            <div id="back2"></div>
            <div id="back3"></div>
            <div id="back4"></div>
            <div id="back5"></div>
        </div>
        <section class="Section">     
            <article class="Section-article">
                <h3 class = "Section-login">¿No tienes cuenta?, &nbsp;<strong style="font-size: 1.4em;">Registrate</strong></h3>
                <form action = "sAltaDeUsuario" method="post" class="Section-form">
                    <input type = "text" name = "txt-name" class="Section-nombre Section-txt" placeholder = "Nombre" required>
                    <p class="Section-form container"><input type = "email" id="email" name = "txt-mail" class="Section-mail Section-txt" placeholder = "Correo" required><span class="arrow hidden"></span></p>
                    <input type = "password" name = "txt-pass" class = "Section-pass Section-txt" placeholder="Contraseña" required>
                    <input type = "submit" name = "btn-signin" class="Section-submit" value="Unirse">
                    <p class="Section-form item">¿Eres un nutriólogo?<a href = "jsp/nutriologo/altanutriologo.jsp">Registrate como médico.</a></p>
                </form>
            </article>
            <article class="Section-signup">
                <p>Administra tus comidas diarias, tus dietas, tu gasto calórico, encuentra nutriólogos y mucho más con <strong>Strongfit</strong>.</p>
            </article>
        </section>    
        <footer class = "Footer">
            <p class="Footer-parrafo Footer-parrafo1">Strongfit es un proyecto creado por <a href="#" class="Footer-link">Strom</a>.</p>
            <p class="Footer-parrafo"><a href="#" class = "Footer-link">Politicas de privacidad</a></p>
        </footer>
        <%
            HttpSession sesion = request.getSession();
            if(sesion.getAttribute("mensaje") != null){
                String mensaje = (String)sesion.getAttribute("mensaje");
                System.out.println(mensaje);
                out.print("<script>alert('"+mensaje+"');</script>");
                sesion.removeAttribute("mensaje");
                sesion.invalidate();
            }
        %>
        <script src="js/acciones_index.js"></script>
    </body>
</html>
