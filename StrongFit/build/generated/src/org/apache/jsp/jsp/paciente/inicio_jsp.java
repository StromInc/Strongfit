package org.apache.jsp.jsp.paciente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import clases.cConexion;
import java.sql.ResultSet;
import java.util.GregorianCalendar;
import java.util.Calendar;
import clases.cConexion;

public final class inicio_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


    cConexion conecta = new cConexion();

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/jsp/paciente/../meta.jsp");
    _jspx_dependants.add("/jsp/paciente/barra_menu.jsp");
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
      out.write("<!-- Para el responsive design de la página -->\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, minimum-scale=1, maximum-scale=1\" />\n");
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
      out.write("        <link rel=\"stylesheet\" type = \"text/css\" href=\"../../Estilos/estilo_inicio.css\">\n");
      out.write("        <script src=\"//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js\"></script>\n");
      out.write("        <link rel=\"stylesheet\" href=\"//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css\" />\n");
      out.write("        <script src=\"../../js/buscar-alimento.js\"></script>\n");
      out.write("        <script src=\"../../js/acciones_cambiarMetas.js\"></script>\n");
      out.write("        <script src=\"../../js/salir.js\"></script>\n");
      out.write("    </head>\n");
      out.write(" <body onload=\"cambiarMetas();\">\n");
      out.write("        ");

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
        
      out.write("\n");
      out.write("        ");
      out.write('\n');
      out.write('\n');
      out.write('\n');

    HttpSession sesion2 = request.getSession();
    conecta.conectar();
    String dom = conecta.getDominio();
    String idUsuarioBarra = (String)sesion2.getAttribute("idUsr"); 

      out.write("\n");
      out.write("<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->\n");
      out.write("<script src = \"../../js/acciones_dietasusr.js\"></script>\n");
      out.write("<header class = \"Header\">\n");
      out.write("    <script>\n");
      out.write("        cargarDia();\n");
      out.write("        cargarDiaCiclico();\n");
      out.write("    </script>\n");
      out.write("    <p class=\"Header-title\"><a href = \"../../index.jsp\">Strongfit</a></p>\n");
      out.write("    <ul class=\"Header-lista\">\n");
      out.write("        <li class=\"Header-li\"><a href=\"inicio.jsp\" class=\"icon-house\"></a></li><!--Inicio-->\n");
      out.write("        <li class=\"Header-li\"><a href= \"dietas_paciente.jsp\" class=\"icon-food2\"></a></li><!--Dieta-->\n");
      out.write("        <li class=\"Header-li\"><a href = \"nutriologo.jsp\" class=\"icon-uniE60D\"></a></li><!--Mi Nutriólogo-->\n");
      out.write("        <li class=\"Header-li user-name\"><a href = \"usuario.jsp\">");
      out.print(idUsuarioBarra);
      out.write("</a></li><!--Usuario-->\n");
      out.write("        <li class=\"Header-li\"><a href = \"../../index.jsp\" class = \"icon-sign-out\" onclick=\"cerrarsesion()\"></a></li><!--log out-->\n");
      out.write("    </ul>\n");
      out.write("</header>");
      out.write("\n");
      out.write("        <form id = \"formularioOculto\">\n");
      out.write("            <input type=\"hidden\" name=\"idCon\" value=\"");
      out.print(idCon);
      out.write("\">\n");
      out.write("        </form>\n");
      out.write("        <section class=\"Section-todo\">\n");
      out.write("            <!--Esta es la seccion de la barra de busqueda, el sabias que y el conteo calorico-->\n");
      out.write("            <article class = \"Article-menu\">\n");
      out.write("                <p class=\"contenedor-search\">\n");
      out.write("                    <input type=\"search\" id=\"search\" name=\"search\" class=\"search\" placeholder=\"Buscar alimentos...\">\n");
      out.write("                    <label class = \"icon-search label-search\" for = \"buscar\"></label>\n");
      out.write("                </p>\n");
      out.write("                <div class = \"content-title\">\n");
      out.write("                        Consumo de hoy\n");
      out.write("                </div>\n");
      out.write("                <div class = \"div\">\n");
      out.write("                    <div class=\"content-contador\" id = \"style-4\">\n");
      out.write("                    ");

                        ResultSet rs2 = conecta.spConsultarAlimentosDiarios(idPaciente, diaA);
                        String nombre = "";
                        int calorias = 0, con = 0;
                        while(rs2.next()){
                            
                            nombre = rs2.getString("nombre");
                            calorias = rs2.getInt("calorias");
                            
      out.write("\n");
      out.write("\n");
      out.write("                                    <p class = \"racion\">");
      out.print(nombre);
      out.write("<span class = \"calorias\"><br>Calorias: ");
      out.print(calorias);
      out.write("kc</span></p>\n");
      out.write("                            \n");
      out.write("                            ");

                            con++;
                            
                        }
                    
      out.write("\n");
      out.write("                        <p class = \"racion hidden\"><span class = \"calorias\"><br></span></p>\n");
      out.write("                    </div>\n");
      out.write("                    \n");
      out.write("                    <div class = \"content-total\">\n");
      out.write("                        Kilocalorías consumidas: <span id=\"noCaloria\">0</span>kc\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </article>\n");
      out.write("\n");
      out.write("            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->\n");
      out.write("            <div style = \"width: 62%; \">\n");
      out.write("                <article class = \"Article-sugerir margen-estadisticas\">\n");
      out.write("                    <div class = \"Article-platillos\">\n");
      out.write("                        <div class = \"meta estadisticas\">\n");
      out.write("                            Meta\n");
      out.write("                            <hr>\n");
      out.write("                            <p id=\"metaCalorias\">");
      out.print(caloriasdia);
      out.write("</p>\n");
      out.write("                        </div>\n");
      out.write("                        <div class = \"consumido estadisticas\">\n");
      out.write("                            Consumido\n");
      out.write("                            <hr>\n");
      out.write("                            <p id=\"consumido\"></p>\n");
      out.write("                        </div>\n");
      out.write("                        <div class = \"faltante estadisticas\">\n");
      out.write("                            Falta\n");
      out.write("                            <hr>\n");
      out.write("                            <p id=\"falta\"></p>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </article>\n");
      out.write("                <article class = \"Article-sugerir\">\n");
      out.write("                    <div class=\"Article-sabias\">\n");
      out.write("                        Esta parte es la de los sabias que?, y sera dinamica, las frases estaran guardadas en la base de datos\n");
      out.write("                    </div>\n");
      out.write("                    <div class = \"Article-platillos\">\n");
      out.write("                        <p>Platillos sugeridos para (D,Co,Ce)</p>\n");
      out.write("                        <hr>\n");
      out.write("                        <div class = \"barra\">\n");
      out.write("                            <div class = \"comida-sugerida\"><!--Maximo tres comidas sugeridas-->\n");
      out.write("                                <span class = \"platillo\">Huevos con tocino</span>\n");
      out.write("                                <span class = \"platillo\">Huevos con jamon</span>\n");
      out.write("                                <span class = \"platillo\">Cereal con leche</span>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </article>\n");
      out.write("            </div>\n");
      out.write("            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->\n");
      out.write("            <article class = \"Article-articulos\">\n");
      out.write("                Aqui van los articulos que los medicos escriben para hacerse mas populares y asi tener mas clientes\n");
      out.write("            </article>\n");
      out.write("        </section>\n");
      out.write("        \n");
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
