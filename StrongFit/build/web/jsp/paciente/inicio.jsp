<%@page import="clases.cCifrado"%>
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
        <script src="../../js/progressbar.min.js"></script>
        <script src="../../js/buscar-alimento.js"></script>
        <script src="../../js/salir.js"></script>
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
                            <p>Meta <%=caloriasdia%> cal</p>
                            <%
                                ResultSet rs2 = conecta.spConsultarAlimentosDiarios(idPaciente, diaA);         
                                int calorias = 0, con = 0;
                                int kcalorias = 0;
                                while(rs2.next()){
                                    calorias = rs2.getInt("calorias");
                                    kcalorias += calorias;
                                    con++;
                                }
                            %>
                        <p>Consumido <%=kcalorias%> cal</p>
                        </div>
                        <div id="container"></div> 
                    </div>      
                </div>
                <div>
                    <h3>Otro div que no recuerdo que va a tener</h3>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
                </div>
                <div class="Registrados">
                    <p>Alimentos Registrados</p>
                    <div class="Registrados-list">
                        <ul class="Consumidos">
                            <%
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
                            <li class="Consumidos-item">
                                <p class="Consumidos-name">Taco</p>
                                <span>5 cal</span>
                                <button class="Consumidos-borrar">X</button>
                            </li>
                            <li class="Consumidos-item">
                                <p class="Consumidos-name">Taco</p>
                                <span>5 cal</span>
                                <button class="Consumidos-borrar">X</button>
                            </li>
                            <li class="Consumidos-item">
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
            <div class="Buscador-title">
                Alimentos
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
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+</button>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+</button>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+</button>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+</button>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                            <button class="Alimentos-agregar">+</button>
                        </li>
                    </ul>
                </div>      
            </div>
        </aside>
    </section>
    <div class="FloatButton">
        <a href="#">+</a>
    </div>
    <script>
        var meta = <%=caloriasdia%>;
        var consumidas = <%=kcalorias%>;
    </script> 
    </body>
</html>
