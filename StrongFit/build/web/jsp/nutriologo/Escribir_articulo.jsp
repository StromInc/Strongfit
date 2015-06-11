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
              <%
              
              HttpSession sesion = request.getSession();
              String idUsr = (String)sesion.getAttribute("idUsr");
              String idArt = (String)sesion.getAttribute("artenuso");
              clases.CImagen objimg = new clases.CImagen();
              String ruta = "";

              if(idArt.equals("")){
                int verificacionimg = objimg.devuelveexistencia(idUsr,2);
                idArt = "nuevoarticuloenblanco";
                String ruta2 = "../../Imagenes/Articulos/";
                switch(verificacionimg){
                    case 1: 
                        ruta = ruta2 + idUsr + ".jpg";
                        break;
                    case 2: 
                        ruta = ruta2 + idUsr + ".png";
                        break;
                    case 3: 
                        ruta = ruta2 + idUsr + ".gif";
                        break;
                    default: 
                        ruta = "../../Imagenes/articulo_sin_imagen.jpg";
                        break;
                }
    }else{
              int verificacionimg = objimg.devuelveexistencia(idArt,2);
                
                String ruta2 = "../../Imagenes/Articulos/";
                switch(verificacionimg){
                    case 1: 
                        ruta = ruta2 + idArt + ".jpg";
                        break;
                    case 2: 
                        ruta = ruta2 + idArt + ".png";
                        break;
                    case 3: 
                        ruta = ruta2 + idArt + ".gif";
                        break;
                    default: 
                        ruta = "../../Imagenes/articulo_sin_imagen.jpg";
                        break;
              }
              }
              %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio2.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src = "../../js/acciones_inicio.js"></script>
        <script src = "../../js/acciones_articulo.js"></script>
         <script src="../../js/salir.js"></script>
    </head>
    <%@include file = "barra_menu.jsp" %>
    <body onLoad="buscamisarticulos('busca'),cambiaarticulo('<%=idArt%>')" >
        <section class="Section-todo">
            <form  enctype="multipart/form-data" id="img_frm" method="post" action="../Ssubirimagenart.jsp" name="img_frm" class="Article-articulosi" >
                        <input class = "articulosk"type = "file"  name="uploadFile" id="ImgUsuario" class="input-subir" required/>
                        <input class = "articulosk"type = "submit" value="cambiar" class="btn-imagen" onclick="cambiarartenuso()"/>
                    </form>         
            <span id="edicion">
                Titulo:<br><input type="text" id="txtnombre" class = "articulosk"><br><br>
                <img src = "<%=ruta%>" class ="portada" alt = "foto de usuario">
                 
                 <br>
                Texto:<br><span contentEditable="true" id="txtarticulo" class="Article-articulosf"><p style="color: white;">  
                        <br>                    
                    </p></span><br>
                    <input type="button" value=Guardar" onclick="escribearticulo('escribe')" class="botonenviar">            
            </span>
                <span id="misarticulos" class="Article-articulosg">
                    
                </span>   
                <span id="misopciones" class="Article-articulosj">
                    <span id="tipo">Fuente: 
                        <select id="fuente" onChange="cambia()" class = "articulosk">
                            <option>Default</option>
                            <option>Arial</option>
                            <option>Comic Sans</option>
                        </select>
                    </span><hr>   
                    <span id="tipo" >Tamaño: 
                        <select id="tamano" onChange="cambia()"  class = "articulosk">
                            <option selected>Normal</option>
                            <option>Pequeña</option>
                            <option>Grande</option>
                        </select>
                    </span><hr>
                    <span id="tipo" >Color: 
                        <select id="color" onChange="cambia()"  class = "articulosk">
                            <option selected>Blanco</option>
                            <option>Rojo</option>
                            <option>Azul</option>
                        </select>
                    </span><hr>
                </span>
        </section> 
    </body>
</html>