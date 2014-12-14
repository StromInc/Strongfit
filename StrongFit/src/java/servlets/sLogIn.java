/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.io.PrintWriter;
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
@WebServlet(name = "sLogIn", urlPatterns = {"/sLogIn"})
public class sLogIn extends HttpServlet {

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
            clases.cConexion objconexion = new clases.cConexion();
            objconexion.conectar();
            HttpSession sesion = request.getSession();
            String idUser = request.getParameter("txt-mail");
            String pass = request.getParameter("txt-pass");
            // identificar al usuario
            try{
            String verificacion = objconexion.busquedadeusuarios(idUser, pass);
            // Logica para permitir o no el acceso
            if (verificacion.equals("si")){ 
                sesion.setAttribute("idUsr",idUser);
                response.sendRedirect("jsp/paciente/inicio.jsp");
                out.print("<script>alert('Bienveido');</script>");
                }
            if (verificacion.equals("no")){ 
                response.sendRedirect("index.jsp");
                 out.print("<script>alert('Usuario inexistente');</script>");
                }
            if (verificacion.equals("nop")){ 
                response.sendRedirect("index.jsp");
                 out.print("<script>alert('Contraseña incorrecta');</script>");
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
