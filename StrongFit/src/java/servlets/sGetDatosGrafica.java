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
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.GregorianCalendar;
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
@WebServlet(name = "sGetDatosGrafica", urlPatterns = {"/sGetDatosGrafica"})
public class sGetDatosGrafica extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            int idPaciente = 0;
            String idP = "";
            
            try{
                cCifrado seguro = new cCifrado();
                seguro.AlgoritmoAES();
                idP = seguro.encriptar(request.getParameter("idPaciente"));
                ResultSet id = conecta.spTraerIdPaciente(idP);
                if(id.next()){
                    idPaciente = id.getInt("idPaciente");
                }
            }
            catch(Exception e){
                idPaciente = (Integer)sesion.getAttribute("idPaciente");
            }
            
            Calendar calendario = new GregorianCalendar();
            
            int cal = 0;
            int por = 0;
            int dia = 0;
            int mes = 0;
            int anio = 0;
            int diaSem = 0;
            try{
                cal = Integer.parseInt(request.getParameter("cal")); //esto representa si se quiere ver por calorias o por proteinas/lipidos/carbohidratos, si es = 1 entonces es por calorias
                por = Integer.parseInt(request.getParameter("por")); //esto dice si es por dia por mes o por año
                dia = Integer.parseInt(request.getParameter("dia"));
                mes = Integer.parseInt(request.getParameter("mes"));
                anio = Integer.parseInt(request.getParameter("anio"));
                diaSem = Integer.parseInt(request.getParameter("diaSem"));
            }
            catch(Exception e){
                Map<String, Object> mapa = new HashMap<>();
                mapa.put("estado", "no");
                write(response, mapa);
            }
            
            DecimalFormat formateador = new DecimalFormat("####.##"); 
            if(por == 1){
                ResultSet rs = conecta.getAlimentosPorFecha(idPaciente, dia, mes, anio);
                //ResultSet calorias = conecta.spGetCaloriasPacienteEspecifico(idPaciente, diaSem);

                float calorias[] = new float[5];
                float proteinas[] = new float[5];
                float lipidos[] = new float[5];
                float carbohidratos[] = new float[5];
                int conteoLugar = 0;
                float calT = 0, proT = 0, lipT = 0, carT = 0;
                
                for(int i = 0; i < calorias.length; ++i){
                    calorias[i] = 0;
                    proteinas[i] = 0;
                    lipidos[i] = 0;
                    carbohidratos[i] = 0;
                }
                
                while(rs.next()){
                    conteoLugar = rs.getInt("tiempo_comida_id") - 1;
                    calorias[conteoLugar] += rs.getFloat("calorias") * rs.getFloat("gramos") / 100;
                    proteinas[conteoLugar] += rs.getFloat("proteinas") * rs.getFloat("gramos") / 100;
                    lipidos[conteoLugar] += rs.getFloat("lipidos") * rs.getFloat("gramos") / 100;
                    carbohidratos[conteoLugar] += rs.getFloat("carbohidratos") * rs.getFloat("gramos") / 100;
                    
                    calorias[conteoLugar] = formateador.parse(formateador.format(calorias[conteoLugar])).floatValue();
                    proteinas[conteoLugar] = formateador.parse(formateador.format(proteinas[conteoLugar])).floatValue();
                    lipidos[conteoLugar] = formateador.parse(formateador.format(lipidos[conteoLugar])).floatValue();
                    carbohidratos[conteoLugar] = formateador.parse(formateador.format(carbohidratos[conteoLugar])).floatValue();
                    
                    calT += rs.getFloat("calorias") * rs.getFloat("gramos") / 100;
                    proT += rs.getFloat("proteinas") * rs.getFloat("gramos") / 100;
                    lipT += rs.getFloat("lipidos") * rs.getFloat("gramos") / 100;
                    carT += rs.getFloat("carbohidratos") * rs.getFloat("gramos") / 100;
                    
                    calT = formateador.parse(formateador.format(calT)).floatValue();
                    proT = formateador.parse(formateador.format(proT)).floatValue();
                    lipT = formateador.parse(formateador.format(lipT)).floatValue();
                    carT = formateador.parse(formateador.format(carT)).floatValue();
                }
                
                conecta.cerrar();
                
                Map<String, Object> mapa = new HashMap<>();
                String comidas[] = {"Desayuno", "Colación 1", "Comida", "Colación 2", "Cena"};
                int contadorC = 0;
                if(cal == 1){
                    String valores[][] = new String[5][2];
                    for(int i = 0; i < 5; ++i){
                        valores[i][0] = comidas[contadorC];
                        valores[i][1] = String.valueOf(calorias[i]);
                        contadorC++;
                    }
                    mapa.put("comidas", valores);
                    mapa.put("quees", 1);
                    mapa.put("estado", "comidahoy");
                    mapa.put("tituloG", "Calorías por comida");
                    if(proT == 0){
                        mapa.put("valorT", "no");
                    }
                    write(response, mapa);
                }
                else 
                    if(cal == 0){
                        String plc [][] = new String[3][2];
                            plc[0][0] = "Proteinas";
                            plc[0][1] = String.valueOf(proT);
                            
                            plc[1][0] = "Lipidos";
                            plc[1][1] = String.valueOf(lipT);
                            
                            plc[2][0] = "Carbohidratos";
                            plc[2][1] = String.valueOf(carT);
 
                        mapa.put("comidas", plc);
                        mapa.put("quees", 0);
                        mapa.put("estado", "comidahoy");
                        mapa.put("tituloG", "Proteinas, Lipidos, Carbohidratos por día");
                        write(response, mapa);
                    }
                    else{
                        mapa.put("estado", "no");
                        write(response, mapa);
                    }
            }
            else
                if(por == 3){
                    float calorias[] = new float[5];
                    float proteinas[] = new float[5];
                    float lipidos[] = new float[5];
                    float carbohidratos[] = new float[5];
                    int conteoLugar = 0;
                    float calT = 0, proT = 0, lipT = 0, carT = 0;
                    
                    ResultSet rs = conecta.spGetAlimentosMes(idPaciente, mes, anio);
                    int contador = 0;
                    while(rs.next()){
                        conteoLugar = rs.getInt("tiempo_comida_id") - 1;
                        calorias[conteoLugar] += rs.getFloat("calorias") * rs.getFloat("gramos") / 100;
                        proteinas[conteoLugar] += rs.getFloat("proteinas") * rs.getFloat("gramos") / 100;
                        lipidos[conteoLugar] += rs.getFloat("lipidos") * rs.getFloat("gramos") / 100;
                        carbohidratos[conteoLugar] += rs.getFloat("carbohidratos") * rs.getFloat("gramos") / 100;

                        calorias[conteoLugar] = formateador.parse(formateador.format(calorias[conteoLugar])).floatValue();
                        proteinas[conteoLugar] = formateador.parse(formateador.format(proteinas[conteoLugar])).floatValue();
                        lipidos[conteoLugar] = formateador.parse(formateador.format(lipidos[conteoLugar])).floatValue();
                        carbohidratos[conteoLugar] = formateador.parse(formateador.format(carbohidratos[conteoLugar])).floatValue();

                        calT += rs.getFloat("calorias") * rs.getFloat("gramos") / 100;
                        proT += rs.getFloat("proteinas") * rs.getFloat("gramos") / 100;
                        lipT += rs.getFloat("lipidos") * rs.getFloat("gramos") / 100;
                        carT += rs.getFloat("carbohidratos") * rs.getFloat("gramos") / 100;

                        calT = formateador.parse(formateador.format(calT)).floatValue();
                        proT = formateador.parse(formateador.format(proT)).floatValue();
                        lipT = formateador.parse(formateador.format(lipT)).floatValue();
                        carT = formateador.parse(formateador.format(carT)).floatValue();
                        
                        contador++;
                    }
                    
                    for(int i = 0; i < 5; i++){
                        calorias[i] = formateador.parse(formateador.format(calorias[i] / contador)).floatValue();
                        proteinas[i] = formateador.parse(formateador.format(proteinas[i] / contador)).floatValue();
                        lipidos[i] = formateador.parse(formateador.format(lipidos[i] / contador)).floatValue();
                        carbohidratos[i] = formateador.parse(formateador.format(carbohidratos[i] / contador)).floatValue();
                    }
                    
                    calT = formateador.parse(formateador.format(calT / contador)).floatValue();
                    proT = formateador.parse(formateador.format(proT / contador)).floatValue();
                    lipT = formateador.parse(formateador.format(lipT / contador)).floatValue();
                    carT = formateador.parse(formateador.format(carT / contador)).floatValue();
                    
                    conecta.cerrar();
                
                    Map<String, Object> mapa = new HashMap<>();
                    String comidas[] = {"Desayuno", "Colación 1", "Comida", "Colación 2", "Cena"};
                    int contadorC = 0;
                    if(cal == 1){
                        String valores[][] = new String[5][2];
                        for(int i = 0; i < 5; ++i){
                            valores[i][0] = comidas[contadorC];
                            valores[i][1] = String.valueOf(calorias[i]);
                            contadorC++;
                        }
                        mapa.put("comidas", valores);
                        mapa.put("quees", 1);
                        mapa.put("estado", "comidahoy");
                        mapa.put("tituloG", "Calorías por comida");
                        if(proT == 0){
                            mapa.put("valorT", "no");
                        }
                        write(response, mapa);
                    }
                    else 
                        if(cal == 0){
                            String plc [][] = new String[3][2];
                                plc[0][0] = "Proteinas";
                                plc[0][1] = String.valueOf(proT);

                                plc[1][0] = "Lipidos";
                                plc[1][1] = String.valueOf(lipT);

                                plc[2][0] = "Carbohidratos";
                                plc[2][1] = String.valueOf(carT);

                            mapa.put("comidas", plc);
                            mapa.put("quees", 0);
                            mapa.put("estado", "comidahoy");
                            mapa.put("tituloG", "Proteinas, Lipidos, Carbohidratos por día");
                            write(response, mapa);
                        }
                        else{
                            mapa.put("estado", "no");
                            write(response, mapa);
                        }
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
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(sGetDatosGrafica.class.getName()).log(Level.SEVERE, null, ex);
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
