var circulo;
var $tituloFecha;
var fechaCambia;
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
            for(var i in nombre){
                var $clon = $alimentoItem.clone().removeClass("ocultar");
                $buscadorAviso.hide();
                $clon.html('<p class="Alimentos-name">'+nombre[i]+'</p>\n\
                            <span class="Alimentos-subname">Contiene: '+calorias[i]+' kcal/100g</span>\n\
                            <div class="Alimentos-subname">\n\
                                Cantidad:<span class="icon3-circle-up Alimentos-arriba"></span>\n\
                                <input class="Alimentos-cantidad" type="number" id="alimentoCantidad" value="100"> g\n\
                                <span class="icon3-circle-down Alimentos-abajo"></span>\n\
                            </div>\n\
                            <button class="Alimentos-agregar">+<input type="hidden" value="'+ids[i]+'"></button>');
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
        color: '#645EB5',
        strokeWidth: 2,
        trailColor: "#f4f4f4",
        text: {
            color: 'black',
            className: 'progressbar__label'
        }
    });
    $tituloFecha = $('#tituloFecha');
    fechaCambia = new Date(); //Esta fecha cambia constantemente
    console.log("Actual: " + fechaCambia);
    $('.Alimentos-agregar').on('click', agregar);
    $('.Consumidos-borrar').on('click', borrarAlimento);
    
    $('#cambiar-adelante').on('click', cambiarAdelante);
    $('#cambiar-atras').on('click', cambiarAtras);
});
//Esto nos muestra los alimentos consumidos
function consumidosAdapter(nombre, calorias, ids, tiempoComida){
    var $alimentoItem = $('#prototipo-borrar');
    var $contenedor;
    $('.Consumidos-item').remove();
    if(nombre.length > 0){
        for(var i in nombre){
            var $clon = $alimentoItem.clone().removeClass("ocultar").attr("id", "");
            if(tiempoComida[i] === 1){
                $contenedor = $('#comida-desayuno');
            }else if(tiempoComida[i] === 2){
                $contenedor = $('#comida-colacion1');
            }else if(tiempoComida[i] === 3){
                $contenedor = $('#comida-comida');
            }else if(tiempoComida[i] === 4){
                $contenedor = $('#comida-colacion2');
            }else if(tiempoComida[i] === 5){
                $contenedor = $('#comida-cena');
            }
            $clon.html('<p class="Consumidos-name">'+nombre[i]+'</p><span class="Consumidos-subname">Consumidos: '+calorias[i]+' kcal</span><button class="Consumidos-borrar">X<input type="hidden" value="'+ids[i]+'"></button>');
            $contenedor.prepend($clon);
        }    
    }
    var $clon = $alimentoItem.clone();
    $('#comida-desayuno').prepend($clon);
    
    $('.Consumidos-borrar').on('click', borrarAlimento);
}
    
