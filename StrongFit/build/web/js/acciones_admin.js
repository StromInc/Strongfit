function aceptaNutriologo(con){
    
    $(function(){
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sValidarMedico',
            type: 'POST',
            dataType: 'JSON',
            data: $('#formulario'+con).serialize(),
            success: function(datos){
                if(datos.confirmacion === "valido"){
                    $('#article'+con).remove();
                }
                else
                    alert("Parece que hubo un problema.");
            }
        });
        ;
        
    });
    
}
