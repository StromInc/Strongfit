package clases;

public class cSugerirDietas 
{
    private final String idUsr;
    private final int edad;
    private final int peso;
    private final int cintura;
    private final int estatura;
    private final int sexo;
    private final int actividad;
    private int imc;
    cConexion conecta = new cConexion();
    
    public cSugerirDietas(String idUsr, int edad, int peso, int cintura, int estatura, int sexo, int actividad)
    {
        this.idUsr = idUsr;
        this.edad = edad;//en años
        this.peso = peso;// en kilogramos
        this.cintura = cintura;
        this.estatura = estatura;//en centimetros
        this.sexo = sexo;
        this.actividad = actividad;
        /*
            actividad = 1 = nada de ejercicio
                      = 2 = ejercicio de baja intencidad
                      = 3 = ejercicio de media intencidad
                      = 4 = ejercicio de alta intencidad
                      = 5 = ejercicio de extrema intencidad
        */
    }
    
    //calcula el indice de masa corporal
    public void calcularIMC()
    {
        this.imc = this.peso / ((this.estatura / 100) * (this.estatura / 100));
    }
    
    //calcula el estado de salud del paciente
    public int estadoSalud()
    {
        int estado = 0;
        /*
            = 1 = saludable
            = 2 = sobrepeso
            = 3 = obesidad
            = 4 = bajo de peso
        */
        if(this.sexo == 1)
        {
            if(this.imc < 27)
            {
                estado = 1;
            }
            else
                if(this.imc >= 27 && this.imc < 30)
                {
                    estado = 2;
                }
                else
                    if(this.imc >= 30)
                    {
                        estado = 3;
                    }
        }
        else
            if(this.imc < 25)
            {
                estado = 1;
            }
            else
                if(this.imc >= 25 && this.imc < 30)
                {
                    estado = 2;
                }
                else
                    if(this.imc >= 30)
                    {
                        estado = 3;
                    }
        
        return estado;
    }
    
    //determina la cantidad de kilo kalorias que debe de consumir el paciente para estar sano
    public int determinarKcalorias()
    {
        int kcalorias = 0;
        double ktem = 0;
        
        //Se obtienen las calorias por el sexo, es diferente gasto entre un hombre o una mujer
        if(this.sexo == 1)
        {
            ktem =  66.47 + (13.75 * this.peso) + (5 * this.estatura) - (6.76 * this.edad);
        }
        else
            ktem = 655.1 + (9.56 * this.peso) + (1.85 * this.estatura) - (4.68 * this.edad);
        
        //Se ajusta el resultado anterior segun su actividad fisica
        if(this.actividad == 1)
        {
            ktem = ktem * 1.2;
        }
        else
            if(this.actividad == 2)
            {
                ktem = ktem * 1.375;
            }
            else
                if(this.actividad == 3)
                {
                    ktem = ktem * 1.55;
                }
                else
                    if(this.actividad == 4)
                    {
                        ktem = ktem * 1.725;
                    }
                    else
                        if(this.actividad == 5)
                        {
                            ktem = ktem * 1.9;
                        }
        
        //quitandole los decimales
        kcalorias = (int) Math.floor(ktem);
        
        return kcalorias;
    }
}
