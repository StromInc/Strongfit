function deplegarDias()
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
    });
}