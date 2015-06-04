var idAlimentoD = 0;
var contadorD = 0;
var dia = 0;

var idRandom = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
var idReforzado = 0;
var cantidadDef = 30;

var caloriasMeta = 0;
var caloriasDia = [];
var caloriasPromedio = 0;
var proteinas = [], proPorciento = [];
var lipidos = [], lipPorciento = [];
var carbohidratos = [], carPorciento = [];

var proTem = 0;
var lipTem = 0;
var carTem = 0;
var calTem = 0;

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
function ocultar(){
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
//function mostrarOpciones(id)
//{
//    $(function(){
//        setTimeout(function(){
//            $('#opc' + id).removeClass('invisible');
//        },200);
//    });
//}
//
////oculta las opciones que tienen las dietas creadas
//function ocultarOpciones(id)
//{
//    $(function(){
//        setTimeout(function(){
//            $('#opc' + id).addClass('invisible');
//        },200);
//    });
//}

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
        
        var divContent = $('#'+id);
        var dat = ev.dataTransfer.getData("text");
        
        if(divContent.find('#'+idAlimentoD).length === 0){
//            console.log($('#'+id+' .enMenu .idsClass'));
            var $elementos = $('#'+id+' .enMenu .idsClass');
            var cuentaSi = 0;
            for(var i = 0; i < $elementos.length; ++i){
                if($elementos[i].value === $('#' + idAlimentoD +' input[type="hidden"]').first().val()){
                    cuentaSi++;
                }
            }
            
            if(cuentaSi === 0){
                divContent.append(document.getElementById(dat));
                //hacemos visible un tache para que cuando se apachurre se elimine ese elemento
                $('#tache'+idAlimentoD).removeClass('invisible');
                $('#flechitas'+idAlimentoD).removeClass('invisible');
                //Ajustamos al elemento contenedor de el alimento para que se vea bien
                $('#'+idAlimentoD).addClass('enMenu');

                if(!$('#'+idAlimentoD).hasClass('yaEsta')){
                    ajustarCantidad(idAlimentoD);
                    automatizarCalculos(idAlimentoD);
                    $('#'+idAlimentoD).addClass('yaEsta');
                }
            }
        }
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
        ajustarCantidad(id);
        caloriasDia[dia] -= calTem;
        caloriasDia[dia] = parseFloat(caloriasDia[dia].toFixed(1));
        
        if(caloriasDia[dia] < 0){
            caloriasDia[dia] = 0;
        }

        caloriasPromedio = 0;
        for(var i = 0; i < caloriasDia.length; ++i){
            caloriasPromedio += caloriasDia[i];
        }
        caloriasPromedio = caloriasPromedio / 7;
        caloriasPromedio = parseFloat(caloriasPromedio.toFixed(1));
        
        proteinas[dia] -= proTem;
        lipidos[dia] -= lipTem;
        carbohidratos[dia] -= carTem;
        
        proteinas[dia] = parseFloat(proteinas[dia].toFixed(1));
        lipidos[dia] = parseFloat(lipidos[dia].toFixed(1));
        carbohidratos[dia] = parseFloat(carbohidratos[dia].toFixed(1));
        
        porcentajes();
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
//                                console.log(idClon);
                                $clon.html('<input type = "hidden" id = "alimento'+idClon+'" class="idsClass" name = "ids" value="'+ids[i]+'"><input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'"><input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="'+datos[i].lipidos+'"><input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="'+datos[i].proteinas+'"><input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="'+datos[i].carbohidratos+'"><input type="hidden" id="consideracion'+idClon+'" name="consideracion" value="'+datos[i].consideracion+'"><input type="hidden" id="porcion'+idClon+'" name="porcion" value="'+datos[i].porcion+'"><input type="hidden" id="cantidad'+idClon+'" name="cantidad" value="30" ><span id="textoResultado">'+nombre[i]+'</span><span id = "tache'+idClon+'" onclick="remover('+idClon+');" class = "icon-cancel-circle invisible"></span><div class="invisible" id="flechitas'+idClon+'"><span class="icon3-circle-up flechitasF" onclick="incrementaBaja('+idClon+',1);" id="masF'+idClon+'"></span><span class="icon3-circle-down flechitasF" onclick="incrementaBaja('+idClon+',2);" id="menosF'+idClon+'"></span><input class="setCantidad" type="text" onchange="cambiarIndependiente('+idClon+');" id="cantidadAsignada'+idClon+'" value="'+cantidadDef+'">g</div>');
                                $('#resultadoClon').addClass('invisible');
                                $clon.appendTo("#idcontenedor-resultados");
//                                var tache =  document.getElementById("tache"+idClon);
//                                tache.addEventListener('click', function(){remover();});
//                                var tache =  document.getElementById("tache"+idClon);
//                                var conte = document.getElementById(idClon);
//                                console.log(tache);
//                                console.log(conte);
                                
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
        var confirmar = confirm("¿Esta seguro(a) qué desea finalizar esta dieta?, podrá editarla después si es necesario.");
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
        caloriasDia[dia] += calTem;
        caloriasDia[dia] = parseFloat(caloriasDia[dia].toFixed(1));
        
        
        proteinas[dia] += proTem;
        lipidos[dia] += lipTem;
        carbohidratos[dia] += carTem;
        
        proteinas[dia] = parseFloat(proteinas[dia].toFixed(1));
        lipidos[dia] = parseFloat(lipidos[dia].toFixed(1));
        carbohidratos[dia] = parseFloat(carbohidratos[dia].toFixed(1));
        
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

function ajustarCantidad(id){
    var cant = $('#cantidadAsignada'+id).val();
    $('#cantidad'+id).val(cant);
    proTem = cant * parseFloat($('#proteinas'+id).val()) / 100;
    lipTem = cant * parseFloat($('#lipidos'+id).val()) / 100;
    carTem = cant * parseFloat($('#carbohidratos'+id).val()) / 100;
    calTem = cant * parseFloat($('#calorias'+id).val()) / 100;
}

function ajustarCantidad2(id, can45){
    var cant = can45;
    proTem = cant * parseFloat($('#proteinas'+id).val()) / 100;
    lipTem = cant * parseFloat($('#lipidos'+id).val()) / 100;
    carTem = cant * parseFloat($('#carbohidratos'+id).val()) / 100;
    calTem = cant * parseFloat($('#calorias'+id).val()) / 100;
    $('#cantidad'+id).val(cant);
}

function porcentajes(){
    /*
     * La relacion es asi:
     * 1g de proteina ------------- 4 kcal
     * 1g de lipido --------------- 9 kcal
     * 1g de carbohidrato --------- 4 kcal
     */
    
    if(caloriasDia[dia] > 0){
        proPorciento[dia] = ((4 * proteinas[dia]) / caloriasDia[dia]) * 100;console.log(proPorciento[dia]);
        lipPorciento[dia] = ((9 * lipidos[dia]) / caloriasDia[dia]) * 100;console.log(lipPorciento[dia]);
        carPorciento[dia] = ((4 * carbohidratos[dia]) / caloriasDia[dia]) * 100;console.log(carPorciento[dia]);

        proPorciento[dia] = parseInt(proPorciento[dia].toFixed());
        carPorciento[dia] = parseInt(carPorciento[dia].toFixed());
        lipPorciento[dia] = parseInt(lipPorciento[dia].toFixed());
    }
    else{
        proPorciento[dia] = 0;
        lipPorciento[dia] = 0;
        carPorciento[dia] = 0;
    }
    
    caloriasPromedio = 0;
    for(var i = 0; i < caloriasDia.length; ++i){
        caloriasPromedio += caloriasDia[i];
    }
    caloriasPromedio = caloriasPromedio / 7;
    caloriasPromedio = parseFloat(caloriasPromedio.toFixed());
    
    $('#caloriasDia').html(caloriasDia[dia]);
    $('#caloriasPromedio').html(caloriasPromedio);
    $('#proteinasPromedio').html(proPorciento[dia]);
    $('#lipidosPromedio').html(lipPorciento[dia]);
    $('#carbohidratosPromedio').html(carPorciento[dia]);
}

function incrementaBaja(id, tipo3){
//    $(function(){
        var $can = parseInt($('#cantidad'+id).val());
        var $canAsignada = parseInt($('#cantidadAsignada'+id).val());
        
        if(tipo3 === 1){ 
            $canAsignada += 10;
        }
        else{
            $canAsignada -= 10;
        }
        
        if($canAsignada > 0){
            ajustarCantidad2(id, $can);
            caloriasDia[dia] -= calTem;
            proteinas[dia] -= proTem;
            lipidos[dia] -= lipTem;
            carbohidratos[dia] -= carTem;

            caloriasDia[dia] = parseFloat(caloriasDia[dia].toFixed(1));
            proteinas[dia] = parseFloat(proteinas[dia].toFixed(1));
            lipidos[dia] = parseFloat(lipidos[dia].toFixed(1));
            carbohidratos[dia] = parseFloat(carbohidratos[dia].toFixed(1));

            $('#cantidadAsignada'+id).val($canAsignada);
            ajustarCantidad2(id, $canAsignada);

            caloriasDia[dia] += calTem;
            proteinas[dia] += proTem;
            lipidos[dia] += lipTem;
            carbohidratos[dia] += carTem;

            porcentajes();
            if($canAsignada <= 10){
                $('#menosF'+id).addClass('desactivado');
            }
            else{
                $('#menosF'+id).removeClass('desactivado');
            }
        }
//    });
}

function cambiarIndependiente(id){
    $(function(){
        var $can = parseInt($('#cantidad'+id).val());
        var $canAsignada = parseInt($('#cantidadAsignada'+id).val());
        
        ajustarCantidad2(id, $can);
        caloriasDia[dia] -= calTem;
        proteinas[dia] -= proTem;
        lipidos[dia] -= lipTem;
        carbohidratos[dia] -= carTem;
        
        caloriasDia[dia] = parseFloat(caloriasDia[dia].toFixed(1));
        proteinas[dia] = parseFloat(proteinas[dia].toFixed(1));
        lipidos[dia] = parseFloat(lipidos[dia].toFixed(1));
        carbohidratos[dia] = parseFloat(carbohidratos[dia].toFixed(1));
        
        if($canAsignada < 0){
            $canAsignada = $canAsignada * -1;
        }
        
        $('#cantidadAsignada'+id).val($canAsignada);
        ajustarCantidad2(id, $canAsignada);

        caloriasDia[dia] += calTem;
        proteinas[dia] += proTem;
        lipidos[dia] += lipTem;
        carbohidratos[dia] += carTem;
        
        porcentajes();
        if($canAsignada <= 10){
                $('#menosF'+id).addClass('desactivado');
            }
            else{
                $('#menosF'+id).removeClass('desactivado');
            }
    });
}


function borrarDieta(contadorD){
    $(function(){
        var confirmacion = confirm("Esta seguro(a) que desesa borrar esta dieta, los pacientes que la esten siguiendo también se verán afectados.");
        if(confirmacion){
            var idDiet = $('#idsDieta'+contadorD).val();
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sBorrarDieta',
                type: 'post',
                dataType: 'json',
                data: {
                    idDieta: idDiet
                },
                success: function(res){
                    $('#dieta'+contadorD).remove();
                }
            });
        }
    });
}


function editarDieta(contadorD){
    $(function(){
        var idDiet = $('#idsDieta'+contadorD).val();
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sEditarDieta',
            type: 'post',
            dataType: 'json',
            data: {
                idDieta: idDiet
            },
            success: function(res){
                location.reload();
            }
        });
    });
}


