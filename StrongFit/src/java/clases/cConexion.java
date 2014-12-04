package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class cConexion {
    
    private Connection con = null;
    private Statement st;
    private String dominio = "";
    
    //Para conectar por default
    public Connection conectar()
    {
        dominio = "http://localhost:8080/StrongFit/";
        try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String base, usr, pass;
            base = "jdbc:mysql://127.0.0.1/basestrongfit";
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
        catch(ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e)
        {
            e.printStackTrace();
        }
        return con;
    }
    
    public String getDominio()
    {
        return dominio;
    }
    //Esto da de alta los primeros 3 campos de los nuevos usuarios
    public String altausuario(String idUser, String pass, String nombre) throws SQLException
    {
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("call sp_AltaUsuario('"+idUser+"','"+pass+"' ,'"+nombre+"');");
        String validacion = "";
        if(resultado.next()){
        validacion = resultado.getString("nombre");
        }     
        return validacion;
    }
    //Esto sirve para buscar y validar usuarios
    public String busquedadeusuarios(String idUser, String pass) throws SQLException{
       this.st = con.createStatement();
       ResultSet resultado = this.st.executeQuery("call sp_Login('"+idUser+"','"+pass+"');");
       String existente = "";
       if(resultado.next()){
       existente = resultado.getString("valido");
       }
       return existente;
    }
    
    //Esto actualizara la dieta en la parte de dietas paciente
    public ResultSet actualizarDieta(int idUser, int idDietas, String quitar) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spActualizarDieta("+idUser+", "+idDietas+", '"+quitar+"');");
    }
    
    //Esto traera las dietas de tipo 1, es decir sugeridas por la aplicacion que el usuario no este usando
    public ResultSet getDietasSugeridas(int calorias) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetDietasSugeridas("+calorias+");");
    }
    
    //Esto traera las dietas que el usuario este usando
    public ResultSet getDietasRegistradas(int idUser) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetDietasRegistradas("+idUser+");");
    }
    
}

