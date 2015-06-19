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
 * @author USER
 */
@WebServlet(name = "sAgregarAlimento", urlPatterns = {"/sAgregarAlimento"})
public class sAgregarAlimento extends HttpServlet {

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
            HttpSession sesion = request.getSession();
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            
            int masivo = 0;
            float calorias = 0;
            String nomAlimento = "";
            
            try{
                calorias = Float.parseFloat(request.getParameter("calorias"));
                nomAlimento = request.getParameter("nomb");
                masivo = 1;
            }
            catch(Exception e){}
            
            Calendar calendario = new GregorianCalendar();
            int dia = calendario.get(Calendar.DAY_OF_YEAR);
            
            int diaMes = Integer.parseInt(request.getParameter("diaMes"));
            int mes = Integer.parseInt(request.getParameter("mes")); //Es un array de meses
            int year = Integer.parseInt(request.getParameter("thisYear"));
            float gramos = Float.parseFloat(request.getParameter("gramos"));
            
            int tipo = Integer.parseInt(request.getParameter("tipo"));
            
            //id del conteo calorico
            int idCont = (Integer) sesion.getAttribute("idcont");
            System.out.print(idCont);
            String id = request.getParameter("valor");
            System.out.print("ID Alimento" + id + " id usuario " +idCont);
            con.agregarAlimento(id, idCont);
            
            //Agregamos el alimento a la base
            int idA = Integer.parseInt(id);
            con.spSetAlimentoConsumido(idPaciente, idA, dia);    
            //Agregar alimento por fecha especifica tipo, idpaciente, numdia, mes, year
            int idAlta = con.spSetAlimentoFecha(idA, idPaciente, tipo, diaMes, mes, year, gramos);
            con.cerrar();
            if(masivo == 0){
                response.getWriter().write(String.valueOf(idAlta));
            }
            else{
                Map<String, Object> mapa = new HashMap();
                mapa.put("idAlta", idAlta);
                mapa.put("nomAlimento", nomAlimento);
                mapa.put("caloriasA", calorias);
                
                response.setContentType("aplication/json");
                response.setCharacterEncoding("charset=UTF-8");
                response.getWriter().write(new Gson().toJson(mapa));
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
            Logger.getLogger(sAgregarAlimento.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sAgregarAlimento.class.getName()).log(Level.SEVERE, null, ex);
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
