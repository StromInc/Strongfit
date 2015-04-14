
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
                        console.log(respuesta);
                        response(respuesta);
                    }
                });
            },
            //esta funcion se ejecuta al seleccionar
            select: ver
        });
            
            function ver(e, res){
    e.priventDefualt();

}

    });


