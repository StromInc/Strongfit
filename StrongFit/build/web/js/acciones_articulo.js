function votar(Npost, numero,nvoto) {      
            $.post('../../SVota', {
                nombre : Npost,
                voto: nvoto
        }, function(responseText) {
            if(responseText === "0"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             
            }
            if(responseText === "1"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             
            }
            if(responseText === "2"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             
            }
              
    });
    
   }
   function comentar(Npost, numero) {      
            $.post('../../SComenta', {
                nombre : Npost,
                comentario: $('#t'+numero).val()
        }, function(responseText) {
           $('#P'+numero).html(responseText);          
    });
    
   }
   function escribearticulo(operacion) {      
            $.post('../../SEscribearticulo', {
                nombre : $('#txtnombre').val(),
                texto: $('#txtarticulo').val(),
                operacion: operacion
        }, function(responseText) {
           $('#misarticulos').html(responseText);          
    });
   }
   
   function buscamisarticulos(operacion){
     $.post('../../SEscribearticulo', {
                nombre : $('#txtnombre').val(),
                texto: $('#txtarticulo').val(),
                operacion: operacion
        }, function(responseText) {          
           $('#misarticulos').html(responseText);          
    });   
        
    }
    function cambiaarticulo(nombre){
     $.post('../../SEscribearticulo', {
                idArt : nombre,
                operacion: "llamadatos"
        }, function(responseText) {
            console.log(":DD");
           $('#edicion').html(responseText);                  
    });   
        
    }
    
