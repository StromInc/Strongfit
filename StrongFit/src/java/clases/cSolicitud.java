/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

/**
 *
 * @author Alumno
 */
public class cSolicitud {
    
    private String nombre;
    private String correo;
    private String imagen;
    private String sesion;
    private String tipo;
    private int contador;
    
    public cSolicitud(String nombre, String correo, String imagen, String sesion, String tipo, int contador){
        this.nombre = nombre;
        this.correo = correo;
        this.imagen = imagen;
        this.sesion = sesion;
        this.tipo = tipo;
        this.contador = contador;
    }
    
}
