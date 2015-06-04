function votar(Npost, numero,nvoto) {      
            $.post('../../SVota', {
                nombre : Npost,
                voto: nvoto
        }, function(responseText) {
            if(responseText === "0"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             $('#us').html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#ds').html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             
            }
            if(responseText === "1"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             $('#us').html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#ds').html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             
            }
            if(responseText === "2"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             $('#us').html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#ds').html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             
            }
              
    });
    
   }
   function comentar(Npost, numero, desde) {      
       var tipo;
       if(desde == 's'){
           tipo = 's';         
       }else{
         tipo = numero;  
           
       }     
       $.post('../../SComenta', {
                nombre : Npost,
                comentario: $('#t'+tipo).val()
        }, function(responseText) {
            
           $('#P'+numero).html(responseText);  
           $('#Ps').html(responseText);  
    });
    
   }
   function escribearticulo(operacion) {      
            $.post('../../SEscribearticulo', {
                nombre : $('#txtnombre').val(),
                texto: $('#txtarticulo').html(),
                operacion: operacion
        }, function(responseText) {
           $('#misarticulos').html(responseText);          
    });
   }
   
   function buscamisarticulos(operacion){
     $.post('../../SEscribearticulo', {
                nombre : $('#txtnombre').val(),
                texto: $('#txtarticulo').html(),
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
    function abrir(nombre, lugar){
      $.post('../../Scargaarticulo', {
                idArt : nombre,
                numpost: lugar
        }, function(responseText) {
            console.log(":DD");
           $('#spanoculto').html(responseText);
           $('#spanoculto').css("z-Index",1);
           $('#spanventana').css("z-Index",0);
           $('#spanventana').show("slow");    
        $('#spanoculto').show("slow");
            
    }); 
    }
    function cerrar(){
      $('#spanoculto').hide("slow");
      $('#spanventana').hide("slow");
    }