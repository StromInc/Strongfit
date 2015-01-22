function desplegarDias()
{
    $(function(){
        if($('#select-actividad').val() !== "" && $('#select-actividad').val() !== 1)
        {
            $('#div-actividadTiempo').removeClass("invisible");
        }
        else
        {
            if(!$('#div-actividadTiempo').hasClass("invisible"))
            {
                $('#div-actividadTiempo').addClass("invisible");
            }
        }
        
        if($('#select-actividad').val() == 1)
        {
            $('#div-actividadTiempo').addClass("invisible");
        }
    });
}