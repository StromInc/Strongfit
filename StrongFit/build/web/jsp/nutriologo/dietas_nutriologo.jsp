<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasnutriologo.css">
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
                <div class = "dietaCreada" id = "1" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
                    Nombre de la dieta
                    <div id = "opc1" class="opciones invisible">
                        <span class = "arrow-left"></span>
                        <div class = "opcionesDiv"><p onclick = "editarDieta()">Editar</p><p onclick = "borrarDieta()">Eliminar</p></div>
                    </div>
                </div>
                <div class = "dietaCreada" id = "2" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
                    Nombre de la dieta
                    <div id = "opc2" class="opciones invisible">
                        <span class = "arrow-left"></span>
                        <div class = "opcionesDiv"><p onclick = "editarDieta()">Editar</p><p onclick = "borrarDieta()">Eliminar</p></div>
                    </div>
                </div>
                <div class = "dietaCreada" id = "3" onmouseover = "mostrarOpciones(id)" onmouseout="ocultarOpciones(id)">
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
                    <input type="search" placeholder = "buscar alimentos ..." class = "input-search" id = "buscar">
                </p>
                <div class = "contenedor-resultados">
                    <div class = "resultado" id = "resultado1" draggable = "true" ondragstart="drag(event)">
                        <input type = "hidden" id = "alimento1" name = "ids" value="iddelalimento">
                        <input type = "hidden" id = "calorias1" name = "calorias" value="calorias">
                        <input type = "hidden" id = "lipidos1" name = "lipidos" value="lipidos">
                        <input type = "hidden" id = "proteinas1" name = "proteinas" value="proteinas">
                        <input type = "hidden" id = "carbohidratos1" name = "carbohidratos" value="carbohidratos">
                        huevo 10kc
                        <span id = "tache1" class = "icon-cancel-circle invisible" onclick = "remover(id)"></span>
                    </div>
                    <div class = "resultado" id = "resultado2" draggable = "true" ondragstart="drag(event)">
                        <input type = "hidden" id = "alimento2" name = "ids" value="iddelalimento">
                        <input type = "hidden" id = "calorias2" name = "calorias" value="calorias">
                        <input type = "hidden" id = "lipidos2" name = "lipidos" value="lipidos">
                        <input type = "hidden" id = "proteinas2" name = "proteinas" value="proteinas">
                        <input type = "hidden" id = "carbohidratos2" name = "carbohidratos" value="carbohidratos">
                        bistec 14kc
                        <span id = "tache2" class = "icon-cancel-circle invisible" onclick = "remover(id)"></span>
                    </div>
                </div>
            </article>
            
            <!--Esta es la parte en la que se ensambla la dieta-->
            <article class="Article-dietas Article-dietas2 invisible tamano" id="crearDietas">
                <form id = "dietaNueva">
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
                                <div class="espacioDieta" id ="DesallunoDomingo" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Domingo" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaDomingo" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Domingo" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaDomingo" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del lunes-->
                        <div class = "diasDieta invisible" id="lunesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoLunes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Lunes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaLunes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Lunes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaLunes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del martes-->
                        <div class = "diasDieta invisible" id="martesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoMartes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Martes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaMartes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Martes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaMartes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del miercoles-->
                        <div class = "diasDieta invisible" id="miercolesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoMiercoles" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Miercoles" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaMiercoles" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Miercoles" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaMiercoles" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del jueves-->
                        <div class = "diasDieta invisible" id="juevesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoJueves" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Jueves" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaJueves" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Jueves" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaJueves" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del viernes-->
                        <div class = "diasDieta invisible" id="viernesDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoViernes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Viernes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaViernes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Viernes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaViernes" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                        
                        <!--Esta es la parte de edicion del sabado-->
                        <div class = "diasDieta invisible" id="sabadoDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta" id ="DesallunoSabado" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta" id="Colacion1Sabado" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta" id="ComdiaSabado" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta" id = "Colacion2Sabado" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta" id = "CenaSabado" ondrop="drop(event, id)" ondragover="allowDrop(event)"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </article>
            
            <!--Esta es la parte en donde se ve el balanceo de los nutrientes-->
            <article class="Article-dietas Article-dietas3 invisible tamano" id = "balanceoDietas">
                <input type="text" id = "nombreNuevaDieta" class ="nombreDieta-txt" name = "nombreNuevaDieta" placeholder = "Nombre de la dieta" required>
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
                        <td class="tdDe">2000kc</td>
                    </tr>
                    <tr>
                        <td class="tdIz">Calorías promedio:</td>
                        <td class="tdDe">1950kc</td>
                    </tr>
                </table>
                <hr>
                <table class = "tablaInf">
                    <tr>
                        <td class="tdIz">Proteinas:</td>
                        <td class="tdDe">20%</td>
                    </tr>
                    <tr>
                        <td class="tdIz">Lípidos:</td>
                        <td class="tdDe">30%</td>
                    </tr>
                    <tr>
                        <td class="tdIz">Carbohidratos:</td>
                        <td class="tdDe">50%</td>
                    </tr>
                </table>
                <div class = "menuFinalizar">
                    <hr>
                    <input type="button" id="finalizarDieta" class="btn-act-usr btnMenuFin" value="Finalizar">
                    <p id="cancelarDieta" class="btn-act-usr btnCancelar icon-cancel-circle"></p>
                </div>
            </article>
            <div class = "arrow-left invisible"></div>
        </section>
        <script src="../../js/acciones_dietasnutriologo.js"></script>
    </body>
</html>
