var circulo;
var $tituloFecha;
var fechaActual;
var fechaCambia;
var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiempre", "Octubre", "Noviembre", "Diciembre"];
var texto = "Hoy";
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
             $menuComidas.fadeOut(200);
         });
        $menuComidas.fadeToggle(200);
    }
    $buttonCambiar.on('click', showMenu); 
    
    //Esto despliega todos los alimentos
    function alimentoAdapter(nombre, calorias, ids){
        var $alimentoItem = $('.Alimentos-item').first();
        var $contenedor = $('.Alimentos');
        var $buscadorAviso = $('#Buscador-aviso');
        var aviso = $buscadorAviso.val();
        if(nombre.length > 0){
            $contenedor.empty();
            for(i in nombre){
                var $clon = $alimentoItem.clone();
                $buscadorAviso.hide();
                $clon.html('<p class="Alimentos-name">'+nombre[i]+'</p><span>'+calorias[i]+' kcal</span><button class="Alimentos-agregar">+<input type="hidden" id="alimento" value="'+ids[i]+'"></button>');
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
    $tituloFecha = $('#tituloFecha');
    fechaActual = new Date();
    fechaCambia = new Date();
    console.log("Actual: " + fechaActual);
    $('.Alimentos-agregar').on('click', agregar);
    $('.Consumidos-borrar').on('click', borrarAlimento);
    
    $('#cambiar-adelante').on('click', cambiarAdelante);
    $('#cambiar-atras').on('click', cambiarAtras);
});
function evaluaDia(){
    if((fechaCambia.getMonth() === fechaActual.getMonth()) && (fechaCambia.getFullYear() === fechaActual.getFullYear())){  
        if(fechaCambia.getDate() === fechaActual.getDate()){
            return "Hoy";
        } else if(fechaCambia.getDate() === (fechaActual.getDate() - 1)){
            return "Ayer";
        } else if(fechaCambia.getDate() === (fechaActual.getDate() + 1)){
            return "Mañana";
        }
    }
    return (meses[fechaCambia.getMonth()] + " " + fechaCambia.getDate()); 
}
function cambiarAtras(){
    var diaActual = fechaCambia.getDate();
    fechaCambia.setDate(diaActual - 1);
    texto = evaluaDia();
    $tituloFecha.text(texto);
    console.log("Actual: " + fechaCambia);
    setValores();
}
function cambiarAdelante(){
    var diaActual = fechaCambia.getDate();
    fechaCambia.setDate(diaActual + 1);   
    texto = evaluaDia();
    $tituloFecha.text(texto);
    console.log("Actual: " + fechaCambia);
    setValores();
}
function setValores(){
    var valor;
    var restantes;
    var meta;
    var porcentaje;
    var duracion = 500;
    var dayOfMonth = fechaCambia.getDate();
    var mes = fechaCambia.getMonth();
    var fullYear = fechaCambia.getFullYear();
    $.ajax({
        url: 'http://localhost:8080/StrongFit/sCambiarMetas',
        type: 'get',
        dataType: 'json',
        data: {diaMes: dayOfMonth, 
               numMes: mes, 
               year: fullYear},
        success: function(datos){
            valor = datos.calDia; //Calorias consumidas ese dia
            meta = $('#metaCalorias').html();
            restantes = meta - valor;
            porcentaje = valor / meta;
            porcentaje = porcentaje.toPrecision(2);
            console.log("Este es el porcentaje: " + porcentaje);
            $('#consumido').html('Consumido: '+ valor +' kcal');
            if(restantes < meta){
                circulo.path.setAttribute('stroke', 'red');
            }
            circulo.animate(porcentaje, {
                duration: duracion
            }, function(){
                console.log("Cargado");
                circulo.setText(restantes + ' kcal. restantes');
            }); 
        }
    });   
}
function agregar(e){
    e.preventDefault();
    var $listaTipo; //Sabemos a que lista agregar el alimento en el html
    var idAlimento = this.children[0].value; //El valor de hidden
    var textCalorias =  $(this).siblings('span').text(); //Calorias del alimento seleccionado
    var textNombre =  $(this).siblings('p').text(); //Nombre del alimento seleccionado
    var $clonBorrar = $('#prototipo-borrar').clone().removeClass("ocultar"); //Necesario para poder agregar un div de alimento a borrar
    var elemento = $('.Seleccionado').text(); //Con esto sabemos que tipo de comida es
    var tipo = 1;
    //Cuando fue agregado el alimento 
    var dayOfMonth = fechaCambia.getDate(); 
    var month = fechaCambia.getMonth();
    var year = fechaCambia.getFullYear();
    
    if(elemento === "Desayuno"){
        tipo = 1;
        $listaTipo = $('#comida-desayuno');
    }else if(elemento === "Colacion 1"){
        tipo = 2;
        $listaTipo = $('#comida-colacion1');
    }else if(elemento === "Comida"){
        tipo = 3;
        $listaTipo = $('#comida-comida');
    }else if(elemento === "Colacion 2"){
        tipo = 4;
        $listaTipo = $('#comida-colacion2');
    }else if(elemento === "Cena"){
        tipo = 5;
        $listaTipo = $('#comida-cena');
    }
    
    console.log("Esta aqui");
    $.ajax({
        url: "http://localhost:8080/StrongFit/sAgregarAlimento",
        type: "post",
        dataType: "text",
        data: {tipo: tipo, 
              valor: idAlimento,
              diaMes: dayOfMonth,
              mes: month,
              thisYear: year},
        success: function(datos){
            console.log(datos + " Y los datos apa");
            setValores();
            //Variable datos es el id del catalo fecha_alimento, con esto lo borramos ya ya no se muestra al usuario
            $clonBorrar.html('<p class="Alimentos-name">'+textNombre+'</p><span>'+textCalorias+'</span><button class="Consumidos-borrar">X<input type="hidden" value="'+datos+'"></button>');
            $listaTipo.append($clonBorrar);
            $('.Consumidos-borrar').on('click', borrarAlimento); 
        },error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}
function borrarAlimento(e){
    var idValor = $(this).children('input').val();
    console.log("Esta cosa funciona?" + idValor);
    var $elemento = $(this).parent();
    $.post('http://localhost:8080/StrongFit/sBorrarAlimentoFecha', {
        valor: idValor}, 
        function(){
            setValores();
            $elemento.remove();
        }
    );
    
}