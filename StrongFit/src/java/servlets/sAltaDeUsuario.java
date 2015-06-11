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
@WebServlet(name = "sAltaDeUsuario", urlPatterns = {"/sAltaDeUsuario"})
public class sAltaDeUsuario extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            cCifrado seguro = new cCifrado();            
            //Recuperando Valores
            String idUser = request.getParameter("txt-mail");
                   idUser = seguro.sanar(idUser);
            String pass = request.getParameter("txt-pass");
                   pass = seguro.sanar(pass);
            String nombre = request.getParameter("txt-name");
                   nombre = seguro.sanar(nombre);
             // conectar a la base de datos                                     
            try{
                seguro.AlgoritmoAES();
                seguro.iniciarBuscador();
                String pwdS = seguro.cifrarSHA1(pass);
                String idS = seguro.encriptar(idUser);
                String nomS = seguro.encriptar(nombre);
                String nomS2 = seguro.cifrarBuscador(nombre);
                clases.cConexion objconexion = new clases.cConexion();
                objconexion.conectar();
                // verificar usuario
                String verificacion = objconexion.altausuario(idS, pwdS, nomS, nomS2);
                if (verificacion.equals("valido")){
                    int idConteo = 0;
                    int idPaciente = 0;
                    ResultSet rs = objconexion.altapaciente(idS);
                    if(rs.next())
                    {
                        idConteo = rs.getInt("idConteo");
                        idPaciente = rs.getInt("idPaciente");
                    }
                    // cargar datos a la sesion
                    sesion.setAttribute("idUsr",idUser);
                    sesion.setAttribute("idPaciente", idPaciente);
                    sesion.setAttribute("passUsr",pass);
                    sesion.setAttribute("nomUsr",nombre);            
                    sesion.setAttribute("nombre",nombre);
                    sesion.setAttribute("pass",pass);
                    sesion.setAttribute("idcont", idConteo);
                    sesion.setAttribute("peso", 0 );
                    sesion.setAttribute("estatura", 0);
                    sesion.setAttribute("cintura", 0);
                    sesion.setAttribute("edad", 0);
                    sesion.setAttribute("sexo", 0);
                    sesion.setAttribute("salud", 0);
                    sesion.setAttribute("estado", "");
                    sesion.setAttribute("municipio", "");
                    sesion.setAttribute("colonia", "");
                    sesion.setAttribute("tipodeus","1");
                    sesion.setAttribute("mensaje", "Bienvenido a Strongfit!");
                    // Mandar al usuario a su perfil
                    response.sendRedirect("jsp/paciente/usuario.jsp");
                }else{
                    sesion.setAttribute("mensaje", "Comprueba tus datos");
                    response.sendRedirect("index.jsp");
                }
            }catch(SQLException ex){
                //out.print(ex.toString());
                sesion.setAttribute("mensaje", "Usuario inválido");
                response.sendRedirect("index.jsp");
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
            Logger.getLogger(sAltaDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sAltaDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
