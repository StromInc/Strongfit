/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webSockets;

import clases.cCifrado;
import clases.cConexion;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Schedule;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 *
 * @author ian
 */
@ServerEndpoint("/endpoint")
public class StrongfitEndPoint {

    static final Logger LOGGER = Logger.getLogger(StrongfitEndPoint.class.getName());
     static final List<Session> conexiones = new ArrayList<>();
 
    @OnOpen
    public void iniciaConexion(Session session) throws SQLException {
        LOGGER.log(Level.INFO, "Iniciando la conexion de {0}");
        conexiones.add(session); //Simplemente, lo agregamos a la lista
    }
 
    @OnClose
    public void finConexion(Session session) {
        LOGGER.info("Terminando la conexion");
        if (conexiones.contains(session)) { // se averigua si está en la colección
            try {
                LOGGER.log(Level.INFO, "Terminando la conexion de {0}", session.getId());
                session.close(); //se cierra la conexión
                conexiones.remove(session); // se retira de la lista
            } catch (IOException ex) {
                LOGGER.log(Level.SEVERE, null, ex);
            }
        }
 
    }
 
    @OnMessage
    public void onMessage(String mensaje, Session session) throws Exception {
        LOGGER.log(Level.INFO, "Que onda mensaje:{0}", mensaje);
        
        cConexion conecta = new cConexion();
        conecta.conectar();
        
        cCifrado seguro = new cCifrado();
        seguro.AlgoritmoAES();
        
        String usrS = seguro.encriptar(mensaje);
        String res = "no";
        ResultSet rs = conecta.spBuscarUsuario(usrS);
        if(rs.next()){
            res = rs.getString("respuesta");
        }
        
        if(res.equals("si")){
            conecta.spNuevaConexion(usrS, session.getId());
        }
        else{
            //remitente, destinatario, mensaje, sesion
            String Nuevo[] = mensaje.split(",");
            for(int i = 0; i < Nuevo.length; i++){
                System.out.println("WHOLOHOLO" + Nuevo[i]);
            }
            for(Session sesion : conexiones){
                System.out.println("============================================");
                System.out.println("ESTA ES LA DE NUEVO: " + Nuevo[3]);
                System.out.println("ESTA ES LA DE SES: " + sesion.getId());
                if(Nuevo[3].equals(sesion.getId())){
                    RemoteEndpoint.Basic remote = sesion.getBasicRemote();
                    remote.sendText(Nuevo[2]);
                    conecta.spSetMensajes("Recibido: " + seguro.encriptar(Nuevo[0]), seguro.encriptar(Nuevo[1]), Nuevo[2]);
                }
            }
        }
    }
    
    
    
    public void registrarUsuario(String idUsr, Session session){
        
    }
    
    //http://www.apuntesdejava.com/2013/05/websockets-en-java-ee-7-jsr-356.html
    
}
