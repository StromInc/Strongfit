$(function(){
    //obtenemos los elementos a modificar
    var $contenido = $('.content-contador'),
        $item = $('.racion').first();
        function agregar(e, res){
            //obtenemos lo que queremos del JSON
            var nombre = res.item.label,
                calorias = res.item.calorias;
            e.preventDefault();
            //hacemos un cron
            var $clon = $item.clone();
            //cambiamos los datos del cron
            $clon.html(nombre + '<span class="calorias"><br>Calorias: ' + calorias +'kc</span>');
            $clon.hide();
            //insertamos cron
            $contenido.prepend($clon);
            $clon.slideDown();
        }
    //utilizamos autocomplete (Funcion de jquery-ui)
    $('#search').autocomplete({
        //busqueda del alimento
        source: function(request, response){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sBusqueda',
                type: 'post',
                dataType: 'json',
                data: {
                    info : request.term
                },
                //respuesta del servidor
                success: function(respuesta){
                    console.log(respuesta);
                    response(respuesta);
                }
            });
        },
        //esta funcion se ejecuta al seleccionar
        select: agregar
    });
});

