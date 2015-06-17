/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cAlimento;
import clases.cConexion;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "sGetConsumidosFecha", urlPatterns = {"/sGetConsumidosFecha"})
public class sGetConsumidosFecha extends HttpServlet {

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
            cConexion con = new cConexion();
            con.conectar();
            
            int idPaciente = Integer.parseInt(request.getParameter("idPaciente")); 
            int diaMes = Integer.parseInt(request.getParameter("day"));
            int mes = Integer.parseInt(request.getParameter("month")); //Es un array de meses
            int year = Integer.parseInt(request.getParameter("year"));
            ArrayList<cAlimento> alimentos = new ArrayList<cAlimento>();
            ResultSet rs = con.getAlimentosPorFecha(idPaciente, diaMes, mes, year);
            
            while(rs.next()){
                cAlimento miAlimento = new cAlimento();
                
                miAlimento.setID(rs.getInt("idAlimento_fecha"));
                miAlimento.setNombre(rs.getString("nombre"));
                miAlimento.setGramos(rs.getFloat("gramos"));
                miAlimento.setCalorias(rs.getInt("calorias"));
                miAlimento.setTiempoComida(rs.getInt("tiempo_comida_id"));  
                alimentos.add(miAlimento);
            }
            con.cerrar();
            regresarAlimentos(response, alimentos);
        }
    }
    
    private void regresarAlimentos(HttpServletResponse response, ArrayList<cAlimento> alimentos) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(alimentos));
        System.out.print(alimentos);
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
            Logger.getLogger(sGetConsumidosFecha.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetConsumidosFecha.class.getName()).log(Level.SEVERE, null, ex);
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
