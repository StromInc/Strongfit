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
            boolean contador2 = true;
            int contador = 0;
            String datosi = "";
            String datos2 = "";
            String datos3 = "";
            String formato1 = "";
            int poscicion = 0;
            int c1 = 0;
            
            if(seleccionado){
                
            for(int j = 0; j < datos.length();j++){                           
                if(datos.charAt(j) == edicion.charAt(contador)){
                    int nveces = 1;
                for(int k = j + 1;k < datos.length();k++){
                    if(contador2){                   
                        if(datos.charAt(k) != edicion.charAt(contador + nveces)){
                        contador2 = false;
                    }                                    
                    nveces++;
                   
                    if(nveces == edicion.length()){
                    poscicion = k - nveces + 1;
                    contador2 = false;
                 }
                }
                }
                }
                contador2 = true;
                }
                
           
            for(int i = 0; i < datos.length();i++ ){
               
               if(varconteo){
                  
                if(i < poscicion){
                   if(datos.charAt(i) == '<' && datos.charAt(i+1) != '/'){
                   formato = true;
                   }
                   if(formato && c1 == 0){
                       formato1 += datos.charAt(i);
                   }
                   if(datos.charAt(i) == '>'){
                   formato = false;
                   c1++;
                   }
                 datosi += datos.charAt(i);
                  
                }else{
                    
                   datosi += "</p>";
                   
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
             
            for(int i = poscicion + edicion.length(); i < datos.length(); i++){
                
                
                datos3 += datos.charAt(i);
            }
            System.out.println(datosi+" l "+nuevotexto+" l "+datos3+" l "+formato1);
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
             nuevotexto += "\">"+ "&nbsp;" +"</p>";    
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
