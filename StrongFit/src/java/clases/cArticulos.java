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
            articulos+= "<h2>" + objcifrado.sustituye(articulosNom[i],2) +"<h2> <br>";
            articulos+= "por: " + articulosAut[i] + " <br>";
            articulos+= articulosTex[i] + "<br><br>";
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
            articulos+= "</span><input type='text' id='t"+i+"'><button id='botoncoment' onclick=comentar('"+objcifrado.sustituye(articulosNom[i],1)+"',"+i+")>comentar</button><hr>";   
       }
    return articulos;
    }
   public String buscamisarticulos(String idUsr) throws SQLException{
   String articulos = "";
   clases.cCifrado objcifrado = new clases.cCifrado();
   articulos += "<span onClick=cambiaarticulo('nuevoarticuloenblanco')>Nuevo articulo</span><br>";
   cConexion objconexion = new cConexion();
   objconexion.conectar();
   String[] misarticulos = objconexion.buscamisarticulos(idUsr);
   if(misarticulos != null){
   for(int i = 0; i < misarticulos.length;i++){
     articulos += "<span onClick=cambiaarticulo('"+misarticulos[i]+"')>" + objcifrado.sustituye(misarticulos[i],2) + "</span>" + "</br>";
   }
   }else{
   articulos += "<span>Todavia no has escrito ningun articulo</span><br>";
   }
   return articulos;
   }
   public String buscadatos(String idArticulo, int operacion) throws SQLException{
   cConexion objconexion = new cConexion();
   clases.cCifrado objcifrado = new clases.cCifrado();
   String articulo = null;
   if(operacion == 1){
   objconexion.conectar();
   String misarticulos = objconexion.buscamiarticulo(idArticulo);
   articulo = "Nombre:<br><input type=\"text\" id=\"txtnombre\" value = '"+objcifrado.sustituye(idArticulo,2)+"'><br>\n" +
"                 <img src = \"\" class =\"img-usr\" alt = \"foto de usuario\">\n" +
"                <form  enctype=\"multipart/form-data\" id=\"img_frm\" method=\"post\" action=\"../Ssubirimagen.jsp\" name=\"img_frm\">\n" +
"                        <input type = \"file\"  name=\"uploadFile\" id=\"ImgUsuario\" class=\"input-subir\" required/>\n" +
"                        <input type = \"submit\" value=\"cambiar\" class=\"btn-imagen\"/>\n" +
"                </form><br>\n" +
"                Texto:<br><div contenteditable=\"true\" id=\"txtarticulo\">"+misarticulos+"</div><br>\n" +
"                <input type=\"button\" value=\"Enviar\" onclick=escribearticulo('escribe')>";
   }else{
   articulo = "Nombre:<br><input type=\"text\" id=\"txtnombre\" value = ''><br>\n" +
"                 <img src = \"\" class =\"img-usr\" alt = \"foto de usuario\">\n" +
"                <form  enctype=\"multipart/form-data\" id=\"img_frm\" method=\"post\" action=\"../Ssubirimagen.jsp\" name=\"img_frm\">\n" +
"                        <input type = \"file\"  name=\"uploadFile\" id=\"ImgUsuario\" class=\"input-subir\" required/>\n" +
"                        <input type = \"submit\" value=\"cambiar\" class=\"btn-imagen\"/>\n" +
"                </form><br>\n" +
"                Texto:<br><div contenteditable=\"true\" id=\"txtarticulo\"><br></div><br>\n" +
"                <input type=\"button\" value=\"Enviar\" onclick=escribearticulo('escribe')>";
   }
   return articulo;
   }
}
