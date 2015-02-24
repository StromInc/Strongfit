<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
    </head>
    <%
    HttpSession sesion = request.getSession();
    String nombre = (String)sesion.getAttribute("nombre");
    String idUsr = (String)sesion.getAttribute("idUsr");
    int idMedico = (Integer)sesion.getAttribute("idMedico");
    String pass = (String)sesion.getAttribute("pass");
    int cedula = (Integer)sesion.getAttribute("cedula");
    String escuela = (String)sesion.getAttribute("escuela");
    String carrera = (String)sesion.getAttribute("carrera");
    int edad = (Integer)sesion.getAttribute("edad");
    int sexo = (Integer)sesion.getAttribute("sexo");
    String estado = (String)sesion.getAttribute("estado");
    String municipio = (String)sesion.getAttribute("municipio");
    String colonia = (String)sesion.getAttribute("colonia");
    // creamos un booleano para la parte del sexo
    String v1 = "";
    String v2 = "";
    String v3 = "";
    if(sexo == 1){
    v2 = "selected";
    }
    if(sexo == 2){
    v3 = "selected";
    }
    if(sexo == 0){
    v1 = "selected";
    }
    clases.CImagen objimg = new clases.CImagen();
    int verificacionimg = objimg.devuelveexistencia(idUsr);
    String ruta = "";
    String ruta2 = "../../Imagenes/Usuarios/";
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
            ruta = "../../Imagenes/usr_sin_imagen.jpg";
            break;              
    }
    %>
    <body>
        <%@include file="barra_menu.jsp"%>       
        <section class = "Section-tbl-usr">
        <div class="div-informacion">
            <article class = "Article-tbl-usr2" style = "margin-left: 0" id="Imagen">
                <img src = "<%=ruta%>" class ="img-usr" alt = "foto de usuario">
                <form  enctype="multipart/form-data" id="img_frm" method="post" action="../Ssubirimagen.jsp" name="img_frm">
                    <input type = "file"  name="uploadFile" id="ImgUsuario" class="input-subir" required/>
                    <input type = "submit" value="cambiar" class="btn-imagen"/>
                </form>
            </article>
            </div>             
            <article class = "Article-tbl-usr">
                <form action = "/StrongFit/sPerfilDeMedico" method = "post">
                    <nav class="Menu">
                        <ul class="Menu-list">
                            <li class="Menu-item"><a href="#" id="link_1" class="activo">1</a></li>
                            <li class="Menu-item"><a href="#" id="link_2">2</a></li>
                            <li class="Menu-item"><a href="#" id="link_3">3</a></li>
                        </ul>
                    </nav>      
                    <div class="prueba is-active" id="formu_1">
                        <h2 class = "Article-title">Información de cuenta</h2>
                        <p class = "personal-p">Nombre</p>
                        <input type = "text" name = "txt-name" required class = "Section-usr" placeholder="" value="<%=nombre%>">
                        <p class = "personal-p">Correo</p>
                        <input type = "email" name = "txt-email" required class = "Section-usr" placeholder="" value="<%=idUsr%>">
                        <p class = "personal-p">Contraseña</p>
                        <input type = "text" name = "txt-pass" required class = "Section-usr" placeholder="" value="<%=pass%>">
                    </div>
                    <div class="prueba" id="formu_2">
                        <h2 class = "Article-title">Información pública</h2>
                        <div class="div-edad">
                            <p class = "medidas-p">Edad</p>
                            <input type = "text" name = "edad" required class = "Section-m" placeholder = "" value="<%=edad%>">
                        </div>
                        <div class = "div-sexo">
                            <p class = "personal-p">Sexo</p>
                            <select name = "sexo" class="select-sexo">
                                <option value="" <%=v1%>>Seleccionar </option>
                                <option value="1" <%=v2%>>Masculino </option>
                                <option value="2" <%=v3%>>femenino </option>
                            </select>
                        </div>
                        <p class = "personal-p">Cédula profesional</p>
                        <input type = "text" name = "plicense" required class = "Section-usr" placeholder="" value="<%=cedula%>">
                        <p class = "personal-p">Escuela de procedencia</p>
                        <input type = "text" name = "school" required class = "Section-usr" placeholder="" value="<%=escuela%>">
                        <p class = "personal-p">Carrera</p>
                        <input type = "text" name = "carrier" required class = "Section-usr" placeholder="" value="<%=carrera%>">
                    </div>
                    <div class="prueba" id="formu_3">
                        <h2 class = "Article-title">Tu dirección</h2>
                        <p class = "personal-p">Estado</p>
                        <input type = "text" name = "estado" required class = "Section-usr" placeholder = "" value="<%=estado%>">
                        <p class = "personal-p">Municipio</p>
                        <input type = "text" name = "municipio" required class = "Section-usr" placeholder = "" value="<%=municipio%>">
                        <p class = "personal-p">Colonia</p>
                        <input type = "text" name = "colonia" required class = "Section-usr" placeholder = "" value="<%=colonia%>">
                    </div>
                    <hr>
                    <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-act-usr">
                </form>
            </article>
        </section>
        <script src="../../js/acciones_perfil.js"></script>
         <script src="../../js/salir.js"></script>
    </body>
</html>
