<%@page import="java.sql.ResultSet"%>
<%@page import="clases.cCifrado"%>
<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasnutriologo.css">
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script src="../../js/acciones_dietasnutriologo.js"></script>
         <script src="../../js/salir.js"></script>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        <section class="Section-todo">
            
            <!--Esta es la parte en donde se vera las dietas que el nutriologo crea-->
            <article class="Article-dietas" id = "tusDietas">
                <h2 id = "textoTitulo">Tus dietas</h2>
                <hr>
                <form>
                    <input type="hidden" value="" name="<%%>" id = "dieta" >
                </form>
                <%
                    HttpSession sesion = request.getSession();
                    cCifrado seguro = new cCifrado();
                    seguro.AlgoritmoAES();
                    String usrid = seguro.encriptar((String)sesion.getAttribute("idUsr"));
                    
                    ResultSet rs = conecta.getDietasRegistradas(usrid);
                    
                    String nom = "";
                    int idDieta = 0;
                    int contadorD = 0;
                    
                    while(rs.next()){
                        idDieta = rs.getInt("idDieta");
                        nom = rs.getString("nombre");
                %>
                <!--Esto es de prueba-->
                <div class = "dietaCreada" id = '<%="dieta" + contadorD%>'>
                    <input type="hidden" name="idsDieta" id="idsDieta<%=contadorD%>" value="<%=idDieta%>">
                    <span id="nombreDieta<%=contadorD%>"><%=nom%></span><div class="divTusDietas"><input type="button" name="btnEditarD" class="btnEditarD" onclick="editarDieta(<%=contadorD%>);" value="Editar"><input type="button" name="btnBorrarD" class="btnEliminarD" onclick="borrarDieta(<%=contadorD%>);" value="Eliminar"></div>
                </div>
                <%
                        contadorD++;
                    }
                %>

                <input type="button" name="nueva" value="Nueva" class="btn-act-usr" onclick = "ocultar()">
            </article>
                
                <%
                    String editando = (String)sesion.getAttribute("editandoDieta");
                    boolean edicion = false;
                    int idDietaEdicion = 0;
                    int contadorDiasE = 0, contadorComidaE = 0;
                    int comidasE[][] = new int[7][5];
                    String nombreDieta = "";
          
                    int idAlimento = 0;
                    float proteinas = 0;
                    float lipidos = 0;
                    float carbohidratos = 0;
                    int porcion = 0;
                    int cantidad = 0;
                    float calorias = 0;
                    int consideracion = 0;
                    int contadorD1 = 0;
                    String nombreA = "";
                    /*var caloriasDia = [];
                        var caloriasPromedio = 0;
                        var proteinas = [], proPorciento = [];
                        var lipidos = [], lipPorciento = [];
                        var carbohidratos = [], carPorciento = [];*/
                    
                    float caloriasDia[] = new float[7];
                    float proteinasD[] = new float[7];
                    float lipidosD[] = new float[7];
                    float carbohidratosD[] = new float[7];
                    
                    if(editando != null){
                        %><script>ocultar();</script><%
                        edicion = true;
                        sesion.removeAttribute("editandoDieta");
                        idDietaEdicion = (Integer)sesion.getAttribute("idDietaEditar");
                        nombreDieta = (String)sesion.getAttribute("nombreDieta");
                        
                        
                        ResultSet diasEdicion = conecta.spGetDiaDieta(idDietaEdicion);
                        while(diasEdicion.next()){
                            ResultSet comidas = conecta.spGetComidaDia(diasEdicion.getInt("idDia"));
                            while(comidas.next()){
                                comidasE[contadorDiasE][contadorComidaE] = comidas.getInt("idComidas");
                                ResultSet comdia = conecta.spGetAlimentoComida(comidasE[contadorDiasE][contadorComidaE]);
                                    while(comdia.next()){
                                        idAlimento = comdia.getInt("idAlimento");
                                        calorias = comdia.getFloat("calorias");
                                        lipidos = comdia.getFloat("lipidos");
                                        proteinas = comdia.getFloat("proteinas");
                                        carbohidratos = comdia.getFloat("carbohidratos");
                                        consideracion = comdia.getInt("consideracion");
                                        porcion = comdia.getInt("porcion");
                                        cantidad = comdia.getInt("cantidad");
                                        nombreA = comdia.getString("nombre");
                                        
                                        caloriasDia[contadorDiasE] += calorias;
                                        proteinasD[contadorDiasE] += proteinas;
                                        lipidosD[contadorDiasE] += lipidos;
                                        carbohidratosD[contadorDiasE] += carbohidratos;
                                    }
                                contadorComidaE++;
                            }
                            contadorComidaE = 0;
                            contadorDiasE++;
                        }
                        %><script>setCaloriasEdicion(<%=caloriasDia[0]%>, <%=caloriasDia[1]%>, <%=caloriasDia[2]%>, <%=caloriasDia[3]%>, <%=caloriasDia[4]%>, <%=caloriasDia[5]%>, <%=caloriasDia[6]%>);</script><%
                        %><script>setProteinasEdicion(<%=proteinasD[0]%>, <%=proteinasD[1]%>, <%=proteinasD[2]%>, <%=proteinasD[3]%>, <%=proteinasD[4]%>, <%=proteinasD[5]%>, <%=proteinasD[6]%>);</script><%
                        %><script>setLipidosEdicion(<%=lipidosD[0]%>, <%=lipidosD[1]%>, <%=lipidosD[2]%>, <%=lipidosD[3]%>, <%=lipidosD[4]%>, <%=lipidosD[5]%>, <%=lipidosD[6]%>);</script><%
                        %><script>setCarbohidratosEdicion(<%=carbohidratosD[0]%>, <%=carbohidratosD[1]%>, <%=carbohidratosD[2]%>, <%=carbohidratosD[3]%>, <%=carbohidratosD[4]%>, <%=carbohidratosD[5]%>, <%=carbohidratosD[6]%>);</script><%
                        
                    }
                    else{
                        sesion.removeAttribute("idDietaEditar");
                        sesion.removeAttribute("nombreDieta");
                        sesion.removeAttribute("idDieta");
                    }
                %>
            
            <!--Esta es la parte en donde aparece un buscador y tu puedes arrastrar los alimentos-->
            <article class="Article-dietas invisible tamano" id = "buscarAlimentos">
                <p class="contenedor-search">
                    <span class = "span-search"><label class = "icon-search label-search" for = "buscar"></label></span>
                    <input type="search" onkeypress="buscarAlimento();" placeholder = "buscar alimentos ..." class = "input-search" id = "buscar">
                </p>
                <div class = "contenedor-resultados" id="idcontenedor-resultados">
                    <div class = "resultado invisible" id = "resultadoClon" draggable = "true" ondragstart="drag(event, id)"></div>
                </div>
            </article>
            
            <%
                conecta.conectar();
                String dominio = conecta.getDominio();
            %>
            <form id = "dietaNueva" action="<%=dominio%>sCrearDieta" method="post">
            <!--Esta es la parte en la que se ensambla la dieta-->
            <article class="Article-dietas Article-dietas2 invisible tamano" id="crearDietas">
                    <div class = "menuCrear">
                        <div class="opcionMenu transparente" id ="domingo" onclick = "mostrarDomingo()">
                            Domingo
                        </div>
                        <div class="opcionMenu" id ="lunes" onclick = "mostrarLunes()">
                            Lunes
                        </div>
                        <div class="opcionMenu" id ="martes" onclick = "mostrarMartes()">
                            Martes
                        </div>
                        <div class="opcionMenu" id ="miercoles" onclick = "mostrarMiercoles()">
                            Miércoles
                        </div>
                        <div class="opcionMenu" id ="jueves" onclick = "mostrarJueves()">
                            Jueves
                        </div>
                        <div class="opcionMenu" id ="viernes" onclick = "mostrarViernes()">
                            Viernes
                        </div>
                        <div class="opcionMenu" id ="sabado" onclick = "mostrarSabado()">
                            Sábado
                        </div>
                    </div>
                    
                    <div>
                        
                        <!--Esta es la parte de edicion del domingo-->
                        <div class = "diasDieta" id="domingoDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio0" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        contadorD1 = 0;
                                        nombreA = ""; 
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[0][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio1" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[0][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio2" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[0][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio3" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[0][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio4" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[0][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del lunes-->
                        <div class = "diasDieta invisible" id="lunesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio5" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[1][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio6" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[1][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio7" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[1][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio8" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[1][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio9" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[1][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del martes-->
                        <div class = "diasDieta invisible" id="martesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio10" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[2][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio11" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[2][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio12" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[2][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio13" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[2][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio14" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[2][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del miercoles-->
                        <div class = "diasDieta invisible" id="miercolesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio15" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[3][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio16" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[3][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio17" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[3][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio18" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[3][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio19" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[3][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del jueves-->
                        <div class = "diasDieta invisible" id="juevesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio20" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio21" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio22" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio23" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio24" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del viernes-->
                        <div class = "diasDieta invisible" id="viernesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio25" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[5][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio26" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[5][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio27" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[5][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio28" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[4][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio29" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[5][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del sabado-->
                        <div class = "diasDieta invisible" id="sabadoDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio30" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[6][0]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio31" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[6][1]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio32" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[6][2]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio33" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[6][3]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio34" ondrop="drop(event, id)" ondragover="allowDrop(event)">
                                    <%
                                        idAlimento = 0;
                                        proteinas = 0;
                                        lipidos = 0;
                                        carbohidratos = 0;
                                        porcion = 0;
                                        cantidad = 0;
                                        calorias = 0;
                                        consideracion = 0;
                                        nombreA = "";
/*$clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'">
                                        <input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'">
                                        <input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'">
                                        <input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'">
                                        <input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'">
                                        <input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'">
                                        <input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'">
                                        <input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" >
                                        <span id="textoResultado">'+nombre[i]+'</span>
                                        <span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span>
                                        <div class="invisible" id="flechitas'+idClon+'">
                                            <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span>
                                            <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span>
                                            <input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g
                                        </div>');*/

                                        if(edicion){
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[6][4]);
                                            while(comdia.next()){
                                                idAlimento = comdia.getInt("idAlimento");
                                                calorias = comdia.getFloat("calorias");
                                                lipidos = comdia.getFloat("lipidos");
                                                proteinas = comdia.getFloat("proteinas");
                                                carbohidratos = comdia.getFloat("carbohidratos");
                                                consideracion = comdia.getInt("consideracion");
                                                porcion = comdia.getInt("porcion");
                                                cantidad = comdia.getInt("cantidad");
                                                nombreA = comdia.getString("nombre");
                                                %>
                                                <div class = "resultado enMenu yaEsta" id = "<%=contadorD1%>" draggable = "true" ondragstart="drag(event, id)">
                                                    <input type = "hidden" id = "alimento<%=contadorD1%>" class="idsClass" name = "ids" value="<%=idAlimento%>">
                                                    <input type = "hidden" id = "calorias<%=contadorD1%>" name = "calorias" value="<%=calorias%>">
                                                    <input type = "hidden" id = "lipidos<%=contadorD1%>" name = "lipidos" value="<%=lipidos%>">
                                                    <input type = "hidden" id = "proteinas<%=contadorD1%>" name = "proteinas" value="<%=proteinas%>">
                                                    <input type = "hidden" id = "carbohidratos<%=contadorD1%>" name = "carbohidratos" value="<%=carbohidratos%>">
                                                    <input type="hidden" id="consideracion<%=contadorD1%>" name="consideracion" value="<%=consideracion%>">
                                                    <input type="hidden" id="porcion<%=contadorD1%>" name="porcion" value="<%=porcion%>">
                                                    <input type="hidden" id="cantidad<%=contadorD1%>" name="cantidad" value="<%=cantidad%>" >
                                                    <span id="textoResultado"><%=nombreA%></span>
                                                    <span id = "tache<%=contadorD1%>" onclick="remover('<%=contadorD1%>');" class = "icon-cancel-circle"></span>
                                                    <div class="" id="flechitas<%=contadorD1%>">
                                                        <span class="icon3-circle-up flechitasF" onclick="incrementaBaja('<%=contadorD1%>',1);" id="masF<%=contadorD1%>"></span>
                                                        <span class="icon3-circle-down flechitasF" onclick="incrementaBaja('<%=contadorD1%>',2);" id="menosF<%=contadorD1%>"></span>
                                                        <input class="setCantidad" type="text" onchange="cambiarIndependiente('<%=contadorD1%>');" id="cantidadAsignada<%=contadorD1%>" value="<%=cantidad%>">g
                                                    </div>
                                                </div>    

                                                <%
                                                contadorD1++;
                                            }
                                        %><script>setContadorD(<%=contadorD1%>);</script><%
                                        }
                                        
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                
            </article>
            
            <!--Esta es la parte en donde se ve el balanceo de los nutrientes-->
            <article class="Article-dietas Article-dietas3 invisible tamano" id = "balanceoDietas">
                <input type="text" id = "nombreNuevaDieta" class ="nombreDieta-txt" value="<%=nombreDieta%>" placeholder = "Nombre de la dieta" required>
             
                <hr>
                <table class = "tablaInf">
                    <tr>
                        <td class="tdIz">Día:</td>
                        <td class="tdDe">Domingo</td>
                    </tr>
                </table>
                <hr>
                <table class = "tablaInf">
                    <tr>
                        <td class="tdIz">Calorías del Día:</td>
                        <td class="tdDe" ><span id="caloriasDia">0</span>kc</td>
                    </tr>
                    <tr>
                        <td class="tdIz">Calorías promedio:</td>
                        <td class="tdDe" ><span id="caloriasPromedio">0</span>kc</td>
                    </tr>
                </table>
                <hr>
                <table class = "tablaInf">
                    <tr>
                        <td class="tdIz">Proteinas:</td>
                        <td class="tdDe" ><span id="proteinasPromedio">0</span>%</td><!--20% es lo ideal-->
                    </tr>
                    <tr>
                        <td class="tdIz">Lípidos:</td>
                        <td class="tdDe" ><span id="lipidosPromedio">0</span>%</td><!--30% es lo ideal-->
                    </tr>
                    <tr>
                        <td class="tdIz">Carbohidratos:</td>
                        <td class="tdDe" ><span id="carbohidratosPromedio">0</span>%</td><!--50% es lo ideal-->
                    </tr>
                </table>
                <div class = "menuFinalizar">
                    <hr>
                    <input type="button" id="finalizarDieta" onclick="contarElementos();" class="btn-act-usr btnMenuFin" value="Finalizar">
                    <p id="cancelarDieta" class="btn-act-usr btnCancelar icon-cancel-circle" onclick="location.reload();"></p>
                </div>
            </article>
            </form>
            <div class = "arrow-left invisible"></div>
        </section>
    </body>
</html>
