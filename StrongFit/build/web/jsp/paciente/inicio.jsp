<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.cCifrado"%>
<%@page import="clases.cConexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="../nutriologo/error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <script src="../../js/progressbar.min.js"></script>
        <script src="../../js/buscar-alimento.js"></script>
        <script src="../../js/salir.js"></script>
    </head>
 <body onload="setValores();">
        <%
            HttpSession sesion = request.getSession();
            int idPaciente = (Integer)sesion.getAttribute("idPaciente");
            int idCon = (Integer)sesion.getAttribute("idcont");
            Calendar c2 = new GregorianCalendar();
            
            int dia = c2.get(Calendar.DAY_OF_WEEK);
            int diaA = c2.get(Calendar.DAY_OF_YEAR);
            %><scritpt></scritpt><%
            int caloriasdia = 0;
            int diaMes = c2.get(Calendar.DATE); //Agregue esta variable
            int numMes = c2.get(Calendar.MONTH); //Esto se maneja como arreglos
            int year = c2.get(Calendar.YEAR);//Agregue esta variable
            cConexion conecta = new cConexion();
            conecta.conectar();
            
            ResultSet rs = conecta.spGetCaloriasPacienteEspecifico(idPaciente, dia);
            if(rs.next())
            {
                caloriasdia = rs.getInt("calorias");
            }
        %>
        <%@include file = "barra_menu.jsp" %>
        <script>setPosicion('inicio');</script>
        <form id = "formularioOculto">
            <input type="hidden" name="idCon" value="<%=idCon%>">
        </form>
        <section class="Section small x-large">
        <article class="Content small x-large">
            <div class="Content-title">
                Consumo Calórico
            </div>
            <div class="Content-informacion">      
                <div class="Estadisticas">
                    <div class="Estadisticas-header">
                        <span><a href="#" class="Estadisticas-atras" id="cambiar-atras"> < </a></span>
                        <h3 class="Estadisticas-titulo" id="tituloFecha">Hoy</h3> 
                        <span><a href="#" class="Estadisticas-adelante" id="cambiar-adelante"> > </a></span>
                    </div>
                    <div class="Estadisticas-section">
                        <div class="Estadisticas-wrapper">
                            <p>Meta <span id="metaCalorias"><%=caloriasdia%></span> kcal</p>
                            <%
                                //Cambie el metodo a uno que recupera por una fecha mas especifica
                                //Hace lo mismo que el anterior
                                ResultSet rs2 = conecta.getAlimentosPorFecha(idPaciente, diaMes, numMes, year);
                                int calorias = 0;
                                float gramos;
                                float kcalorias = 0;
                                float calDesayuno = 0; 
                                float calColacion1 = 0;
                                float calColacion2 = 0; 
                                float calComida = 0;
                                float calCena = 0;
                                int idAlimentoFecha;
                                //100 g - calorias
                                //gramos - x calorias
                                while(rs2.next()){
                                    calorias = rs2.getInt("calorias");
                                    gramos = rs2.getFloat("gramos");
                                    idAlimentoFecha = rs2.getInt("tiempo_comida_id");
                                    kcalorias += (gramos * calorias)/100;
                                    if(idAlimentoFecha == 1){
                                        calDesayuno += (gramos * calorias)/100;
                                    }else if(idAlimentoFecha == 2){
                                        calColacion1 += (gramos * calorias)/100;
                                    }else if(idAlimentoFecha == 3){
                                        calComida += (gramos * calorias)/100;
                                    }else if(idAlimentoFecha == 4){
                                        calColacion2 += (gramos * calorias)/100;
                                    }else if(idAlimentoFecha == 5){
                                        calCena += (gramos * calorias)/100;
                                    }
                                }
                                System.out.println("Totales " + kcalorias);
                                
                                String calTotales = String.format("%.2f", kcalorias);
                                
                                String calTotalesDesayuno = String.format("%.2f", calDesayuno);
                                String calTotalesColacion1 = String.format("%.2f", calColacion1);
                                String calTotalesComida = String.format("%.2f", calComida);
                                String calTotalesColacion2 = String.format("%.2f", calColacion2);
                                String calTotalesCena = String.format("%.2f", calCena);
                                
                                System.out.println("otras totales: " + calTotales);
                                System.out.println(calTotalesDesayuno);
  
                            %>
                        <p id="consumido">Consumido <%=calTotales%> kcal</p>
                        </div>
                        <div id="container"></div> <!--El div de la grafica--> 
                    </div>      
                </div>
                <div class="Registrados">
                    <h3 class="Buscador-aviso Seleccionado-titulo">Alimentos Registrados</h3>
                    <div>
                        <h3 class="Registrados-header" id="tituloDesayuno">Desayuno - <%=calTotalesDesayuno%> kcal</h3>
                        <div class="Registrados-list">
                            <ul class="Consumidos" id="comida-desayuno">
                                <li class="Consumidos-item ocultar" id="prototipo-borrar">
                                    <p class="Consumidos-name ">Taco </p>
                                    <span class="Consumidos-subname">Consumidos: 5 kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden"></button>
                                </li>
                                <%
                                    //Datos del alimento que se mostraran cuando cargue la pagina
                                    //Estan organizados por tipo de comida
                                    //100 g - calorias
                                    //gramos - x calorias
                                    String nombre = "";
                                    int tipoAlimento = 0;

                                    String calAlimento;
                                    rs2.beforeFirst();
                                    while(rs2.next()){
                                        nombre = rs2.getString("nombre");
                                        calorias = rs2.getInt("calorias");
                                        gramos = rs2.getFloat("gramos");
                                        kcalorias = (gramos * calorias)/100;
                                        calAlimento = String.format("%.2f", kcalorias);
                                        tipoAlimento = rs2.getInt("tiempo_comida_id");
                                        idAlimentoFecha = rs2.getInt("idAlimento_fecha");
                                        if(tipoAlimento == 1){                                              
                                %>
                                <li class="Consumidos-item">
                                    <p class="Consumidos-name"><%=nombre%></p>
                                    <span class="Consumidos-subname">Consumidos: <%=calAlimento%> kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden" value="<%=idAlimentoFecha%>"></button>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <h3 class="Registrados-header" id="tituloColacion1">Colación 1 - <%=calTotalesColacion1%> kcal</h3>
                        <div class="Registrados-list">
                            <ul class="Consumidos" id="comida-colacion1">
                                <%
                                    rs2.beforeFirst();
                                    while(rs2.next()){
                                        nombre = rs2.getString("nombre");
                                        calorias = rs2.getInt("calorias");
                                        gramos = rs2.getFloat("gramos");
                                        kcalorias = (gramos * calorias)/100;
                                        calAlimento = String.format("%.2f", kcalorias);
                                        tipoAlimento = rs2.getInt("tiempo_comida_id");
                                        idAlimentoFecha = rs2.getInt("idAlimento_fecha");
                                        if(tipoAlimento == 2){                                              
                                %>
                                <li class="Consumidos-item">
                                    <p class="Consumidos-name"><%=nombre%></p>
                                    <span class="Consumidos-subname">Consumidos: <%=calAlimento%> kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden" value="<%=idAlimentoFecha%>"></button>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <h3 class="Registrados-header" id="tituloComida">Comida - <%=calTotalesComida%> kcal</h3>
                        <div class="Registrados-list">
                            <ul class="Consumidos" id="comida-comida">
                                <%
                                    //Esta parte solo se cambio de lugar para que se adapte a la nueva vista
                                    rs2.beforeFirst();
                                    while(rs2.next()){
                                        nombre = rs2.getString("nombre");
                                        calorias = rs2.getInt("calorias");
                                        gramos = rs2.getFloat("gramos");
                                        kcalorias = (gramos * calorias)/100;
                                        calAlimento = String.format("%.2f", kcalorias);
                                        tipoAlimento = rs2.getInt("tiempo_comida_id");
                                        idAlimentoFecha = rs2.getInt("idAlimento_fecha");
                                        if(tipoAlimento == 3){                                              
                                %>
                                <li class="Consumidos-item">
                                    <p class="Consumidos-name"><%=nombre%></p>
                                    <span class="Consumidos-subname">Consumidos: <%=calAlimento%> kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden" value="<%=idAlimentoFecha%>"></button>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <h3 class="Registrados-header" id="tituloColacion2">Colación 2 - <%=calTotalesColacion2%> kcal</h3>
                        <div class="Registrados-list">
                            <ul class="Consumidos" id="comida-colacion2">
                                <%
                                    //Esta parte solo se cambio de lugar para que se adapte a la nueva vista
                                    rs2.beforeFirst();
                                    while(rs2.next()){
                                        nombre = rs2.getString("nombre");
                                        calorias = rs2.getInt("calorias");
                                        gramos = rs2.getFloat("gramos");
                                        kcalorias = (gramos * calorias)/100;
                                        calAlimento = String.format("%.2f", kcalorias);
                                        tipoAlimento = rs2.getInt("tiempo_comida_id");
                                        idAlimentoFecha = rs2.getInt("idAlimento_fecha");
                                        if(tipoAlimento == 4){                                              
                                %>
                                <li class="Consumidos-item">
                                    <p class="Consumidos-name"><%=nombre%></p>
                                    <span class="Consumidos-subname">Consumidos: <%=calAlimento%> kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden" value="<%=idAlimentoFecha%>"></button>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <h3 class="Registrados-header" id="tituloCena">Cena - <%=calTotalesCena%> kcal</h3>
                        <div class="Registrados-list">
                            <ul class="Consumidos" id="comida-cena">
                                <%
                                    //Esta parte solo se cambio de lugar para que se adapte a la nueva vista
                                    rs2.beforeFirst();
                                    while(rs2.next()){
                                        nombre = rs2.getString("nombre");
                                        calorias = rs2.getInt("calorias");
                                        gramos = rs2.getFloat("gramos");
                                        kcalorias = (gramos * calorias)/100;
                                        calAlimento = String.format("%.2f", kcalorias);
                                        tipoAlimento = rs2.getInt("tiempo_comida_id");
                                        idAlimentoFecha = rs2.getInt("idAlimento_fecha");
                                        if(tipoAlimento == 5){                                              
                                %>
                                <li class="Consumidos-item">
                                    <p class="Consumidos-name"><%=nombre%></p>
                                    <span class="Consumidos-subname">Consumidos: <%=calAlimento%> kcal</span>
                                    <button class="Consumidos-borrar">X <input type="hidden" value="<%=idAlimentoFecha%>"></button>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div> 
                    </div>
                </div>
            </div>                 
        </article>
        <aside class="Buscador x-large">
            <div class="Buscador-header">
                <h3 class="Buscador-title">Agrear alimentos a: Desayuno</h3>    
                <div class="Buscador-cambiar" id="buscadorCambiar">+</div>
                <ul class="Buscador-nav" id="buscadorNav">
                    <li class="Comida Seleccionado">Desayuno</li>
                    <li class="Comida">Colacion 1</li>
                    <li class="Comida">Comida</li>
                    <li class="Comida">Colacion 2</li>       
                    <li class="Comida">Cena</li>
                </ul>
            </div>
            <div class="Buscador-form">
                <input type="search" name="nombre-alimento" class="Buscador-search" id="input-alimento" placeholder="buscar" required> 
                <button class="Buscador-btn" id="buscadorBoton">
                    <span class="icon-search"></span>
                </button>
            </div>
            <div class="dietaDia">
                <h3 class="Buscador-aviso buscarh3">Alimentos sugeridos por tu dieta<button class="Alimentos-agregar2" onclick="agregarDieta();">+</button></h3>
                <div>
                    <ul class="AlimentosDieta">
                        <li class="Alimentos-item2 ocultar">
                            <p class="Alimentos-name">Taco</p>            
                            <span class="Alimentos-subname">Contiene: 5 kcal/100g</span>
                            <div class="Alimentos-subname">
                                Cantidad:
                                <span class="icon3-circle-up Alimentos-arriba"></span>
                                <input class="Alimentos-cantidad" id="alimentoCantidad" type="number" value="100"> g
                                <span class="icon3-circle-down Alimentos-abajo"></span>     
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="Buscador-contenedor">
                <h3 class="Buscador-aviso" id="Buscador-aviso">Alimentos por defecto</h3>
                <div class="Buscador-list">
                    <ul class="Alimentos">
                        <li class="Alimentos-item ocultar">
                            <p class="Alimentos-name">Taco</p>            
                            <span class="Alimentos-subname">Contiene: 5 kcal/100g</span>
                            <div class="Alimentos-subname">
                                Cantidad:
                                <span class="icon3-circle-up Alimentos-arriba"></span>
                                <input class="Alimentos-cantidad" id="alimentoCantidad" type="number" value="100"> g
                                <span class="icon3-circle-down Alimentos-abajo"></span>     
                            </div>
                            <button class="Alimentos-agregar">+<input type="hidden"></button>
                        </li>
                    </ul>
                </div>      
            </div>
        </aside>
    </section>
    <div class="FloatButton">
        <a href="#">+</a>
    </div>
        <script>
            setIds(<%=dia%>, <%=diaA%>);
            cargarComidaDieta();
        </script>
    </body>
</html>
