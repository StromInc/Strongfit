<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilos_perfil.css">
        <script>
                function numerossolo(e) {
			var keynum;
			if (window.event) {
				/*IE*/
				keynum=e.keyCode;
			}
			if (e.which) {
				//Netscape Firefox Opera
				keynum=e.which;
			}
			if ((keynum>=48&&keynum<=57)||keynum==8) {
				return true;
			} 
			else{
				return false;
			}
		}
        </script>
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
    int verificacionimg = objimg.devuelveexistencia(idUsr,1);
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
        <section class = "Section large x-large">
            <div class="Content"> 
                <div class="Content-image">
                    <h2 class="Datos-title">Mi perfil</h2>
                    <figure >                   
                    <img src = "<%=ruta%>" width="250" height="250" class="Figure-image" alt = "foto de usuario">
                    </figure>
                    <form  enctype="multipart/form-data" id="img_frm" method="post" action="../Ssubirimagen.jsp" name="img_frm">
                    <p>
                        <input type = "file"  name="uploadFile" id="ImgUsuario" class="input-subir" required/>
                    </p>
                    <p>
                        <input type = "submit" value="cambiar" class="btn-profile"/>
                    </p>
                    </form>
                </div>             
                <div class="Datos">
                    <form action = "/StrongFit/sPerfilDeMedico" method = "post">
                        <!--<nav class="Menu">
                            <ul class="Menu-list">
                                <li class="Menu-item"><a href="#" id="link_1" class="activo">1</a></li>
                                <li class="Menu-item"><a href="#" id="link_2">2</a></li>
                                <li class="Menu-item"><a href="#" id="link_3">3</a></li>
                            </ul>
                        </nav>-->    
                        <div class="prueba is-active" id="formu_1">
                            <h3 class="Datos-title">Información de la cuenta</h3>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="nombre">Nombre:</label>
                                <input type = "text" name = "txt-name" required class="Datos-input" placeholder="" value="<%=nombre%>" id="nombre"></p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="correo">Correo:</label>
                                <input type = "email" id="correo" name = "txt-email" required class="Datos-input" placeholder="" value="<%=idUsr%>">
                            </p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="contra">Contraseña:</label>
                                <input type = "password" name = "txt-pass" required class="Datos-input" placeholder="" value="<%=pass%>" id="for">
                            </p>
                        </div>
                        <div class="prueba" id="formu_2">
                            <h3 class="Datos-title">Información pública</h3>
                            <div class="Datos-especial">
                                <p class="Datos-wrapper centrar-texto">
                                    <label class = "medidas-p" for="edad">Edad:</label>
                                    <input type = "number" name = "edad" onkeypress="return numerossolo(event);" required class="Datos-input" placeholder = "" value="<%=edad%>" id="edad">
                                </p>
                                <p class="Datos-wrapper centrar-texto">
                                    <label for="genero">Genero:</label>
                                    <select name = "sexo" class="Datos-input" id="genero">
                                        <option value="" <%=v1%>>Seleccionar </option>
                                        <option value="1" <%=v2%>>Masculino </option>
                                        <option value="2" <%=v3%>>Femenino </option>
                                    </select>
                                </p>
                            </div>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="cedula">Cédula profesional:</label>
                                <input type = "text" name = "plicense" onkeypress="return numerossolo(event);" required class="Datos-input" placeholder="" value="<%=cedula%>" id="cedula">
                            </p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" id="escula">Escuela de procedencia:</label>
                                <input type = "text" name = "school" required class="Datos-input" placeholder="" value="<%=escuela%>" id="escuela">
                            </p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" id="carrera">Carrera:</label>
                                <input type = "text" name = "carrier" required class="Datos-input" placeholder="" value="<%=carrera%>" id="carrera">
                            </p>
                        </div>
                        <div class="prueba" id="formu_3">
                            <h3 class="Datos-title">Tu dirección</h3>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="estado">Estado:</label>
                                <input type = "text" name = "estado" id="estado" required class="Datos-input" placeholder = "" value="<%=estado%>">
                            </p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="municipio">Municipio:</label>
                                <input type = "text" name = "municipio" id="municipio" required class="Datos-input" placeholder = "" value="<%=municipio%>">
                            </p>
                            <p class="Datos-wrapper">
                                <label class="Datos-label" for="colonia">Colonia:</label>
                                <input type = "text" name = "colonia" id="colonia" required class="Datos-input" placeholder = "" value="<%=colonia%>">
                            </p>
                        </div>
                        <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-profile">
                    </form>
                </div>
            </div>
        </section>
        <script src="../../js/acciones_perfil.js"></script>
         <script src="../../js/salir.js"></script>
    </body>
</html>
