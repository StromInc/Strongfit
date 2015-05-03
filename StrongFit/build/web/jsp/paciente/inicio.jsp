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
        <script src="../../js/buscar-alimento.js"></script>
        <script src="../../js/acciones_cambiarMetas.js"></script>
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
                Informacion nutrimental
            </div>
            <div>
                <h2>Aqui vamos a poner informacion</h2>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
            </div>
            <div>
                <h2>Aqui vamos a poner informacion</h2>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
            </div>
            <div>
                <h2>Aqui vamos a poner informacion</h2>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
            </div>
            <div>
                <h2>Div de contenido</h2>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
            </div>
            <div>
                <h2>Otro div</h2>
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima magni consequuntur expedita ex quasi. Incidunt dolore iste, non quia quod animi aliquam sed alias, facere dignissimos ratione labore magni beatae!
            </div>
        </article>
        <aside class="Buscador x-large">
            <div class="Buscador-title">
                Alimentos
            </div>
            <div class="Buscador-form">
                <input type="search" class="Buscador-search" placeholder="buscar">
                <button class="Buscador-btn">
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
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
                        </li>
                        <li class="Alimentos-item">
                            <p class="Alimentos-name">Taco</p>
                            <span>5 cal</span>
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
