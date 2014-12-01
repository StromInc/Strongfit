/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cConexion;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
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
 * @author ian
 */
@WebServlet(name = "sDietasUsr", urlPatterns = {"/sDietasUsr"})
public class sDietasUsr extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession sesion = request.getSession(false);
            int idUser = (Integer)sesion.getAttribute("idUsr");
            int idDieta = Integer.parseInt(request.getParameter("idDieta"));
            String quit = request.getParameter("quitar");
            System.out.println(idDieta);
        
            Map<String, Object> map = new HashMap<>();
//            String dieta = Integer.toString(idDieta);
            map.put("idDieta", request.getParameter("nombreDieta"));
            
            write(response, map);
            registrarDieta(idUser, idDieta, quit);
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
            Logger.getLogger(sDietasUsr.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sDietasUsr.class.getName()).log(Level.SEVERE, null, ex);
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

    //Escribe un archivo json como respuesta a la peticion ajax
    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(map));
    }
    
    //Usa el procedure para crear o eliminar una relacion con las dietas que el usuario esta usando
    public void registrarDieta(int idUser, int idDietas, String quit) throws SQLException
    {
        cConexion conecta = new cConexion();
        conecta.conectar();
        conecta.actualizarDieta(idUser, idDietas, quit);
    }

}
