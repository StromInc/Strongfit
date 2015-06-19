<%@page import="java.text.DecimalFormat"%>
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
                <div class = "dietaCreada" id = '<%="dieta" + contadorD%>' onclick="mostrarDieta(<%=idDieta%>, <%=contadorD%>);">
                    <input type="hidden" name="idsDieta" id="idsDieta<%=contadorD%>" value="<%=idDieta%>">
                    <span id="nombreDieta<%=contadorD%>"><%=nom%></span><div class="divTusDietas"><input type="button" name="btnEditarD" class="btnEditarD" onclick="editarDieta(<%=contadorD%>);" value="Editar"><input type="button" name="btnBorrarD" class="btnEliminarD" onclick="borrarDieta(<%=contadorD%>);" value="Eliminar"></div>
                </div>
                <%
                        contadorD++;
                    }
                %>

                <input type="button" name="nueva" value="Nueva" class="btn-act-usr" onclick = "ocultar()">
            </article>
                
                <article class="Article-dietas" id="mostrarDieta">
                    <div id="datosDieta">
                        <span id="nombreMuestraDieta"></span>
                        <br>
                        <span id="caloriasMuestra"></span>
                        <span id="proteinasMuestra"></span>
                        <span id="lipidosMuestra"></span>
                        <span id="carbohidratosMuestra"></span>
                    </div>
                    <div class = "menuCrear">
                        <div class="opcionMenu transparente MenuMuestra" id ="muestraDia0" onclick = "mostrarDiaMuestra(0);">
                            Domingo
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia1" onclick = "mostrarDiaMuestra(1);">
                            Lunes
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia2" onclick = "mostrarDiaMuestra(2);">
                            Martes
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia3" onclick = "mostrarDiaMuestra(3);">
                            Miércoles
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia4" onclick = "mostrarDiaMuestra(4);">
                            Jueves
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia5" onclick = "mostrarDiaMuestra(5);">
                            Viernes
                        </div>
                        <div class="opcionMenu MenuMuestra" id ="muestraDia6" onclick = "mostrarDiaMuestra(6);">
                            Sábado
                        </div>
                    </div>
                    
                    <%
                        String catalogoComidas[] = {"Desayuno", "Colación 1", "Comida", "Colación 2", "Cena"};
                        String mostrar = "";
                        int contadorMuestra = 0;
                        for(int i = 0; i < 7; ++i){
                            if(i == 1){mostrar = "invisible";}
                    %>
                    
                    <div class = "Muestras diasDieta <%=mostrar%>" id="diaMuestra<%=i%>">
                        <%
                        for(int j = 0; j < 5; j++){
                        %>
                        <div class="espacionMuestra">
                            <h2>
                                <%=catalogoComidas[j]%>
                            </h2>
                            <div class="espacioDieta" id="espacioMuestraContenedor<%=contadorMuestra%>"></div>
                        </div>
                        <%
                        contadorMuestra++;
                        }
                        %>
                    </div>
                    
                    <%
                        }
                    %>
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
                        
                        DecimalFormat formateador = new DecimalFormat("####.##");
                        
                        
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
                                        
                                        caloriasDia[contadorDiasE] += calorias * cantidad / 100;
                                        proteinasD[contadorDiasE] += proteinas * cantidad / 100;
                                        lipidosD[contadorDiasE] += lipidos * cantidad / 100;
                                        carbohidratosD[contadorDiasE] += carbohidratos * cantidad / 100;

                                        caloriasDia[contadorDiasE] = formateador.parse(formateador.format(caloriasDia[contadorDiasE])).floatValue();
                                        proteinasD[contadorDiasE] = formateador.parse(formateador.format(proteinasD[contadorDiasE])).floatValue();
                                        lipidosD[contadorDiasE] = formateador.parse(formateador.format(lipidosD[contadorDiasE])).floatValue();
                                        carbohidratosD[contadorDiasE] = formateador.parse(formateador.format(carbohidratosD[contadorDiasE])).floatValue();
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
                    <span>
                        <select class = "filtros" id="filtro" onchange="buscarAlimento();">
                            <option value="0">Todos</option>
                            <%
                                ResultSet filtros = conecta.spGetTiposAlimento();
                                String filtro = "";
                                int tipoF = 0;
                                while(filtros.next()){
                                    filtro = filtros.getString("tipoAlimento");
                                    tipoF = filtros.getInt("idTipoAlimento");
                                    %>
                                    <option value="<%=tipoF%>"><%=filtro%></option>
                                    <%
                                }
                            %>
                        </select>
                    </span>
                
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
                        <div class="opcionMenu transparente" id ="diamen0" onclick = "mostrarDias(0);">
                            Domingo
                        </div>
                        <div class="opcionMenu" id ="diamen1" onclick = "mostrarDias(1);">
                            Lunes
                        </div>
                        <div class="opcionMenu" id ="diamen2" onclick = "mostrarDias(2);">
                            Martes
                        </div>
                        <div class="opcionMenu" id ="diamen3" onclick = "mostrarDias(3);">
                            Miércoles
                        </div>
                        <div class="opcionMenu" id ="diamen4" onclick = "mostrarDias(4);">
                            Jueves
                        </div>
                        <div class="opcionMenu" id ="diamen5" onclick = "mostrarDias(5);">
                            Viernes
                        </div>
                        <div class="opcionMenu" id ="diamen6" onclick = "mostrarDias(6);">
                            Sábado
                        </div>
                    </div>
                    
                    <div>
                        <!--==========================================================================-->
                    <%
                        mostrar = "";
                        contadorMuestra = 0;
                        contadorD1 = 0;
                        for(int i = 0; i < 7; ++i){
                            if(i == 1){mostrar = "invisible";}
                    %>
                    
                    <div class = "diasDieta <%=mostrar%>" id="diaDieta<%=i%>">
                        <%
                        for(int j = 0; j < 5; j++){
                        %>
                        <div class="espacionMuestra">
                            <h2>
                                <%=catalogoComidas[j]%>
                            </h2>
                            <div class="espacioDieta" id="espacio<%=contadorMuestra%>" ondrop="drop(event, id)" ondragover="allowDrop(event)">
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
                                
                                if(edicion){
                                    
                                            ResultSet comdia = conecta.spGetAlimentoComida(comidasE[i][j]);
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
                        <%
                        contadorMuestra++;
                        }
                        %>
                    </div>
                    
                    <%
                        }
                    %>
                        <!--==========================================================================-->
                        
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
