/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import clases.cCifrado;
import clases.cSugerirDietas;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            // recuperamos los valores
            clases.cConexion objconexion = new clases.cConexion();
            objconexion.conectar();
            
            cCifrado seguro = new cCifrado();
            String pass = request.getParameter("contra");
            seguro.AlgoritmoAES();
            String pass2 = seguro.cifrarSHA1(pass);
            
            String idUser = (String)sesion.getAttribute("idUsr");
            String idUserS = seguro.encriptar(idUser);
            
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            
            String nombre = request.getParameter("name");
            String nombreS = seguro.encriptar(nombre);
            String idUsr = request.getParameter("email");
            String idUsrS = seguro.encriptar(idUsr);
            
            String peso = request.getParameter("peso");
            String estatura = request.getParameter("estatura");
            String cintura = request.getParameter("cintura");
            String edad = request.getParameter("edad");
            
            int edad2 = Integer.parseInt(edad);
            int peso2 = Integer.parseInt(peso);
            int cintura2 = Integer.parseInt(cintura);
            int estatura2 = Integer.parseInt(estatura);
            int sexo = Integer.parseInt(request.getParameter("sexo"));
            int ocupacion = Integer.parseInt(request.getParameter("ocupacion"));
            int actividad = Integer.parseInt(request.getParameter("actividad"));
            String d[], hrs[];
            int horasR[], dias[];
            d = request.getParameterValues("dias");
            int con = 0;
            
            System.out.println("=====================================");
            System.out.println(actividad);
            System.out.println("=====================================");
            cSugerirDietas sugerir;
            
            if(actividad != 1)
            {
                for(int i = 0; i < d.length; ++i)
                {
                    con++;
                }
                dias = new int[con];
                for(int i = 0; i < dias.length; ++i)
                {
                    dias[i] = Integer.parseInt(d[i]);
                }
                hrs = request.getParameterValues("horas");

                ArrayList<Integer> horas = new ArrayList();
                for(int i = 0; i < hrs.length; ++i)
                {
                    if(!hrs[i].equals(""))
                    {
                        System.out.println("ESTE ES EL VALOR DE HRS: " + hrs[i]);
                        horas.add(Integer.parseInt(hrs[i]));
                    }
                }
                horasR = new int[horas.size()];
                for(int i = 0; i < horasR.length; ++i)
                {
                    horasR[i] = horas.get(i);
                }
                sugerir = new cSugerirDietas(idUserS, edad2, peso2, cintura2, estatura2, sexo, actividad, dias, horasR, ocupacion);
            }
            else
                sugerir = new cSugerirDietas(idUserS, edad2, peso2, cintura2, estatura2, sexo, actividad, ocupacion);
            
            
            String estado = request.getParameter("estado");
            String estadoS = seguro.encriptar(estado);
            String municipio = request.getParameter("municipio");
            String municipioS = seguro.encriptar(municipio);
            String colonia = request.getParameter("colonia");
            String coloniaS = seguro.encriptar(colonia);
            String verificacion = "";
            
            //Calculamos el estado de salud del paciente y las calorias que debe de consumir para estar saludable

            
            float imc = sugerir.calcularIMC();
            int estadoSalud = sugerir.estadoSalud(imc);
            System.out.println("ESTE ES EL ESTADO DE SALUD" + estadoSalud);
            int kcalorias[] = sugerir.determinarKcalorias();
            int horasS[] = sugerir.getHoras();
            //Guardamos
            for(int i = 0; i < kcalorias.length; ++i)
            {
                System.out.println("###########################################");
                System.out.println(kcalorias[i]);
                objconexion.modificarCalorias(idPaciente, kcalorias[i], (i+1), horasS[i], actividad, ocupacion);
            }
            
           // Conectar a la base de datos
            try{
             // verificar si el nuevo correo esta disponible
             if(idUser.equals(idUsr)){
             objconexion.cambioUsuario(idUserS, nombreS, pass2, peso, estatura, cintura, edad, sexo, estadoSalud, estadoS, municipioS, coloniaS, idPaciente);
             sesion.setAttribute("idUsr",idUser);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("peso", peso2);
                 sesion.setAttribute("estatura", estatura2);
                 sesion.setAttribute("cintura", cintura2);
                 sesion.setAttribute("edad", edad2);
                 sesion.setAttribute("sexo", sexo);
                 sesion.setAttribute("estado", estado);
                 sesion.setAttribute("municipio", municipio);
                 sesion.setAttribute("colonia", colonia);
                 sesion.setAttribute("salud", estadoSalud);
                 response.sendRedirect("jsp/paciente/usuario.jsp");
             }else{
             verificacion = objconexion.cambiarcorreo(idUsrS);
             if(verificacion.equals("libre")){
             objconexion.cambioUsuarioConCorreo(idUserS, nombreS, pass2, peso, estatura, cintura, edad, sexo, estadoS, municipioS, coloniaS, idUsrS, estadoSalud, idPaciente);
             sesion.setAttribute("idUsr",idUsr);
                 sesion.setAttribute("nombre",nombre);
                 sesion.setAttribute("pass",pass);
                 sesion.setAttribute("peso", peso2);
                 sesion.setAttribute("estatura", estatura2);
                 sesion.setAttribute("cintura", cintura2);
                 sesion.setAttribute("edad", edad2);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(sPerfilDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sPerfilDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(sPerfilDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sPerfilDeUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
