<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasusr.css">
        <link rel="stylesheet" type="text/css" href="../../Estilos/estilo_dietasnutriologo.css">
        <script src="../../js/acciones_dietasnutriologo.js"></script>
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
                    <span class = "search"><input type="search" placeholder = "buscar alimentos ..." class = "input-search" id = "buscar"></span>
                </p>
            </article>
            
            <!--Esta es la parte en la que se ensambla la dieta-->
            <article class="Article-dietas Article-dietas2 invisible tamano" id="crearDietas">
                <form>
                    <div class = "menuCrear">
                        <div class="opcionMenu">
                            Domingo
                        </div>
                        <div class="opcionMenu">
                            Lunes
                        </div>
                        <div class="opcionMenu">
                            Martes
                        </div>
                        <div class="opcionMenu">
                            Miércoles
                        </div>
                        <div class="opcionMenu">
                            Jueves
                        </div>
                        <div class="opcionMenu">
                            Viernes
                        </div>
                        <div class="opcionMenu">
                            Sábado
                        </div>
                    </div>
                    
                    <div>
                        <div class = "diasDieta" id="domingoDieta">
                            <div class="desalluno">
                                <h2>
                                    Desalluno
                                </h2>
                                <div class="espacioDieta"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 1
                                </h2>
                                <div class="espacioDieta"></div>
                            </div>
                            
                            <div class="comida">
                                <h2>
                                    Comida
                                </h2>
                                <div class="espacioDieta"></div>
                            </div>
                            
                            <div class="colacion">
                                <h2>
                                    Colación 2
                                </h2>
                                <div class="espacioDieta"></div>
                            </div>
                            
                            <div class="cena">
                                <h2>
                                    Cena
                                </h2>
                                <div class="espacioDieta"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </article>
            
            <!--Esta es la parte en donde se ve el balanceo de los nutrientes-->
            <article class="Article-dietas Article-dietas3 invisible tamano" id = "balanceoDietas">
                
            </article>
            
            <div class = "arrow-left invisible"></div>
        </section>
    </body>
</html>
