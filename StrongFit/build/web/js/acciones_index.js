/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function cambiarFondo(){
    var $fondo = $('#background');
    var $body = $('body');
    if (window.matchMedia('(max-width: 767px)').matches){
        console.log('tableta');   
        $fondo.css('display', 'none');
        $body.addClass('fondo');
        
    }else{
        $fondo.css('display', 'block');
        $body.removeClass('fondo');
        $(window).load(function(){
        $('#background').fadeIn(1500);//Muestra el background oculto cuando carga todo
        setInterval('cycleImages()', 4000); //se ejecuta cada 4s
    });
    }
}

$(function() {
    var $email = $('#email');
    var $arrow = $('.arrow');
    cambiarFondo();
    var ajaxBuscar = (function() {
        var correo = $email.val().trim();
        var DIRECCION = 'http://localhost:8080/StrongFit/sAjaxCorreo';
        if(correo !== ''){
            $.ajax({
                url: DIRECCION,
                type: 'post',
                dataType: 'text',
                data: {
                    email: correo
                },
                success: function(datos){
                    //Si hay respuesta      
                    console.log('Resultado ' + datos);
                    if(datos !== 'El correo es valido'){
                        $arrow.removeClass('hidden');
                        $arrow.html(datos);
                    }else{
                        $email.css('border', '2px solid rgba(0, 139, 0, 0.8)');
                    }          
                }
            }); 
        }else{
           console.log('Nada');
        }     
    });
    //ocultamos el mensaje cuando se da click en el input
    $email.on('focus', function(){
        $arrow.addClass('hidden');
        $email.css('border', 'none');
    }).on('blur', ajaxBuscar); //se ejecuta despues de quitar el mouse
});

function nuevo(){
        cambiarFondo();
        if (window.matchMedia('(max-width: 850px)').matches){
            var $buttonShow = document.getElementById('show');
            var $buttonHide = document.getElementById('hide');
            var $menu = document.getElementById('formu');

            function showMenu(e) {
              // body...
               e.preventDefault();
               $menu.classList.add('is-active');
               $buttonHide.classList.add('is-active');
               $buttonShow.classList.remove('is-active');
            }
            function hideMenu(e) {
              // body...
               e.preventDefault();
               $buttonShow.classList.add('is-active');
               $menu.classList.remove('is-active');
               $buttonHide.classList.remove('is-active');
            }
            $buttonShow.addEventListener('click', showMenu);
            $buttonHide.addEventListener('click', hideMenu);
        }
    }
    window.onresize = nuevo;

function guardarsesion() {
		
        var correoVar = $('#email1').val();
        var contraVar = $('#psw1').val();
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        if($("#chek1").is(':checked')){
            console.log("vamos bien");
            $.post('SCheca', {
                id : correoVar,
                contra: contraVar
        }, function(responseText) {
            var validacion = responseText;
            console.log(validacion);
            if(validacion == "si1"){               
                localStorage.setItem("id", correoVar);
                localStorage.setItem("contra", contraVar);
                localStorage.setItem("sesioniniciada", "si");
            }
            if(validacion == "si2"){               
                localStorage.setItem("id", correoVar);
                localStorage.setItem("contra", contraVar);
                localStorage.setItem("sesioniniciada", "si");
            }
            if(validacion == "si3"){               
                localStorage.setItem("id", correoVar);
                localStorage.setItem("contra", contraVar);
                localStorage.setItem("sesioniniciada", "si");
            }
        });
    }
   }

   function mandar(){
        nuevo();
      var sesion = localStorage.getItem("sesioniniciada");
      if(sesion == "si"){
      var id = localStorage.getItem("id");
      var contra = localStorage.getItem("contra");
      console.log(id);
      $.post('SCheca', {
                id : id,
                contra: contra
        }, function(responseText) {
            var validacion = responseText;
            console.log(validacion);
            if(validacion == "si1"){
                location.href="jsp/nutriologo/inicio.jsp";
            }
             if(validacion == "si2"){
                location.href="jsp/paciente/inicio.jsp";
            }
             if(validacion == "si3"){
                location.href="jsp/admin/inicio.jsp";
            }
        });
     }
   }
//Esta funcion es la que cambia el fondo
function cycleImages(){
    var $active = $('#background .active'); //fondo actual
    var $next = ($('#background .active').next().length > 0) ? $('#background .active').next() : $('#background div:first'); //este operador terneario es un un if
    $next.css('z-index', 2);
    $active.fadeOut(1500, function(){ 
        $active.css('z-index', 1).show().removeClass('active'); //ocualtamos y lo mandamos atras
        $next.css('z-index', 3).addClass('active'); //lo ponemos adelante
    });
}   
