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
    private String direccionWS = "";
    
    //Para conectar por default
    public Connection conectar()
    {
        dominio = "http://localhost:8080/StrongFit/";
        direccionWS = "ws://192.168.1.202:8080/StrongFit/endpoint";
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
    public void cerrar() throws SQLException{
        con.close();
        con = null;
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
    
    public String getWS(){
        return direccionWS;
    }
    //Esto da de alta los primeros 3 campos de los nuevos usuarios
    public String altausuario(String idUser, String pass, String nombre, String nom) throws SQLException
    {
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("call sp_AltaUsuario('"+idUser+"','"+pass+"' ,'"+nombre+"', '"+nom+"');");
        String validacion = "";
        if(resultado.next()){
            validacion = resultado.getString("nombre");
        }     
        return validacion;
    }
    //Esto da de alta a el paciente y la direccion
    //Esta sera una variable de sesion 
    public ResultSet altapaciente(String idUser)throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call sp_AltaPaciente('"+idUser+"');");
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
        if(resultado.next()){
             existente = "existente";
        }
        return existente;
    }
    //Esto recupera los valores en el login
    
    //cambia los datos del usuario si tiene el mismo correo(id)
    public void cambioUsuario(String idUser, String nombre, String pass , String peso, String estatura, String cintura, String edad, int sexo, int idSalud, String estado, String municipio, String colonia, int idPa, String nom2) throws SQLException
    {
     this.st = con.createStatement();
     int peso1 = Integer.parseInt(peso);
     int estatura1 = Integer.parseInt(estatura);
     int cintura1 = Integer.parseInt(cintura);
     int edad1 = Integer.parseInt(edad);
     this.st.executeQuery("call sp_CambioUsuarioPaciente('"+idUser+"','"+pass+"','"+nombre+"', "+peso1+" , "+estatura1+" , "+cintura1+" , "+edad1+" ,"+sexo+", "+idSalud+",'"+estado+"','"+municipio+"' ,'"+colonia+"', "+idPa+", '"+nom2+"');");
    }
    // Esto cambia los datos de l usuario si este camia su correo
    public void cambioUsuarioConCorreo(String idUser, String nombre, String pass , String peso, String estatura, String cintura, String edad, int sexo, String estado, String municipio, String colonia, String correo, int idSalud, int idPa, String nom2) throws SQLException
    {
     this.st = con.createStatement();
     int peso1 = Integer.parseInt(peso);
     int estatura1 = Integer.parseInt(estatura);
     int cintura1 = Integer.parseInt(cintura);
     int edad1 = Integer.parseInt(edad);
     if(!idUser.equals(correo)){
     this.st.executeQuery("call sp_CambioUsuarioPacienteConCorreo('"+idUser+"','"+pass+"','"+nombre+"', "+peso1+" , "+estatura1+" , "+cintura1+" , "+edad1+" ,"+sexo+",'"+estado+"','"+municipio+"' ,'"+colonia+"','"+correo+"', "+idSalud+", "+idPa+", '"+nom2+"');");
     }
     }
    
    //Esto agregara o quitara las calorias de un usuario
    public ResultSet modificarCalorias(int idUser, int cal, int dia, int hrs, int actividad, int ocupacion) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetCaloriasUsuario('"+idUser+"', "+cal+" , "+dia+" ,"+hrs+", "+actividad+", "+ocupacion+");");
    }
    
    //Esto identifica al usuario como paciente o como nutriologo
    public String determinarusuario(int idUser)throws SQLException{
        String validacion = "doctor";
        this.st = con.createStatement();
        ResultSet resultado = this.st.executeQuery("call sp_DeterminarUsuario("+idUser+")");
        if(resultado.isLast()){
        validacion = "paciente";
        }
        return validacion;
    }
    //Esto da de alta a los medicos
    public ResultSet altamedico(String idUser, String cedula, String escuela, String estado, String municipio, String colonia, int sexo, String edad, String carrera) throws SQLException
    {
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st = con.createStatement();
        return this.st.executeQuery("call sp_AltaMedico('"+idUser+"',"+cedula1+",'"+escuela+"','"+estado+"','"+municipio+"','"+colonia+"','"+sexo+"',"+edad1+",'"+carrera+"');");
    }
    //cambia los datos del medico si tiene el mismo correo(id)
    public void cambioUsuariomedico(String idUser, String nombre, String pass , String cedula, String escuela, String carrera, String edad, int sexo, String estado, String municipio, String colonia, int idMe,String nom2) throws SQLException
    {
        this.st = con.createStatement();
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioMedico('"+idUser+"','"+pass+"','"+nombre+"', "+cedula1+" , '"+escuela+"' , '"+carrera+"' , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"', "+idMe+", '"+nom2+"');");
    }
    //Cambia los datos del medico incluyendo el correo
    public void cambioUsuariomedicoConCorreo(String idUser, String nombre, String pass , String cedula, String escuela, String carrera, String edad, int sexo, String estado, String municipio, String colonia, String correo, int idMe,String nom2) throws SQLException
    {
        this.st = con.createStatement();
        int cedula1 = Integer.parseInt(cedula);
        int edad1 = Integer.parseInt(edad);
        this.st.executeQuery("call sp_CambioUsuarioMedicoConCorreo('"+idUser+"','"+pass+"','"+nombre+"', "+cedula1+" , '"+escuela+"' , '"+carrera+"' , "+edad1+" ,'"+sexo+"','"+estado+"','"+municipio+"' ,'"+colonia+"','"+correo+"', "+idMe+", '"+nom2+"');");
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
    public ResultSet actualizarDieta(String idUser, int idDietas, String quitar) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spActualizarDieta('"+idUser+"', "+idDietas+", '"+quitar+"');");
    }
    
    //Esto traera las dietas de tipo 1, es decir sugeridas por la aplicacion que el usuario no este usando
    public ResultSet getDietasSugeridas(int calorias) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetDietasSugeridas("+calorias+");");
    }
    
    //Esto traera las dietas que el usuario este usando
    public ResultSet getDietasRegistradas(String idUser) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetDietasRegistradas('"+idUser+"');");
    }
    
    //Esto trae las actividades deportivas disponibles en la base
    public ResultSet getActividades() throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetActividades();");
    }
    
    //Esto trae el factor de activadad de la actividad seleccionada
    public ResultSet getActividadEspecifica(int Actividad) throws SQLException
    {
        System.out.println("Este es el idActividad: " + Actividad);
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetActividadEspecifica("+Actividad+");");
    }
    
    //Esto trae el factor de activadad de la actividad seleccionada
    public ResultSet getOcupacionEspecifica(int Ocupacion) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetOcupacionEspecifica("+Ocupacion+");");
    }
    
    //Esto trae el factor de activadad de la actividad seleccionada
    public ResultSet getOcupacion() throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetOcupacion();");
    }
    
    //Hace una consulta al catalogo estado de salud
    public ResultSet spGetInfoEstado(int estado) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetInfoEstado("+estado+");");
    }
    
    //Esto traera la tabla de calorias paciente
    public ResultSet spGetCaloriasPaciente(int idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetCaloriasPaciente('"+idUsr+"');");
    }
    
    //Esto traera la tabla de calorias paciente
    public ResultSet spGetCaloriasPacienteEspecifico(int idUsr, int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetCaloriasPacienteEspecifico("+idUsr+", "+dia+");");
    }
    
    //Esto traera cuantas calorias que ha consumido el paciente en el dia
    public ResultSet spGetConteo(int idConteo) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetConteo("+idConteo+");");
    }
    
    //Esto registrara los alimentos consumidos en un cierto dia
    public ResultSet spSetAlimentoConsumido(int Paciente, int alimento, int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetAlimentoConsumido("+Paciente+", "+alimento+", "+dia+");");
    }
    
    //Esto le llevara al administrador
    public ResultSet spGetSolicitudes() throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetSolicitudes();");
    }
    
    //Esto confirmara al medico como registrado
    public ResultSet spConfirmarMedico(String idMedico) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spConfirmarMedico('"+idMedico+"');");
    }
    
    //Esto rechaza al medico como registrado
    public ResultSet spRechazarMedico(String idMedico) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spRechazarMedico('"+idMedico+"');");
    }
    
    //Esto  agrega que alimento a consumido al dia
    public ResultSet spRegistraAlimentoDiario(int idPaciente, int idAlimento, int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spRegistraAlimentoDiario("+idPaciente+","+idAlimento+","+dia+");");
    }
    
    //Esto borra un alimento que este en un dia que no es el actual
    public ResultSet spBorrarAlimentos(int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spBorrarAlimentos("+dia+");");
    }
    
    //Esto consulta todos los alimento que el usuario haya consumido en el dia
    public ResultSet spConsultarAlimentosDiarios(int idPaciente, int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spConsultarAlimentosDiarios("+idPaciente+", "+dia+");");
    }
    
    //Esto cambia el conteocalorico del usuario
    public ResultSet spSetCalorias(int idC, int diaA, int mesA, int semA, int cDia, int cMes, int cSem) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetCalorias("+idC+", "+diaA+", "+mesA+", "+semA+", "+cDia+", "+cMes+", "+cSem+");");
    }
    
    
    //Esto registra o cambia el usuario en el chat
    public ResultSet spNuevaConexion(String idUsr, String idCon) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spNuevaConexion('"+idUsr+"', '"+idCon+"');");
    }
 
    //Busca el usuario
    public ResultSet spBuscarUsuario(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spBuscarUsuario('"+idUsr+"');");
    }
    
    //Registra el mensaje
    public ResultSet spSetMensajes(String idUsr, String idRemi, String msj) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetMensajes('"+idUsr+"', '"+idRemi+"', '"+msj+"');");
    }
    
    //spGetRelUsr
    public ResultSet spGetRelUsr(String idUsr, String idOtro) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetRelUsr('"+idUsr+"', '"+idOtro+"');");
    }
    
    public ResultSet spGetConectadosGeneral() throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetConectadosGeneral();");
    }
    
    public ResultSet spSetDesconexion(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetDesconexion('"+idUsr+"');");
    }
    
    //este metodo retorna la sesion propia del usuario
    public ResultSet spGetSesion(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetSesion('"+idUsr+"');");
    }
    
    public ArrayList<cUsuarioChat> spBuscarUsuarioChat(String busca) throws SQLException, Exception
    {
        cCifrado seguro = new cCifrado();
        seguro.iniciarBuscador();
        seguro.AlgoritmoAES();
        busca = seguro.cifrarBuscador(busca);
        System.out.println("VALOR DE BUSCA:"+busca);
        ArrayList<cUsuarioChat> lista = new ArrayList<>();
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spBuscarUsuarioChat('"+busca+"');");
        
        String nombre = "";
        String correo = "";
        while(rs.next()){
            nombre = seguro.desencriptar(rs.getString("nombre"));
            correo = seguro.desencriptar(rs.getString("idUsuario"));
            System.out.println(nombre);
            System.out.println(correo);
            lista.add(new cUsuarioChat(nombre, correo));
        }
        return lista;
    }
            
    //Busca usuarios
    public ResultSet spGetConectados(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetConectados('"+idUsr+"');");
    }
    
    //esto retorna, toda la informacion del usuario al que seleccionemos, lo usamos en la parte del chat
    public ResultSet spGetInfoUsuario(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetInfoUsuario('"+idUsr+"');");
    }
    
    //envia una solicitud de amistad de un usuario a otro
    public ResultSet spSolicitudAmistad(String idUsr, String idOtro) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSolicitudAmistad('"+idUsr+"', '"+idOtro+"');");
    }
    
    //Trae todos los datos de dos usuarios que tienen activa una solicitud de amistad
    public ResultSet spSeleccionarAmistad(String idUsr, String idOtro) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSeleccionarAmistad('"+idUsr+"', '"+idOtro+"');");
    }
    
    //Trae todas las solicitudes del usuario, tanto enviadas como recividas
    public ResultSet spSeleccionarSolicitudes(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSeleccionarSolicitudes('"+idUsr+"');");
    }
    
    //trae a todos tus amigos y su estatus
    public ResultSet spGetAmigos(String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetAmigos('"+idUsr+"');");
    }
    
    //Acepta o rechaza la solicitud de amistad, depende del valor de acepta, 1 es si, 2 es no
    public ResultSet spAceptaSolicitud(String idUsr, String idOtro, int acepta, int idAmigo) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spAceptaSolicitud('"+idUsr+"', '"+idOtro+"', "+acepta+", "+idAmigo+");");
    }
    
    //Con esto se crea una nueva dieta
    public ResultSet spSetDieta(int idD, String nom, int tipo, int kcal, float pro, float car, float lip, int considera, String idCreador, String nomC) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetDieta("+idD+", '"+nom+"', "+tipo+", "+kcal+", "+pro+", "+car+", "+lip+", "+considera+", '"+idCreador+"', '"+nomC+"');");
    }
    
    //Esto es para crear un dia de la dieta
    public ResultSet spSetDiaDieta(int catDia, int idDieta) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetDiaDieta("+catDia+", "+idDieta+");");
    }
    
    //Esto es para crear una comida de cada dia
    public ResultSet spSetComidaDieta(int tiempoComid, int dia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spSetComidaDieta("+tiempoComid+", "+dia+");");
    }
    
    //Esto es para crear una comida de cada dia
    public ResultSet spInsertarAlimentoComida(int idAlimen, int idComi, int cant) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spInsertarAlimentoComida("+idAlimen+", "+idComi+", "+cant+");");
    }
    
    //Esto borrara la dieta despues de verificar su pertenencia 
    public ResultSet spBorrarDieta(int dieta, String idUsr) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spBorrarDieta("+dieta+", '"+idUsr+"');");
    }
    
    //Esto borrara el dia despues de verificar su pertenencia 
    public ResultSet spBorrarDia(int idDia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spBorrarDia("+idDia+");");
    }
    
    //Esto borrara la comida despues de verificar su pertenencia 
    public ResultSet spBorrarComida(int idComi, int idDiet) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spBorrarComida("+idComi+", "+idDiet+");");
    }
    
    //Esto borrara el dia despues de verificar su pertenencia 
    public ResultSet spGetDiaDieta(int idDiet) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetDiaDieta("+idDiet+");");
    }
    
    //Esto borrara el dia despues de verificar su pertenencia 
    public ResultSet spGetComidaDia(int idDia) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetComidaDia("+idDia+");");
    }
    
    //Esto borrara el dia despues de verificar su pertenencia 
    public ResultSet spGetAlimentoComida(int idCom) throws SQLException
    {
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetAlimentoComida("+idCom+");");
    }
            
    //Esto busca los alimentos y los agrega a un Array 
    public ArrayList<cAlimento> buscarAlimento(String info) throws SQLException{
        int id;
        float calorias;
        String nombre;
        ArrayList<cAlimento> lista = new ArrayList();
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spBuscarAlimento('"+info+"');");
        while(rs.next()){
            id = Integer.parseInt(rs.getString("idAlimento"));
            nombre = rs.getString("nombre");
            calorias = Float.parseFloat(rs.getString("calorias"));
            lista.add(new cAlimento(id, nombre, calorias));
        }
        System.out.print("Tamaño " + lista.size());
        return lista;
    }
    
    //trae todas las propiedades de los alimentos
    public ResultSet spGetAlimentoNutriologo(String nomAlimento)throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetAlimentoNutriologo('"+nomAlimento+"');");
    }
    
    
    
    //Esto agrega las calorias al conteo calorico
    public void agregarAlimento(String id, int idCont) throws SQLException {
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
    public String getCorreo(String correo) throws SQLException{
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spComprobarCorreo('"+correo+"');");
        String respuesta = "";
        while(rs.next()){
            respuesta = rs.getString("respuesta");
        }
        return respuesta;
    }
    
    public String ruta(int i){
        String ruta = "";
        if(i == 1){
        ruta = "C:\\Users\\Alumno\\Documents\\GitHub\\Strongfit\\Strongfit\\web\\Imagenes\\Usuarios\\"; //La ruta de Jorge
        //ruta = "C:\\Users\\USER\\Documents\\Git\\Strongfit\\StrongFit\\web\\Imagenes\\Usuarios";  //Ruta de Tona
        }else{
        ruta = "E:\\Strongfit\\StrongFit\\web\\Imagenes\\Articulos\\";
        }
        return  ruta;
    }
    
    public String[] getArticulosNom() throws SQLException{
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_SeleccionarArticulos();");
    ResultSet rs3 = null;
    String[][] articulos = null;
    String[] articulosordenados = null;
    int contador = 0;
    if(rs.next()){
    while(rs.next()){
    contador++;
    }
    contador++;
    
    ResultSet rs2 = this.st.executeQuery("call sp_SeleccionarArticulos();");
    articulos = new String[contador][2];
    articulosordenados = new String[contador];
     int contador2 = 0;
     while(rs2.next()){
         articulos[contador2][0] = rs2.getString("nombre");
         contador2++;
     }
     
     
     
     
     
     for(int i = 0; i < contador;i++){
      
     rs3 = this.st.executeQuery("call sp_regresavotos('"+articulos[i][0]+"');");
     if(rs3.next()){
      int resultado = rs3.getInt("arriba");
      resultado -= rs3.getInt("abajo");
      articulos[i][1] = Integer.toString(resultado);
   
     
     }
     }
    
     boolean termine = false;
     int contador3 = contador - 1;
     int valor = -2000;
     String identifica = "";
     String identifica2 = "";
     int val = 0;
   
     while(!termine){
      int e = 0;  
     for(int i = 0; i < contador;i++){
   
     if(!articulos[i][0].equals(identifica2)){
        
         int numero = Integer.parseInt(articulos[i][1]);
          
     if(Integer.parseInt(articulos[i][1]) >= valor ){
          
     valor = Integer.parseInt(articulos[i][1]);
     identifica = articulos[i][0];
     e = i;
    
     }
     }
     
     }
     articulosordenados[contador3] = identifica;
     articulos[e][1] = "-201";
     
     contador3--;
     
     if(contador3 == -1){
     termine = true;
      
     }
     identifica2 = identifica;
     valor = -200;
     }
    }
   
    return articulosordenados;
    }
    
    public String[] getArticulosAut() throws SQLException{
     this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_SeleccionarArticulos();");
    ResultSet rs3 = null;
    String[][] articulos = null;
    String[] articulosordenados = null;
    int contador = 0;
    if(rs.next()){
    while(rs.next()){
    contador++;
    }
    contador++;
    
    ResultSet rs2 = this.st.executeQuery("call sp_SeleccionarArticulos();");
    articulos = new String[contador][3];
    articulosordenados = new String[contador];
     int contador2 = 0;
     while(rs2.next()){
         articulos[contador2][0] = rs2.getString("nombre");
         articulos[contador2][2] = rs2.getString("idmedico");
         contador2++;
     }
     
     
     
     
     
     for(int i = 0; i < contador;i++){
      
     rs3 = this.st.executeQuery("call sp_regresavotos('"+articulos[i][0]+"');");
     if(rs3.next()){
      int resultado = rs3.getInt("arriba");
      resultado -= rs3.getInt("abajo");
      articulos[i][1] = Integer.toString(resultado);
     
     
     }
     }
    
     boolean termine = false;
     int contador3 = contador - 1;
     int valor = -2000;
     String identifica = "";
     String identifica2 = "";
     String valt = "";
     int val = 0;
   
     while(!termine){
       int e = 0;  
     for(int i = 0; i < contador;i++){
     
     if(!articulos[i][0].equals(identifica2)){
        
         int numero = Integer.parseInt(articulos[i][1]);
         
     if(Integer.parseInt(articulos[i][1]) >= valor ){
          
     valor = Integer.parseInt(articulos[i][1]);
     e = i;
     identifica = articulos[i][0];
     valt = articulos[i][2];
     
     }
     }
     
     }
     articulosordenados[contador3] = valt;
     articulos[e][1] = "-201";
     
     contador3--;
     
     if(contador3 == -1){
     termine = true;
      
     }
     identifica2 = identifica;
     valor = -200;
     }
    }
   
    return articulosordenados;
    }
    
    public String[] getArticulosTex() throws SQLException{
     this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_SeleccionarArticulos();");
    ResultSet rs3 = null;
    String[][] articulos = null;
    String[] articulosordenados = null;
    int contador = 0;
    if(rs.next()){
    while(rs.next()){
    contador++;
    }
    contador++;
    
    ResultSet rs2 = this.st.executeQuery("call sp_SeleccionarArticulos();");
    articulos = new String[contador][3];
    articulosordenados = new String[contador];
     int contador2 = 0;
     while(rs2.next()){
         articulos[contador2][0] = rs2.getString("nombre");
         articulos[contador2][2] = rs2.getString("texto");
         contador2++;
     }
     
     
     
     
     
     for(int i = 0; i < contador;i++){
      
     rs3 = this.st.executeQuery("call sp_regresavotos('"+articulos[i][0]+"');");
     if(rs3.next()){
      int resultado = rs3.getInt("arriba");
      resultado -= rs3.getInt("abajo");
      articulos[i][1] = Integer.toString(resultado);
      
     
     }
     }
    
     boolean termine = false;
     int contador3 = contador - 1;
     int valor = -2000;
     String identifica = "";
     String identifica2 = "";
     String valt = "";
     int val = 0;
   
     while(!termine){
     int e = 0;   
     for(int i = 0; i < contador;i++){
     
     if(!articulos[i][0].equals(identifica2)){
        
         int numero = Integer.parseInt(articulos[i][1]);
         
     if(Integer.parseInt(articulos[i][1]) >= valor ){
          
     valor = Integer.parseInt(articulos[i][1]);
     identifica = articulos[i][0];
    e = i;
     valt = articulos[i][2];
     
     }
     }
     
     }
     articulosordenados[contador3] = valt;
      articulos[e][1] = "-201";
     
     contador3--;
     
     if(contador3 == -1){
     termine = true;
      
     }
     identifica2 = identifica;
     valor = -200;
     }
    }
   
    return articulosordenados;
    }
    
    public int regresavoto(String idusr, String nPost) throws SQLException{
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_buscavoto('"+idusr+"','"+nPost+"');");
    int confirmacion = 0;
    if(rs.next()){
    if(rs.getInt("Existencia") > 0){
    if(rs.getInt("puntuacion") == 1){
    confirmacion = 1;
    }
    if(rs.getInt("puntuacion") == 0){
    confirmacion = 2;
    }
    }
    else{
    confirmacion = 0;
    }
    }
    return confirmacion;
    }
    
    public void altavoto(String idusr, String nPost, int voto) throws SQLException{
    this.st = con.createStatement();
    this.st.executeQuery("call sp_altavoto('"+idusr+"','"+nPost+"', "+voto+");");
    }
    
    public void cambiavoto(String idusr, String nPost, int voto) throws SQLException{
    this.st = con.createStatement();
    this.st.executeQuery("call sp_cambiovoto('"+idusr+"','"+nPost+"', "+voto+");");
    }
    
    public void borravoto(String idusr, String nPost) throws SQLException{
    this.st = con.createStatement();
    this.st.executeQuery("call sp_borravoto('"+idusr+"','"+nPost+"');");
    }
    
    public void altacomentario(String idusr, String nPost, String ncomentario)throws SQLException{
    this.st = con.createStatement();
    this.st.executeQuery("call sp_altacomentario('"+idusr+"','"+nPost+"', '"+ncomentario+"');");
    }
    
    //obtener los mensajes de que ha mandado o recibido el usuario
    public ResultSet spGetMensajes(String idusr, String idOtro, String fecha)throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetMensajes('"+idusr+"', '"+idOtro+"', '"+fecha+"');");
    }
    
    //esto obtiene los mensajes no leidos por el usuario
    public ResultSet spGetMsjNoLeidos(String idusr)throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetMsjNoLeidos('"+idusr+"');");
    }
    
    //esto marca como leido todos los mensajes entre un remitente y un destinatario
    public ResultSet spLeido(String idusr, String idOtro)throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spLeido('"+idusr+"', '"+idOtro+"');");
    }
    
    public String[][] regresacomentarios(String nPost) throws SQLException{
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_buscacomentarios('"+nPost+"');");
    String[][] arreglodecomentarios = null; 
    int contador = 0;        
    if(rs.next()){
    while(rs.next()){
    contador++;
    }
    System.out.print(contador);
    arreglodecomentarios = new String[contador + 1][3];
    ResultSet rs2 = this.st.executeQuery("call sp_buscacomentarios('"+nPost+"');");
    int contador2 = 0;
    while(rs2.next()){
    arreglodecomentarios[contador2][0] = rs2.getString("idUsuario");
    arreglodecomentarios[contador2][1] = rs2.getString("comentario");
    arreglodecomentarios[contador2][2] = Integer.toString(rs2.getInt("ncomentario"));
    contador2++;        
    }
   
    }
    return arreglodecomentarios;
    }
    public String altaarticulo(String idusr, String nPost, String nTexto, String nVPost, String idUser) throws SQLException{
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_altaarticulo('"+idusr+"','"+nPost+"','"+nTexto+"','"+nVPost+"','"+idUser+"');");
    String validacion = "";
    if(rs.next()){
     validacion = rs.getString("proceso");
    }
    return validacion;
    }
    public String[] buscamisarticulos(String idUsr) throws SQLException{
    String[] misarticulos = null;
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_buscamisarticulos('"+idUsr+"');");
    int contador = 0;
    if(rs.next()){
     while(rs.next()){
    contador++;
    }
    misarticulos = new String[contador + 1];
    ResultSet rs2 = this.st.executeQuery("call sp_buscamisarticulos('"+idUsr+"');");
    int contador2 = 0;
    while(rs2.next()){
    misarticulos[contador2] = rs2.getString("nombre");
    contador2++;        
    } 
    }
    return misarticulos;
    }
    public String buscamiarticulo(String idArt) throws SQLException{
    String misarticulos = "";
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_buscamiarticulo('"+idArt+"');");
    if(rs.next()){
    misarticulos = rs.getString("texto");
    }
    return misarticulos;
    }
    public String[] buscadatosdemiarticulo(String idArt) throws SQLException{
    String[] misarticulos = new String[3];
    this.st = con.createStatement();
    ResultSet rs = this.st.executeQuery("call sp_buscamiarticulo('"+idArt+"');");
    if(rs.next()){
    misarticulos[1] = rs.getString("texto");
    misarticulos[2] = rs.getString("idmedico");
    }
    return misarticulos;
    }
    //Este procedure agrega los alimentos mediante el id del paciente, el del alimento y el dia del mes, el mes y año
    public int spSetAlimentoFecha(int idA, int idPaciente, int tipo, int diaMes, int mes, int year, float gramos) throws SQLException{
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spSetAlimentoFecha("+idA+", "+idPaciente+", "+tipo+", "+diaMes+", "+mes+", "+year+", "+gramos+");");
        int idAlta = 0;
        while(rs.next()){
            idAlta = rs.getInt("valor"); //Recupera el ID de la relacion muchos a muchos para poder borrar el alimento si se requiere
        }
        return idAlta;
    }
    //Con esto recuperamos todos los alimentos usando parametros similares a los anteriores
    public ResultSet getAlimentosPorFecha(int idPaciente, int dia, int mes, int year) throws SQLException{
        this.st = con.createStatement();
        ResultSet rs = this.st.executeQuery("call spGetAlimentosPorFecha("+idPaciente+", "+dia+", "+mes+", "+year+");");
        return rs;
    }
    //Borramos el alimento mediante el id de la relacion muchos a muchos antes mencionada
    //Solo borra la relacion de la tabla muchos a muchos (alimento_fecha), creo que eso esta bien
    public void spBorrarAlimentoFecha(int idFecha) throws SQLException{
        this.st = con.createStatement();
        this.st.executeQuery("call spBorrarAlimentoFecha("+idFecha+");");
    }
    //borra articulos
    public void borrararticulo(String idArt) throws SQLException{
        this.st = con.createStatement();
        this.st.executeQuery("call sp_Borrararticulo('"+idArt+"');");
    }
     public int[] cuentavotos(String idArt) throws SQLException{
        this.st = con.createStatement();
        ResultSet resultado = null;
        int votos[] = new int[2];
        resultado = this.st.executeQuery("call sp_regresavotos('"+idArt+"');");
        if(resultado.next()){
         votos[0] = resultado.getInt("arriba");
          votos[1] = resultado.getInt("abajo");       
        }
        return votos;
    }
     
    //spGetAlimentosMes(in id_paciente int, in numMes int, in numYear int)
    public ResultSet spGetAlimentosMes(int idPaciente, int numMes, int year)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spGetAlimentosMes("+idPaciente+", "+numMes+", "+year+");");
    }
     
     //spGetAlimentosMes(in id_paciente int, in numMes int, in numYear int)
    public ResultSet spSetAsociasiones(int idPaciente, int idMe, int idD, String idUsrM, int accion)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spSetAsociasiones("+idPaciente+", "+idMe+", "+idD+", '"+idUsrM+"', "+accion+");");
    }
     
     //spGetAlimentosMes(in id_paciente int, in numMes int, in numYear int)
    public ResultSet spGetAsociaciones(int idPaciente)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spGetAsociaciones("+idPaciente+");");
    }
     
     //nos trae el idPaciente de el usuario paciente
    public ResultSet spTraerIdPaciente(String idPaciente)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spTraerIdPaciente('"+idPaciente+"');");
    }
     
     //nos trae el idPaciente de el usuario paciente
    public ResultSet spTraerIdMedico(String idPaciente)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spTraerIdMedico('"+idPaciente+"');");
    }
     
    //Agrega, actualiza o borra un registro de dietas
    public ResultSet spSetResgitroDietas(int dieta, int idSemana, int idAnio, int Paciente, int accion)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spSetResgitroDietas("+dieta+", "+idSemana+", "+idAnio+", "+Paciente+", "+accion+");");
    } 
     
    //nos trae el idPaciente de el usuario paciente
    public ResultSet spSetPosicion(int idDieta, int idPaciente, int pos)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spSetPosicion('"+idDieta+"', '"+idPaciente+"', '"+pos+"');");
    }
     
     //nos trae el idPaciente de el usuario paciente
    public ResultSet spGetRegistroDietas(int idPaciente)throws SQLException{
       this.st = con.createStatement();
       return this.st.executeQuery("call spGetRegistroDietas("+idPaciente+");");
    }
    public ResultSet spGetTodosAlimentos() throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("select * from alimento;");
    }

    public ResultSet spGetDatosPaciente(String correo, String contra) throws SQLException {
        this.st = con.createStatement();
        return this.st.executeQuery("select nombre, idPaciente from usuario where idUsuario='" + correo + "' and passUsuario='" + contra + "';");
    }
    public ResultSet spGetTiposAlimento() throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetTiposAlimento();");
    }
    //spAjustarPos(in idPac int, in diaA int)
    public ResultSet spAjustarPos(int idPaciente, int diaAnio) throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spAjustarPos("+idPaciente+","+diaAnio+");");
    }
    public ResultSet spGetComidasDieta(int idPaciente, int diaSemana, int comida) throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetComidasDieta("+idPaciente+", "+diaSemana+", "+comida+");");
    }
    
    //Retorna el idUsuario de un paciente
    public ResultSet spGetUsrId(int idPaciente) throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetUsrId("+idPaciente+");");
    }
    
    //Esto trae si o no dependiendo de si 
    public ResultSet spGetAsociacionEspecifica(int idDieta, int idPaciente) throws SQLException{
        this.st = con.createStatement();
        return this.st.executeQuery("call spGetAsociacionEspecifica("+idDieta+", "+idPaciente+");");
    }
}

