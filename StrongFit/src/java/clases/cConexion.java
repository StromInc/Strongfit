package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class cConexion {
    
    private Connection con = null;
    private Statement st;
    
    //Para conectar por default
    public Connection conectar()
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String base, usr, pass;
            base = "jdbc:mysql://localhost/basestrongfit";
            usr = "root";
            pass = "n0m3l0";
            con = DriverManager.getConnection(base, usr, pass);
            System.out.println("Conexión exitosa");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return con;
    }
    
    //Para conectar con nuestros propios datos
    public Connection conectar(String driver, String puerto, String usuario, String pasword)
    {
        try
        {
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(puerto, usuario, pasword);
            System.out.println("Conexion exitosa");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return con;
    }
    
}

