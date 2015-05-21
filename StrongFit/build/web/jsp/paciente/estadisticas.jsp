<%-- 
    Document   : estadisticas
    Created on : 18/05/2015, 07:34:00 PM
    Author     : ian
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_usuario.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_chat.css" >
        
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
            <article class="Article-tbl-usr2 issues">
                <h2 style="font-size: 1.3em;">Calorias a consumir diariamente</h2>
                    <%for(int i = 0; i < caloriasD.length; ++i)
                        {
                    %>
                    <div class = "micha" style="text-align: left;"><div class = "diaCalorias"><%=diasSemana[i]%></div></div><div class = "micha" style ="text-align: right;"><div class = "caloriasPaciente "><%=caloriasD[i]%> kcal</div></div>
                    <%
                        }
                    %>
            </article>
            <article class="Article-tbl-usr2 cajachat">
                <div id="chart_div" style="width: 550px; height: 400px;"></div>
            </article>
            <article class="Article-tbl-usr2 contactos">
                <ul>
                    <li class="listaGraficas"><label>Hoy</label></li>
                    <li class="listaGraficas"><label>Semanal</label></li>
                    <li class="listaGraficas"><label>Mensual</label></li>
                    <li class="listaGraficas"><label>P/C/L</label></li>
                    <li class="listaGraficas"><label>Alimentos</label></li>
                </ul>
            </article>
        </section>
    </body>
</html>
