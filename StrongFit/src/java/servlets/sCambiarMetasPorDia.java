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
@WebServlet(name = "sCambiarMetasPorDia", urlPatterns = {"/sCambiarMetasPorDia"})
public class sCambiarMetasPorDia extends HttpServlet {

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
            
            Calendar cal = new GregorianCalendar();
            int diaA = cal.get(Calendar.DAY_OF_YEAR);
            int semA = cal.get(Calendar.WEEK_OF_YEAR);
            int mesA = cal.get(Calendar.MONTH);
            
            HttpSession sesion = request.getSession();
            int idCon = (Integer)sesion.getAttribute("idcont");
            int ultimoDia = 0, ultimoMes = 0, ultimoSem = 0;
            int caloriasD = 0, caloriasM = 0, caloriasSem = 0;
            
            cConexion con = new cConexion();
            con.conectar();
            
            ResultSet rs = con.spGetConteo(idCon);
            if(rs.next())
            {
                ultimoDia = rs.getInt("ultimoDia");
                ultimoSem = rs.getInt("ultimoSem");
                ultimoMes = rs.getInt("ultimoMes");
                caloriasD = rs.getInt("caloriasDia");
                caloriasSem = rs.getInt("caloriasSem");
                caloriasM = rs.getInt("caloriasMen");
            }
            caloriasSem += caloriasD;
            caloriasM += caloriasD;
            caloriasD = 0;
//            (in idC int, in diaA int, in mesA int, in semA int, in cDia int, in cMes int, in cSem int)
            if(diaA != ultimoDia){
                con.spSetCalorias(idCon, diaA, ultimoMes, ultimoSem, 0, caloriasM, caloriasSem);
                if(ultimoSem != semA){
                System.out.println("SI ENTRO AL IF DE SEMANA");
                    con.spSetCalorias(idCon, diaA, ultimoMes, semA, 0, caloriasM, 0);
                }
                
                if(ultimoMes != mesA){
                    con.spSetCalorias(idCon, diaA, mesA, ultimoSem, 0, 0, caloriasSem);
                }
            }
            
            Map<String, Object> map = new HashMap<>();
            map.put("confirmacion", semA);
            write(response, map);
            
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
            Logger.getLogger(sCambiarMetasPorDia.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sCambiarMetasPorDia.class.getName()).log(Level.SEVERE, null, ex);
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
