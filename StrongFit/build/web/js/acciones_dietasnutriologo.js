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
function drag(ev) {
    /*obtiene el tipo de dato que se esta arrastrando*/
    ev.dataTransfer.setData("text", ev.target.id);
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
        $('#tache1').removeClass('invisible');
        //Ajustamos al elemento contenedor de el alimento para que se vea bien
        $('#resultado1').addClass('enMenu');
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
    });
}


//Con este se elimina el elemento cuando se aprieta el boton de tache
function remover(id)
{
    $(function(){
        $("#resultado1").remove();
    });
}