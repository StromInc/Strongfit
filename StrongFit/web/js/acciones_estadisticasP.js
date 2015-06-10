google.load("visualization", "1", {packages:["corechart"]});
//google.setOnLoadCallback(drawChart);

var opciones = {};
var datos = [];
var idG = "";

var meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
var fecha = new Date();
var dia = fecha.getDate();
var dia2 = dia;
var mes = fecha.getMonth();
var mes2 = mes;
var anio = fecha.getFullYear();
var anio2 = anio;
var diaSem = 0;

/*
 * 
 * @returns {undefined}
 * [
            ['Task', 'Hours per Day'],
            ['Work',     11],
            ['Eat',      2],
            ['Commute',  2],
            ['Watch TV', 2],
            ['Sleep',    7]
        ]
 */
function drawChart() {
    $(function(){
        var data = google.visualization.arrayToDataTable(datos);

        var options = opciones;

        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));

        chart.draw(data, options);
    });
}

function datosGrafica(id){
    idG = id;
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
        
        if(id === "labelG1"){
            por = 1;
        }
        else if(id === "labelG2"){
            por = 2;
        }
        else if(id === "labelG3"){
            por = 3;
        }
        else if(id === "labelG4"){
            por = 4;
        }
        else{
            por = 0;
        }
        
        diaSem = setDiaSemana();
        
        $.ajax({
            url: 'http://localhost:8080/StrongFit/sGetDatosGrafica',
            type: 'post',
            dataType: 'json',
            data: {
                cal: cal,
                por: por,
                dia: dia,
                mes: mes,
                anio: anio,
                diaSem: diaSem
            },
            success: function(res){
                console.log(res);
                if(res.estado === "comidahoy"){
                    if(res.quees === 1){
                        datos[0] = ['Task', "Calorías por comida"];
                        var con = 1;
                        for(var i = 0; i < 5; ++i){
                            datos[con] = [res.comidas[i][0], parseFloat(res.comidas[i][1])];
                            con++;
                        }
                        drawChart();
                        if(res.valorT === "no"){
                            $('#div_chart').html("No has comido nada en este día.");
                        }
                    }
                    else{
                        
                    }
                }
            }
        });
    });
}


function cambiarDia(id){
    $(function(){
        if(id === 0){
            dia -= 1;
            if(dia <= 0){
                cambiarMes(0);
                if(mes === 0 || mes === 2 || mes === 4 || mes === 6 || mes === 7 || mes === 9 || mes === 11){
                    dia = 31;
                }
                else if(mes === 1){
                    dia = 28;
                    if(anio % 2 === 0){
                        dia = 29;
                    }
                }
                else{
                    dia = 30;
                }
            }
            $();
        }
        else{
            if(!(dia - dia2 === 0 && mes - mes2 === 0)){
                dia += 1;
                if(mes === 0 || mes === 2 || mes === 4 || mes === 6 || mes === 7 || mes === 9 || mes === 11){
                    if(dia === 32){
                        cambiarMes(1);
                    }
                }
                else if(mes === 1){
                    if(!(anio % 2 === 0)){
                        if(dia === 29){
                            cambiarMes(1);
                        }
                    }
                    else{
                        if(dia === 30){
                            cambiarMes(1);
                        }
                    }
                }
                else{
                    if(dia === 31){
                        cambiarMes(1);
                    }
                }
            }
        }
        
        if(dia - dia2 === 0 && mes - mes2 === 0){
            $('#spanInfoDia').html('Hoy');
        }
        else if(dia - dia2 === -1 && mes - mes2 ===0){
            $('#spanInfoDia').html('Ayer');
        }
        else{
            $('#spanInfoDia').html(dia + " de " + meses[mes]);
        }
        
        datosGrafica(idG);
    });
}

function cambiarSemanal(){
    
}

function cambiarMensual(id){
    $(function(){
        cambiarMes(id);
        
    });
}

function cambiarMes(id){
    $(function(){
        dia = 1;
        if(id === 0){
            mes -= 1;
            if(mes < 0){
                mes = 12;
                anio -= 1;
            }
        }
        else{
            if(!(mes - mes2 === 0 && anio - anio2 === 0)){
                mes += 1;
                if(mes >= 13){
                    mes = 0;
                    anio += 1;
                }
            }
            else
                dia = dia2;
        }
        if(mes - mes2 === 0 && anio - anio2 === 0){
            $('#spanInfoMes').html("Este mes");
        }
        else{
            $('#spanInfoMes').html(meses[mes] + " de " + anio);
        }
        
        if(dia - dia2 === 0 && mes - mes2 === 0){
            $('#spanInfoDia').html('Hoy');
        }
        else{
            $('#spanInfoDia').html(dia + " de " + meses[mes]);
        }
        
        datosGrafica(idG);
    });
}

function setDiaSemana(){
    
    //http://esquirladigital.blogspot.mx/2011/08/codigo-javascript-para-saber-el-dia-de.html
    //http://www.tutorialspoint.com/javascript/date_getutcday.htm
    
    //Vector para calcular día de la semana de un año regular.  
    var regular =[0,3,3,6,1,4,6,2,5,0,3,5];   
    //Vector para calcular día de la semana de un año bisiesto.  
    var bisiesto=[0,3,4,0,2,5,0,3,6,1,4,6];
    
    var m = 0;
    var semana = [1, 2, 3, 4, 5, 6 ,7];
    
    if(anio % 4 === 0){
        m = bisieto[mes];
    }
    else{
        m = regular[mes];
    }
    return semana[Math.ceil(Math.ceil(Math.ceil((anio-1)%7)+Math.ceil((Math.floor((anio-1)/4)-Math.floor((3*(Math.floor((anio-1)/100)+1))/4))%7)+m+dia%7)%7)]
}