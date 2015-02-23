<%@page import="clases.cConexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
        <script src="../../js/buscar-alimento.js"></script>
        <script src="../../js/acciones_cambiarMetas.js"></script>
    </head>
 <body onload="cambiarMetas();">
        <%
            HttpSession sesion = request.getSession();
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            int idCon = (Integer)sesion.getAttribute("idcont");
            
            Calendar c2 = new GregorianCalendar();
            
            int dia = c2.get(Calendar.DAY_OF_WEEK);
            int diaA = c2.get(Calendar.DAY_OF_YEAR);
            int caloriasdia = 0;
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            ResultSet rs = conecta.spGetCaloriasPacienteEspecifico(idPaciente, dia);
            if(rs.next())
            {
                caloriasdia = rs.getInt("calorias");
            }
        %>
        <%@include file = "barra_menu.jsp" %>
        <form id = "formularioOculto">
            <input type="hidden" name="idCon" value="<%=idCon%>">
        </form>
        <section class="Section-todo">
            <!--Esta es la seccion de la barra de busqueda, el sabias que y el conteo calorico-->
            <article class = "Article-menu">
                <p class="contenedor-search">
                    <input type="search" id="search" name="search" class="search" placeholder="Buscar alimentos...">
                    <label class = "icon-search label-search" for = "buscar"></label>
                </p>
                <div class = "content-title">
                        Consumo de hoy
                </div>
                <div class = "div">
                    <div class="content-contador" id = "style-4">
                    <%
                        ResultSet rs2 = conecta.spConsultarAlimentosDiarios(idPaciente, diaA);
                        String nombre = "";
                        int calorias = 0, con = 0;
                        while(rs2.next()){
                            
                            nombre = rs2.getString("nombre");
                            calorias = rs2.getInt("calorias");
                            %>

                                    <p class = "racion"><%=nombre%><span class = "calorias"><br>Calorias: <%=calorias%>kc</span></p>
                            
                            <%
                            con++;
                            
                        }
                    %>
                        <p class = "racion hidden"><span class = "calorias"><br></span></p>
                    </div>
                    
                    <div class = "content-total">
                        Kilocalorías consumidas: <span id="noCaloria">0</span>kc
                    </div>
                </div>
            </article>

            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->
            <div style = "width: 62%; ">
                <article class = "Article-sugerir margen-estadisticas">
                    <div class = "Article-platillos">
                        <div class = "meta estadisticas">
                            Meta
                            <hr>
                            <p id="metaCalorias"><%=caloriasdia%></p>
                        </div>
                        <div class = "consumido estadisticas">
                            Consumido
                            <hr>
                            <p id="consumido"></p>
                        </div>
                        <div class = "faltante estadisticas">
                            Falta
                            <hr>
                            <p id="falta"></p>
                        </div>
                    </div>
                </article>
                <article class = "Article-sugerir">
                    <div class="Article-sabias">
                        Esta parte es la de los sabias que?, y sera dinamica, las frases estaran guardadas en la base de datos
                    </div>
                    <div class = "Article-platillos">
                        <p>Platillos sugeridos para (D,Co,Ce)</p>
                        <hr>
                        <div class = "barra">
                            <div class = "comida-sugerida"><!--Maximo tres comidas sugeridas-->
                                <span class = "platillo">Huevos con tocino</span>
                                <span class = "platillo">Huevos con jamon</span>
                                <span class = "platillo">Cereal con leche</span>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->
            <article class = "Article-articulos">
                Aqui van los articulos que los medicos escriben para hacerse mas populares y asi tener mas clientes
            </article>
        </section>
        
    </body>
</html>
