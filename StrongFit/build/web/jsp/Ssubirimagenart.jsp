<%@page import="org.apache.jasper.JasperException"%>
<%@ page import="org.apache.commons.fileupload.FileItem" %> 
<%@ page import="java.util.*" %> 
<%@ page import="org.apache.commons.fileupload.*" %> 
<%@ page import="org.apache.commons.fileupload.disk.*" %> 
<%@ page import="org.apache.commons.fileupload.servlet.*" %> 
<%@ page import="org.apache.commons.io.*" %> 
<%@ page import="java.io.*" %> 
<%@ page session="true" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>

<%
 clases.cConexion objruta = new clases.cConexion();
            String ubicacionArchivo = objruta.ruta(2);
HttpSession sesion = request.getSession();
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setSizeThreshold(1024); 
factory.setRepository(new File(ubicacionArchivo));

ServletFileUpload upload = new ServletFileUpload(factory);

try
{
List<FileItem> partes = upload.parseRequest(request);
if(partes == null){
out.write("es nulo");
}
if(partes.size() == 0){
out.write("es el 0");
}
for(FileItem item : partes)
{     
String nombre = FilenameUtils.getName(item.getName());
out.println(nombre);
try{
File file = new  File(ubicacionArchivo, nombre);
int lugar= nombre.length();
if(nombre.charAt(lugar -1) == 'g' || nombre.charAt(lugar - 1) == 'f'){
if(nombre.charAt(lugar - 2) == 'p' || nombre.charAt(lugar - 2) == 'n' || nombre.charAt(lugar - 2) == 'i'){
if(nombre.charAt(lugar - 3) == 'j' || nombre.charAt(lugar - 3) == 'p' || nombre.charAt(lugar - 3) == 'g'){    
item.write(file);
out.write("no es la validacion");
String tipo = "";
switch(nombre.charAt(lugar - 3)){
    case 'j':
    tipo = ".jpg";
        break;
    case 'p':
    tipo = ".png";
        break;
    case'g':
    tipo = ".gif";    
        break;
}

String nombre2 = (String)sesion.getAttribute("idUsr") + tipo;
String nombre3 = (String)sesion.getAttribute("idUsr") + ".jpg";
String nombre4 = (String)sesion.getAttribute("idUsr") + ".png";
String nombre5 = (String)sesion.getAttribute("idUsr") + ".gif";
File file2 = new File(ubicacionArchivo, nombre2);
File file3 = new File(ubicacionArchivo, nombre3);
File file4 = new File(ubicacionArchivo, nombre4);
File file5 = new File(ubicacionArchivo, nombre5);
if(file3.exists()){
file3.delete();
}
if(file4.exists()){
file4.delete();
}
if(file5.exists()){
file5.delete();
}
boolean xd = file.renameTo(file2);

}
}
}
}
catch(JasperException e){    
response.sendRedirect("index.jsp");
}
}
String tipodeus = (String)sesion.getAttribute("tipodeus");
if(tipodeus.equals("1")){
response.sendRedirect("paciente/usuario.jsp");
}
if(tipodeus.equals("2")){
response.sendRedirect("nutriologo/Escribir_articulo.jsp");
}
}
catch(FileUploadException ex)
{
out.write("Error al subir archivo "+ex.getMessage());
}
%>