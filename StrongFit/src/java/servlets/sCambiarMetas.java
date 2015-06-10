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
@WebServlet(name = "sCambiarMetas", urlPatterns = {"/sCambiarMetas"})
public class sCambiarMetas extends HttpServlet {

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

            HttpSession sesion = request.getSession();
            cConexion conectar = new cConexion();
            conectar.conectar();
            
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            
            int diaMes = Integer.parseInt(request.getParameter("diaMes"));
            int diaSemana = Integer.parseInt(request.getParameter("diaSemana")) + 1; //Por que en la base el domingo es 1
            int numMes = Integer.parseInt(request.getParameter("numMes"));
            int year = Integer.parseInt(request.getParameter("year"));
            
            int caloriasdia = 0;
            int calorias = 0;
            float kcalorias = 0;
            float gramos;
            System.out.println("IDPaciente: " + idPaciente + " " + diaSemana + " " + diaMes);
            ResultSet rs = conectar.getAlimentosPorFecha(idPaciente, diaMes, numMes, year);
            while(rs.next()){
                calorias = rs.getInt("calorias");
                gramos = rs.getFloat("gramos");

                kcalorias += (gramos * calorias)/100;
            }
            String calTotales = String.format("%.2f", kcalorias);
            
            ResultSet rs2 = conectar.spGetCaloriasPacienteEspecifico(idPaciente, diaSemana);
            if(rs2.next()){
                caloriasdia = rs2.getInt("calorias");
            }
            conectar.cerrar();
            Map respuesta = new HashMap();
            respuesta.put("calDia", calTotales);
            respuesta.put("laMeta", caloriasdia);
            write(response, respuesta);
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
            Logger.getLogger(sCambiarMetas.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sCambiarMetas.class.getName()).log(Level.SEVERE, null, ex);
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
