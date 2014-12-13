<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file = "../meta.jsp" %>
        <link rel="stylesheet" type = "text/css" href="../../Estilos/estilo_inicio.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
        <!--El script lo puse aqui porque no me cargaba desde un archivo externo, no se porque, luego lo checo-->
        <script>
            $(document).ready(function() {
                /*autocomplete es una funcion de jquery ui para hacer las cosas mas faciles*/
                $("#search").autocomplete({     
                    source : function(request, response) {
                        /*Esto es para la barra de busqueda*/
                        $.ajax({
                            url : "http://localhost:8080/StrongFit/sBusqueda",
                            type : "post",
                            dataType : "json",
                            data : {
                                info : request.term
                            },             
                            success : function(respuesta) {
                                    console.log("********Regreso algo******");
                                    console.log(respuesta);
                                    response(respuesta);
                            }
                        });
                    }
                });
            });
        </script>
    </head>
    <body>
        <%@include file = "barra_menu.jsp" %>
        
        <section class="Section-todo">
            <!--Esta es la seccion de la barra de busqueda, el sabias que y el conteo calorico-->
            <article class = "Article-menu">
                <p class="contenedor-search">
                    <span class = "span-search"><label class = "icon-search label-search" for = "buscar"></label></span>
                    <span class = "search"><input type="text" id="search" name="search" class="search"></span>
                </p>
                <div class = "div">
                    <div class = "content-title">
                        Consumo de hoy
                    </div>
                    <div class="content-contador" id = "style-4">
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                        <p class = "racion">Huevos con jamón<span class = "calorias"><br>Calorias: 100kc</span></p>
                    </div>
                    <div class = "content-total">
                        Kilocalorías consumidas: <span>0kc</span>
                    </div>
                </div>
            </article>

            <!--Esta es la parte en la que te sugiere el platillo que te toca segun tu dieta-->
            <div style = "width: 62%; ">
                <article class = "Article-sugerir margen-estadisticas">
                    <div class = "Article-platillos">
                        <div class = "meta estadisticas">
                            Meta
                            <hr>
                            <p>1800kc</p>
                        </div>
                        <div class = "consumido estadisticas">
                            Consumido
                            <hr>
                            <p>1300kc</p>
                        </div>
                        <div class = "faltante estadisticas">
                            Falta
                            <hr>
                            <p>500kc</p>
                        </div>
                    </div>
                </article>
                <article class = "Article-sugerir">
                    <div class="Article-sabias">
                        Esta parte es la de los sabias que?, y sera dinamica, las frases estaran guardadas en la base de datos
                    </div>
                    <div class = "Article-platillos">
                        <p>Platillos sugeridos para (D,Co,Ce)</p>
                        <hr>
                        <div class = "barra">
                            <div class = "comida-sugerida"><!--Maximo tres comidas sugeridas-->
                                <span class = "platillo">Huevos con tocino</span>
                                <span class = "platillo">Huevos con jamon</span>
                                <span class = "platillo">Cereal con leche</span>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
            <!--Esta es la seccion donde se pueden ver cosas publicadas por los medicos-->
            <article class = "Article-articulos">
                Aqui van los articulos que los medicos escriben para hacerse mas populares y asi tener mas clientes
            </article>
        </section>  
        
        
    </body>
</html>
