
$(function(){
    $('#search').autocomplete({
        //busqueda del alimento
        source: function(request, response){
            $.ajax({
                url: 'http://localhost:8080/StrongFit/sBusquedaUsuario',
                type: 'post',
                dataType: 'json',
                data: {
                    info : request.term
                },
                //respuesta del servidor
                success: function(respuesta){
                    response(respuesta);
                }
            });
        },
        //esta funcion se ejecuta al seleccionar
        select: ver
    });

    function ver(e, res){
        console.log(res.item.correo);
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sGetInfoUsuario',
            type: 'post',
            dataType: 'json',
            data: {
                desti: res.item.correo
            },
            success: function(respuesta){
                document.getElementById("imagenDesti").src = respuesta.imagen;

                $('#nombreChat').html("Nombre: "+respuesta.nombre);
                $('#correoChat').html("Correo: "+respuesta.correo);

                if(respuesta.tipo === "medico"){
                    $('#cedulaChat').html("Cédula Profesional: "+respuesta.cedula).removeClass('invisible');
                    $('#carreraChat').html("Carrera: "+respuesta.carrera).removeClass('invisible');
                    $('#escuelaChat').html("Escuela: "+respuesta.escuela).removeClass('invisible');
                    if(respuesta.amistad === "no"){
                        $('#botonSolicitud').val("Enviar solicitud de Nutriólogo").removeClass('invisible');
                    }
                }
                else{
                    $('#cedulaChat').addClass('invisible');
                    $('#carreraChat').addClass('invisible');
                    $('#escuelaChat').addClass('invisible');
                    if(respuesta.amistad === "no"){
                        $('#botonSolicitud').val("Enviar solicitud de Amistad").removeClass('invisible');
                    }
                }
            }
        });
    }

});


