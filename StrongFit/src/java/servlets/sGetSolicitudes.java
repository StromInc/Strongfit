/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cCifrado;
import clases.cConexion;
import clases.cSolicitud;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
 * @author Alumno
 */
@WebServlet(name = "sGetSolicitudes", urlPatterns = {"/sGetSolicitudes"})
public class sGetSolicitudes extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            String idUsr = (String)sesion.getAttribute("idUsr");
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            Map<String, Object> mapa = new HashMap();
            
            ArrayList<cSolicitud> lista = new ArrayList<>();

            String usrS = seguro.encriptar(idUsr);
            ResultSet rs2 = conecta.spSeleccionarSolicitudes(usrS);
            String correoSolicitud = "";
            String tipoUs = "Paciente";
            int contador = 0, si=0;

            while(rs2.next()){
                if(usrS.equals(rs2.getString("amigo2")) && rs2.getInt("estado") == 1){
                    correoSolicitud = rs2.getString("amigo1");
                    ResultSet rs3 = conecta.spGetInfoUsuario(correoSolicitud);
                    if(rs3.next()){
                        clases.CImagen objimg = new clases.CImagen();
                        int verificacionimg = objimg.devuelveexistencia(seguro.desencriptar(rs3.getString("idUsuario")),1);
                        String ruta = "lel";
                        String ruta2 = "../../Imagenes/Usuarios/";
                        String ses = "";
                        ResultSet r = conecta.spGetSesion(rs3.getString("idUsuario"));
                        if(r.next()){
                            ses = r.getString("sesion");
                        }
                        String nom = seguro.desencriptar(rs3.getString("idUsuario"));
                        String nombre = seguro.desencriptar(rs3.getString("nombre"));
                        if(rs3.getInt("idMedico") > 0){
                            tipoUs = "Médico";
                        }
                        switch(verificacionimg){
                            case 1: 
                                ruta = ruta2 + nom + ".jpg";
                                break;
                            case 2: 
                                ruta = ruta2 + nom + ".png";
                                break;
                            case 3: 
                                ruta = ruta2 + nom + ".gif";
                                break;
                            default: 
                                ruta = "../../Imagenes/usr_sin_imagen.jpg";
                                break;              
                        }
                        lista.add(new cSolicitud(nombre, nom, ruta, ses, tipoUs, contador));
                        contador++;
                    }
                }
            }
            
            mapa.put("solicitudes", lista);
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
            Logger.getLogger(sGetSolicitudes.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetSolicitudes.class.getName()).log(Level.SEVERE, null, ex);
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
