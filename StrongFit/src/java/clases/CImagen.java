/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package clases;
import java.io.File;
/**
 *
 * @author jorge pastrana
 */
public class CImagen {
public int devuelveexistencia(String IdUser, int i){
        int verificacion = 0;
        cConexion objruta = new cConexion();
        String ruta = objruta.ruta(i);
        File file2 = new File(ruta, IdUser + ".jpg");
         File file3 = new File(ruta, IdUser + ".png");
          File file4 = new File(ruta, IdUser + ".gif");         
        if(file2.exists()){
         verificacion = 1;
       }
        if(file3.exists()){
         verificacion = 2;
       }
        if(file4.exists()){
         verificacion = 3;
       }
        
      return verificacion;  
}
public void cambianombreimagen(String iduser, String iduser2, int i){
            cConexion objruta = new cConexion();
            String ruta = objruta.ruta(i);
            File file2 = new File(ruta, iduser + ".jpg");
            File file3 = new File(ruta, iduser + ".png");
            File file4 = new File(ruta, iduser + ".gif");
            File file5 = new File(ruta, iduser2 + ".jpg");
            File file6 = new File(ruta, iduser2 + ".png");
            File file7 = new File(ruta, iduser2 + ".gif");
             if(file2.exists()){
               file2.renameTo(file5);
               }
             if(file3.exists()){
               file3.renameTo(file6);
              }
             if(file4.exists()){
               file4.renameTo(file7);
              }
       }
}
