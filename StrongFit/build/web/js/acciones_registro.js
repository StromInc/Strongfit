function justNumbers(e){
		var keynum = window.event ? window.event.keyCode : e.which;
		if ((keynum == 8) || (keynum == 46))
			return true;
		 
		return /\d/.test(String.fromCharCode(keynum));
	}
$(function(){
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
    $email.on('focus', function(){
        $arrow.addClass('hidden')
    }).on('blur', ajaxBuscar);

})