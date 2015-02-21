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
                    alert("Nutriologo aceptado.");
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
                    alert("Nutriologo rechazado.");
                }
                else
                    alert("Parece que hubo un problema.");
            }
        });
        
    });
    
}

