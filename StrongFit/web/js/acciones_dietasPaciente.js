/*se dispara para evitar cualquier cosa por default que ocurra como que se envie un formulario con el boton submit*/
function allowDrop(ev) {
    ev.preventDefault();
}

/*se dispara cuando alguien arrastra un elemento*/
function drag(ev) {
    /*obtiene el tipo de dato que se esta arrastrando*/
    ev.dataTransfer.setData("text", ev.target.id);
}

/*Se dispara cuando alguien suelta un elemento en el formulario, ademas activara la funcion ajax*/
function drop(ev) {
    $(function(){
        
        ev.preventDefault();
        
        var formulario = document.getElementById("formularioDietasPaciente");
        var divF = document.getElementById("divForm");
        var dat = ev.dataTransfer.getData("text");
        
        formulario.appendChild(document.getElementById(dat));
        $('#inputQuitar').val("no");
        
        //funcion para enviar la dieta de una por una para su registro
        $.ajax({
            
            url:"http://localhost:8080/StrongFit/sDietasUsr",
            type: 'POST',
            dataType: 'json',
            data: $('#formularioDietasPaciente').serialize(),
            success: function(datos){
                console.log("Exito");
            }
            
        })
        .done(function(){
            console.log("Actualización exitosa");
        })
        .fail(function(){
            alert("Parece que hubo un error, por favor vuelve a intentarlo");
        })
        .always(function(){
            console.log("Proceso terminado exitoso o no.");
        });
        
        divF.appendChild(document.getElementById(dat));

    });
}

/*se dispara cuando alguien suelta un elementon en el contenedor de las dietas*/
function dropDiv(ev) {
    $(function(){
        
        ev.preventDefault();
        
        var form = document.getElementById("quitarForm");
        var div = document.getElementById("divDietasPaciente");
        var data = ev.dataTransfer.getData("text");
        
        form.appendChild(document.getElementById(data));
        $('#inputQuitar2').val("si");
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sDietasUsr',
            type: 'POST',
            dataType: 'json',
            data: $('#quitarForm').serialize()
            
        })
        .done(function(){
            console.log("Actualización exitosa");
        })
        .fail(function(){
            alert("Parece que hubo un error, por favor vuelve a intentarlo");
        })
        .always(function(){
            console.log("Proceso terminado exitoso o no.");
        });
        
        div.appendChild(document.getElementById(data));
        
    });
}
