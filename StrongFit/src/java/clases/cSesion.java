/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author ian
 */
public class cSesion {
    private String idAmigo;
    private String sesionAmigo;
    
    public cSesion(){
        this.idAmigo = "";
        this.sesionAmigo = "";
    }
    
    public cSesion(String idAmigo, String sesionAmigo){
        this.idAmigo = idAmigo;
        this.sesionAmigo = sesionAmigo;
    }
    
    public void setIdAmigo(String idAmigo){
        this.idAmigo = idAmigo;
    }
    
    public void setSesionAmigo(String sesionAmigo){
        this.sesionAmigo = sesionAmigo;
    }
    
    public String getIdAmigo(){
        return this.idAmigo;
    }
    
    public String getSesionAmigo(){
        return this.sesionAmigo;
    }
}
