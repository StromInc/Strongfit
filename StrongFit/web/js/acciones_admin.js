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
                    alert("Nutriólogo aceptado.");
                }
                else
                    alert("Parece que hubo un problema.");
            }
        });
        
    });
    
}



function rechazaNutriologo(con){
    
    $(function(){
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sRechazarMedico',
            type: 'POST',
            dataType: 'JSON',
            data: $('#formulario'+con).serialize(),
            success: function(datos){
                if(datos.confirmacion === "valido"){
                    $('#article'+con).remove();
                    alert("Nutriólogo rechazado.");
                }
                else
                    alert("Parece que hubo un problema.");
            }
        });
        
    });
    
}

