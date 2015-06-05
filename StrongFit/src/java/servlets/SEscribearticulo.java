/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 *
 * @author jorge pastrana
 */
@WebServlet(name = "SEscribearticulo", urlPatterns = {"/SEscribearticulo"})
public class SEscribearticulo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            clases.cConexion objconexion= new clases.cConexion();
            clases.cCifrado objcifrado = new clases.cCifrado();
            clases.CImagen objimagen = new clases.CImagen();
            objconexion.conectar();
            HttpSession sesion = request.getSession();
            String idUsr = (String)sesion.getAttribute("idUsr");          
            String idArt = request.getParameter("idArt");
            String idArti = (String)sesion.getAttribute("edicion");
            if(request.getParameter("operacion").equals("escribe")){    
            String validacion = objconexion.altaarticulo(idUsr, objcifrado.sustituye(request.getParameter("nombre"),1), request.getParameter("texto"), idArti, idUsr);
            if(validacion.equals("Exitoso")){
            objimagen.cambianombreimagen(idUsr, objcifrado.sustituye(request.getParameter("nombre"),1), 2);
            }
            }
            if(request.getParameter("operacion").equals("llamadatos")){
            clases.cArticulos objarticulo = new clases.cArticulos();
            String texto = null;
            if(!"nuevoarticuloenblanco".equals(idArt)){             
            texto = objarticulo.buscadatos(idArt,1);
            sesion.setAttribute("edicion",idArt);        
            }else{
            texto = objarticulo.buscadatos(idArt,2);
            sesion.setAttribute("edicion",idArt);
            }
            out.print(texto);
            }else{
            clases.cArticulos objarticulo = new clases.cArticulos();
            String texto = objarticulo.buscamisarticulos(idUsr);
            out.print(texto);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SEscribearticulo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(SEscribearticulo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SEscribearticulo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(SEscribearticulo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
