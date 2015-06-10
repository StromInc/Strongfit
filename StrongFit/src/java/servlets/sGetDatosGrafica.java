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
import java.sql.ResultSet;
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
@WebServlet(name = "sGetDatosGrafica", urlPatterns = {"/sGetDatosGrafica"})
public class sGetDatosGrafica extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            
            Calendar calendario = new GregorianCalendar();
            
            int cal = 0;
            int por = 0;
            int dia = 0;
            int mes = 0;
            int anio = 0;
            int diaSem = 0;
            try{
                cal = Integer.parseInt(request.getParameter("cal")); //esto representa si se quiere ver por calorias o por proteinas/lipidos/carbohidratos, si es = 1 entonces es por calorias
                por = Integer.parseInt(request.getParameter("por")); //esto dice si es por dia por mes o por año
                dia = Integer.parseInt(request.getParameter("dia"));
                mes = Integer.parseInt(request.getParameter("mes"));
                anio = Integer.parseInt(request.getParameter("anio"));
                diaSem = Integer.parseInt(request.getParameter("diaSem"));
            }
            catch(Exception e){
                Map<String, Object> mapa = new HashMap<>();
                mapa.put("estado", "no");
                write(response, mapa);
            }
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            ResultSet rs = conecta.getAlimentosPorFecha(idPaciente, dia, mes, anio);
            ResultSet calorias = conecta.spGetCaloriasPacienteEspecifico(idPaciente, diaSem);
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
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
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

    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(map));
    }
}
