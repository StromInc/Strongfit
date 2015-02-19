$(function(){
    //obtenemos los elementos a modificar
    var $elemento = $('#noCaloria'); 
    var numCalorias = parseFloat($elemento.html());
    var $contenido = $('.content-contador'),
        $item = $('.racion').first();
        function agregar(e, res){
            //obtenemos lo que queremos del JSON
            e.preventDefault();
            var nombre = res.item.label,
                calorias = res.item.calorias,
                idAlimento = res.item.id;
        
            numCalorias += calorias;
            //hacemos un cron
            var $clon = $item.clone();
            $clon.removeClass('hidden');
            //cambiamos los datos del cron
            $clon.html(nombre + '<span class="calorias"><br>Calorias: ' + calorias +'kc</span>');
            $clon.hide();
            //insertamos cron
            $contenido.prepend($clon);
            $clon.slideDown();
            $elemento.html(numCalorias);
            $.post('http://localhost:8080/StrongFit/sAgregarAlimento', 
                {dataType: 'json', valor: idAlimento}, function(){
                    cambiarMetas();
                });
            /*
             * Esto es lo de arriba
            $.ajax({
               url: 'http://localhost:8080/StrongFit/sAgregarAlimento',
               type: 'post',
               dataType: 'json',
               data: {
                   valor: idAlimento
               }
            });*/
        }
        
        function cambiarMetas()
        {
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sCambiarMetas',
                type: 'post',
                dataType: 'json',
                data: $('#formularioOculto').serialize(),
                success: function(datos)
                {
                    $('#consumido').html(datos.calDia);
                    $('#falta').html($('#metaCalorias').html() - $('#consumido').html());
                }
            });
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

