/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cCifrado;
import clases.cConexion;
import clases.cMensajes;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author ian
 */
@WebServlet(name = "sGetInfoUsuario", urlPatterns = {"/sGetInfoUsuario"})
public class sGetInfoUsuario extends HttpServlet {

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
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            HttpSession sesion = request.getSession();
            String idUsr = (String)sesion.getAttribute("idUsr");
                   idUsr = seguro.encriptar(idUsr);
            
            String desti = request.getParameter("desti");
            String destiS = desti;
            desti = seguro.encriptar(desti);
            
            clases.CImagen objimg = new clases.CImagen();
            int verificacionimg = objimg.devuelveexistencia(destiS);
            String ruta = "lel";
            String ruta2 = "../../Imagenes/Usuarios/";
            switch(verificacionimg){
                case 1: 
                    ruta = ruta2 + destiS + ".jpg";
                    break;
                case 2: 
                    ruta = ruta2 + destiS + ".png";
                    break;
                case 3: 
                    ruta = ruta2 + destiS + ".gif";
                    break;
                default: 
                    ruta = "../../Imagenes/usr_sin_imagen.jpg";
                    break;              
            }
            
            ResultSet rs = conecta.spGetInfoUsuario(desti);
            ResultSet rs2 = conecta.spGetRelUsr(idUsr, desti);

            Map<String, Object> lista = new HashMap<>();
            while(rs.next()){
                lista.put("nombre", seguro.desencriptar(rs.getString("nombre")));
                lista.put("correo", seguro.desencriptar(rs.getString("idUsuario")));
                lista.put("imagen", ruta);
                if(rs.getInt("idMedico") > 0){
                    lista.put("cedula", rs.getString("cedulaProf"));
                    lista.put("escuela", seguro.desencriptar(rs.getString("escuela")));
                    lista.put("carrera", seguro.desencriptar(rs.getString("carrera")));
                    lista.put("tipo", "medico");
                }
                else{
                    lista.put("tipo", "paciente");
                }
            }
            
            if(rs2.next()){
                lista.put("amistad", "si");
            }
            else{
                lista.put("amistad", "no");
            }
            
            write(response, lista);
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
        } catch (Exception ex) {
            Logger.getLogger(sGetInfoUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetInfoUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
