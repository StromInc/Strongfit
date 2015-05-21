var idAlimentoD = 0;
var contadorD = 0;
var dia = 0;

var idRandom = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
var idReforzado = 0;

var caloriasMeta = 0;
var caloriasDia = [];
var caloriasPromedio = 0;
var proteinas = [], proPorciento = [];
var lipidos = [], lipPorciento = [];
var carbohidratos = [], carPorciento = [];

var tem = 0, t = 0;

for(var i = 0; i < 7; ++i){
    caloriasDia[i] = 0;
    proteinas[i] = 0;
    lipidos[i] = 0;
    carbohidratos[i] = 0;
    proPorciento[i] = 0;
    lipPorciento[i] = 0;
    carPorciento[i] = 0;
}

//oculta el menu de las dietas creadas
function ocultar()
{
    $(function(){
        $('#textoTitulo').addClass('textoBueno');
        $('#tusDietas').animate({
            width : 0,
            opacity : 0
        }, function(){
            $(this).addClass('invisible');
            revelar();
        });
    });
}

//muestra el menu de creacion o edicion de dietas
function revelar()
{
    $(function(){
        var tam = window.innerWidth;
        var tam1 = tam * .25;
        var tam2 = tam * .5;
        var tam3 = tam * .23;
        $('#buscarAlimentos').removeClass('invisible').animate({
            width: tam1
        }
        ,function(){
            $('#crearDietas').removeClass('invisible').animate({
                width: tam2
            }
            ,function(){
                $('#balanceoDietas').removeClass('invisible').animate({
                    width: tam3
                });
            });
        });
    });
}

//muestra las opciones de las dietas creadas
function mostrarOpciones(id)
{
    $(function(){
        setTimeout(function(){
            $('#opc' + id).removeClass('invisible');
        },200);
    });
}

//oculta las opciones que tienen las dietas creadas
function ocultarOpciones(id)
{
    $(function(){
        setTimeout(function(){
            $('#opc' + id).addClass('invisible');
        },200);
    });
}

//Se dispara para evitar cualquier cosa que ocurra por default
function allowDrop(ev) {
    ev.preventDefault();
}

/*se dispara cuando alguien arrastra un elemento*/
function drag(ev, id) {
    /*obtiene el tipo de dato que se esta arrastrando*/
    ev.dataTransfer.setData("text", ev.target.id);
    idAlimentoD = id;
}

//Se dispara cuando el elemento se suelta en alguna parte
function drop(ev, id)
{
    $(function(){
        ev.preventDefault();
        
        var divContent = document.getElementById(id);
        var dat = ev.dataTransfer.getData("text");
        
        divContent.appendChild(document.getElementById(dat));
        //hacemos visible un tache para que cuando se apachurre se elimine ese elemento
        $('#tache'+idAlimentoD).removeClass('invisible');
        //Ajustamos al elemento contenedor de el alimento para que se vea bien
        $('#'+idAlimentoD).addClass('enMenu');
        
        automatizarCalculos(idAlimentoD);
    });
}


