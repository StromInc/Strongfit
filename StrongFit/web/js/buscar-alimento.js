var circulo;
$(function(){
    //Se ejecuta cuando se busca un alimento
    $("#buscadorBoton").on("click", function() {
        var alimento = $("#input-alimento").val().trim();
        if(alimento.length  > 0){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sBusqueda',
                type: 'get',
                dataType: 'json',
                data: {'nombre-alimento': alimento},
                success: function(datos){
                    var nombre = [];
                    var calorias = [];
                    var ids = [];
                    for(var i in datos){
                        nombre[i] = datos[i].nombre;
                        calorias[i] = datos[i].calorias; 
                        ids[i] = datos[i].id;
                    }
                    alimentoAdapter(nombre, calorias, ids);
                }
        });
        }
    });
    var $buttonCambiar = $( "#buscadorCambiar");
    var $menuComidas = $( "#buscadorNav" );
    function showMenu(e) {
        e.preventDefault();
         var $comidas = $( ".Comida" );
         $comidas.on('click', function(){
             $('.Buscador-title').text('Agregar alimentos a: ' + $(this).text());
             $comidas.removeClass('Seleccionado');
             $(this).addClass('Seleccionado');
         });
        $menuComidas.fadeToggle(200);
    }
    $buttonCambiar.on('click', showMenu); 
    
    //Esto despliega todos los alimentos
    function alimentoAdapter(nombre, calorias, ids){
        var $alimentoItem = $('.Alimentos-item').first();
        var $contenedor = $('.Alimentos');
        var $buscadorAviso = $('.Buscador-aviso');
        var aviso = $buscadorAviso.val();
        if(nombre.length > 0){
            $contenedor.empty();
            for(i in nombre){
                var $clon = $alimentoItem.clone();
                $buscadorAviso.hide();
                $clon.html('<p class="Alimentos-name">'+nombre[i]+'</p><span>'+calorias[i]+' cal</span><button class="Alimentos-agregar">+<input type="hidden" id="alimento" value="'+ids[i]+'"></button>');
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
        $('.Alimentos-agregar').on('click', agregar);
    }
    //Esto crea un circulo
    circulo = new ProgressBar.Circle('#container', {
        color: '#0070C8',
        strokeWidth: 2,
        trailColor: "#f4f4f4",
        text: {
            color: 'black',
            className: 'progressbar__label'
        }
    });
    $('.Alimentos-agregar').on('click', agregar);   
});
function setValores(){
    var valor;
    var restantes;
    var meta;
    var porcentaje;
    var duracion = 500;
    $.ajax({
        url: 'http://localhost:8080/StrongFit/sCambiarMetas',
        type: 'get',
        dataType: 'json',
        data: $('#formularioOculto').serialize(),
            success: function(datos){
                valor = datos.calDia;
                meta = $('#metaCalorias').html();
                restantes = meta - valor;
                porcentaje = valor / meta;
                $('#consumido').html('Consumido: '+valor+' cal');
                if(restantes < meta){
                    circulo.path.setAttribute('stroke', 'red');
                }
                circulo.animate(porcentaje, {
                    duration: duracion
                }, function(){
                    console.log("Cargado");
                    circulo.setText(restantes + ' cal. restantes');
                }); 
            }
    });   
}
function agregar(e){
    e.preventDefault();
    var idAlimento;
    idAlimento = this.children[0].value;
    console.log(this + " " + idAlimento);
    $.post('http://localhost:8080/StrongFit/sAgregarAlimento', {
        dataType: 'json', 
        valor: idAlimento}, 
        function(){
            setValores();
        }
    );
}