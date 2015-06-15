/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cCifrado;
import clases.cConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
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
@WebServlet(name = "sCrearDieta", urlPatterns = {"/sCrearDieta"})
public class sCrearDieta extends HttpServlet {

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
            String msjError = "";
            
            HttpSession sesion = request.getSession();
            
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            int idDietaEdicion = 0;
                        //nombreDieta = (String)sesion.getAttribute("nombreDieta");
            
            try{
                idDietaEdicion = (Integer)sesion.getAttribute("idDietaEditar");
            }
            catch(NullPointerException e){}
            System.out.print("¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬");
            System.out.print(idDietaEdicion);
            System.out.print("¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬");
            
            String cuantos[] = null;

                String ids[] = null;
                String calorias[] = null;
                String lipidos[] = null;
                String proteinas[] = null;
                String carbohidratos[] = null;
                String consideracion[] = null;
                String porcion[] = null;
                String cantidad[] = null;
                String nom = null;
                
                String idUsr = seguro.encriptar((String)sesion.getAttribute("idUsr"));
                String nomC = seguro.encriptar((String)sesion.getAttribute("nombre"));
                
                try{
                    cuantos = request.getParameter("cuantos").split(",");

                    ids = request.getParameterValues("ids");
                    calorias = request.getParameterValues("calorias");
                    lipidos = request.getParameterValues("lipidos");
                    proteinas = request.getParameterValues("proteinas");
                    carbohidratos = request.getParameterValues("carbohidratos");
                    consideracion = request.getParameterValues("consideracion");
                    porcion = request.getParameterValues("porcion");
                    cantidad = request.getParameterValues("cantidad");
                    nom = request.getParameter("nombreNuevaDieta");
                    
                    sesion.setAttribute("cuantos", cuantos);
                    sesion.setAttribute("ids", ids);
                    sesion.setAttribute("calorias", calorias);
                    sesion.setAttribute("lipidos", lipidos);
                    sesion.setAttribute("proteinas", proteinas);
                    sesion.setAttribute("carbohidratos", carbohidratos);
                    sesion.setAttribute("consideracion", consideracion);
                    sesion.setAttribute("porcion", porcion);
                    sesion.setAttribute("cantidad", cantidad);
                    sesion.setAttribute("nom", nom);
                }
                catch(Exception e){
                    cuantos = (String[])sesion.getAttribute("cuantos");
                    ids = (String[])sesion.getAttribute("ids");
                    calorias = (String[])sesion.getAttribute("calorias");
                    lipidos = (String[])sesion.getAttribute("lipidos");
                    proteinas = (String[])sesion.getAttribute("proteinas");
                    carbohidratos = (String[])sesion.getAttribute("carbohidratos");
                    consideracion = (String[])sesion.getAttribute("consideracion");
                    porcion = (String[])sesion.getAttribute("porcion");
                    cantidad = (String[])sesion.getAttribute("cantidad");
                    nom = (String)sesion.getAttribute("nom");
                }
            
            if(idDietaEdicion == 0){

                cConexion conector = new cConexion();
                conector.conectar();
                
                int tipo = 2;
                int kcal2 = 0;
                int considera = 1;

                float kcal = 0;
                float pro = 0f;
                float car = 0f;
                float lip = 0f;

                DecimalFormat formateador = new DecimalFormat("####.##"); 

                for(int i = 0; i < proteinas.length; ++i){
                    pro += Float.parseFloat(cantidad[i]) * Float.parseFloat(proteinas[i]) / 100;
                    car += Float.parseFloat(cantidad[i]) * Float.parseFloat(carbohidratos[i]) / 100;
                    lip += Float.parseFloat(cantidad[i]) * Float.parseFloat(lipidos[i]) / 100;
                    kcal += Float.parseFloat(cantidad[i]) * Float.parseFloat(calorias[i]) / 100;
                }

                pro = formateador.parse(formateador.format(pro)).floatValue();
                car = formateador.parse(formateador.format(car)).floatValue();
                lip = formateador.parse(formateador.format(lip)).floatValue();
                kcal = formateador.parse(formateador.format(kcal)).floatValue();

                pro = pro / 7;
                car = car / 7;
                lip = lip / 7;
                kcal = kcal / 7;

                pro = formateador.parse(formateador.format(pro)).floatValue();
                car = formateador.parse(formateador.format(car)).floatValue();
                lip = formateador.parse(formateador.format(lip)).floatValue();
                kcal = formateador.parse(formateador.format(kcal)).floatValue();

                kcal2 = (int)kcal;

                //primero se crea la dieta
                int idDieta = 0;
                int idDEdicion = 0;
                try{
                    idDEdicion = (Integer)sesion.getAttribute("idDieta");
                    idDieta = idDEdicion;
                }
                catch(Exception e){}
                
                ResultSet dieta = conector.spSetDieta(idDieta, nom, tipo, kcal2, pro, car, lip, considera, idUsr, nomC);
                if(dieta.next()){
                    idDieta = dieta.getInt("idDietaCreada");
                }

                conector.actualizarDieta(idUsr, idDieta, "no");

                //segundo se crea el dia de la dieta
                int cuantosAlimentos = 0;
                int cuanto = 0;
                int contadorComida = 0;
                int idDia = 0;
                int idComida = 0;

                for(int i = 1; i <= 7; ++i){

                    ResultSet dia = conector.spSetDiaDieta(i, idDieta);
                    if(dia.next()){
                        idDia = dia.getInt("idDiaCreado");
                    }

                    for(int j = 1; j <= 5; ++j){

                        ResultSet comida = conector.spSetComidaDieta(j, idDia);
                        if(comida.next()){
                            idComida = comida.getInt("idComidaCreada");
                        }
                        cuantosAlimentos = Integer.parseInt(cuantos[cuanto]);
                        for(int k = 0; k < cuantosAlimentos; ++k){
                            conector.spInsertarAlimentoComida(Integer.parseInt(ids[contadorComida]), idComida, Integer.parseInt(cantidad[contadorComida]));
                            contadorComida++;
                        }
                        cuanto++;
                    }
                }
                conector.cerrar();
                response.sendRedirect("jsp/nutriologo/dietas_nutriologo.jsp");
            }
            else{
                response.sendRedirect("http://localhost:8080/StrongFit/sBorrarDieta");
            }
        }
//        catch(Exception e){
//            System.out.println("Parece que hubo un error.");
//        }
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
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(sCrearDieta.class.getName()).log(Level.SEVERE, null, ex);
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