//esta es la parte en la que se muestran las pestañas
function mostrarDomingo()
{
    $(function(){
        $('#domingoDieta').addClass('visible');
        dia = 0;
        mostrarEseDia(dia);
        if($('#domingoDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').addClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Domingo');
    });
}

function mostrarLunes()
{
    $(function(){
        $('#lunesDieta').addClass('visible');
        dia = 1;
        mostrarEseDia(dia);
        if($('#lunesDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').addClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Lunes');
    });
}

function mostrarMartes()
{
    $(function(){
        $('#martesDieta').addClass('visible');
        dia = 2;
        mostrarEseDia(dia);
        if($('#martesDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').addClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Martes');
    });
}

function mostrarMiercoles()
{
    $(function(){
        $('#miercolesDieta').addClass('visible');
        dia = 3;
        mostrarEseDia(dia);
        if($('#miercolesDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').addClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Miércoles');
    });
}

function mostrarJueves()
{
    $(function(){
        $('#juevesDieta').addClass('visible');
        dia = 4;
        mostrarEseDia(dia);
        if($('#juevesDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').addClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Jueves');
    });
}

function mostrarViernes()
{
    $(function(){
        $('#viernesDieta').addClass('visible');
        dia = 5;
        mostrarEseDia(dia);
        if($('#viernesDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        $('#sabadoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').addClass('transparente');
        $('#sabado').removeClass('transparente');
        
        $('.tdDe').first().html('Viernes');
    });
}

function mostrarSabado()
{
    $(function(){
        $('#sabadoDieta').addClass('visible');
        dia = 6;
        mostrarEseDia(dia);
        if($('#sabadoDieta').hasClass('invisible'))
        {
            $(this).removeClass('invisible');
        }
        $('#lunesDieta').addClass('invisible').removeClass('visible');
        $('#martesDieta').addClass('invisible').removeClass('visible');
        $('#miercolesDieta').addClass('invisible').removeClass('visible');
        $('#juevesDieta').addClass('invisible').removeClass('visible');
        $('#viernesDieta').addClass('invisible').removeClass('visible');
        $('#domingoDieta').addClass('invisible').removeClass('visible');
        
        $('#domingo').removeClass('transparente');
        $('#lunes').removeClass('transparente');
        $('#martes').removeClass('transparente');
        $('#miercoles').removeClass('transparente');
        $('#jueves').removeClass('transparente');
        $('#viernes').removeClass('transparente');
        $('#sabado').addClass('transparente');
        
        $('.tdDe').first().html('Sábado');
    });
}


//Con este se elimina el elemento cuando se aprieta el boton de tache
function remover(id)
{
    $(function(){
        alert(id);
        $("#"+id).remove();
    });
}


function buscarAlimento(){
    $(function(){
        $('#buscar').autocomplete({
            source: function(request, response){
                var alimento = request.term;
                if(alimento.length  > 0){
                    $.ajax({
                        url: 'http://localhost:8080/StrongFit/sBusquedaN',
                        type: 'get',
                        dataType: 'json',
                        data: {'nombre-alimento': alimento},
                        success: function(datos){
                            $('#idcontenedor-resultados').html('<div class = "resultado invisible" id = "resultadoClon" draggable = "true" ondragstart="drag(event, id)"></div>');
                            var nombre = [];
                            var calorias = [];
                            var ids = [];
                            for(var i in datos){
                                nombre[i] = datos[i].nombre;
                                calorias[i] = datos[i].calorias; 
                                ids[i] = datos[i].id;
                            }
                            for(var i = 0; i < nombre.length; ++i){
//                                idR = "";
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
//                                idR += idRandom[Math.floor((Math.random() * 62) + 1)];
                                var $clon = $('#resultadoClon').clone();
                                var idClon = contadorD;
                                $clon.removeClass('invisible');
                                $clon.attr('id', idClon);
                                $clon.html('<input type = "hidden" id = "alimento'+idClon+'" name = "ids" value="'+ids[i]+'"><input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'"><input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'"><input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'"><input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'"><input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'"><input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'"><input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="1" ><span id="textoResultado">'+nombre[i]+'</span><span id = "tache'+idClon+'" class = "icon-cancel-circle invisible"></span>');
                                $('#resultadoClon').addClass('invisible');
                                $clon.appendTo("#idcontenedor-resultados");
                                document.getElementById("tache"+idClon).addEventListener('click', function(){remover(idClon)});
                                contadorD++;
                            }
                        }
                    });
                }
            }
        });
    });
}

function contarElementos(){
    $(function(){
        var confirmar = confirm("Esta seguro(a) que desea finalizar esta dieta, podra editarla después si es necesario.");
        if(confirmar){
            var tam = 0;
            var valores = "";
            for(var i = 0; i < 35; i++){
                tam = ($('#espacio'+i+' div > input[type="hidden"]').length) / 8;
                valores += tam + ',';
            }
            var formDieta = document.getElementById("dietaNueva");
            var nom = $("#nombreNuevaDieta").val();
            formDieta.innerHTML += "<input type = 'hidden' name='cuantos' id='cuantos' value='"+valores+"' ><input type='hidden' name='nombreNuevaDieta' value='"+nom+"'>";
            console.log(formDieta);
            //alert($('#nombreNuevaDieta').val());
            formDieta.submit();
        }
    });
}

function setCaloriasMeta(){
    $(function(){
        caloriasMeta = $('#caloriasMeta').val();
    });
}

function automatizarCalculos(id){
    $(function(){
        caloriasDia[dia] += parseFloat($('#calorias'+id).val());
        caloriasPromedio = 0;
        for(var i = 0; i < caloriasDia.length; ++i){
            caloriasPromedio += caloriasDia[i];
        }
        caloriasPromedio = caloriasPromedio / 7;
        
        proteinas[dia] += parseFloat($('#proteinas'+id).val());
        lipidos[dia] += parseFloat($('#lipidos'+id).val());
        carbohidratos[dia] += parseFloat($('#carbohidratos'+id).val());
        
        porcentajes();
    });
}

function mostrarEseDia(d){
    $(function(){
        $('#caloriasDia').html(caloriasDia[d]);
        $('#proteinasPromedio').html(proPorciento[d]);
        $('#lipidosPromedio').html(lipPorciento[d]);
        $('#carbohidratosPromedio').html(carPorciento[d]);
    });
}

function porcentajes(){
    /*
     * La relacion es asi:
     * 1g de proteina ------------- 4 kcal
     * 1g de lipido --------------- 9 kcal
     * 1g de carbohidrato --------- 4 kcal
     */
    
    proPorciento[dia] = ((4 * proteinas[dia]) / caloriasDia[dia]) * 100;console.log(proPorciento[dia]);
    lipPorciento[dia] = ((9 * lipidos[dia]) / caloriasDia[dia]) * 100;console.log(lipPorciento[dia]);
    carPorciento[dia] = ((4 * carbohidratos[dia]) / caloriasDia[dia]) * 100;console.log(carPorciento[dia]);
    
    tem = proPorciento[dia] - Math.floor(proPorciento[dia]);
    if(tem >= .5){
        tem = 1;
    }
    else{
        tem = 0;
    }
    proPorciento[dia] = Math.floor(proPorciento[dia]) + parseInt(tem);
    
    tem = carPorciento[dia] - Math.floor(carPorciento[dia]);
    if(tem >= .5){
        tem = 1;
    }
    else{
        tem = 0;
    }
    carPorciento[dia] = Math.floor(carPorciento[dia]) + parseInt(tem);
    
    tem = lipPorciento[dia] - Math.floor(lipPorciento[dia]);console.log(tem);
    if(tem >= .5){
        tem = 1;
    }
    else{
        tem = 0;
    }
    lipPorciento[dia] = Math.floor(lipPorciento[dia]) + parseInt(tem);
    
    $('#caloriasDia').html(caloriasDia[dia]);
    $('#caloriasPromedio').html(caloriasPromedio);
    $('#proteinasPromedio').html(proPorciento[dia]);
    $('#lipidosPromedio').html(lipPorciento[dia]);
    $('#carbohidratosPromedio').html(carPorciento[dia]);
}




