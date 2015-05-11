<%@page import="clases.cConexion" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<%!
    cConexion conecta = new cConexion();
%>
<%
    HttpSession sesion2 = request.getSession();
    conecta.conectar();
    String dom = conecta.getDominio();
    String idUsuarioBarra = (String)sesion2.getAttribute("idUsr");
%>
<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->
<header class = "Header">
    <p class="Header-title"><a href = "../../index.jsp">Strongfit</a></p>
    <ul class="Header-lista">
        <li class="Header-li user-name"><a href = "inicio.jsp">Administrador</a></li>
        <li class="Header-li"><a href = "../../index.jsp" class = "icon-sign-out" onclick="cerrarsesion()"></a></li><!--log out-->
    </ul>
</header>