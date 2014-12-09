/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "sAltaDeUsuario", urlPatterns = {"/sAltaDeUsuario"})
public class sAltaDeUsuario extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
             HttpSession sesion = request.getSession();
             //Recuperando Valores
             String idUser = request.getParameter("txt-mail");
             String pass = request.getParameter("txt-pass");
             String nombre = request.getParameter("txt-name");
             // conectar a la base de datos                                     
             try{
             clases.cConexion objconexion = new clases.cConexion();
             objconexion.conectar();
            // verificar usuario
            String verificacion = objconexion.altausuario(idUser, pass, nombre);           
             if (verificacion.equals("valido")){                
                 sesion.setAttribute("idUsr",idUser);
                 sesion.setAttribute("passUsr",pass);
                 sesion.setAttribute("nomUsr",nombre);
                 response.sendRedirect("jsp/paciente/usuario.jsp");
                 out.print("<script>alert('Alta realizada');</script>");
             }
             else{
             out.println("<script>alert('Actuelmente ya existe una cuenta registrada con ese correo');</script>");    
             response.sendRedirect("index.jsp");
             }
             }
             catch(SQLException ex){
             out.print(ex.toString());
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
        processRequest(request, response);
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
        processRequest(request, response);
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
