package org.apache.jsp.jsp.nutriologo;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import clases.cConexion;

public final class dietas_005fnutriologo_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


    cConexion conecta = new cConexion();

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/jsp/nutriologo/../meta.jsp");
    _jspx_dependants.add("/jsp/nutriologo/barra_menu.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        ");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write(" <!-- Metadatos para buscadores -->\n");
      out.write("<!-- Descripción de la página -->\n");
      out.write("<meta name=\"description\" content=\"Mejora tu salud y vive plenamente\" />\n");
      out.write("<!-- Autor de la página -->\n");
      out.write("<meta name=\"author\" content=\"StrongFit, Strom\" />\n");
      out.write("<!-- Indexación para los motores de búsqueda -->\n");
      out.write("<meta name=\"robots\" content=\"index, follow, noarchive\" />\n");
      out.write("<!-- Palabras clave de la página -->\n");
      out.write("<meta name=\"keywords\" content=\"Strong, fit, dieta, salud, HTML5, CSS3, JavaScript\" />\n");
      out.write("<!-- Para el responsive design de la página -->\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=2\">\n");
      out.write("<!--<link rel=\"stylesheet\" href=\"Estilos/estilo.css\">-->\n");
      out.write("<!--[if lt IE 9]>\n");
      out.write("    <script src=\"http://html5shim.googlecode.com/svn/trunk/html5.js\"></script>\n");
      out.write("<![endif]-->\n");
      out.write("<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>\n");
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../../Estilos/normalize.css\">\n");
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../../Estilos/barra_menu.css\">\n");
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../../Estilos/estilo_footer.css\">\n");
      out.write("<link rel=\"shortcut icon\" href=\"../../Imagenes/logo_s.jpg\">\n");
      out.write("<script src = \" http://code.jquery.com/jquery-2.1.0.min.js\"></script>\n");
      out.write("<title>Strongfit</title>");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"../../Estilos/estilo_dietasusr.css\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"../../Estilos/estilo_dietasnutriologo.css\">\n");
      out.write("        <script src=\"../../js/acciones_dietasnutriologo.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
      out.write('\n');
      out.write('\n');

    conecta.conectar();
    String dom = conecta.getDominio();

      out.write("\n");
      out.write("<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->\n");
      out.write("<header class = \"Header\">\n");
      out.write("    <p class=\"Header-title\"><a href = \"../../index.jsp\">Strongfit</a></p>\n");
      out.write("    <ul class=\"Header-lista\">\n");
      out.write("        <li class=\"Header-li\"><a href=\"inicio.jsp\" class=\"icon-house\"></a></li><!--Inicio-->\n");
      out.write("        <li class=\"Header-li\"><a href= \"dietas_nutriologo.jsp\" class=\"icon-food2\"></a></li><!--Dieta-->\n");
      out.write("        <li class=\"Header-li\"><a href = \"pacientes.jsp\" class=\"icon-user\"></a></li><!--Mi Nutriólogo-->\n");
      out.write("        <li class=\"Header-li user-name\"><a href = \"usuario.jsp\">Nombre del usuario</a></li>\n");
      out.write("    </ul>\n");
      out.write("</header>");
      out.write("\n");
      out.write("        <section class=\"Section-todo\">\n");
      out.write("            \n");
      out.write("            <!--Esta es la parte en donde se vera las dietas que el nutriologo crea-->\n");
      out.write("            <article class=\"Article-dietas\" id = \"tusDietas\">\n");
      out.write("                <h2 id = \"textoTitulo\">Tus dietas</h2>\n");
      out.write("                <hr>\n");
      out.write("                <input type=\"button\" name=\"nueva\" value=\"Nueva\" class=\"btn-act-usr\" onclick = \"ocultar()\">\n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <!--Esta es la parte en donde aparece un buscador y tu puedes arrastrar los alimentos-->\n");
      out.write("            <article class=\"Article-dietas invisible tamano\" id = \"buscarAlimentos\">\n");
      out.write("                <p class=\"contenedor-search\">\n");
      out.write("                    <span class = \"span-search\"><label class = \"icon-search label-search\" for = \"buscar\"></label></span>\n");
      out.write("                    <span class = \"search\"><input type=\"search\" placeholder = \"buscar alimentos ...\" class = \"input-search\" id = \"buscar\"></span>\n");
      out.write("                </p>\n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <!--Esta es la parte en la que se ensambla la dieta-->\n");
      out.write("            <article class=\"Article-dietas Article-dietas2 invisible tamano\" id=\"crearDietas\">\n");
      out.write("                \n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <!--Esta es la parte en donde se ve el balanceo de los nutrientes-->\n");
      out.write("            <article class=\"Article-dietas Article-dietas3 invisible tamano\" id = \"balanceoDietas\">\n");
      out.write("                \n");
      out.write("            </article>\n");
      out.write("            \n");
      out.write("            <div class = \"arrow-left invisible\"></div>\n");
      out.write("        </section>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
