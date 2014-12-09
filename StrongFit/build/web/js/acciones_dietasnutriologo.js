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

function mostrarOpciones(id)
{
    $(function(){
        setTimeout(function(){
            $('#opc' + id).removeClass('invisible');
        },200);
    });
}

function ocultarOpciones(id)
{
    $(function(){
        setTimeout(function(){
            $('#opc' + id).addClass('invisible');
        },200);
    });
}
