
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../meta.jsp" %>
    </head>
    <style>
            .Section{
                text-align: justify;
                margin: 0 auto;
                margin-top: 3em;
                max-width: 300px;
            }
            .Section-title{
                font-weight: normal;
                text-align: center;
            }
            .Section-button{
                font-size:16px;
                background:#0070c8;
                border:none;
                -webkit-border-radius:3px;
                border-radius:3px;
                padding:.3rem 1rem;
                color:#fff;
                -webkit-box-shadow:0 1px 3px rgba(0,0,0,0.12),0 1px 2px rgba(0,0,0,0.24);
                box-shadow:0 1px 3px rgba(0,0,0,0.12),0 1px 2px rgba(0,0,0,0.24);
                text-decoration: none;
            }
        </style>
    <body>
        <section class="Section">
        <h1 class="Section-title">Felicidades, ya casi eres miembro</h1>
        <p>Por cuestiones de seguridad y de autentificación de datos, los administradores de StrongFit revisarán tu perfil. No te preocupes, no tomaremos más de un día. Revisa frecuentemente tu bandeja de entrada del correo que ingresaste, ahí te enviarémos las notificaciones y también lo usarás para entrar al sistema. Ten un gran día.</p>
        <p class="Section-title"><input type = "button" class="Section-button"value="Aceptar" onclick="location.href='http://localhost:8080/StrongFit/'"></p>
        </section>
    </body>
</html>
