/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cCifrado;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            clases.cConexion objconexion = new clases.cConexion();
            objconexion.conectar();
            HttpSession sesion = request.getSession();
            sesion.setMaxInactiveInterval(-1);
            String idUser = request.getParameter("txt-mail");
            String pass = request.getParameter("txt-pass");
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            String idUS = seguro.encriptar(idUser);
            String passS = seguro.cifrarSHA1(pass);
            
            String tipo = "";
            ResultSet resultado;
            String verificacion = objconexion.busquedadeusuarios(idUS, passS); 
            // identificar al usuario
            try{                   
            // Logica para permitir o no el acceso
            if (verificacion.equals("si")){
                sesion.setAttribute("idUsr",idUser);                
                sesion.setAttribute("pass",pass);
                //logica para mandar al usuario a donde deba
                tipo = objconexion.tipodeusuario(idUS);
                System.out.println(tipo);
                if(tipo.equals("medico")){
                    System.out.println("Entro a medico");
                    resultado = objconexion.cargadedatos(idUS, tipo);
                    if(resultado.next()){
                        if(resultado.getInt("estatus") == 1)
                        {
                            int idMedico = resultado.getInt("idMedico");
                            int cedula = resultado.getInt("cedulaProf");
                            int edad = resultado.getInt("edad");
                            int sexo = resultado.getInt("idSexo"); //En la base dice idSexo no sexo 
                            String nombre = seguro.desencriptar(resultado.getString("nombre"));
                            String carrera = seguro.desencriptar(resultado.getString("carrera"));
                            String escuela = seguro.desencriptar(resultado.getString("escuela"));
                            String estado = seguro.desencriptar(resultado.getString("estado"));
                            String municipio = seguro.desencriptar(resultado.getString("municipio"));
                            String colonia = seguro.desencriptar(resultado.getString("colonia"));
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
                            sesion.setAttribute("tipodeus","2");
                            sesion.setAttribute("edicion","");
                            response.sendRedirect("jsp/nutriologo/inicio.jsp");
                        }
                        else{
                            sesion.setAttribute("mensaje", "Lo sentimos parece que no has sido verificado aun");
                            response.sendRedirect("index.jsp");
                        }
                    }
                }else{
                    if(tipo.equals("paciente")){
                        System.out.println("Entro a paciente");
                        resultado = objconexion.cargadedatos(idUS, tipo);
                        if(resultado.next()){
                            int idPaciente = resultado.getInt("idPaciente");
                            int peso = resultado.getInt("peso");
                            int edad = resultado.getInt("edad");
                            int sexo = resultado.getInt("idSexo"); //en la base es idSexousuario
                            int salud = resultado.getInt("idSalud");
                            int idCont = resultado.getInt("idConteo");
                            String nombre = seguro.desencriptar(resultado.getString("nombre"));
                            int estatura = resultado.getInt("estatura");
                            int cintura = resultado.getInt("medidaCintura");
                            String estado = resultado.getString("estado");
                            String municipio = resultado.getString("municipio");
                            String colonia = resultado.getString("colonia");
                            if(estado != null && !estado.equals("")){
                                estado = seguro.desencriptar(estado);
                            }
                            if(municipio != null && !municipio.equals("")){
                                municipio = seguro.desencriptar(municipio);
                            }
                            if(colonia != null && !colonia.equals("")){
                                colonia = seguro.desencriptar(colonia);
                            }
                            //variables de sesion
                            sesion.setAttribute("idPaciente", idPaciente);
                            sesion.setAttribute("UsrS", idUS);
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
                            sesion.setAttribute("tipodeus","1");
                            response.sendRedirect("jsp/paciente/inicio.jsp");
                        }
                    }else{
                        if(tipo.equals("admin")){
                            System.out.println("Entro a admin");
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
                response.sendRedirect("index.jsp");
            } 
            }catch(SQLException ex){
                out.print(ex.toString());
            }
        }catch(SQLException ex){
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(sLogIn.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sLogIn.class.getName()).log(Level.SEVERE, null, ex);
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