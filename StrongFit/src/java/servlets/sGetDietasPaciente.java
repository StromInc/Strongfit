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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
 * @author Alumno
 */
@WebServlet(name = "sGetDietasPaciente", urlPatterns = {"/sGetDietasPaciente"})
public class sGetDietasPaciente extends HttpServlet {

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
            HttpSession sesion = request.getSession();
            ArrayList<dietaAsociada>lista = new ArrayList<>();
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            String idOtro = request.getParameter("idOtro");
                   idOtro = seguro.encriptar(idOtro);
                   
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            ResultSet idP = conecta.spTraerIdPaciente(idOtro);
            int idPaciente = 0;
            if(idP.next()){
                idPaciente = idP.getInt("idPaciente");
            }
            
            ResultSet rs = conecta.spGetAsociaciones(idPaciente);
            String nombreN = "", nombreD = "";
            int idD = 0;
            while(rs.next()){
                nombreD = rs.getString("nombre");
                nombreN = seguro.desencriptar(rs.getString("creador"));
                idD = rs.getInt("idDieta");
                
                lista.add(new dietaAsociada(idD, nombreN, nombreD));
            }
            
            Map<String, Object> mapa = new HashMap<>();
            mapa.put("paciente", idPaciente);
            mapa.put("asociadas", lista);
            
            write(response, mapa);
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
        } catch (Exception ex) {
            Logger.getLogger(sGetDietasPaciente.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(sGetDietasPaciente.class.getName()).log(Level.SEVERE, null, ex);
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

    private class dietaAsociada{
        private int idDieta;
        private String nombreN;
        private String nombreD;
        
        public dietaAsociada(int idDieta, String nombreN, String nombreD){
            this.idDieta = idDieta;
            this.nombreN = nombreN;
            this.nombreD = nombreD;
        }
    }
    
    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(map));
    }
    
}
