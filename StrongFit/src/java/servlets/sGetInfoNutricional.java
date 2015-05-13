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

/**
 *
 * @author ian
 */
@WebServlet(name = "sGetInfoNutricional", urlPatterns = {"/sGetInfoNutricional"})
public class sGetInfoNutricional extends HttpServlet {

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
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            String idOtro = request.getParameter("idOtro");
                   idOtro = seguro.encriptar(idOtro);
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            Map<String, Object> mapa = new HashMap();
            
            int seleccion = 0, con = 0, seleccionOcupacion = 0;
            int caloriasD[] = new int[7];
            String horas[] = new String[7];
            String seleccionDias[] = new String[7];
            String actividad = "sin";
            String ocupacion = "";
            
            ResultSet rs = conecta.cargadedatos(idOtro, "paciente");
            if(rs.next()){
                mapa.put("peso", rs.getInt("peso"));
                mapa.put("estatura", rs.getInt("estatura"));
                mapa.put("medidaCintura", rs.getInt("medidaCintura"));
                mapa.put("edad", rs.getInt("edad"));
                mapa.put("sexo", rs.getInt("idSexo"));
                
                ResultSet select = conecta.spGetCaloriasPaciente(rs.getInt("idPaciente"));
                for(int i = 0; i < horas.length; ++i){
                    horas[i] = "";
                }
                while(select.next()){
                    caloriasD[con] = select.getInt("calorias");
                    seleccion = select.getInt("idActividad");
                    seleccionOcupacion = select.getInt("ocupacion");
                    if(select.getInt("horas") != 0){
                        seleccionDias[con] = "checked";
                        horas[con] = String.valueOf(select.getInt("horas"));
                    }
                    else{
                        seleccionDias[con] = "";
                        horas[con] = "";
                    }   
                    con++;
                }
                
                ResultSet rs2 = conecta.getActividadEspecifica(seleccion);
                if(rs2.next()){
                    actividad = rs2.getString("actividad");
                }
                
                ResultSet rs3 = conecta.getOcupacionEspecifica(seleccionOcupacion);
                if(rs3.next()){
                    ocupacion = rs3.getString("ocupacion");
                }
                
                mapa.put("actividad", actividad);
                mapa.put("ocupacion", ocupacion);
                mapa.put("caloriasD", caloriasD);
                mapa.put("horas", horas);
                mapa.put("seleccionDias", seleccionDias);
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
            Logger.getLogger(sGetInfoNutricional.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetInfoNutricional.class.getName()).log(Level.SEVERE, null, ex);
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
