package clases;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class cSugerirDietas 
{
    private final String idUsr;
    private final int edad;
    private final int peso;
    private final int cintura;
    private final int estatura;
    private final int sexo;
    private final int ocupacion;
    private final int actividad;
    private final int[] dias;
    private final int[] horas;
    private final int[] horasR;
    private float imc;
    private int[] kcalorias;
    cConexion conecta = new cConexion();
    
    public cSugerirDietas(String idUsr, int edad, int peso, int cintura, int estatura, int sexo, int actividad, int[] dias, int[]horas, int ocupacion)
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
        this.ocupacion = ocupacion;
        this.dias = dias;
        this.horas = horas;
        
        this.kcalorias = new int[7];
        for(int i = 0; i < kcalorias.length; ++i)
        {
            this.kcalorias[i] = 100;
        }
        
        this.horasR = new int[7];
        for(int i = 0; i < horasR.length; ++i)
        {
            this.horasR[i] = 0;
        }
    }
    
    public cSugerirDietas(String idUsr, int edad, int peso, int cintura, int estatura, int sexo, int actividad, int ocupacion)
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
        this.ocupacion = ocupacion;
        this.dias = new int[0];
        this.horas = new int[0];
        
        this.kcalorias = new int[7];
        for(int i = 0; i < kcalorias.length; ++i)
        {
            this.kcalorias[i] = 100;
        }
        
        this.horasR = new int[7];
        for(int i = 0; i < horasR.length; ++i)
        {
            this.horasR[i] = 0;
        }
    }
    
    //calcula el indice de masa corporal
    public float calcularIMC()
    {
        this.imc = (float) (this.peso / Math.pow(estatura / 100f, 2));
        return imc;
    }
    
    //calcula el estado de salud del paciente
    public int estadoSalud(float imc)
    {
        int estado = 0;
        /*
            = 1 = saludable
            = 2 = sobrepeso
            = 3 = obesidad
            = 4 = bajo de peso
        */
        
        //aplicando los criterios de Garrow para el diagnostico de obesidad
        if(this.sexo == 1)
        {
            if(imc < 27)
            {
                estado = 1;
            }
            else
                if(imc >= 27 && imc < 30)
                {
                    estado = 2;
                }
                else
                    if(imc >= 30)
                    {
                        estado = 3;
                    }
        }
        else
            if(imc < 25)
            {
                estado = 1;
            }
            else
                if(imc >= 25 && imc < 30)
                {
                    estado = 2;
                }
                else
                    if(imc >= 30)
                    {
                        estado = 3;
                    }
        
        return estado;
    }
    
    //determina la cantidad de kilo kalorias que debe de consumir el paciente para estar sano
    public int[] determinarKcalorias() throws SQLException
    {
        double ktem = 0;
        
        //Se obtienen las calorias por el sexo, es diferente gasto entre un hombre o una mujer
        if(this.sexo == 1)
        {
            ktem =  (11.3 * this.peso) + (16f * ((float)this.estatura / 100f)) + 901;
        }
        else
            ktem = (8.7 * this.peso) + (25f * ((float)this.estatura / 100f)) + 865;
        
        //Se hace el ajuste por actividad y ocupacion
        int dia = 1, actividadF = 1;
        float factorActividad = 0.03f, factorOcupacion = 0f;
        boolean diaActivo = false;
        int minutos = 0, posicion;
        conecta.conectar();
        ResultSet facO = conecta.getOcupacionEspecifica(this.ocupacion);
        if(facO.next())
        {
            factorOcupacion = facO.getFloat("factor");
        }
        ResultSet fac;
        while(dia <= 7)
        {
            posicion = dia -1;
            for(int i = 0; i < this.dias.length; ++i)
            {
                if(this.dias[i] == dia)
                {
                    diaActivo = true;
                    System.out.println("Este es el valor de horas: " + this.horas[i]);
                    minutos = this.horas[i];
                    this.horasR[posicion] = this.horas[i]; 
                }
            }
            
            if(diaActivo && this.actividad != 1)
            {
                fac = conecta.getActividadEspecifica(this.actividad);
                if(fac.next())
                {
                    factorActividad = fac.getFloat("factor");
                }
            }

            //sumando el gasto calorico del metabolismo basal, la actividad y la ocupacion y quitando decimales
            this.kcalorias[posicion] = (int)Math.floor(ktem + (this.peso * minutos * factorActividad) + (this.peso * 60 * factorOcupacion));
            
            System.out.println("Esta es la clase sugerir-----------------------");
            System.out.println("Este es la actividad: " + this.actividad);
            System.out.println("Este es el dia: " + dia);
            System.out.println("Este es ktem: " + ktem);
            System.out.println("Este es minutos: " + minutos);
            System.out.println("Este es factorActividad: " + factorActividad);
            System.out.println("Este es diaActivo: " + diaActivo);
            System.out.println("Este es kcalorias: " + this.kcalorias[posicion]);
            System.out.println("-----------------------------------------------");
            
            dia++;
            diaActivo = false;
            minutos = 0;
            factorActividad = 0.03f;
        }
        
        
        
        return this.kcalorias;
    }
    
    public int[] getHoras()
    {
        return this.horasR;
    }
}
