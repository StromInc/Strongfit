function activarMensajes(remi, ses){
    
    $(function(){
        
        alert("hola");
        $('#destinatario').val(remi);
        $('#ses').val(ses);
        
    });
    
}

function cargaSes(){
    
    setInterval(cSes, 2000);
    
}


function cSes(){
    

    $(function(){
        
        var valor = "";
        var con = 0;
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sConectarSes',
            type: 'POST',
            dataType: 'XML',
            data: valor,
            success: function(data){
                $(data).find('sesiones').each(function(){
                    $(this).find("usuario").each(function(){
                        var idU = "";
                        var ses = "";
                        $(this).find("idU").each(function(){
                            idU = $(this).text();
                        });
                        $(this).find("ses").each(function(){
                           ses = $(this).text();
                        });
                        if($('#usr'+con).val() !== idU){
                            $('#ses'+con).val(ses);
                            if($('#destinatario').val() === idU){
                                $('#ses').val(ses);
                            }
                        }
                        con = con + 1;
                    });
                });
            }
        });
        
    });
    
}