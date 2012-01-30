package Ganatool.Simplex;

/**
 *
 * @author Jesus Herazo
 */
public class SegundaFase {

    PrimeraFase Fase1;
    double[][] matriz;
    double[][] viejaMatriz;
    int[] base;
    int numVarHol;
    double[] varHolgura;
    int r, v;                                   //Variables de indice.

    public SegundaFase(PrimeraFase Fase1) {
        this.Fase1 = Fase1;
        viejaMatriz = Fase1.matriz;
        base = Fase1.base;
        numVarHol = Fase1.numVarHol;
        varHolgura = new double[Fase1.varHolgura.length];
    }

    public boolean esArtificial(int var) {
        boolean esArt = false;
        for (int i = 0; i < Fase1.posVarArt.length; i++) {
            if (!esArt) {
                esArt = Fase1.posVarArt[i] == var;
            }
        }
        return esArt;
    }

    public void construirMatriz() {
        matriz = new double[viejaMatriz.length][viejaMatriz[0].length
                - Fase1.numVarArt];

        for (r = 0; r < viejaMatriz.length - 1; r++) {
            int v2 = 0;
            for (v = 0; v < viejaMatriz[r].length; v++) {
                if (!esArtificial(v)) {
                    matriz[r][v2] = viejaMatriz[r][v];
                    v2++;
                }
            }
        }
        for (v = 0; v < Fase1.PPL.numVariables; v++) {
            matriz[Fase1.PPL.numRestricciones][v] = -1
                    * Fase1.PPL.funcionObjetivo[v];
        }
    }

    public boolean esOptima() {
        boolean solOpt = true;
        for (v = 0; v < matriz[Fase1.PPL.numRestricciones].length - 1; v++) {
            if (solOpt) {
                solOpt = !(matriz[Fase1.PPL.numRestricciones][v] > 0);
            }
        }
        return solOpt;
    }

    public void ajustarTabla() {
        double num = 0;
        double aux[] = matriz[Fase1.PPL.numRestricciones];
        for (v = 0; v < Fase1.PPL.numVariables; v++) {
            num = -1 * matriz[Fase1.PPL.numRestricciones][v];
            for (r = 0; r < Fase1.PPL.numRestricciones; r++) {
                if (matriz[r][v] == 1) {
                    for (int i = 0; i < aux.length; i++) {
                        aux[i] += (matriz[r][i] * num);
                    }
                }
            }
        }
        matriz[Fase1.PPL.numRestricciones] = aux;
    }

    public int buscarColumnaPivote() {
        int colPvt = -1;
        double may = 0;
        for (v = 0; v < matriz[Fase1.PPL.numRestricciones].length - 1; v++) {
            if (matriz[Fase1.PPL.numRestricciones][v] > may) {
                may = matriz[Fase1.PPL.numRestricciones][v];
                colPvt = v;
            }
        }
        return colPvt;
    }

    public int buscarFilaPivote(int colPvt) {
        int filPvt = -1;
        double men = 0;
        for (r = 0; r < Fase1.PPL.numRestricciones; r++) {
            double aux = matriz[r][matriz[r].length - 1] / matriz[r][colPvt];
            if (filPvt >= 0) {
                if (matriz[r][colPvt] > 0 && aux < men) {
                    men = aux;
                    filPvt = r;
                }
            } else {
                if (matriz[r][colPvt] > 0) {
                    men = aux;
                    filPvt = r;
                }
            }
        }
        return filPvt;
    }

    public void iterar() {
        int colPvt = buscarColumnaPivote();
        if (colPvt >= 0) {
            int filPvt = buscarFilaPivote(colPvt);
            if (filPvt >= 0) {
                double[][] nuevaMatriz = matriz;
                double[] filaPivote;
                double pivote = matriz[filPvt][colPvt];

                // Se cambia la Fila Pivote:
                for (v = 0; v < matriz[filPvt].length; v++) {
                    nuevaMatriz[filPvt][v] = matriz[filPvt][v] / pivote;
                }
                filaPivote = nuevaMatriz[filPvt];

                // Se actualizan el resto de filas:
                for (r = 0; r < matriz.length; r++) {
                    if (r != filPvt) {
                        double coef = matriz[r][colPvt];
                        for (v = 0; v < matriz[r].length; v++) {
                            nuevaMatriz[r][v] = matriz[r][v] - (coef
                                    * filaPivote[v]);
                        }
                    }
                }

                /* Reemplazamos la matriz vieja, por la nueva matriz
                 * y actualizamos la base:
                 */
                matriz = nuevaMatriz;
                base[filPvt] = colPvt;
            } else {
                problemaAcotado();
            }
        } else {
            problemaInfactible();
        }
    }

    public void mostrarTabla() {
        System.out.print("|Bs|\t");
        for (v = 0; v < matriz[0].length - 1; v++) {
            System.out.print("|X" + Math.rint((v + 1) * Fase1.PPL.cantDecimales)
                    / Fase1.PPL.cantDecimales + "|\t");
        }
        System.out.println();
        for (r = 0; r < matriz.length; r++) {
            System.out.print("|X" + (base[r] + 1) + "|\t");
            for (v = 0; v < matriz[r].length; v++) {
                System.out.print("|" + Math.rint(matriz[r][v]
                        * Fase1.PPL.cantDecimales) / Fase1.PPL.cantDecimales + "|\t");
            }
            System.out.println();
        }
    }

    public double[] extraerSolucion() {
        double[] solucion = null;
        if (Fase1.PPL.estado == Problema.OPTIMIZADO) {
            solucion = new double[Fase1.PPL.numRestricciones + 1];
            for (r = 0; r < Fase1.PPL.numRestricciones + 1; r++) {
                solucion[r] = matriz[r][matriz[r].length - 1];
            }
        }
        return solucion;
    }

    private void problemaInfactible() {
        System.err.println("El problema es infactible\n"
                + "No se puede hallar una solucion optima");
        Fase1.PPL.estado = Problema.INFACTIBLE;
    }

    private void problemaAcotado() {
        System.err.println("El problema no esta acotado\n"
                + "No se puede hallar una solucion optima");
        Fase1.PPL.estado = Problema.NO_ACOTADO;
    }
}
