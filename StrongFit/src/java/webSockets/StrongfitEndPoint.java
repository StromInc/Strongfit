/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webSockets;

import clases.cCifrado;
import clases.cConexion;
import clases.cSesion;
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
     
    private ArrayList<cSesion> listaSesiones = new ArrayList<>();
 
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
                conexiones.remove(session); // se retira de la lista
                session.close(); //se cierra la conexión
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
        System.out.println("###############################################");
        System.out.println(usrS.length());
        System.out.println("###############################################");
        if(usrS.length() < 255){
            ResultSet rs = conecta.spBuscarUsuario(usrS);
            if(rs.next()){
                res = rs.getString("respuesta");
            }
        }
        
        if(res.equals("si")){
            System.out.println("###############################################");
            System.out.println(usrS);
            System.out.println("###############################################");
            int contador = -1;
            cSesion ses = new cSesion();
            for(int i = 0; i < listaSesiones.size(); i++){
                ses = listaSesiones.get(i);
                if(ses.getIdAmigo().equals(usrS)){
                    contador = i;
                    break;
                }
            }
            if(contador > -1){
                cSesion s = listaSesiones.get(contador);
                s.setSesionAmigo(session.getId());
                listaSesiones.set(contador, ses);
            }
            else{
                cSesion s = new cSesion(usrS, session.getId());
                listaSesiones.add(s);
            }
            ResultSet amigos = conecta.spGetAmigos(usrS);
            String amigo = "";
            int conSes = 0;
            
            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            for(Session sesion: conexiones){
                System.out.println(sesion.getId());
            }
            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            System.out.println("");
            
            while(amigos.next()){
                if(amigos.getString("amigo1").equals(usrS)){
                    amigo = amigos.getString("amigo2");
                }
                else{
                    amigo = amigos.getString("amigo1");
                }
                for(int i = 0; i < conexiones.size(); ++i){
                    ResultSet rSes = conecta.spGetConectados(amigo);
                    if(rSes.next()){
                        for(Session conexion: conexiones){
                            if(rSes.getString("sesion").equals(conexion.getId())){
                                RemoteEndpoint.Basic remote = conexion.getBasicRemote();
                                remote.sendText("s3sI0NamIgO9321djzlqoicnzskaak1795edsklvsnd,"+session.getId()+","+mensaje);
                            }
                            conSes++;
                        }
                    }
                }
                conSes = 0;
            }
            
            conecta.spNuevaConexion(usrS, session.getId());
        }
        else{
            String Nuevo[] = mensaje.split(",");
            if(Nuevo.length == 3){
                for(Session sesion : conexiones){
                    if(Nuevo[2].equals(sesion.getId())){
                        System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                        System.out.println("SI ENTRO AL IF");
                        System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                        RemoteEndpoint.Basic remote = sesion.getBasicRemote();
                        String msj = "j34546HRghTWEfs0978ñwEWHgdOIRifiue49854T5T40rdkglndf3" + "," + Nuevo[0];
                        remote.sendText(msj); 
                    }
                }
            }
            else{
                //remitente, destinatario, mensaje, sesion
                //String Nuevo[] = mensaje.split(",");
                conecta.spLeido(seguro.encriptar(Nuevo[1]), seguro.encriptar(Nuevo[0]));
                conecta.spSetMensajes(seguro.encriptar(Nuevo[0]), seguro.encriptar(Nuevo[1]), Nuevo[2]);
                for(Session sesion : conexiones){
                    System.out.println("============================================");
                    System.out.println("ESTA ES LA DE NUEVO: " + Nuevo[3]);
                    System.out.println("ESTA ES LA DE SES: " + sesion.getId());
                    if(Nuevo[3].equals(sesion.getId())){
                        RemoteEndpoint.Basic remote = sesion.getBasicRemote();
                        String msj = Nuevo[0] + "," + Nuevo[2];
                        System.out.println(msj);
                        remote.sendText(msj); 
                    }
                }
            }
        }
    }
    
    
    
    public void registrarUsuario(String idUsr, Session session){
        
    }
    
    //http://www.apuntesdejava.com/2013/05/websockets-en-java-ee-7-jsr-356.html
    
}
