function cambiarMetas()
{
    $(function(){
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
    });
}