<%@page import="clases.cConexion"%>
<%!
    cConexion conecta = new cConexion();
%>
<%
    conecta.conectar();
    String dom = conecta.getDominio();
%>
<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->
<header class = "Header">
    <p class="Header-title"><a href = "../../index.jsp">Strongfit</a></p>
    <ul class="Header-lista">
        <li class="Header-li"><a href="inicio.jsp" class="icon-house"></a></li><!--Inicio-->
        <li class="Header-li"><a href= "dietas_paciente.jsp" class="icon-food2"></a></li><!--Dieta-->
        <li class="Header-li"><a href = "nutriologo.jsp" class="icon-uniE60D"></a></li><!--Mi Nutriólogo-->
        <li class="Header-li user-name"><a href = "usuario.jsp">Nombre del usuario</a></li>
    </ul>
</header>