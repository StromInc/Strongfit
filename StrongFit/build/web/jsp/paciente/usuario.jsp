<%@page contentType="text/html" pageEncoding="UTF-8" session='true'%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
    </head>
    <!-- obtenemos los datos del usuario -->
    <%
    HttpSession sesion = request.getSession();
    String nombre = (String)sesion.getAttribute("nombre");
    String idUsr = (String)sesion.getAttribute("idUsr");
    String pass = (String)sesion.getAttribute("pass");
    String peso = (String)sesion.getAttribute("peso");
    String estatura = (String)sesion.getAttribute("estatura");
    String cintura = (String)sesion.getAttribute("cintura");
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
                <form action = "/StrongFit/sPerfilDeUsuario" method = "post">
                    <hr>
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <p class = "personal-p">Nombre</p>
                    <input type = "text" name = "name" required class = "Section-usr" placeholder="<%=nombre%>">
                    <p class = "personal-p">Correo</p>
                    <input type = "email" name = "email" required class = "Section-usr" placeholder="<%=idUsr%>">
                    <p class = "personal-p">Contraseña</p>
                    <input type = "text" name = "contra" required class = "Section-usr" placeholder="<%=pass%>">
                    <hr>
                    <h2 class = "Article-title">Información nutrimental</h2>
                    <p class = "m1 medidas-p">Peso</p>
                    <p class = "m2 medidas-p">Estatura</p>
                    <p class = "m3 medidas-p">Cintura</p>
                    <input type = "text" name = "peso" required class = "Section-m" placeholder = "<%=peso%>(Kg)">
                    <input type = "text" name = "estatura" required class = "Section-m" placeholder = "<%=estatura%>(m)">
                    <input type = "text" name = "cintura" required class = "Section-m" placeholder = "<%=cintura%>(m)">
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
