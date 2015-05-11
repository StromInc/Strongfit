<%-- 
    Document   : Escribir_articulo
    Created on : 17/03/2015, 11:19:46 AM
    Author     : jorge pastrana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
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
    <%@include file = "barra_menu.jsp" %>
    <body onLoad=buscamisarticulos('busca');>
        <section class="Section-todo">
            <form action="" method="post">
            <span id="edicion">
                Nombre:<br><input type="text" id="txtnombre"><br>
                 <img src = "" class ="img-usr" alt = "foto de usuario">
                <form  enctype="multipart/form-data" id="img_frm" method="post" action="../Ssubirimagen.jsp" name="img_frm">
                        <input type = "file"  name="uploadFile" id="ImgUsuario" class="input-subir" required/>
                        <input type = "submit" value="cambiar" class="btn-imagen"/>
                </form><br>
                Texto:<br><textarea rows="30" cols="100" id="txtarticulo"></textarea><br>
                <input type="button" value="Enviar" onclick=escribearticulo('escribe')>                
            </span>
                <span id="misarticulos" >
                    
                </span>   
            </form>    
        </section> 
    </body>
</html>
