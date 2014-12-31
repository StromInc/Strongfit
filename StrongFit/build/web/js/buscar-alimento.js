$(function(){
    //obtenemos los elementos a modificar
    var $elemento = $('#noCaloria'), 
    	numCalorias = parseFloat($elemento.html()),
    	$contenido = $('.content-contador'),
        $item = $('.racion').first();

        function agregar(e, res){
            //obtenemos lo que queremos del JSON
            e.preventDefault();
            var nombre = res.item.label,
                calorias = res.item.calorias,
                idAlimento = res.item.id;
            //hacemos un cron
            var $clon = $item.clone();
            numCalorias += calorias;
            //cambiamos los datos del cron
            $clon.html(nombre + '<span class="calorias"><br>Calorias: ' + calorias +'kc</span>');
            $clon.hide();
            //insertamos cron
            $contenido.prepend($clon);
            $clon.slideDown();
            $elemento.html(numCalorias);
            
            $.post('http://localhost:8080/StrongFit/sAgregarAlimento', 
                {dataType: 'json', valor: idAlimento});
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

