<%-- 
    Document   : estadisticas
    Created on : 18/05/2015, 07:34:00 PM
    Author     : ian
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_chat.css" >
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_estadisticas.css" >
        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript" src="../../js/acciones_estadisticasP.js"></script>
    </head>
    <body>
        <%@include file="barra_menu.jsp"%>
        <%
            //1g Proteina ------ 4 kcal
            //1g Carbohidrato -- 4 kcal
            //1g Lipido -------- 9 kcal
        
            HttpSession sesion = request.getSession();
            String nombre = (String)sesion.getAttribute("nombre");
            String idUsr = (String)sesion.getAttribute("idUsr");
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            
            int con = 0;
            int caloriasD[] = new int[7];

            String diasSemana[] = {"Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"};
            
            ResultSet select = conecta.spGetCaloriasPaciente(idPaciente);
            while(select.next()){
                caloriasD[con] = select.getInt("calorias"); 
                con++;
            }
        %>
        <section class = "Section-tbl-usr">
            <article class="Article-tbl-usr2 issues2 sinP">
                <div class="Content-title">Calorías a consumir diariamente</div>
                    <%for(int i = 0; i < caloriasD.length; ++i)
                        {
                    %>
                    <div class = "micha" style="text-align: left;"><div class = "diaCalorias"><%=diasSemana[i]%></div></div><div class = "micha" style ="text-align: right;"><div class = "caloriasPaciente "><%=caloriasD[i]%> kcal</div></div>
                    <%
                        }
                    %>
            </article>
            <article class="Article-tbl-usr2 cajachat graficas sinP">
                <div id="btnLabels" class="Content-title">
                    <input type="radio" checked name="estadistics" id="caloriasEst"><label for="caloriasEst" id="labelCalEst">Calorías</label>
                    <input type="radio" name="estadistics" id="procarlip"><label for="procarlip" id="labelProCarLip">Pro/Car/Lip</label>
                </div>
                <div id="chart_div"></div>
            </article>
            <article class="Article-tbl-usr2 contactos sinP particularEst">
                <div class="Content-title">Ver estadísticas por:</div>
                <ul>
                    <li class="listaGraficas" id="labelG1" onclick="datosGrafica(id);"><span class="spanCambiarDia" onclick="cambiarDia(0);"><</span><span id="spanInfoDia">Hoy</span><span class="spanCambiarDia" onclick="cambiarDia(1);">></span></li>
                    <!--<li class="listaGraficas" id="labelG2" onclick="datosGrafica(id);"><span class="spanCambiarSemana"><</span><span id="spanInfoSem">Esta semana</span><span class="spanCambiarSemana">></span></li>-->
                    <li class="listaGraficas" id="labelG3" onclick="datosGrafica(id);"><span class="spanCambiarMensual" onclick="cambiarMensual(0);"><</span><span id="spanInfoMes">Este mes</span><span class="spanCambiarMensual" onclick="cambiarMensual(1);">></span></li>
                    <!--<li class="listaGraficas" id="labelG4" onclick="datosGrafica(id);"><span><</span>Alimentos<span>></span></li>-->
                </ul>
            </article>
        </section>
    </body>
</html>
