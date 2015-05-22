<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error500.jsp" import="org.apache.jasper.JasperException"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasnutriologo.css">
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
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
                <!--Esto es de prueba-->
                <div class = "dietaCreada" id = "dieta1" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
                    Nombre de la dieta
                    <div id = "opc1" class="opciones invisible">
                        <span class = "arrow-left"></span>
                        <div class = "opcionesDiv"><p onclick = "editarDieta()">Editar</p><p onclick = "borrarDieta()">Eliminar</p></div>
                    </div>
                </div>
                <div class = "dietaCreada" id = "dieta2" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
                    Nombre de la dieta
                    <div id = "opc2" class="opciones invisible">
                        <span class = "arrow-left"></span>
                        <div class = "opcionesDiv"><p onclick = "editarDieta()">Editar</p><p onclick = "borrarDieta()">Eliminar</p></div>
                    </div>
                </div>
                <div class = "dietaCreada" id = "dieta3" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
                    Nombre de la dieta
                    <div id = "opc3" class="opciones invisible">
                        <span class = "arrow-left"></span>
                        <div class = "opcionesDiv"><p onclick = "editarDieta()">Editar</p><p onclick = "borrarDieta()">Eliminar</p></div>
                    </div>
                </div>
                <!------------------------>
                <input type="button" name="nueva" value="Nueva" class="btn-act-usr" onclick = "ocultar()">
            </article>
            
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
                                <div class="espacioDieta" id ="espacio0" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio1" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio2" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio3" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio4" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del lunes-->
                        <div class = "diasDieta invisible" id="lunesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio5" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio6" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio7" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio8" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio9" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del martes-->
                        <div class = "diasDieta invisible" id="martesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio10" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio11" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio12" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio13" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio14" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del miercoles-->
                        <div class = "diasDieta invisible" id="miercolesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio15" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio16" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio17" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio18" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio19" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del jueves-->
                        <div class = "diasDieta invisible" id="juevesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio20" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio21" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio22" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio23" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio24" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del viernes-->
                        <div class = "diasDieta invisible" id="viernesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio25" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio26" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio27" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio28" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio29" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del sabado-->
                        <div class = "diasDieta invisible" id="sabadoDieta">
                            <div class="desalluno">
                                <h2>
                                    Desayuno
                                </h2>
                                <div class="espacioDieta" id ="espacio30" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="espacio31" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="espacio32" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "espacio33" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "espacio34" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                    </div>
                
            </article>
            
            <!--Esta es la parte en donde se ve el balanceo de los nutrientes-->
            <article class="Article-dietas Article-dietas3 invisible tamano" id = "balanceoDietas">
                <input type="text" id = "nombreNuevaDieta" class ="nombreDieta-txt" placeholder = "Nombre de la dieta" required>
             
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
                    <p id="cancelarDieta" class="btn-act-usr btnCancelar icon-cancel-circle"></p>
                </div>
            </article>
            </form>
            <div class = "arrow-left invisible"></div>
        </section>
        <script src="../../js/acciones_dietasnutriologo.js"></script>
         <script src="../../js/salir.js"></script>
    </body>
</html>
