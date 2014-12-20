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
@WebServlet(name = "sPerfilDeUsuario", urlPatterns = {"/sPerfilDeUsuario"})
public class sPerfilDeUsuario extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            // recuperamos los valores
            String idUser = (String)sesion.getAttribute("idUsr");
            String nombre = request.getParameter("name");
            String idUsr = request.getParameter("email");
            String pass = request.getParameter("contra");
            String peso = request.getParameter("peso");
            String estatura = request.getParameter("estatura");
            String cintura = request.getParameter("cintura");
            String edad = request.getParameter("edad");
            String sexo = request.getParameter("sexo");
            String estado = request.getParameter("estado");
            String municipio = request.getParameter("municipio");
            String colonia = request.getParameter("colonia");
            String verificacion = "";
           // Conectar a la base de datos
            try{
             clases.cConexion objconexion = new clases.cConexion();
             objconexion.conectar();
             // verificar si el nuevo correo esta disponible
             if(idUser.equals(idUsr)){
             objconexion.cambioUsuario(idUser, nombre, pass, peso, estatura, cintura, edad, sexo, estado, municipio, colonia);
             sesion.setAttribute("idUsr",idUser);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("peso", peso );
                 sesion.setAttribute("estatura", estatura);
                 sesion.setAttribute("cintura", cintura);
                 sesion.setAttribute("edad", edad);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 response.sendRedirect("jsp/paciente/usuario.jsp");
             }else{
             verificacion = objconexion.cambiarcorreo(idUser);
             if(verificacion.equals("libre")){
             objconexion.cambioUsuarioConCorreo(idUser, nombre, pass, peso, estatura, cintura, edad, sexo, estado, municipio, colonia, idUsr);
             sesion.setAttribute("idUsr",idUsr);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("peso", peso );
                 sesion.setAttribute("estatura", estatura);
                 sesion.setAttribute("cintura", cintura);
                 sesion.setAttribute("edad", edad);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 response.sendRedirect("jsp/paciente/usuario.jsp");
             }else{
             response.sendRedirect("index.jsp");
             }
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
