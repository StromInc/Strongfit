/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cCifrado;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * @author jorge pastrana
 */
@WebServlet(name = "sAltaDeMedico", urlPatterns = {"/sAltaDeMedico"})
public class sAltaDeMedico extends HttpServlet {

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
            throws ServletException, IOException, NoSuchAlgorithmException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            seguro.iniciarBuscador();
            /* TODO output your page here. You may use following sample code. */
            String pass = seguro.cifrarSHA1(seguro.sanar(request.getParameter("txt-pass")));
            String nombre = seguro.encriptar(seguro.sanar(request.getParameter("txt-name")));
            String nombre2 = seguro.cifrarBuscador(seguro.sanar(request.getParameter("txt-name")));
            String idUser = seguro.encriptar(seguro.sanar(request.getParameter("txt-mail")));
            
            String edad = seguro.sanar(request.getParameter("edad"));
            int sexo = Integer.parseInt(seguro.sanar(request.getParameter("idSexo")));
            String estado = seguro.encriptar(seguro.sanar(request.getParameter("estado")));
            String municipio = seguro.encriptar(seguro.sanar(request.getParameter("municipio")));
            String colonia = seguro.encriptar(seguro.sanar(request.getParameter("colonia")));
            String cedula = seguro.sanar(request.getParameter("plicense"));
            String escuela = seguro.encriptar(seguro.sanar(request.getParameter("school")));
            String carrera = seguro.encriptar(seguro.sanar(request.getParameter("carrier")));
            boolean noAvanza= true;
            int cedula2 = 0;
            int edad2 = 0;
            try{
                cedula2 = Integer.parseInt(cedula);
                edad2 = Integer.parseInt(edad);
                noAvanza = false;
            }catch(NumberFormatException e){
                System.out.println(e.toString() + " Error de parseo");
            }
            if(noAvanza){
                System.out.println("Mal");
                sesion.setAttribute("mensaje", "Por favor comprueba tus datos");
                response.sendRedirect("jsp/nutriologo/altanutriologo.jsp");        
            }else{
                try{
                    clases.cConexion objconexion = new clases.cConexion();
                    objconexion.conectar();
                    String verificacion = objconexion.altausuario(idUser, pass, nombre, nombre2);
                    if(verificacion.equals("valido")){ 
                        ResultSet rs = objconexion.altamedico(idUser,cedula,escuela,estado,municipio,colonia,sexo,edad, carrera);
                        // Mandar al usuario a su perfil
                        response.sendRedirect("jsp/nutriologo/RegistroExitoso.jsp");
                    }else{
                        sesion.setAttribute("mensaje", "Ya exte una cuenta con ese correo");    
                        response.sendRedirect("jsp/nutriologo/altanutriologo.jsp"); 
                    }
                }catch(SQLException ex){
                    //out.print(ex.toString());
                    sesion.setAttribute("mensaje", "Usuario inválido");
                    response.sendRedirect("index.jsp");
                } 
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
        } catch (Exception ex) {
            Logger.getLogger(sAltaDeMedico.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sAltaDeMedico.class.getName()).log(Level.SEVERE, null, ex);
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
