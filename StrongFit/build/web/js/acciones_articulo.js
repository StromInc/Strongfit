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
             console.log("1 " + numero);
            }
            if(responseText === "1"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             $('#us').html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#ds').html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             console.log("2 " + numero);
            }
            if(responseText === "2"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             $('#us').html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#ds').html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             console.log("3 " + numero);
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
           $('#Ps').html('Comentarios: <hr>'+responseText);  
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
        $('#body').css("overflow-y","hidden");
            
    }); 
    }
    function cerrar(){
      $('#spanoculto').hide("slow");
      $('#spanventana').hide("slow");
      $('#body').css("overflow-y","auto");
    }
    function cambiarartenuso(){
      $.post('../../Sartenuso', {
                idArt : $('#txtnombre').val(),
                texto: $('#txtarticulo').val()
        }, function(responseText){
    }); 
    }
    function borrar(nombre){
      $.post('../../Sborraarticulo', {
                 idArt : nombre
                
        }, function(responseText){
            $('#misarticulos').html(responseText);   
    }); 
    }
    function contar(nombre, numero){
      $.post('../../Scontarvoto', {
                 idArt : nombre
                
        }, function(responseText){
            $('#votos'+numero+'').html(responseText);   
    }); 
    }
    function cambia(){
       $.post('../../Scambiaformato', {
            datos : $('#txtarticulo').html(),
            tipo: $('#fuente').val(),
            color: $('#color').val(),
            tamano: $('#tamano').val(),
            edicion : document.getSelection().toString()
        }, function(responseText){
        console.log($('#txtarticulo').html());    
        $('#txtarticulo').html(responseText);
            
        console.log(responseText);
        console.log();
    });
    
    }