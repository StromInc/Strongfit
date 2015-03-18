/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;

import java.sql.SQLException;

/**
 *
 * @author jorge pastrana
 */
public class cArticulos {
    public String construirlista(String idusr) throws SQLException{    
        cConexion objconexion = new cConexion();
        objconexion.conectar();
        String[] articulosNom = objconexion.getArticulosNom();
        String[] articulosAut = objconexion.getArticulosAut();
        String[] articulosTex = objconexion.getArticulosTex();
        String articulos = "";
        
        for(int i = articulosNom.length-1; i >= 0 ;i--){
            articulos+= "<h2>" + articulosNom[i] +"<h2> <br>";
            articulos+= "por: " + articulosAut[i] + " <br>";
            articulos+= articulosTex[i] + "<br><br>";
             articulos+= "Comentarios: " + "<hr>";
             articulos+= "<div id='P"+i+"'>";
             String[][] arreglodecomentarios = objconexion.regresacomentarios(articulosNom[i]);
           
            
            if(arreglodecomentarios != null){
             int[] ordendecomentarios = new int[arreglodecomentarios.length];
            int numeroc = 1000000;
            
            int nmayor;
            for(int k = 0; k < arreglodecomentarios.length;k++){
             nmayor = Integer.parseInt(arreglodecomentarios[0][2]);    
            for(int l = 0; l < arreglodecomentarios.length;l++){         
                if(Integer.parseInt(arreglodecomentarios[l][2]) < numeroc){
                    if(Integer.parseInt(arreglodecomentarios[l][2]) > nmayor){
                    nmayor = Integer.parseInt(arreglodecomentarios[l][2]);
                    } 
            }
            }
            ordendecomentarios[k] = nmayor;
            numeroc = nmayor;
            }
            for(int m = ordendecomentarios.length-1 ; m >= 0 ;m--){
            articulos+= arreglodecomentarios[ordendecomentarios[m]][0] + "<br>";
            articulos+= arreglodecomentarios[ordendecomentarios[m]][1] + "<br>";
            articulos+= "<hr>";
            }
            articulos+= "<hr>";
            }else{
            articulos+= "Se el primero en dejar un comentario" + " <hr>"; 
            }
            articulos+= "</div>";
            int estado = objconexion.regresavoto(idusr, articulosNom[i]);
            switch (estado){
                case 0:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                       
                break;
                case 1:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote3.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                        
                break;
                case 2:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+articulosNom[i]+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote4.png'>";                       
                break;                                  
            }
            articulos+= "</span><input type='text' id='t"+i+"'><button id='botoncoment' onclick=comentar('"+articulosNom[i]+"',"+i+")>comentar</button><hr>";   
       }
    return articulos;
    }

    
    
}
