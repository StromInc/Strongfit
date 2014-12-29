<%@page import="java.sql.ResultSet"%>
<%@page import="clases.cSugerirDietas"%>
<%@page import="javax.validation.constraints.Null"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session='true'%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
    </head>
    
    <body>
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
    int sexo = (Integer)sesion.getAttribute("sexo");
    String estado = (String)sesion.getAttribute("estado");
    String municipio = (String)sesion.getAttribute("municipio");
    String colonia = (String)sesion.getAttribute("colonia");
    
    int calorias = 0;
    int horas = 0;
    int idActividad = 0;
    int idSalud = 0;
    String estadoS = "";
    
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
    conecta.conectar();

   ResultSet info = conecta.spGetInfoNutricional(idUsr);
   if(info.next())
   {
       calorias = info.getInt("calorias");%><script>alert(<%=calorias%>);</script><%
       horas = info.getInt("horas");%><script>alert(<%=horas%>);</script><%
       idActividad = info.getInt("idActividad");%><script>alert(<%=idActividad%>);</script><%
       idSalud = info.getInt("idSalud");%><script>alert(<%=idSalud%>);</script><%
   }

   if(idSalud != 0)
   {
       ResultSet es = conecta.spGetInfoEstado(idSalud);
       if(es.next())
       {
           estadoS = es.getString("tipoEstado");
       }
   }
   else
       estadoS = "Aún sin calcular";
//    cSugerirDietas sugerirD = new cSugerirDietas(idUsr, edad, peso, cintura, estatura, sexo, actividad);
    %>
    
        <%@include file="barra_menu.jsp"%>       
        <section class = "Section-tbl-usr">
            <div class="div-informacion">
                <!--esta es la imagen que el usuario elija-->
                <article class = "Article-tbl-usr2" style = "margin-left: 0">
                    <img src = "../../Imagenes/usr-sin-img.jpg" class ="img-usr" alt = "foto de usuario">
                    <input type = "button" value="cambiar" class="btn-imagen">
                </article>

                <!--esta es informacion nutrimental como si esta gordo y cuantas calorias debe de consumir-->
                <article class = "Article-tbl-usr2" style = "margin-left: 0">
                    <h2 class = "Article-title">Calorias a consumir diariamente</h2>
                    <hr>
                    <%
                        if(calorias == 0)
                        {
                            %><h3>Aún sin calcular</h3><%
                        }
                        else
                        {
                            %><h3><%=calorias%></h3><%
                        }
                    %>
                </article>
                <article class = "Article-tbl-usr2" style = "margin-left: 0">
                    <h2 class = "Article-title">Estado de salud</h2>
                    <hr>
                    <h3><%=estadoS%></h3>
                </article>
            </div>
            <!--esta es la informacion de la cuenta del paciente-->
            <article class = "Article-tbl-usr">
                <form action = "/StrongFit/sPerfilDeUsuario" method = "post">
                    <hr>
                    <h2 class = "Article-title">Información de cuenta</h2>
                    <p class = "personal-p">Nombre</p>
                    <input type = "text" name = "name" required class = "Section-usr" value = "<%=nombre%>">
                    <p class = "personal-p">Correo</p>
                    <input type = "email" name = "email" required class = "Section-usr" value="<%=idUsr%>">
                    <p class = "personal-p">Contraseña</p>
                    <input type = "text" name = "contra" required class = "Section-usr" value="<%=pass%>">
                    <hr>
                    <h2 class = "Article-title">Información nutrimental</h2>
                    <div class = "div-nutrimental">
                        <p class = "m1 medidas-p">Peso</p>
                        <input type = "text" name = "peso" required class = "Section-m" value = "<%=peso%>" placeholder="(Kg)">
                    </div>
                    <div class = "div-nutrimental estatura">
                        <p class = "m2 medidas-p">Estatura</p>
                        <input type = "text" name = "estatura" required class = "Section-m" value = "<%=estatura%>" placeholder="cm">
                    </div>
                    <div class = "div-nutrimental">
                        <p class = "m3 medidas-p">Cintura</p>
                        <input type = "text" name = "cintura" required class = "Section-m" value = "<%=cintura%>" placeholder="cm">
                    </div>
                    <div class = "div-nutrimental edad">
                        <p class = "medidas-p">Edad</p>
                        <input type = "text" name = "edad" required class = "Section-m" value = "<%=edad%>">
                    </div>
                    <div class = "div-nutrimental sexo">
                        <p class = "medidas-p">Sexo</p>
                        <select name = "sexo" class = "select-sexo">
                            <option value="" <%=v1%>>Seleccionar </option>
                            <option value="1" <%=v2%>>Masculino </option>
                            <option value="2" <%=v3%>>Femenino </option>
                        </select>
                    </div>
                    <div class="div-nutrimental actividad">
                        <p class = "medidas-p">Actividad Física</p>
                        <select required name ="actividad" class = "select-actividad">
                            <option value="">Selcciona actividad</option>
                            <%
                            conecta.conectar();
                            ResultSet rs = conecta.getActividades();
                            int idAct = 0;
                            String nombreAct = "";
                            while(rs.next())
                            {
                                idAct = rs.getInt("idActividad");
                                nombreAct = rs.getString("actividad");
                            %>
                            <option value="<%=idAct%>"><%=nombreAct%></option>
                            <%
                            }
                            %>
                        </select>
                    </div>
                    <div class = "div-nutrimental input-horas">
                        <p class="medidas-p">Horas</p>
                        <%
                            
                                %><input type="text" placeholder = "hrs/semana" name ="horas" value="<%=horas%>" class="Section-m horas" required><%
                            
                        %>
                        
                    </div>
                    <hr>
                    <h2 class = "Article-title">Tu dirección</h2>
                    <p class = "personal-p">Estado</p>
                    <input type = "text" name = "estado" required class = "Section-usr" value = "<%=estado%>">
                    <p class = "personal-p">Municipio</p>
                    <input type = "text" name = "municipio" required class = "Section-usr" value = "<%=municipio%>">
                    <p class = "personal-p">Colonia</p>
                    <input type = "text" name = "colonia" required class = "Section-usr" value = "<%=colonia%>">
                    <hr>
                    <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-act-usr">
                </form>
            </article>
        </section>
        
    </body>
</html>
