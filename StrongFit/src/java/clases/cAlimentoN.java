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
public class cAlimentoN {
    
    int id;
    String nombre;
    float calorias;
    float proteinas;
    float carbohidratos;
    float lipidos;
    int consideracion;
    float porcion;
    
    //datos que se necesitan sobre los alimentos
    public cAlimentoN(int ids, String nom, float calo, float proteinas, float carbohidratos, float lipidos, int consideracion, float porcion){
        this.id = ids;
        this.nombre = nom;
        this.calorias = calo;
        this.proteinas = proteinas;
        this.carbohidratos = carbohidratos;
        this.lipidos = lipidos;
        this.consideracion = consideracion;
        this.porcion = porcion;
    }
    
}
