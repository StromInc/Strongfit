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
public class AlimentoAndroid {
    private int alimentoID;
    private String name;
    private String calories;
    private String lipidos;
    private String carbohidratos;
    private String proteinas;
    private int alimentoTipo;
    
    public int getAlimentoID() {
        return alimentoID;
    }

    public String getName() {
        return name;
    }

    public String getCalories() {
        return calories;
    }

    public String getLipidos() {
        return lipidos;
    }

    public String getCarbohidratos() {
        return carbohidratos;
    }

    public String getProteinas() {
        return proteinas;
    }

    public int getAlimentoTipo() {
        return alimentoTipo;
    }

    //Luego van los set

    public void setAlimentoID(int alimentoID) {
        this.alimentoID = alimentoID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCalories(float calories) {
    this.calories = String.valueOf(calories);
    }

    public void setLipidos(float lipidos) {
        this.lipidos = String.valueOf(lipidos);
    }

    public void setCarbohidratos(float carbohidratos) {
        this.carbohidratos = String.valueOf(carbohidratos);
    }

    public void setProteinas(float proteinas) {
        this.proteinas = String.valueOf(proteinas);
    }

    public void setAlimentoTipo(int alimentoTipo) {
        this.alimentoTipo = alimentoTipo;
    }
}
