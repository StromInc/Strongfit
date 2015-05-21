/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "sCrearDieta", urlPatterns = {"/sCrearDieta"})
public class sCrearDieta extends HttpServlet {

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
            String msjError = "";
            
            cConexion conector = new cConexion();
            conector.conectar();
            
            String cuantos[] = request.getParameter("cuantos").split(",");
            
            String ids[] = request.getParameterValues("ids");
            String calorias[] = request.getParameterValues("calorias");
            String lipidos[] = request.getParameterValues("lipidos");
            String proteinas[] = request.getParameterValues("proteinas");
            String carbohidratos[] = request.getParameterValues("carbohidratos");
            String consideracion[] = request.getParameterValues("consideracion");
            String porcion[] = request.getParameterValues("porcion");
            String cantidad[] = request.getParameterValues("cantidad");
            String nom = request.getParameter("nombreNuevaDieta");
            
            int tipo = 2;
            int kcal = 0;
            int considera = 1;
            
            float pro = 0f;
            float car = 0f;
            float lip = 0f;

            //primero se crea la dieta
            int idDieta = 0;
            ResultSet dieta = conector.spSetDieta(nom, tipo, kcal, pro, car, lip, considera);
            if(dieta.next()){
                idDieta = dieta.getInt("idDietaCreada");
            }
            
            //segundo se crea el dia de la dieta
            int cuantosAlimentos = 0;
            int cuanto = 0;
            int contadorComida = 0;
            int idDia = 0;
            int idComida = 0;
            for(int i = 1; i <= 7; ++i){
                
                ResultSet dia = conector.spSetDiaDieta(i, idDieta);
                if(dia.next()){
                    idDia = dia.getInt("idDiaCreado");
                }
                
                for(int j = 1; j <= 5; ++j){
                    
                    ResultSet comida = conector.spSetComidaDieta(j, idDia);
                    if(comida.next()){
                        idComida = comida.getInt("idComidaCreada");
                    }
                    cuantosAlimentos = Integer.parseInt(cuantos[cuanto]);
                    for(int k = 0; k < cuantosAlimentos; ++k){
                        conector.spInsertarAlimentoComida(Integer.parseInt(ids[contadorComida]), idComida, Integer.parseInt(cantidad[contadorComida]));
                        contadorComida++;
                    }
                    cuanto++;
                }
            }
            response.sendRedirect("jsp/nutriologo/dietas_nutriologo.jsp");
        }
//        catch(Exception e){
//            System.out.println("Parece que hubo un error.");
//        }
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
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
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
