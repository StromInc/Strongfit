/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function() {
    var $email = $('#email');
    var $arrow = $('.arrow');

    var ajaxBuscar = (function() {
        var correo = $email.val();
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
                    console.log('Resultado ' + datos);
                    if(datos != 'El correo es valido'){
                        $arrow.removeClass('hidden');
                        $arrow.html(datos);
                    }          
                }
            }); 
        }else{
           console.log('Nada');
        }
         
    });
    function nuevo(){
        console.log('hola');
        if (window.matchMedia('(max-width: 768px)').matches){
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
    $email.on('focus', function(){
        $arrow.addClass('hidden')
    }).on('blur', ajaxBuscar);

    window.onresize = nuevo;
});
function guardarsesion() {
		
        var correoVar = $('#email1').val();
        var contraVar = $('#psw1').val();
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        if($("#chek1").is(':checked')){
            console.log("vamos bien");
            $.post('SCheca', {
                nombre : correoVar,
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
      var sesion = localStorage.getItem("sesioniniciada");
      if(sesion == "si"){
      var id = localStorage.getItem("id");
      var contra = localStorage.getItem("contra");
      $.post('SCheca', {
                nombre : id,
                contra: contra
        }, function(responseText) {
            var validacion = responseText;
            console.log(validacion);
            if(validacion == "si1"){
                location.href="jsp/nutriologo/inicio.jsp"
            }
             if(validacion == "si2"){
                location.href="jsp/paciente/inicio.jsp"
            }
             if(validacion == "si3"){
                location.href="jsp/admin/inicio.jsp"
            }
        });
     }
   }

