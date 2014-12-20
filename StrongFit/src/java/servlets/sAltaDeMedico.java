/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            String nombre = request.getParameter("txt-name");
            String idUser = request.getParameter("txt-mail");
            String pass = request.getParameter("txt-pass");
            String edad = request.getParameter("edad");
            String sexo = request.getParameter("sexo");
            String estado = request.getParameter("estado");
            String municipio = request.getParameter("municipio");
            String colonia = request.getParameter("colonia");
            String cedula = request.getParameter("plicense");
            String escuela = request.getParameter("school");
            String carrera = request.getParameter("carrier");
            // Conectamos la base y damos de alta al usuario 
            try{
             clases.cConexion objconexion = new clases.cConexion();
             objconexion.conectar();
             String verificacion = objconexion.altausuario(idUser, pass, nombre);
              if (verificacion.equals("valido")){ 
                  objconexion.altamedico(idUser,cedula,escuela,estado,municipio,colonia,sexo,edad, carrera);
                  // cargar datos a la sesion
                 sesion.setAttribute("idUsr",idUser);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("cedula", cedula );
                 sesion.setAttribute("escuela", escuela);
                 sesion.setAttribute("carrera", carrera);
                 sesion.setAttribute("edad", edad);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 // Mandar al usuario a su perfil
                 response.sendRedirect("jsp/nutriologo/usuario.jsp");
                 out.print("<script>alert('Alta realizada');</script>");
              }else{
             out.print("<script>alert('Actuelmente ya existe una cuenta registrada con ese correo');</script>");    
             response.sendRedirect("index.jsp");
             }
             }catch(SQLException ex){
             out.print(ex.toString());
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
        processRequest(request, response);
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
        processRequest(request, response);
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
