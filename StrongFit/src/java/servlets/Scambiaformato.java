/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jorge pastrana
 */
@WebServlet(name = "Scambiaformato", urlPatterns = {"/Scambiaformato"})
public class Scambiaformato extends HttpServlet {

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
            String datos = request.getParameter("datos");
            String tamano = request.getParameter("tamano");
            String color = request.getParameter("color");
            String fuente = request.getParameter("tipo");
            String edicion = request.getParameter("edicion");
            boolean seleccionado = false;
            if(!edicion.equals("")){
            seleccionado = true;
            }
            boolean varconteo = true;
            boolean formato = false;
            int contador = 0;
            String datosi = "";
            String datos2 = "";
            String datos3 = "";
            String formato1 = "";
            int poscicion = 0;
            
            
            if(seleccionado){
                System.out.println("edicion " + edicion);
            for(int j = 0; j < datos.length();j++){
                if(contador < edicion.length()){
                    System.out.println("a");
                if(datos.charAt(j) == edicion.charAt(contador)){
                
                if(contador + 1 == edicion.length()){
                  poscicion = j - contador; 
                 }
                contador++;
                }
                }
                }
            System.out.println("pocicionon " + poscicion);
            for(int i = 0; i < datos.length();i++ ){
                System.out.println(i);
               if(varconteo){
                System.out.println("corre " + i );   
                if(i != poscicion){
                   if(datos.charAt(i) == '<'){
                   formato = true;
                   }
                   if(formato){
                       formato1 += datos.charAt(i);
                   }
                   if(datos.charAt(i) == '>'){
                   formato = false;
                   }
                 datosi += datos.charAt(i);
                 System.out.println(datosi);   
                }else{
                   datosi += "</p>";
                   System.out.println("cancela");
                   varconteo = false;
                }
               } 
            } 
                
               
                
                
               
                
            
          
            String nuevotexto = "<p  style=\"display:initial; font-family: ";
            if(fuente.equals("Arial")){
            nuevotexto += "serif;";
            }
            if(fuente.equals("Comic Sans")){
            nuevotexto += "sans-serif;";
            }    
             if(fuente.equals("Default")){
            nuevotexto += ";";
            }    
                  
                 
                      
            
            nuevotexto += "color: ";
            switch(color){
                case "Blanco":
                 nuevotexto += "White;";
                    break;
                    case "Rojo":
                 nuevotexto += "Red;";
                    break;
                    case "Azul":
                 nuevotexto += "Blue;";
                    break;        
            }
            nuevotexto += "font-size: ";
            switch(tamano){
                case "Normal":
                 nuevotexto += "medium;";
                    break;
                case "Grande":
                 nuevotexto += "larger;";
                    break;
                 default:
                 nuevotexto += "small;";
                    break;
            }
            for(int i = 0; i < edicion.length(); i++){
            datos2 += edicion.charAt(i);
            }
             nuevotexto += "\">"+ datos2 +"</p>";
             datos3 += formato1;
             boolean primeravez = true;
            for(int i = poscicion + edicion.length(); i < datos.length(); i++){
                if(primeravez && datos.charAt(i) == '<' && datos.charAt(i + 1) != '/'){
                datos3+="</p>";
                primeravez = false;
                }
                datos3 += datos.charAt(i);
            } 
            out.print(datosi+nuevotexto+datos3);
        }else{
                
            String nuevotexto = "<p style=\"display:initial; font-family: ";
            if(fuente.equals("Arial")){
            nuevotexto += "serif;";
            }
            if(fuente.equals("Comic Sans")){
            nuevotexto += "sans-serif;";
            }    
             if(fuente.equals("Default")){
            nuevotexto += ";";
            }    
                  
                 
                      
            
            nuevotexto += "color: ";
            switch(color){
                case "Blanco":
                 nuevotexto += "White;";
                    break;
                    case "Rojo":
                 nuevotexto += "Red;";
                    break;
                    case "Azul":
                 nuevotexto += "Blue;";
                    break;        
            }
            nuevotexto += "font-size: ";
            switch(tamano){
                case "Normal":
                 nuevotexto += "medium;";
                    break;
                case "Grande":
                 nuevotexto += "larger;";
                    break;
                 default:
                 nuevotexto += "small;";
                    break;
            }
             nuevotexto += "\">"+ datosi +"</p>";    
            out.print(datos + nuevotexto);
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
