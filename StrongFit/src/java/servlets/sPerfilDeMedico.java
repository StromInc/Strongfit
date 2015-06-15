/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cCifrado;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "sPerfilDeMedico", urlPatterns = {"/sPerfilDeMedico"})
public class sPerfilDeMedico extends HttpServlet {

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
           
           cCifrado seguro = new cCifrado();
            // recuperamos los valores
           String pass = seguro.sanar(request.getParameter("txt-pass"));
            seguro.AlgoritmoAES();
            seguro.iniciarBuscador();
            String passS = seguro.cifrarSHA1(pass);
            String idUser = (String)sesion.getAttribute("idUsr");
            String idUserS = seguro.encriptar(idUser);
            
            
            int idMedico = (Integer)sesion.getAttribute("idMedico");
            
            String nombre = seguro.sanar(request.getParameter("txt-name"));
            String nombreS = seguro.encriptar(nombre);
            String nombre2 = seguro.cifrarBuscador(nombre);
            String idUsr = seguro.sanar(request.getParameter("txt-email"));
            String idUsrS = seguro.encriptar(idUsr);
            
            if(nombre == null || idUsr == null || nombre.equals("") || idUsr.equals("")){
                sesion.setAttribute("mensaje", "Usuario no válido, por favor intenta de nuevo.");
                response.sendRedirect("jsp/paciente/usuario.jsp");
            }
            
            String edad = seguro.sanar(request.getParameter("edad"));
            int sexo = Integer.parseInt(request.getParameter("sexo"));
            
            String estado = seguro.sanar(request.getParameter("estado"));
            String estadoS = seguro.encriptar(estado);
            String municipio = seguro.sanar(request.getParameter("municipio"));
            String municipioS = seguro.encriptar(municipio);
            String colonia = seguro.sanar(request.getParameter("colonia"));
            String coloniaS = seguro.encriptar(colonia);
            
            String cedula = seguro.sanar(request.getParameter("plicense"));
            
            String escuela = seguro.sanar(request.getParameter("school"));
            String escuelaS = seguro.encriptar(escuela);
            String carrera = seguro.sanar(request.getParameter("carrier"));
            String carreraS = seguro.encriptar(carrera);
            String verificacion = "";
             
            
            int edad2 = Integer.parseInt(edad);
            int cedula2 = Integer.parseInt(cedula);
            
           // Conectar a la base de datos
            try{
             clases.cConexion objconexion = new clases.cConexion();
             objconexion.conectar();
             // verificar si el nuevo correo esta disponible
             if(idUser.equals(idUsr)){
             objconexion.cambioUsuariomedico(idUserS, nombreS, passS, cedula, escuelaS, carreraS, edad, sexo, estadoS, municipioS, coloniaS, idMedico, nombre2);
             sesion.setAttribute("idUsr",idUser);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("cedula", cedula2);
                 sesion.setAttribute("escuela", escuela);
                 sesion.setAttribute("carrera", carrera);
                 sesion.setAttribute("edad", edad2);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 response.sendRedirect("jsp/nutriologo/usuario.jsp");
             }else{
             verificacion = objconexion.cambiarcorreo(idUserS);
             System.out.print("verificacion   " + verificacion);
             if(verificacion.equals("libre")){
             objconexion.cambioUsuariomedicoConCorreo(idUserS, nombreS, passS, cedula, escuelaS, carreraS, edad, sexo, estadoS, municipioS, coloniaS, idUsrS, idMedico, nombre2);
             sesion.setAttribute("idUsr",idUsr);
                 sesion.setAttribute("idUsr",idUsr);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("cedula", cedula2);
                 sesion.setAttribute("escuela", escuela);
                 sesion.setAttribute("carrera", carrera);
                 sesion.setAttribute("edad", edad2);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 clases.CImagen objimagen = new clases.CImagen();
                 objimagen.cambianombreimagen(idUser, idUsr,1);
                 response.sendRedirect("jsp/nutriologo/usuario.jsp");
             }else{
             response.sendRedirect("jsp/nutriologo/usuario.jsp");
             }
             }
        }catch(SQLException ex){
             //out.print(ex.toString());
             response.sendRedirect("jsp/nutriologo/usuario.jsp");
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
            Logger.getLogger(sPerfilDeMedico.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sPerfilDeMedico.class.getName()).log(Level.SEVERE, null, ex);
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