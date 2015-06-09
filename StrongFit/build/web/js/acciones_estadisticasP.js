google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

var opciones = {};
var datos = [];

function drawChart() {
    $(function(){
        var data = google.visualization.arrayToDataTable([
            ['Task', 'Hours per Day'],
            ['Work',     11],
            ['Eat',      2],
            ['Commute',  2],
            ['Watch TV', 2],
            ['Sleep',    7]
        ]);

        var options = {
          legend: 'none'
        };

        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));

        chart.draw(data, options);
    });
}

function datosGrafica(id){
    $(function(){
        datos = [];
        opciones = {};
        
        var cal = 1;
        var por = 0;
        
        $('.listaGraficas').removeClass('fondoGris');
        $('#'+id).addClass('fondoGris');
        
        if(!$('#caloriasEst').is(':checked')){
            cal = 0;
        }
        
        if($('#'+id).html() === "labelG1"){
            por = 1;
        }
        else if($('#'+id).html() === "labelG2"){
            por = 2;
        }
        else if($('#'+id).html() === "labelG3"){
            por = 3;
        }
        else if($('#'+id).html() === "labelG4"){
            por = 4;
        }
        else{
            por = 0;
        }
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sGetDatosGrafica',
            type: 'post',
            dataType: 'json',
            data: {
                cal: cal,
                por: por
            },
            success: function(res){
                
            }
        });
    });
}

