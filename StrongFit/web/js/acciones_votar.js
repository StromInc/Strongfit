function votar(Npost, numero,nvoto) {      
            $.post('../../SVota', {
                nombre : Npost,
                voto: nvoto
        }, function(responseText) {
            if(responseText === "0"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             console.log("OMG");
            }
            if(responseText === "1"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote3.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote2.png'>");
             console.log("OMG");
            }
            if(responseText === "2"){
             $('#u'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote.png'>");      
             $('#d'+numero).html("<img src='../../Imagenes/Iconos/sticky-vote4.png'>");
             console.log("OMG");
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
