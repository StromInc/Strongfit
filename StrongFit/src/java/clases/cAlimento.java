/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author USER
 */
public class cAlimento {
    int id;
    String nombre;
    float calorias;
    int tiempo_comida;
    
    //datos que se necesitan sobre los alimentos
    public cAlimento(int ids, String nom, float calo){
        this.id = ids;
        this.nombre = nom;
        this.calorias = calo;
    }
    public cAlimento(){
        
    }
    //En este caso manejo el id como el id de la fecha
    public void setID(int id){
        this.id = id;
    }
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    public void setCalorias(float calorias){
        this.calorias = calorias;
    }
    public void setTiempoComida(int tiempo_comida){
        this.tiempo_comida = tiempo_comida;
    }
}
