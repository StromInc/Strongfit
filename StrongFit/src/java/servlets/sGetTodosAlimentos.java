/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.AlimentoAndroid;
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

/**
 *
 * @author USER
 */
@WebServlet(name = "sGetTodosAlimentos", urlPatterns = {"/sGetTodosAlimentos"})
public class sGetTodosAlimentos extends HttpServlet {

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
            ArrayList<AlimentoAndroid> alimentos = new ArrayList<AlimentoAndroid>();
            ResultSet rs = con.spGetTodosAlimentos();
            int i =0;
            while(rs.next()){
                if(i>15){
                    break;
                }
                AlimentoAndroid miAlimento = new AlimentoAndroid();        
                miAlimento.setAlimentoID(rs.getInt("idAlimento"));
                miAlimento.setName(rs.getString("nombre"));
                miAlimento.setCalories(rs.getFloat("calorias"));
                miAlimento.setLipidos(rs.getFloat("lipidos"));
                miAlimento.setCarbohidratos(rs.getFloat("carbohidratos"));
                miAlimento.setProteinas(rs.getFloat("proteinas"));
                miAlimento.setAlimentoTipo(rs.getInt("idTipoAlimento")); 
                alimentos.add(miAlimento);
                i++;
            }
            System.out.println("Numero de alimentos: " + i);
            con.cerrar();
            regresarAlimentos(response, alimentos);
        }
    }
    
    //Esto convierte el array en un Json y lo regresa al html
    private void regresarAlimentos(HttpServletResponse response, ArrayList<AlimentoAndroid> alimentos) throws IOException 
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
            Logger.getLogger(sGetTodosAlimentos.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetTodosAlimentos.class.getName()).log(Level.SEVERE, null, ex);
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
