/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function() {
    var $email = $('#email'); 
    function ajaxBusqueda(argument) {
        var correo = $email.val();
        console.log(correo == 0);
        console.log(correo == false);
        if(correo != '' && correo != 0 && correo){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sAjaxCorreo',
                type: 'post',
                dataType: 'text',
                data: {
                    email: correo
                },
                success: function(datos){        
                    console.log('Resultado ' + datos);    
                }
            }); 
        }else{
           console.log('Nada')
        }
         
    }
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
    $email.on('blur', ajaxBusqueda);
    window.onresize = nuevo;
});

