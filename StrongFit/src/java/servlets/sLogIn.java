/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
            String idUser = request.getParameter("txt-mail");
            String pass = request.getParameter("txt-pass");
            String tipo = "";
            ResultSet resultado;
            // identificar al usuario
            try{
                String verificacion = objconexion.busquedadeusuarios(idUser, pass);           
            // Logica para permitir o no el acceso
            if (verificacion.equals("si")){
                sesion.setAttribute("idUsr",idUser);
                sesion.setAttribute("pass",pass);
                //logica para mandar al usuario a donde deba
                tipo = objconexion.tipodeusuario(idUser);
                if(tipo.equals("medico")){
                    resultado = objconexion.cargadedatos(idUser, tipo);
                if(resultado.next()){
                    int cedula = resultado.getInt("cedulaProf");
                    int edad = resultado.getInt("edad");
                    String cedula1 = Integer.toString(cedula);
                    String edad1 = Integer.toString(edad);
                    String sexo = resultado.getString("idSexo"); //En la base dice idSexo no sexo 
                    String nombre = resultado.getString("nombre");
                    String carrera = resultado.getString("carrera");
                    String escuela = resultado.getString("escuela");
                    String estado = resultado.getString("estado");
                    String municipio = resultado.getString("municipio");
                    String colonia = resultado.getString("colonia");
                    //variables de sesion
                    sesion.setAttribute("nombre",nombre);
                    sesion.setAttribute("cedula", cedula1 );
                    sesion.setAttribute("escuela", escuela);
                    sesion.setAttribute("carrera", carrera);
                    sesion.setAttribute("edad", edad1);
                    sesion.setAttribute("sexo", sexo);
                    sesion.setAttribute("estado", estado);
                    sesion.setAttribute("municipio", municipio);
                    sesion.setAttribute("colonia", colonia);
                    response.sendRedirect("jsp/nutriologo/inicio.jsp");
                }//falta un else, se traba si el usuario no existe
                }else{
                    tipo = "paciente";
                    resultado = objconexion.cargadedatos(idUser, tipo);
                    if(resultado.next()){  
                        int peso = resultado.getInt("peso");
                        int edad = resultado.getInt("edad");
                        String sexo = resultado.getString("idSexo"); //en la base es idSexo
                        String idCont = resultado.getString("idCont");
                        String nombre = resultado.getString("nombre");
                        int estatura = resultado.getInt("estatura");
                        int cintura = resultado.getInt("medidaCintura");
                        String estado = resultado.getString("estado");
                        String municipio = resultado.getString("municipio");
                        String colonia = resultado.getString("colonia");
                        String edad1 = Integer.toString(edad);
                        String peso1 = Integer.toString(peso);
                        String estatura1 = Integer.toString(estatura);
                        String cintura1 = Integer.toString(cintura);
                        //variables de sesion
                        sesion.setAttribute("nombre",nombre); 
                        sesion.setAttribute("idcont", idCont); //el id del conteo calorico
                        sesion.setAttribute("peso", peso1 );
                        sesion.setAttribute("estatura", estatura1);
                        sesion.setAttribute("cintura", cintura1);
                        sesion.setAttribute("edad", edad1);
                        sesion.setAttribute("sexo", sexo);
                        sesion.setAttribute("estado", estado);
                        sesion.setAttribute("municipio", municipio);
                        sesion.setAttribute("colonia", colonia);
                        response.sendRedirect("jsp/paciente/inicio.jsp");
                        out.print("<script>alert('Bienveido');</script>");
                    }
                }
            }
            if (verificacion.equals("no")){ 
                response.sendRedirect("index.jsp");
                out.print("<script>alert('Usuario inexistente');</script>");
            }
            if (verificacion.equals("nop")){ 
                response.sendRedirect("index.jsp");
                out.print("<script>alert('Contraseña incorrecta');</script>");
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
