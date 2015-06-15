/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cCifrado;
import clases.cConexion;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession sesion = request.getSession(false);
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            String idUser = seguro.encriptar((String)sesion.getAttribute("idUsr"));
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            int idDieta = Integer.parseInt(request.getParameter("idDieta"));
            int accion = 1;
            
            String quit = request.getParameter("quitar");
            
            if(!quit.equals("no")){accion = 0;}
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            Calendar calendario = new GregorianCalendar();
            int diaSem = calendario.get(Calendar.DAY_OF_WEEK);
            int diaAnio = calendario.get(Calendar.DAY_OF_YEAR);
            
            conecta.actualizarDieta(idUser, idDieta, quit);
            conecta.spSetResgitroDietas(idDieta, diaSem, diaAnio, idPaciente, accion);
            
            try{
                int primero = Integer.parseInt(request.getParameter("primero"));
                conecta.spSetPosicion(idDieta, idPaciente, 1);
            }
            catch(Exception e){
                
            }
        
            Map<String, Object> map = new HashMap<>();
//            String dieta = Integer.toString(idDieta);
            map.put("idDieta", request.getParameter("idDieta"));
            
            write(response, map);
            conecta.cerrar();
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
        } catch (Exception ex) {
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
        } catch (Exception ex) {
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

}
