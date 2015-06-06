/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import clases.cCifrado;
import clases.cConexion;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
@WebServlet(name = "sMostrarDieta", urlPatterns = {"/sMostrarDieta"})
public class sMostrarDieta extends HttpServlet {

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
            cCifrado seguro = new cCifrado();
            seguro.AlgoritmoAES();
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            String usrid = seguro.encriptar((String)sesion.getAttribute("idUsr"));
            
            int idDieta = Integer.parseInt(request.getParameter("idDietaMostrar"));
            
            ArrayList<String> nombres = new ArrayList<>();
            ArrayList<Integer> cantidades = new ArrayList<>();
            
            int cuantos[] = new int[35];
            
            float proteinas = 0;
            float lipidos = 0;
            float carbohidratos = 0;
            int cantidad = 0;
            float calorias = 0;
            int contador = 0;
            int conComida = 0;
            String nombreA = "";
            /*var caloriasDia = [];
                var caloriasPromedio = 0;
                var proteinas = [], proPorciento = [];
                var lipidos = [], lipPorciento = [];
                var carbohidratos = [], carPorciento = [];*/
            
            int contadorDiasE = 0, contadorComidaE = 0;
            int comidasE[][] = new int[7][5];

            float caloriasDia[] = new float[7];
            float proteinasD[] = new float[7];
            float lipidosD[] = new float[7];
            float carbohidratosD[] = new float[7];
            
            DecimalFormat formateador = new DecimalFormat("####.##"); 
            
            ResultSet diasEdicion = conecta.spGetDiaDieta(idDieta);
            while(diasEdicion.next()){
                ResultSet comidas = conecta.spGetComidaDia(diasEdicion.getInt("idDia"));
                while(comidas.next()){
                    comidasE[contadorDiasE][contadorComidaE] = comidas.getInt("idComidas");
                    ResultSet comdia = conecta.spGetAlimentoComida(comidasE[contadorDiasE][contadorComidaE]);
                        while(comdia.next()){
                            calorias = comdia.getFloat("calorias");
                            lipidos = comdia.getFloat("lipidos");
                            proteinas = comdia.getFloat("proteinas");
                            carbohidratos = comdia.getFloat("carbohidratos");
                            cantidad = comdia.getInt("cantidad");
                            nombreA = comdia.getString("nombre");

                            caloriasDia[contadorDiasE] += calorias * cantidad / 100;
                            proteinasD[contadorDiasE] += proteinas * cantidad / 100;
                            lipidosD[contadorDiasE] += lipidos * cantidad / 100;
                            carbohidratosD[contadorDiasE] += carbohidratos * cantidad / 100;
                            
                            caloriasDia[contadorDiasE] = formateador.parse(formateador.format(caloriasDia[contadorDiasE])).floatValue();
                            proteinasD[contadorDiasE] = formateador.parse(formateador.format(proteinasD[contadorDiasE])).floatValue();
                            lipidosD[contadorDiasE] = formateador.parse(formateador.format(lipidosD[contadorDiasE])).floatValue();
                            carbohidratosD[contadorDiasE] = formateador.parse(formateador.format(carbohidratosD[contadorDiasE])).floatValue();
                            
                            nombres.add(nombreA);
                            cantidades.add(cantidad);
                            
                            contador++;
                        }
                    cuantos[conComida] = contador;
                    conComida++;
                    contadorComidaE++;
                    contador = 0;
                }
                contadorComidaE = 0;
                contadorDiasE++;
            }
            Map<String, Object> map = new HashMap();
            map.put("caloriasM", caloriasDia);
            map.put("proteinasM", proteinasD);
            map.put("lipidosM", lipidosD);
            map.put("carbohidratosM", carbohidratosD);
            map.put("nombresM", nombres);
            map.put("cantidadesM", cantidades);
            map.put("cuantosM", cuantos);
            
            write(response, map);
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
            Logger.getLogger(sMostrarDieta.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sMostrarDieta.class.getName()).log(Level.SEVERE, null, ex);
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

    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException 
    {
        response.setContentType("aplication/json");
        response.setCharacterEncoding("charset=UTF-8");
        response.getWriter().write(new Gson().toJson(map));
    }
}
