$(function(){
    $("#buscadorBoton").on("click", function() {
        var alimento = $("#input-alimento").val().trim();
        if(alimento.length  > 0){
            console.log(alimento);
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sBusqueda',
                type: 'get',
                dataType: 'json',
                data: {'nombre-alimento': alimento},
                success: function(datos){
                    var nombre = [];
                    var calorias = [];
                    for(var i in datos){
                        nombre[i] = datos[i].nombre;
                        calorias[i] = datos[i].calorias;      
                    }
                    alimentoAdapter(nombre, calorias);
                }
        });
        }
    });
    function alimentoAdapter(nombre, calorias){
        var $alimentoItem = $('.Alimentos-item').first();;
        var $contenedor = $('.Alimentos');
        var $buscadorAviso = $('.Buscador-aviso');
        var aviso = $buscadorAviso.val();
        if(nombre.length > 0){
            $contenedor.empty();
            for(i in nombre){
                var $clon = $alimentoItem.clone();
                $buscadorAviso.hide();
                console.log($clon);
                $clon.html('<p class="Alimentos-name">'+nombre[i]+'</p><span>'+calorias[i]+' cal</span><button class="Alimentos-agregar">+</button>');
                $clon.hide();
                $contenedor.prepend($clon);
                $clon.slideDown();
                $buscadorAviso.text("Resultados Encontrados").removeClass("color-rojo");
                $buscadorAviso.slideDown();
            }    
        }else{
            $buscadorAviso.hide();
            $buscadorAviso.text("No se encontraron resultados").addClass("color-rojo");
            $contenedor.empty();
            var $clon = $alimentoItem.clone();
            $clon.html('<p class="Alimentos-name"></p><span></span>');
            $clon.hide();
            $contenedor.prepend($clon);
            $buscadorAviso.slideDown();
        }       
    }
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
        }
    var circulo = new ProgressBar.Circle('#container', {
    color: '#0070C8',
    strokeWidth: 2,
    trailColor: "#f4f4f4",
    text: {
        color: 'black',
        className: 'progressbar__label'
    }
    });
    function setValores(consumidas, meta){
        var valor = consumidas / meta;
        var restantes = meta - consumidas;
        circulo.animate(valor, {
            duration: 500
        }, function(){
            console.log("Cargado");
            circulo.setText(restantes + ' cal. restantes');
        }); 
    }
    setValores(consumidas, meta);
});
function cambiarMetas(){
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