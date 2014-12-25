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
    String label;
    float calorias;
    public cAlimento(int ids, String nom, float calo){
        this.id = ids;
        this.label = nom;
        this.calorias = calo;
    }
}
