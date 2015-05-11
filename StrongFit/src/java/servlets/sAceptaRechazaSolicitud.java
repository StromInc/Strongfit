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
@WebServlet(name = "sAceptaRechazaSolicitud", urlPatterns = {"/sAceptaRechazaSolicitud"})
public class sAceptaRechazaSolicitud extends HttpServlet {

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
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            String idUsr = (String)sesion.getAttribute("idUsr");
                   idUsr = seguro.encriptar(idUsr);
            String idOtro = request.getParameter("idOtro");
                   idOtro = seguro.encriptar(idOtro);
            int respuesta = Integer.parseInt(request.getParameter("respuesta"));
            int idAmigo = 0;
            
            ResultSet rs = conecta.spSeleccionarAmistad(idUsr, idOtro);
            if(rs.next()){
                idAmigo = rs.getInt("idRelAmigosChat");
            }
            ResultSet rs2 = conecta.spAceptaSolicitud(idUsr, idOtro, respuesta, idAmigo);
            
            Map<String, Object> mapa = new HashMap();
            if(rs2.next()){
                mapa.put("res", rs2.getString("respuesta")); 
            }
            
            write(response, mapa);
        }
    }
    
    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(map));
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
            Logger.getLogger(sAceptaRechazaSolicitud.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sAceptaRechazaSolicitud.class.getName()).log(Level.SEVERE, null, ex);
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
