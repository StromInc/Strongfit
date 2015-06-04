<%@page import="clases.cCifrado"%>
<%@page import="clases.cConexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="../nutriologo/error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <script src="../../js/progressbar.min.js"></script>
        <script src="../../js/buscar-alimento.js"></script>
        <script src="../../js/salir.js"></script>
    </head>
 <body onload="setValores();">
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
        <script>setPosicion('inicio');</script>
        <form id = "formularioOculto">
            <input type="hidden" name="idCon" value="<%=idCon%>">
        </form>
        <section class="Section small x-large">
        <article class="Content small x-large">
            <div class="Content-title">
                Consumo Clalorico
            </div>
            <div class="Content-informacion">      
                <div class="Estadisticas">
                    <div class="Estadisticas-header">
                        <span class="Estadisticas-atras"><</span>
                        <h3 class="Estadisticas-titulo">Hoy</h3> 
                        <span class="Estadisticas-adelante">></span>
                    </div>
                    <div class="Estadisticas-section">
                        <div class="Estadisticas-wrapper">
                            <p>Meta <span id="metaCalorias"><%=caloriasdia%></span> cal</p>
                            <%
                                //Esta parte solo se cambio de lugar para que se adapte a la nueva vista
                                ResultSet rs2 = conecta.spConsultarAlimentosDiarios(idPaciente, diaA);         
                                int calorias = 0, con = 0;
                                int kcalorias = 0;
                                while(rs2.next()){
                                    calorias = rs2.getInt("calorias");
                                    kcalorias += calorias;
                                    con++;
                                }
                            %>
                        <p id="consumido">Consumido <%=kcalorias%> cal</p>
                        </div>
                        <div id="container"></div> <!--El div de la grafica--> 
                    </div>      
                </div>
                <div class="Registrados">
                    <p>Alimentos Registrados</p>
                    <div class="Registrados-list">
                        <ul class="Consumidos">
                            <%
                                //Esta parte solo se cambio de lugar para que se adapte a la nueva vista
                                String nombre = "";
                                while(rs2.next()){
                                    nombre = rs2.getString("nombre");
                                    calorias = rs2.getInt("calorias");
                            %>
                            <li class="Consumidos-item">
                                <p class="Consumidos-name"><%=nombre%></p>
                                <span><%=calorias%> cal</span>
                                <button class="Consumidos-borrar">X</button>
                            </li>
                            <%
                                }
                            %>
                            <li class="Consumidos-item ocultar">
                                <p class="Consumidos-name">Taco</p>
                                <span>5 cal</span>
                                <button class="Consumidos-borrar">X</button>
                            </li>
                        </ul>
                    </div> 
                </div>     
            </div>                 
        </article>
        <aside class="Buscador x-large">
            <div class="Buscador-header">
                <h3 class="Buscador-title">Agrear alimentos a: Desayuno</h3>    
                <div class="Buscador-cambiar" id="buscadorCambiar">+</div>
                <ul class="Buscador-nav" id="buscadorNav">
                    <li class="Comida Seleccionado">Desayuno</li>
                    <li class="Comida">Colacion 1</li>
                    <li class="Comida">Comida</li>
                    <li class="Comida">Colacion 2</li>       
                    <li class="Comida">Cena</li>
                </ul>
            </div>
            <div class="Buscador-form">
                <input type="search" name="nombre-alimento" class="Buscador-search" id="input-alimento" placeholder="buscar" required> 
                <button class="Buscador-btn" id="buscadorBoton">
                    <span class="icon-search"></span>
                </button>
            </div>
            <div class="Buscador-contenedor">
                <h3 class="Buscador-aviso">Alimentos por defecto</h3>
                <div class="Buscador-list">
                    <ul class="Alimentos">
                        <li class="Alimentos-item ocultar">
                            <p class="Alimentos-name">Taco</p>
                            
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+<input type="hidden"></button>
                        </li>
                    </ul>
                </div>      
            </div>
        </aside>
    </section>
    <div class="FloatButton">
        <a href="#">+</a>
    </div>
    </body>
</html>
