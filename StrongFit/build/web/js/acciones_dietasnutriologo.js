var idAlimentoD = 0;
var contadorD = 0;

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
    });
}


//esta es la parte en la que se muestran las pestañas
function mostrarDomingo()
{
    $(function(){
        $('#domingoDieta').addClass('visible');
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
                        url: 'http://localhost:8080/StrongFit/sBusqueda',
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
                                var $clon = $('#resultadoClon').clone();
                                var idClon = ids[i] + contadorD;
                                $clon.removeClass('invisible');
                                $clon.attr('id', idClon);
                                $clon.html('<input type = "hidden" id = "alimento'+idClon+'" name = "ids" value="'+idClon+'"><input type = "hidden" id = "calorias'+idClon+'" name = "calorias" value="'+calorias[i]+'"><input type = "hidden" id = "lipidos'+idClon+'" name = "lipidos" value="lipidos"><input type = "hidden" id = "proteinas'+idClon+'" name = "proteinas" value="proteinas"><input type = "hidden" id = "carbohidratos'+idClon+'" name = "carbohidratos" value="carbohidratos"><span id="textoResultado">'+nombre[i]+'</span><span id = "tache'+idClon+'" class = "icon-cancel-circle invisible"></span>');
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




