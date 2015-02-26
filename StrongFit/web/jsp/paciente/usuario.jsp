<%@page import="java.sql.ResultSet"%>
<%@page import="clases.cSugerirDietas"%>
<%@page import="javax.validation.constraints.Null"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session='true'%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <script src = "../../js/acciones_usuarioPaciente.js"></script>
        <script src="../../js/salir.js"></script>
    </head>
    <body>
        <%@include file="barra_menu.jsp"%> 
        <%
    HttpSession sesion = request.getSession();
    String nombre = (String)sesion.getAttribute("nombre");
    String idUsr = (String)sesion.getAttribute("idUsr");
    int idPaciente = (Integer)sesion.getAttribute("idPaciente");
    String pass = (String)sesion.getAttribute("pass");
    int peso = (Integer)sesion.getAttribute("peso");
    int estatura = (Integer)sesion.getAttribute("estatura");
    int cintura = (Integer)sesion.getAttribute("cintura");
    int edad = (Integer)sesion.getAttribute("edad");
    int sexo = (Integer)sesion.getAttribute("sexo");
    String estado = (String)sesion.getAttribute("estado");
    String municipio = (String)sesion.getAttribute("municipio");
    String colonia = (String)sesion.getAttribute("colonia");
    int idSalud = (Integer)sesion.getAttribute("salud");
    String estadoS = "";
    String color = "";
    
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
    ResultSet es = conecta.spGetInfoEstado(idSalud);
    if(es.next())
    {
       estadoS = es.getString("tipoEstado");
    }
    else
        estadoS = "Aún sin calcular";
    
