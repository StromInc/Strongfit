/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.AlimentoAndroid;
import clases.CImagen;
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
 * @author Alumno
 */
@WebServlet(name = "sGetDatospaciente", urlPatterns = {"/sGetDatospaciente"})
public class sGetDatospaciente extends HttpServlet {

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
            cConexion con = new cConexion();
            con.conectar();
             cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            Map<String, String> datosPaciente = new HashMap<>();
            String idUser = seguro.sanar(request.getParameter("correo"));
            String pass = seguro.sanar(request.getParameter("contra"));
            
            String idUS = seguro.encriptar(idUser);
            String passS = seguro.cifrarSHA1(pass);
            ResultSet rs = con.spGetDatosPaciente(idUS, passS);
            String nombre = "";
            String idPaciente = "";
            int i =0;
            CImagen imagen = new CImagen();
            int var = imagen.devuelveexistencia(idUser, 1);
            while(rs.next()){
                nombre =rs.getString("nombre");
                idPaciente =String.valueOf(rs.getInt("idPaciente"));
                i++;
            }
            datosPaciente.put("avatar", "Imagenes/Usuarios/"+idUser+".jpg");
            datosPaciente.put("nombre", seguro.desencriptar(nombre));
            datosPaciente.put("idPaciente", idPaciente);
            System.out.println("Nombre: " + seguro.desencriptar(nombre) + " idPaciente: " + idPaciente);
            con.cerrar();
            regresarDatos(response, datosPaciente);
        }
    }
    
    private void regresarDatos(HttpServletResponse response, Map<String, String> datosPaciente) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(datosPaciente));
        System.out.print(datosPaciente);
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
            Logger.getLogger(sGetDatospaciente.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sGetDatospaciente.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetDatospaciente.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sGetDatospaciente.class.getName()).log(Level.SEVERE, null, ex);
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
