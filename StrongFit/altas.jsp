<%-- 
    Document   : al  Created on : 9/04/2014, 05:58:00 PM
    Author     : DavidGustavo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page Altas</title>
    </head>
    <body bgcolor="#9491ee">
        <h1>Altas</h1>
        <%@page import="java.sql.*, java.*"%>
        <%
            String boleta = request.getParameter("textfieldboleta");
            String contra = request.getParameter("contrasenia");
            String nombre = request.getParameter("textfieldnombre");
            String sexo = request.getParameter("radiosexo");
            String email = request.getParameter("textfieldemail");
            String calle = request.getParameter("textfieldcalle");
            String delegacion = request.getParameter("select");
            String colonia = request.getParameter("select2");
            String sueldo = request.getParameter("textfieldsueldo");
            String estadocivil = request.getParameter("radiodeporte");
            
            
            
            //variables para la conexión
            Connection con = null;
            Statement stm = null;
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                con = DriverManager.getConnection("jdbc:mysql://localhost/formulario","root","n0m3l0");
                stm = con.createStatement();
            }
            catch(SQLException error)
            {
                out.print(error.toString());
            }
              //stm.executeUpdate("insert into datos(boleta,contra,nombre,sexo,email,calle,delegacion,colonia,sueldo,estadocivil)" + "values('"+boleta+"', '"+contra+"', '"+nombre+"', '"+sexo+"', '"+email+"', '"+calle+"', '"+delegacion+"', '"+colonia+"', '"+sueldo+"', '"+estadocivil+"');");
                 //stm.executeUpdate("insert into datos(boleta,contra,nombre,sexo,email,calle,delegacion,colonia,sueldo,estadocivil)" + "values('"+boleta+"', '"+contra+"', '"+nombre+"', '"+sexo+"', '"+email+"', '"+calle+"', '"+delegacion+"', '"+colonia+"', '"+sueldo+"', '"+estadocivil+"');");
              
              try
              {
                    stm.executeUpdate("insert into datos(boleta, contra, nombre, sexo, email, calle, delegacion, colonia, sueldo, estadocivil)" + "values('"+boleta+"','"+contra+"', '"+nombre+"', '"+sexo+"', '"+email+"', '"+calle+"', '"+delegacion+"', '"+colonia+"', '"+sueldo+"', '"+estadocivil+"');");
                      out.println("<script> alert('Registro dado de alta');</script>");
                      out.print("<META HTTP-EQUIV='REFRESH' " + "CONTENT='.0000001; URL=http://localhost:8080/FORMULARIO/'/>");
              }
              catch(SQLException error)
                {
                    out.print(error.toString());
                }
              %>
    </body>
</html>