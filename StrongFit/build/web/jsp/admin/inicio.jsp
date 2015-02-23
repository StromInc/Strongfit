<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio2.css">
        <script src = "../../js/acciones_admin.js"></script>
        <script src="../../js/salir.js"></script>
        <style>
            .btnAdmin{
                
                display: inline-block;
                text-align: right;
                padding: .1em .3em;
                
            }
            
            div{
                display: inline-block;
            }
            
            .botones-admin{
                
                display: inline-block;
                position: absolute;
                right: 0;
                top: 0;
                margin: 2.5em .6em 0 0;
                
            }
            
            .alineame{
                
                position: relative;
                
            }
            
            .div-acepta{
                color: #206A1D;
                cursor: pointer;
                size: 1.2em;
                margin-right: 1em;
            }
            .div-acepta:hover{
                color: #094607;
            }
            
            .div-rechaza{
                color: #ff2115;
                cursor: pointer;
                size: 1.2em;
            }
            .div-rechaza:hover{
                color: #c80000;
            }
        </style>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        
        <section class="Section-todo">
            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->
            <article class = "Article-title Article-articulo">
                <div class = "Article-platillos">
                    <div class = "meta estadisticas">
                        Solicitudes enviadas
                    </div>
                    <div class = "faltante estadisticas"> 
                    </div>
                </div>
            </article>
            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->
            
                <%
                    cConexion conecta = new cConexion();
                    conecta.conectar();
                    ResultSet rs = conecta.spGetSolicitudes();
                    int con = 0;
                    String nombre = "", correo = "", cedula = "", escuela = "", carrera = "";
                    while(rs.next())
                    {
                        nombre = rs.getString("nombre") + " " + rs.getString("apellidos");
                        correo = rs.getString("idUsuario");
                        cedula = rs.getString("cedulaProf");
                        escuela = rs.getString("escuela");
                        carrera = rs.getString("carrera");
                        %>
                        <article id="article<%=con%>" class = "Article-articulos Article-articulo alineame">
                            <form method="post" id = "formulario<%=con%>">
                                <input type="hidden" name="idMedico" value="<%=correo%>">
                                <div><strong>Nombre:</strong> <%=nombre%></div><br>
                                <div><strong>Correo:</strong> <%=correo%></div><br>
                                <div><strong>Cédula profecional:</strong> <%=cedula%></div><br>
                                <div><strong>Escuela: </strong> <%=escuela%></div><br>
                                <div><strong>Carrera: </strong> <%=carrera%></div><br>
                                <div class = "botones-admin">
                                    <div class="div-acepta" id="aceptarMedico<%=con%>" onclick="aceptaNutriologo(<%=con%>);"><p  class="icon-checkmark-circle btnAdmin"> Aceptar</p></div>
                                    <div class="div-rechaza" id="rechazarMedico<%=con%>" onclick="rechazaNutriologo(<%=con%>);"><p  class="icon-cancel-circle btnAdmin"></p> Rechazar</div>
                                </div>
                            </form>
                        </article>
                        <%
                        con++;
                    }
                %>
            
        </section>         
    </body>
</html>
