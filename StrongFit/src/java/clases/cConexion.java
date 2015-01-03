package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


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
    //Esto da de alta a el paciente y la direccion
    //Esta sera una variable de sesion 
    public int altapaciente(String idUser)throws SQLException
    {
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call sp_AltaPaciente('"+idUser+"');");
        int idConteo = 0;
        if(rs.next()){
            idConteo = rs.getInt("idConteo");
        }
        return idConteo;
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
    //Esto verifica la posible existencia de un nuevo correo
    public String cambiarcorreo(String idUser) throws SQLException{
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("select * from usuario where usuario.idUsuario = '"+idUser+"';");
        String existente = "libre";
        if(resultado.isLast()){
             existente = "existente";
        }
        return existente;
    }
    //Esto recupera los valores en el login
    
    //cambia los datos del usuario si tiene el mismo correo(id)
    public void cambioUsuario(String idUser, String nombre, String pass , String peso, String estatura, String cintura, String edad, String sexo, String estado, String municipio, String colonia) throws SQLException
    {
        this.st = con.createStatement();
        int peso1 = Integer.parseInt(peso);
        int estatura1 = Integer.parseInt(estatura);
        int cintura1 = Integer.parseInt(cintura);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioPaciente('"+idUser+"','"+pass+"','"+nombre+"', "+peso1+" , "+estatura1+" , "+cintura1+" , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"');");
    }
    // Esto cambia los datos de l usuario si este camia su correo
    public void cambioUsuarioConCorreo(String idUser, String nombre, String pass , String peso, String estatura, String cintura, String edad, String sexo, String estado, String municipio, String colonia, String correo) throws SQLException
    {
        this.st = con.createStatement();
        int peso1 = Integer.parseInt(peso);
        int estatura1 = Integer.parseInt(estatura);
        int cintura1 = Integer.parseInt(cintura);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioPacienteConCorreo('"+idUser+"','"+pass+"','"+nombre+"', "+peso1+" , "+estatura1+" , "+cintura1+" , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"','"+correo+"');");
    }
    //Esto identifica al usuario como paciente o como nutriologo
    public String determinarusuario(String idUser)throws SQLException{
        String validacion = "doctor";
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("call sp_DeterminarUsuario("+idUser+")");
        if(resultado.isLast()){
        validacion = "paciente";
        }
        return validacion;
    }
    //Esto da de alta a los medicos
    public void altamedico(String idUser, String cedula, String escuela, String estado, String municipio, String colonia, String sexo, String edad, String carrera) throws SQLException
    {
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st = con.createStatement();
        this.st.executeQuery("call sp_AltaMedico('"+idUser+"',"+cedula1+",'"+escuela+"','"+estado+"','"+municipio+"','"+colonia+"','"+sexo+"',"+edad1+",'"+carrera+"');");
    }
    //cambia los datos del medico si tiene el mismo correo(id)
    public void cambioUsuariomedico(String idUser, String nombre, String pass , String cedula, String escuela, String carrera, String edad, String sexo, String estado, String municipio, String colonia) throws SQLException
    {
        this.st = con.createStatement();
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioMedico('"+idUser+"','"+pass+"','"+nombre+"', "+cedula1+" , '"+escuela+"' , '"+carrera+"' , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"');");
    }
    //Cambia los datos del medico incluyendo el correo
    public void cambioUsuariomedicoConCorreo(String idUser, String nombre, String pass , String cedula, String escuela, String carrera, String edad, String sexo, String estado, String municipio, String colonia, String correo) throws SQLException
    {
        this.st = con.createStatement();
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioMedicoConCorreo('"+idUser+"','"+pass+"','"+nombre+"', "+cedula1+" , '"+escuela+"' , '"+carrera+"' , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"','"+correo+"');");
    }
    //Esto identifica al usuario como medico o paciente
    public String tipodeusuario(String idUsr)throws SQLException{
        ResultSet resultado;
        String valor = "";
        this.st = con.createStatement();
        resultado = this.st.executeQuery("call sp_TipoDeUsuario('"+idUsr+"');");
        if(resultado.next()){
            valor = resultado.getString("tipo");
        }
        return valor;
    }
    // Esto carga los datos del paciente
    public ResultSet cargadedatos(String idUsr,String tipo)throws SQLException
    {
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("call sp_cargadedatosespecificos('"+idUsr+"', '"+tipo+"');");
        return resultado;
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
    //Esto busca los alimentos y los agrega a un Array 
    public ArrayList<cAlimento> buscar(String info) throws SQLException{
        int id;
        float calorias;
        String nombre;
        ArrayList<cAlimento> lista = new ArrayList();
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spBuscarAlimento('"+info+"');");
        while(rs.next()){
            System.out.print("***************Entro al while************************");
            id = Integer.parseInt(rs.getString("idAlimento"));
            nombre = rs.getString("nombre");
            calorias = Float.parseFloat(rs.getString("calorias"));
            lista.add(new cAlimento(id, nombre, calorias));
        }
        System.out.print("Tamaño " + lista.size());
        return lista;
    }
    //Esto agrega las calorias al conteo calorico
    public void agregarAlimento(String id, String idCont) throws SQLException {
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("select calorias from alimento where idAlimento ="+id+";");
        float calo = 0;
        float calTotal = 0;
        if(rs.next()){
            calo = rs.getFloat("calorias");    
        }
        System.out.print("las calorias " + calo);
        //Obtiene las calorias guardadas en la base
        ResultSet rs2 = this.st.executeQuery("select caloriasDia from conteocalorico where idConteo ="+idCont+";");
        if(rs2.next()){
            calTotal = rs2.getFloat("caloriasDia");
        }
        //Se suma las calorias del alimento mas las del conteo calorico
        calTotal +=calo;
        this.st.executeUpdate("update conteocalorico set caloriasDia = "+calTotal+" where idConteo = "+idCont+";");
        System.out.print("Calorias totales " + calTotal);
    }
}

