/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.ResultSet;
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
@WebServlet(name = "sLogIn", urlPatterns = {"/sLogIn"})
public class sLogIn extends HttpServlet {

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
            clases.cConexion objconexion = new clases.cConexion();
            objconexion.conectar();
            HttpSession sesion = request.getSession();
            sesion.setMaxInactiveInterval(-1);
            String idUser = request.getParameter("txt-mail");
            String pass = request.getParameter("txt-pass");
            String tipo = "";
            ResultSet resultado;
            String verificacion = objconexion.busquedadeusuarios(idUser, pass); 
            // identificar al usuario
            try{                   
            // Logica para permitir o no el acceso
            if (verificacion.equals("si")){
                sesion.setAttribute("idUsr",idUser);
                sesion.setAttribute("pass",pass);
                //logica para mandar al usuario a donde deba
                tipo = objconexion.tipodeusuario(idUser);
                System.out.println(tipo);
                if(tipo.equals("medico")){
                    resultado = objconexion.cargadedatos(idUser, tipo);
                if(resultado.next()){
                    if(resultado.getInt("estatus") == 1)
                    {
                        int idMedico = resultado.getInt("idMedico");
                        int cedula = resultado.getInt("cedulaProf");
                        int edad = resultado.getInt("edad");
                        int sexo = resultado.getInt("idSexo"); //En la base dice idSexo no sexo 
                        String nombre = resultado.getString("nombre");
                        String carrera = resultado.getString("carrera");
                        String escuela = resultado.getString("escuela");
                        String estado = resultado.getString("estado");
                        String municipio = resultado.getString("municipio");
                        String colonia = resultado.getString("colonia");
                        //variables de sesion
                        sesion.setAttribute("nombre",nombre);
                        sesion.setAttribute("idMedico", idMedico);
                        sesion.setAttribute("cedula", cedula);
                        sesion.setAttribute("escuela", escuela);
                        sesion.setAttribute("carrera", carrera);
                        sesion.setAttribute("edad", edad);
                        sesion.setAttribute("sexo", sexo);
                        sesion.setAttribute("estado", estado);
                        sesion.setAttribute("municipio", municipio);
                        sesion.setAttribute("colonia", colonia);
                        response.sendRedirect("jsp/nutriologo/inicio.jsp");
                    }
                    else{
                        out.println("<script>alert('Lo sentimos parece que no has sido confirmado.');</script>");
                    }
                }
                }else{
                    if(tipo.equals("paciente")){
                    
                    resultado = objconexion.cargadedatos(idUser, tipo);
                    if(resultado.next()){
                        int idPaciente = resultado.getInt("idPaciente");
                        int peso = resultado.getInt("peso");
                        int edad = resultado.getInt("edad");
                        int sexo = resultado.getInt("idSexo"); //en la base es idSexousuario
                        int salud = resultado.getInt("idSalud");
                        int idCont = resultado.getInt("idConteo");
                        String nombre = resultado.getString("nombre");
                        int estatura = resultado.getInt("estatura");
                        int cintura = resultado.getInt("medidaCintura");
                        String estado = resultado.getString("estado");
                        String municipio = resultado.getString("municipio");
                        String colonia = resultado.getString("colonia");
                        //variables de sesion
                        sesion.setAttribute("idPaciente", idPaciente);
                        sesion.setAttribute("nombre",nombre); 
                        sesion.setAttribute("idcont", idCont); //el id del conteo calorico
                        sesion.setAttribute("salud", salud);
                        sesion.setAttribute("peso", peso);
                        sesion.setAttribute("estatura", estatura);
                        sesion.setAttribute("cintura", cintura);
                        sesion.setAttribute("edad", edad);
                        sesion.setAttribute("sexo", sexo);
                        sesion.setAttribute("estado", estado);
                        sesion.setAttribute("municipio", municipio);
                        sesion.setAttribute("colonia", colonia);
                        response.sendRedirect("jsp/paciente/inicio.jsp");
                        out.print("<script>alert('Bienveido');</script>");
                    }
                    } else
                        {
                            if(tipo.equals("admin")){

                                sesion.setAttribute("idUsr", "supremo");
                                response.sendRedirect("jsp/admin/inicio.jsp");

                            }
                        }
                }//falta un else, se traba si el usuario no existe 

                }
                
                if (verificacion.equals("no")){ 
                    sesion.setAttribute("mensaje", "El usuario no existe");
                    response.sendRedirect("index.jsp");
                }
                if (verificacion.equals("nop")){ 
                    sesion.setAttribute("mensaje", "Los datos no son correctos");
                    response.sendRedirect("index.jsp");;
            }
            
            }
            catch(SQLException ex){
                out.print(ex.toString());
            }
            }
            catch(SQLException ex){
                out.print(ex.toString());
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