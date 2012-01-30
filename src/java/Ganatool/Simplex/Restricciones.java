package Ganatool.Simplex;

/**
 *
 * @author Jesus Herazo
 */
public class Restricciones {

    double[] valores;
    int tipo;
    double restriccion;

    public Restricciones() {
    }

    public Restricciones(double[] valores, int tipo, double restriccion) {
        this.valores = valores;
        this.tipo = tipo;                       // 0: <=; 1: >=; 2: =;
        this.restriccion = restriccion;
    }
}
