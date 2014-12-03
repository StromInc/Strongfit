package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.HashMap;
import java.util.*;
import java.sql.ResultSet;
import clases.cConexion;

public final class dietas_005fpaciente_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


    cConexion conecta = new cConexion();

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/jsp/meta.jsp");
    _jspx_dependants.add("/jsp/barra_menu.jsp");
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
      out.write("    ");

        /*esto es temporal debido a que las variables de sesion como usrid y usrname se deben obtener en el momento del login*/
        HttpSession sesion = request.getSession();
        sesion.setAttribute("idUsr", 1);
    
      out.write("\n");
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
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../Estilos/normalize.css\">\n");
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../Estilos/barra_menu.css\">\n");
      out.write("<link rel = \"stylesheet\" type =\"text/css\" href=\"../Estilos/estilo_footer.css\">\n");
      out.write("<link rel=\"shortcut icon\" href=\"../Imagenes/logo_s.jpg\">\n");
      out.write("<script src = \" http://code.jquery.com/jquery-2.1.0.min.js\"></script>\n");
      out.write("<title>Strongfit</title>");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"../Estilos/estilo_dietasusr.css\">\n");
      out.write("        <script src = \"../js/acciones_dietasPaciente.js\"></script>\n");
      out.write("        \n");
      out.write("        <style>\n");
      out.write("            .invisible\n");
      out.write("            {\n");
      out.write("                display: none;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            int usrid = 1; //Provisional
            //Esto es provisional, despues se construira el metodo para extraer las dietas de la base de datos
        
      out.write("        \n");
      out.write("        ");
      out.write('\n');
      out.write('\n');

    conecta.conectar();
    String dom = conecta.getDominio();

      out.write("\n");
      out.write("<!--Su hoja de estilos esta definida en la pagina meta.jsp, que debe de ser incluida en todas las paginas de este proyecto-->\n");
      out.write("<header class = \"Header\">\n");
      out.write("    <p class=\"Header-title\"><a href = \"../index.jsp\">Strongfit</a></p>\n");
      out.write("    <ul class=\"Header-lista\">\n");
      out.write("        <li class=\"Header-li\"><a href=\"inicio.jsp\" class=\"icon-house\"></a></li><!--Inicio-->\n");
      out.write("        <li class=\"Header-li\"><a href= \"dietas_paciente.jsp\" class=\"icon-food2\"></a></li><!--Dieta-->\n");
      out.write("        <li class=\"Header-li\"><a href = \"nutriologo.jsp\" class=\"icon-uniE60D\"></a></li><!--Mi Nutriólogo-->\n");
      out.write("        <li class=\"Header-li user-name\"><a href = \"usuario.jsp\">Nombre del usuario</a></li>\n");
      out.write("    </ul>\n");
      out.write("</header>");
      out.write("\n");
      out.write("        \n");
      out.write("        <section class = \"Section-dietas\">\n");
      out.write("            <article class = \"Article-dietas\"  id = \"Article-dietas\" ondrop=\"dropDiv(event)\" ondragover=\"allowDrop(event)\" >\n");
      out.write("                <h2>Dietas sugeridas</h2>\n");
      out.write("                <hr>\n");
      out.write("                ");

                    conecta.conectar();
                
      out.write("\n");
      out.write("                <form id = \"quitarForm\">\n");
      out.write("                    <input type = \"hidden\" id = \"inputQuitar2\" name = \"quitar\" value = \"\">\n");
      out.write("                </form>\n");
      out.write("                <div id = \"divDietasPaciente\" >\n");
      out.write("                    ");

                        //llenando el campo de las dietas sugeridas
                        ResultSet rs = conecta.getDietasSugeridas();
                        String nombreD;
                        int idD, contador = 0, contadorid = 0;
                        
                        while(rs.next())
                        {
                            ResultSet rs2 = conecta.getDietasRegistradas(usrid);
                            contador = 0;
                            while(rs2.next())
                            {
                                if(rs.getInt("idDieta") == rs2.getInt("idDieta"))
                                {
                                    contador++;
                                }
                            }
                            
                            if(contador == 0)
                            {
                                nombreD = rs.getString("nombre");
                                idD = rs.getInt("idDieta");
                    
      out.write("\n");
      out.write("                    <figure class = \"Figure-dietas\" draggable=\"true\" ondragstart=\"drag(event)\" id = \"");
      out.print("figure-usr" + contadorid);
      out.write("\">\n");
      out.write("                        <input type=\"hidden\" name = \"idDieta\" value = \"");
      out.print(idD);
      out.write("\" >\n");
      out.write("                        <figcaption>");
      out.print(nombreD);
      out.write("</figcaption>\n");
      out.write("                        <img src = \"../Imagenes/imagen-dietas.jpg\" class = \"img-dietas\" draggable=\"false\">\n");
      out.write("                    </figure>\n");
      out.write("                    ");

                                contadorid += 1;
                            }
                        }
                    
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </article>\n");
      out.write("            <article class = \"Article-usr\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\" id = \"Article-user\">\n");
      out.write("                <h2>Tus dietas</h2>\n");
      out.write("                <hr>\n");
      out.write("                <div id = \"spanIn\" style=\"opacity: .5; text-align: center; margin-top: 2em;\">\n");
      out.write("                    Arrastra aquí las dietas que te gustaría seguir, los datos se actualizaran automáticamente\n");
      out.write("                </div>\n");
      out.write("                <div id = \"divForm\">\n");
      out.write("                    ");

                        ResultSet rs3 = conecta.getDietasRegistradas(usrid);
                        while(rs3.next())
                        {                            
                            idD = rs3.getInt("idDieta");
                            nombreD = rs3.getString("nombre");
                    
      out.write("\n");
      out.write("                    <figure class = \"Figure-dietas\" draggable=\"true\" ondragstart=\"drag(event)\" id = \"");
      out.print("figure-usr" + contadorid);
      out.write("\">\n");
      out.write("                        <input type=\"hidden\" name = \"idDieta\" value = \"");
      out.print(idD);
      out.write("\" >\n");
      out.write("                        <figcaption>");
      out.print(nombreD);
      out.write("</figcaption>\n");
      out.write("                        <img src = \"../Imagenes/imagen-dietas.jpg\" class = \"img-dietas\" draggable=\"false\">\n");
      out.write("                    </figure>\n");
      out.write("                    ");

                        contadorid += 1;
                        }  
                    
      out.write("\n");
      out.write("                </div>\n");
      out.write("                <form id = \"formularioDietasPaciente\">\n");
      out.write("                    <input type = \"hidden\" id = \"inputQuitar\" name = \"quitar\" value = \"\">\n");
      out.write("                </form>\n");
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