function getAlimentosFecha(){
    var dayOfMonth = fechaCambia.getDate();
    var mes = fechaCambia.getMonth();
    var fullYear = fechaCambia.getFullYear();
    console.log("Dia mes: " + dayOfMonth + " mes " + mes + " año" + fullYear);
    $.ajax({
        url: "http://localhost:8080/StrongFit/sGetAlimentosFecha",
        type: 'get',
        dataType: 'json',
        data: {diaMes: dayOfMonth, 
               numMes: mes, 
               year: fullYear},
        success: function(datos){
            var nombre = [];
            var tiempoComida = [];
            var calorias = [];
            var ids = [];
            for(var i in datos){
                nombre[i] = datos[i].nombre;
                calorias[i] = datos[i].calorias; 
                ids[i] = datos[i].id;
                tiempoComida[i] = datos[i].tiempo_comida;
            }
            consumidosAdapter(nombre, calorias, ids, tiempoComida);
        },error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}

function evaluaDia(){
    var fechaActual = new Date(); //Esta fecha se usa com referencia
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiempre", "Octubre", "Noviembre", "Diciembre"];
        
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

function cambiarAtras(e){
    e.preventDefault();
    fechaCambia.setDate(fechaCambia.getDate() - 1); //Obtiene el dia siguiente en base al "actual" menos uno
    texto = evaluaDia();
    $tituloFecha.text(texto);
    setValores(); //Esto actualiza la grafica 
    getAlimentosFecha();
}

function cambiarAdelante(e){
    e.preventDefault();
    fechaCambia.setDate(fechaCambia.getDate() + 1); //Obtiene el dia siguiente en base al "actual" mas uno
    texto = evaluaDia();
    $tituloFecha.text(texto);
    setValores(); //Esto actualiza la grafica
    getAlimentosFecha();
}

function setValores(){
    var valor, restantes, meta, textCirculo,
        porcentaje, css, colorLinea;
    var duracion = 500;
    //Variables necesarias para modificar los datos
    var dayOfMonth = fechaCambia.getDate();
    var mes = fechaCambia.getMonth();
    var dayOfWeek = fechaCambia.getDay();
    var fullYear = fechaCambia.getFullYear();
    console.log("Dia mes: " + dayOfMonth + " mes " + mes + " año" + fullYear);
    $.ajax({
        url: 'http://localhost:8080/StrongFit/sCambiarMetas',
        type: 'get',
        dataType: 'json',
        data: {diaMes: dayOfMonth, 
               numMes: mes, 
               year: fullYear,
               diaSemana: dayOfWeek},
        success: function(datos){
            valor = datos.calDia; //Calorias consumidas ese dia
            meta = datos.laMeta;
            console.log("La meta del dia: " + meta);
            $('#metaCalorias').html(meta); //Nuestra meta
            restantes = ((meta*100) - (valor*100))/100; //Las que faltan
            restantes = restantes.toFixed(2);
            
            $('#consumido').html('Consumido: '+ valor +' kcal');
            //Se ejecuta si las calorias consumidas son demasiadas
            if(restantes < 0){
                //Seteamos los valores para la grafica
                colorLinea = 'red';
                css = {'color': 'red', 'font-weight': 'bold'};
                textCirculo = Math.abs(restantes) + ' kcal. excedentes';
                porcentaje = 1;
            }else{
                //Seteamos los valores para la grafica
                colorLinea = '#645EB5';
                css = {'color': 'black', 'font-weight': 'normal'};
                $('.progressbar__label').css(css);
                textCirculo = restantes + ' kcal. restantes';
                porcentaje = valor / meta;
                porcentaje = porcentaje.toFixed(2);
            }
            circulo.path.setAttribute('stroke', colorLinea);
            $('.progressbar__label').css(css); //Color del texto
            circulo.animate(porcentaje, {
                duration: duracion
            }, function(){
                circulo.setText(textCirculo);
            }); 
        }
    });   
}

function agregar(e){
    e.preventDefault();
    var $listaTipo; //Sabemos a que lista agregar el alimento en el html
    var idAlimento = this.children[0].value; //El valor de hidden
    var textCalorias =  $(this).siblings('span').text(); //Calorias del alimento seleccionado
    var calorias = parseFloat(textCalorias.split(' ', 2)[1]);
    var textNombre =  $(this).siblings('p').text(); //Nombre del alimento seleccionado
    var misGramos = parseFloat($(this).siblings('div').children('#alimentoCantidad').val());
    
    calorias = (misGramos * calorias)/100;
    calorias = calorias.toFixed(2);
    console.log(calorias);
    var $clonBorrar = $('#prototipo-borrar').clone().removeClass("ocultar"); //Necesario para poder agregar un div de alimento a borrar
    var elemento = $('.Seleccionado').text(); //Con esto sabemos que tipo de comida es
    var tipo = 1;
    //Cuando fue agregado el alimento 
    var dayOfMonth = fechaCambia.getDate(); 
    var month = fechaCambia.getMonth();
    var year = fechaCambia.getFullYear();
    var $calTiempo;
    var calTiempoTexto;
    var otroTitulo;
    if(elemento === "Desayuno"){
        tipo = 1;
        $calTiempo = $('#tituloDesayuno');
        otroTitulo = "Desayuno";
        $listaTipo = $('#comida-desayuno');
        calTiempoTexto = parseFloat($calTiempo.text().split(" ")[2]);
    }else if(elemento === "Colacion 1"){
        tipo = 2;
        otroTitulo = "Colacion 1";
        $calTiempo = $('#tituloColacion1');
        $listaTipo = $('#comida-colacion1');
        calTiempoTexto = parseFloat($calTiempo.text().split(" ")[3]);
    }else if(elemento === "Comida"){
        tipo = 3;
        otroTitulo = "Comida";
        $calTiempo = $('#tituloComida');
        $listaTipo = $('#comida-comida');
        calTiempoTexto = parseFloat($calTiempo.text().split(" ")[2]);
    }else if(elemento === "Colacion 2"){
        tipo = 4;
        otroTitulo = "Colacion 2";
        $calTiempo = $('#tituloColacion2');
        $listaTipo = $('#comida-colacion2');
        calTiempoTexto = parseFloat($calTiempo.text().split(" ")[3]);
    }else if(elemento === "Cena"){
        tipo = 5;
        otroTitulo = "Cena";
        $calTiempo = $('#tituloCena');
        $listaTipo = $('#comida-cena');
        calTiempoTexto = parseFloat($calTiempo.text().split(" ")[2]);
    }
    
    calTiempoTexto = ((calTiempoTexto*100) + (calorias*100))/100;
    calTiempoTexto = calTiempoTexto.toFixed(2);
    $calTiempo.html(otroTitulo + " - " + calTiempoTexto + " kcal");
    debugger;
    
    console.log("Esta aqui");
    $.ajax({
        url: "http://localhost:8080/StrongFit/sAgregarAlimento",
        type: "post",
        dataType: "text",
        data: {tipo: tipo, 
              valor: idAlimento,
              diaMes: dayOfMonth,
              mes: month,
              thisYear: year,
              gramos: misGramos},
        success: function(datos){
            console.log(datos + " Y los datos apa");
            setValores();
            //Variable datos es el id del catalo fecha_alimento, con esto lo borramos ya ya no se muestra al usuario
            $clonBorrar.html('<p class="Consumidos-name">'+textNombre+'</p><span class="Consumidos-subname">Consumidos: '+calorias+' kcal<button class="Consumidos-borrar">X<input type="hidden" value="'+datos+'"></button>');
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
