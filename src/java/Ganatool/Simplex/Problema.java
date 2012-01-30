package Ganatool.Simplex;

/**
 *
 * @author Jesus Herazo
 */
public class Problema {

    int cantDecimales;
    int estado;
    int tipo;
    int numVariables;
    int numRestricciones;
    double[] funcionObjetivo;
    Restricciones[] restricciones;
    static int MINIMIZACION = 0;
    static int MAXIMIZACION = 1;
    public static int FORMULANDO = 0;
    public static int FASE1 = 1;
    public static int FASE2 = 2;
    public static int OPTIMIZADO = 3;
    public static int INFACTIBLE = 4;
    public static int NO_ACOTADO = 5;
    static int MENOR_IGUAL = 0;
    static int MAYOR_IGUAL = 1;
    static int IGUAL = 2;

    public Problema(int var, int rest, int t) {
        tipo = t;
        numVariables = var;
        numRestricciones = rest;
        funcionObjetivo = new double[var];
        restricciones = new Restricciones[rest];
        estado = FORMULANDO;
        cantDecimales = 1000;
    }
}
