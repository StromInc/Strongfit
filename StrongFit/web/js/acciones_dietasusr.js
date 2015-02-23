function cargarDiaCiclico(){
    
    setInterval(cargarDia, 60000);
    
}


function cargarDia(){
    

    $(function(){
        
        var valor = "";
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sCambiarMetasPorDia',
            type: 'POST',
            dataType: 'JSON',
            data: valor,
            success: function(data){;
            }
        });
        
    });
    
}