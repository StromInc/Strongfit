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
                    for(var i in datos){
                        nombre[i] = datos[i].nombre;
                        calorias[i] = datos[i].calorias;      
                    }
                    alimentoAdapter(nombre, calorias);
                }
        });
        }
    });
    //Esto despliega todos los alimentos
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
    //La funcion que modifica los valores de la grafica
    
});
function setValores(){
    var valor;
    var restantes;
    var meta;
    $.ajax({
        url: 'http://localhost:8080/StrongFit/sCambiarMetas',
        type: 'get',
        dataType: 'json',
        data: $('#formularioOculto').serialize(),
            success: function(datos){
                valor = datos.calDia;
                meta = $('#metaCalorias').html();
                restantes = meta - valor;
                circulo.animate(valor, {
                    duration: 500
                }, function(){
                    console.log("Cargado");
                    circulo.setText(restantes + ' cal. restantes');
                }); 
            }
    });   
}
function agregar(){
    
}