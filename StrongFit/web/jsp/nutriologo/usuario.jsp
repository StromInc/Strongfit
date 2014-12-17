<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
    </head><%
    HttpSession sesion = request.getSession();
    String nombre = (String)sesion.getAttribute("nombre");
    String idUsr = (String)sesion.getAttribute("idUsr");
    String pass = (String)sesion.getAttribute("pass");
    String peso = (String)sesion.getAttribute("peso");
    String cedula = (String)sesion.getAttribute("cedula");
    String escuela = (String)sesion.getAttribute("escuela");
    String carrera = (String)sesion.getAttribute("carrera");
    String edad = (String)sesion.getAttribute("edad");
    String sexo = (String)sesion.getAttribute("sexo");
    String estado = (String)sesion.getAttribute("estado");
    String municipio = (String)sesion.getAttribute("municipio");
    String colonia = (String)sesion.getAttribute("colonia");
    // creamos un booleano para la parte del sexo
    String v1 = "";
    String v2 = "";
    String v3 = "";
    if(sexo.equals("1")){
    v2 = "selected";
    }
    if(sexo.equals("2")){
    v3 = "selected";
    }
    if(sexo.equals("")){
    v1 = "selected";
    }
    %>
    <body>
        <%@include file="barra_menu.jsp"%>       
        <section class = "Section-tbl-usr">
            <article class = "Article-tbl-usr2" style = "margin-left: 0">
                <img src = "../../Imagenes/usr-sin-img.jpg" class ="img-usr" alt = "foto de usuario">
                <input type = "button" value="cambiar" class="btn-imagen">
            </article> 
            <article class = "Article-tbl-usr">
                <form action = "/StrongFit/sPerfilDeMedico" method = "post">
                    <hr>
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <p class = "personal-p">Nombre</p>
                    <input type = "text" name = "txt-name" required class = "Section-usr" placeholder="<%=nombre%>">
                    <p class = "personal-p">Correo</p>
                    <input type = "email" name = "txt-email" required class = "Section-usr" placeholder="<%=idUsr%>">
                    <p class = "personal-p">Contraseña</p>
                    <input type = "text" name = "txt-pass" required class = "Section-usr" placeholder="<%=pass%>">
                    <hr>
                    
                    <h2>Información pública</h2>
                    <p class = "personal-p">Cédula profesional</p>
                    <input type = "text" name = "plicense" required class = "Section-usr" placeholder="<%=cedula%>">
                    <p class = "personal-p">Escuela de procedencia</p>
                    <input type = "text" name = "school" required class = "Section-usr" placeholder="<%=escuela%>">
                    <p class = "personal-p">Carrera</p>
                    <input type = "text" name = "carrier" required class = "Section-usr" placeholder="<%=carrera%>">
                    <hr>
                    <h2 class = "Article-title">Tu edad</h2>
                    <input type = "text" name = "edad" required class = "Section-usr" placeholder = "<%=edad%>">
                    <hr>
                    <h2 class = "Article-title">Tu sexo</h2>
                    <select name = "sexo">
                        <option value="" <%=v1%>>Seleccionar </option>
                        <option value="1" <%=v2%>>Masculino </option>
                        <option value="2" <%=v3%>>femenino </option>
                    </select>
                    <hr>
                    <h2 class = "Article-title">Tu dirección</h2>
                    <p class = "personal-p">Estado</p>
                    <input type = "text" name = "estado" required class = "Section-usr" placeholder = "<%=estado%>">
                    <p class = "personal-p">Municipio</p>
                    <input type = "text" name = "municipio" required class = "Section-usr" placeholder = "<%=municipio%>">
                    <p class = "personal-p">Colonia</p>
                    <input type = "text" name = "colonia" required class = "Section-usr" placeholder = "<%=colonia%>">
                    <hr>
                    <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-act-usr">
                </form>
            </article>
        </section>
        
    </body>
</html>
