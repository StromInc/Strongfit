/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cCifrado;
import clases.cConexion;
import clases.cMensajes;
import clases.cUsuarioChat;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
 * @author ian
 */
@WebServlet(name = "sGetConversaciones", urlPatterns = {"/sGetConversaciones"})
public class sGetConversaciones extends HttpServlet {

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
            cConexion conecta = new cConexion();
            conecta.conectar();
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            String idUsr = (String)sesion.getAttribute("idUsr");
            idUsr = seguro.encriptar(idUsr);
            String idOtro = request.getParameter("otroUsuario");
            idOtro = seguro.encriptar(idOtro);
            Calendar calendario = new GregorianCalendar();
            int dia = calendario.get(Calendar.DAY_OF_MONTH);
            int mes = calendario.get(Calendar.MONTH) + 1;
            int anio = calendario.get(Calendar.YEAR);
            int hora = calendario.get(Calendar.HOUR) + 12;
            int minuto = calendario.get(Calendar.MINUTE);
            int segundo = calendario.get(Calendar.SECOND);
            String fecha = anio + "-" + mes + "-" + dia + " " + hora + ":" + minuto + ":" + segundo;
            System.out.println(idUsr);
            System.out.println("..........................................................");
            System.out.println("ESTA ES LA FECHA DEL TIMESTAMP: " + fecha);
            ResultSet mensajes = conecta.spGetMensajes(idUsr, idOtro, fecha);
            String mensaje = "";
            String remitente = "";
            String destinatario = "";
            ArrayList<cMensajes> lista = new ArrayList<>();
            
            while(mensajes.next()){
                remitente = seguro.desencriptar(mensajes.getString("remitente"));
                destinatario = seguro.desencriptar(mensajes.getString("destinatario"));
                mensaje = mensajes.getString("mensaje");
                
                lista.add(new cMensajes(remitente, destinatario, mensaje));
            }
            
            buscar(response, lista);
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
            Logger.getLogger(sGetConversaciones.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetConversaciones.class.getName()).log(Level.SEVERE, null, ex);
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
    
    private void buscar(HttpServletResponse response, ArrayList<cMensajes> lista) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(lista));
        System.out.print(lista);
    }

}
