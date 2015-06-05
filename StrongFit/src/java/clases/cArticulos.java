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
        cCifrado objcifrado = new cCifrado();
        objconexion.conectar();
        String[] articulosNom = objconexion.getArticulosNom();
        String[] articulosAut = objconexion.getArticulosAut();
        String[] articulosTex = objconexion.getArticulosTex();
        String articulos = "";
        
        for(int i = articulosNom.length-1; i >= 0 ;i--){
            articulos+= "<h2>" + objcifrado.sustituye(articulosNom[i],2) +"</h2> <br>";
            articulos+= "por: " + articulosAut[i] + " <br>";
            for(int j = 0; j < 200;j++){
            articulos+= articulosTex[i].charAt(j);
            if(j == (articulosTex[i].length()-1) ){
            break;
            }
            }
            articulos+="...<br><br>";
             articulos+= "Comentarios: " + "<hr>";
             articulos+= "<div id='P"+i+"'>";
             String[][] arreglodecomentarios = objconexion.regresacomentarios(objcifrado.sustituye(articulosNom[i],1));
           
            
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
            if(m <= 3){
            articulos+= arreglodecomentarios[ordendecomentarios[m]][0] + "<br>";
            articulos+= arreglodecomentarios[ordendecomentarios[m]][1] + "<br>";
            articulos+= "<hr>";
            }
            
            }
            articulos+= "<hr>";
            }else{
            articulos+= "Se el primero en dejar un comentario" + " <hr>"; 
            }
            articulos+= "</div>";
            int estado = objconexion.regresavoto(idusr, articulosNom[i]);
            switch (estado){
                case 0:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                       
                break;
                case 1:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote3.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                        
                break;
                case 2:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote4.png'>";                       
                break;                                  
            }
            articulos+= "</span><input type='text' id='t"+i+"'><button id='botoncoment' onclick=comentar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+",'1')>comentar</button><hr>";
            articulos+="<button id='botonabrir' onclick=abrir('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+")>Seguir leyendo</button>";
       }
    return articulos;
    }
   public String buscamisarticulos(String idUsr) throws SQLException{
   String articulos = "";
   clases.cCifrado objcifrado = new clases.cCifrado();
   articulos += "<span onClick=cambiaarticulo('nuevoarticuloenblanco') class='Article-articulosh'>Nuevo articulo</span><br>";
   cConexion objconexion = new cConexion();
   objconexion.conectar();
   String[] misarticulos = objconexion.buscamisarticulos(idUsr);
   if(misarticulos != null){
   for(int i = 0; i < misarticulos.length;i++){    
     
     articulos += "<span onClick=cambiaarticulo('"+misarticulos[i]+"') class='Article-articulosh'>" + objcifrado.sustituye(misarticulos[i],2) + "</span>" + "</br>";
     
   }
   }else{
   articulos += "<span>Todavia no has escrito ningun articulo</span><br>";
   }
   return articulos;
   }
   public String buscadatos(String idArticulo, int operacion) throws SQLException{
   cConexion objconexion = new cConexion();
   clases.cCifrado objcifrado = new clases.cCifrado();
   clases.CImagen objimg = new clases.CImagen();
   int verificacionimg = objimg.devuelveexistencia(idArticulo,2);
                String ruta = "";
                String ruta2 = "../../Imagenes/Articulos/";
                switch(verificacionimg){
                    case 1: 
                        ruta = ruta2 + idArticulo + ".jpg";
                        break;
                    case 2: 
                        ruta = ruta2 + idArticulo + ".png";
                        break;
                    case 3: 
                        ruta = ruta2 + idArticulo + ".gif";
                        break;
                    default: 
                        ruta = "../../Imagenes/usr_sin_imagen.jpg";
                        break;
              }
   String articulo = null;
   if(operacion == 1){
   objconexion.conectar();
   String misarticulos = objconexion.buscamiarticulo(idArticulo);
   articulo = "Nombre:<br><input type=\"text\" id=\"txtnombre\" value = '"+objcifrado.sustituye(idArticulo,2)+"'><br>\n" +
"                 <img src = \""+ruta+"\" class =\"img-usr\" alt = \"foto de usuario\">\n"+
"                Texto:<br><div contenteditable=\"true\" id=\"txtarticulo\" class=\"Article-articulosf\">"+misarticulos+"</div><br>\n" +
"                <input type=\"button\" value=\"Enviar\" onclick=escribearticulo('escribe') class=\"botonenviar\">";
   }else{
   articulo = "Nombre:<br><input type=\"text\" id=\"txtnombre\" value = ''><br>\n" +
"                 <img src = \""+ruta+"\" class =\"img-usr\" alt = \"foto de usuario\">\n" +
"                Texto:<br><div contenteditable=\"true\" id=\"txtarticulo\" class=\"Article-articulosf\"><br></div><br>\n" +
"                <input type=\"button\" value=\"Enviar\" onclick=escribearticulo('escribe') class=\"botonenviar\">";
   }
   return articulo;
   }
   public String construirdiv(String idusr, String idArt, int i) throws SQLException{    
        cConexion objconexion = new cConexion();
        cCifrado objcifrado = new cCifrado();
        objconexion.conectar();
        String[] articulosAut = objconexion.buscadatosdemiarticulo(idArt);
        
        String articulos = "<span id='articulo' class='Article-articulosc'>";
        
        
            articulos+= "<h2>" + idArt +"</h2><hr> <br>";
            articulos+= "por: " + articulosAut[2] + " <br>";
            
            articulos+= articulosAut[1];
            
            articulos+= "</span>";
            articulos+="<span id='Ps'  class='Article-articulosd'>";
             articulos+= "Comentarios:<hr>";
             
             String[][] arreglodecomentarios = objconexion.regresacomentarios(idArt);
           
            
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
            articulos+= "</span><span class='icon-cancel-circle' style='left:82%;position:fixed;color:red;' onClick=cerrar()></span><span id='acciones' class='Article-articulose'>";
            int estado = objconexion.regresavoto(idusr, idArt);
            switch (estado){
                case 0:
                        articulos+= "<span id='us' onclick=votar('"+idArt+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='ds' onclick=votar('"+idArt+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                       
                break;
                case 1:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+idArt+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote3.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+idArt+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote2.png'>";                        
                break;
                case 2:
                        articulos+= "<span id='u"+i+"' onclick=votar('"+idArt+"',"+i+",1)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote.png'></span>";
                        articulos+= "<span id='d"+i+"' onclick=votar('"+idArt+"',"+i+",0)>";
                        articulos+= "<img src='../../Imagenes/Iconos/sticky-vote4.png'>";                       
                break;                                  
            }
            articulos+= "</span><input type='text' id='ts'><button id='botoncoment' onclick=comentar('"+idArt+"',"+i+",'s')>comentar</button></span>";
            
       
    return articulos;
}
}