//    cSugerirDietas sugerirD = new cSugerirDietas(idUsr, edad, peso, cintura, estatura, sexo, actividad);
    int seleccion = 0, con = 0, seleccionOcupacion = 0;
    int caloriasD[] = new int[7];
    String horas[] = new String[7];
    String seleccionDias[] = new String[7];
    String diasSemana[] = {"Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"};
    ResultSet select = conecta.spGetCaloriasPaciente(idPaciente);
    for(int i = 0; i < horas.length; ++i)
    {
        horas[i] = "";
    }
    while(select.next())
    {
        caloriasD[con] = select.getInt("calorias");
        seleccion = select.getInt("idActividad");
        seleccionOcupacion = select.getInt("ocupacion");
        if(select.getInt("horas") != 0)
        {
            seleccionDias[con] = "checked";
            horas[con] = String.valueOf(select.getInt("horas"));
        }
        else
        {
            seleccionDias[con] = "";
            horas[con] = "";
        }   
        con++;
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
    <section class = "Section-tbl-usr">
            <div class="div-informacion">
                <!--esta es la imagen que el usuario elija-->
                <article class = "Article-tbl-usr2" style = "margin-left: 0" id="Imagen">
                    <img src = "<%=ruta%>" class ="img-usr" alt = "foto de usuario">
                    <form  enctype="multipart/form-data" id="img_frm" method="post" action="../Ssubirimagen.jsp" name="img_frm">
                        <input type = "file"  name="uploadFile" id="ImgUsuario" class="input-subir" required/>
                        <input type = "submit" value="cambiar" class="btn-imagen"/>
                    </form>
                </article>    
                <!--esta es informacion nutrimental como si esta gordo y cuantas calorias debe de consumir-->
                <article class = "Article-tbl-usr2" style = "margin-left: 0">
                    <h2 class = "Article-title">Calorias a consumir diariamente</h2>
                    <hr>
                    <%for(int i = 0; i < caloriasD.length; ++i)
                        {
                    %>
                    <div class = "micha" style="text-align: left;"><div class = "diaCalorias"><%=diasSemana[i]%></div></div><div class = "micha" style ="text-align: right;"><div class = "caloriasPaciente "><%=caloriasD[i]%> kcal</div></div>
                    <%
                        }
                    %>
                </article>
                <article class = "Article-tbl-usr2" style = "margin-left: 0; <%=color%>">
                    <h2 class = "Article-title">Estado de salud</h2>
                    <hr>
                    <h3><%=estadoS%></h3>
                </article>
            </div>
            <!--esta es la informacion de la cuenta del paciente-->
            <article class = "Article-tbl-usr">
                <form action = "/StrongFit/sPerfilDeUsuario" method = "post">
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
                        <input type = "text" name = "name" required class = "Section-usr" value = "<%=nombre%>">
                        <p class = "personal-p">Correo</p>
                        <input type = "email" name = "email" required class = "Section-usr" value="<%=idUsr%>">
                        <p class = "personal-p">Contraseña</p>
                        <input type = "password" name = "contra" required class = "Section-usr" value="<%=pass%>">
                    </div>               
                    <div class="prueba" id="formu_2">
                        <h2 class = "Article-title">Información nutrimental</h2>
                        <div class="Article-flex">
                            <%
                            if(peso != 0)
                            {
                                %>
                                    <div class = "div-nutrimental">
                                        <p class = "m1 medidas-p">Peso</p>
                                        <input type = "text" name = "peso" required class = "Section-m" value = "<%=peso%>" placeholder="(Kg)">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "m2 medidas-p">Estatura</p>
                                        <input type = "text" name = "estatura" required class = "Section-m" value = "<%=estatura%>" placeholder="cm">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "m3 medidas-p">Cintura</p>
                                        <input type = "text" name = "cintura" required class = "Section-m" value = "<%=cintura%>" placeholder="cm">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "medidas-p">Edad</p>
                                        <input type = "text" name = "edad" required class = "Section-m" value = "<%=edad%>" placeholder="años">
                                    </div>
                                <%
                            }
                            else
                            {
                                %>
                                    <div class = "div-nutrimental">
                                        <p class = "m1 medidas-p">Peso</p>
                                        <input type = "text" name = "peso" required class = "Section-m" value = "" placeholder="(Kg)">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "m2 medidas-p">Estatura</p>
                                        <input type = "text" name = "estatura" required class = "Section-m" value = "" placeholder="cm">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "m3 medidas-p">Cintura</p>
                                        <input type = "text" name = "cintura" required class = "Section-m" value = "" placeholder="cm">
                                    </div>
                                    <div class = "div-nutrimental">
                                        <p class = "medidas-p">Edad</p>
                                        <input type = "text" name = "edad" required class = "Section-m" value = "" placeholder="años">
                                    </div>
                                <%
                            }
                        %>                  
                        <div class = "div-nutrimental sexo">
                            <p class = "medidas-p">Sexo</p>
                            <select name = "sexo" class = "select-sexo">
                                <option value="" <%=v1%>>Seleccionar </option>
                                <option value="1" <%=v2%>>Masculino </option>
                                <option value="2" <%=v3%>>Femenino </option>
                            </select>
                        </div>
                        <div class = "div-ocupacion">
                            <p class = "medidas-p">Ocupación</p>
                            <select required name = "ocupacion" class="select-ocupacion" id="div-ocupacion">
                                <option value = "">Selecciona una opción</option>
                                <%
                                    ResultSet rs2 = conecta.getOcupacion();
                                    String actividadSeleccionada = "";
                                    while(rs2.next())
                                    {
                                        actividadSeleccionada = "";
                                        if(rs2.getInt("idCatOcupacion") == seleccionOcupacion)
                                        {
                                            actividadSeleccionada = "selected";
                                        }
                                        %><option value = "<%=rs2.getInt("idCatOcupacion")%>" <%=actividadSeleccionada%>><%=rs2.getString("ocupacion") + ": " + rs2.getString("descripcion")%></option><%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="div-nutrimental actividad">
                            <p class = "medidas-p">Actividad Física</p>
                            <select required name ="actividad" class = "select-actividad" id = "select-actividad" onchange = "desplegarDias();">
                                <option value="">Selcciona actividad</option>
                                <%
                                conecta.conectar();
                                ResultSet rs = conecta.getActividades();
                                
                                int idAct = 0;
                                String nombreAct = "";
                                actividadSeleccionada = "";
                                while(rs.next())
                                {
                                    idAct = rs.getInt("idActividad");
                                    
                                    nombreAct = rs.getString("actividad");
                                    if(idAct == seleccion)
                                    {
                                        actividadSeleccionada = "selected";
                                    }
                                %>
                                <option value="<%=idAct%>" <%=actividadSeleccionada%>><%=nombreAct%></option>
                                <%
                                    actividadSeleccionada = "";
                                }
                                %>
                            </select>
                            <script>desplegarDias();</script>
                        </div>
                        <div class = "div-actividadTiempo invisible" id = "div-actividadTiempo">
                                <div id = "contenedor-dias1">
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="1" id = "dom" <%=seleccionDias[0]%>><label for = "dom" id="dom-label">Domingo</label><input type="text" name="horas" value ="<%=horas[0]%>" placeholder="(min)" class = "Section-h invisible" id="dom-horas2"></div>
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="2" id = "lun" <%=seleccionDias[1]%>><label for = "lun" id="lun-label">Lunes</label><input type="text" name="horas" value ="<%=horas[1]%>" placeholder="(min)" class = "Section-h invisible" id="lun-horas2"></div>
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="3" id = "mar" <%=seleccionDias[2]%>><label for = "mar" id="mar-label">Martes</label><input type="text" name="horas" value ="<%=horas[2]%>" placeholder="(min)" class = "Section-h invisible" id="mar-horas2"></div>
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="4" id = "mie" <%=seleccionDias[3]%>><label for = "mie" id="mie-label">Miércoles</label><input type="text" name="horas" value ="<%=horas[3]%>" placeholder="(min)" class = "Section-h invisible" id = "mie-horas2"></div>
                                </div>
                                <div id = "contenedor-dias2">
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="5" id = "jue" <%=seleccionDias[4]%>><label for = "jue" id="jue-label">Jueves</label><input type="text" name="horas" value ="<%=horas[4]%>" placeholder="(min)" class = "Section-h invisible" id="jue-horas2"></div>
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="6" id = "vie" <%=seleccionDias[5]%>><label for = "vie" id="vie-label">Viernes</label><input type="text" name="horas" value ="<%=horas[5]%>" placeholder="(min)" class = "Section-h invisible" id="vie-horas2"></div>
                                    <div class = "div-Semana"><input type = "checkbox" class = "div-dia" name = "dias" value="7" id = "sab" <%=seleccionDias[6]%>><label for = "sab" id="sab-label">Sábado</label><input type="text" name="horas" value ="<%=horas[6]%>" placeholder="(min)" class = "Section-h invisible" id="sab-horas2"></div>
                                </div>    
                        </div>
                        </div>
                    </div>
                    <div class="prueba" id="formu_3">
                        <%
                            if(estado != null)
                            {
                                %>
                                <h2 class = "Article-title">Tu dirección</h2>
                                <p class = "personal-p">Estado</p>
                                <input type = "text" name = "estado" required class = "Section-usr" value = "<%=estado%>">
                                <p class = "personal-p">Municipio</p>
                                <input type = "text" name = "municipio" required class = "Section-usr" value = "<%=municipio%>">
                                <p class = "personal-p">Colonia</p>
                                <input type = "text" name = "colonia" required class = "Section-usr" value = "<%=colonia%>">
                                <%
                            }
                            else
                            {
                                %>
                                <h2 class = "Article-title">Tu dirección</h2>
                                <p class = "personal-p">Estado</p>
                                <input type = "text" name = "estado" required class = "Section-usr" value = "" placeholder="Estado en el que vives">
                                <p class = "personal-p">Municipio</p>
                                <input type = "text" name = "municipio" required class = "Section-usr" value = "" placeholder="Municipio en el que vives">
                                <p class = "personal-p">Colonia</p>
                                <input type = "text" name = "colonia" required class = "Section-usr" value = "" placeholder="Colonia en la que vives">
                                <%
                            }
                        %>
                    </div>      
                    <hr>
                    <input type = "submit" value = "Actualizar" name = "act_usr" class = "btn-act-usr">
                </form>
            </article>
        </section>
        <%
            if(sesion.getAttribute("mensaje") != null){
                String mensaje = (String)sesion.getAttribute("mensaje");
                System.out.println(mensaje);
                out.print("<script>alert('"+mensaje+"');</script>");
                sesion.removeAttribute("mensaje");
            }
        %>
        <script src="../../js/acciones_perfil.js"></script>
    </body>
</html>
