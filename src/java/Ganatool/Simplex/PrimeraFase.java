package Ganatool.Simplex;

/**
 *
 * @author Jesus Herazo
 */
public class PrimeraFase {

    Problema PPL;
    double[][] matriz;
    int[] base;
    int[] posVarArt;
    int numVarHol;
    int numVarArt;
    double[] varHolgura;
    double[] varArtificiales;
    int r, v;                                   //Variables de indice.

    public PrimeraFase(Problema P) {
        PPL = P;
        varHolgura = new double[P.numRestricciones];
        varArtificiales = new double[P.numRestricciones];
        numVarHol = 0;
        numVarArt = 0;
        base = new int[P.numRestricciones + 1];
    }

    public void pasarFormatoEstandar() {
        for (r = 0; r < PPL.numRestricciones; r++) {

            // Si es Menor Igual;
            if (PPL.restricciones[r].tipo == 0) {
                varHolgura[r] = 1;
                numVarHol++;
            }

            // Si es Mayor Igual;
            if (PPL.restricciones[r].tipo == 1) {
                varHolgura[r] = -1;
                numVarHol++;
                varArtificiales[r] = 1;
                numVarArt++;
            }

            // Si es Igual;
            if (PPL.restricciones[r].tipo == 2) {
                varArtificiales[r] = 1;
                numVarArt++;
            }
        }
    }

    public void construirMatriz() {
        matriz = new double[PPL.numRestricciones + 1][PPL.numVariables
                + numVarHol + numVarArt + 1];
        posVarArt = new int[numVarArt];
        int i = 0;
        int varExtras = PPL.numVariables;

        for (r = 0; r < PPL.numRestricciones; r++) {
            for (v = 0; v < PPL.numVariables; v++) {
                matriz[r][v] = PPL.restricciones[r].valores[v];
            }
            if (varHolgura[r] != 0) {
                matriz[r][varExtras] = varHolgura[r];
                base[r] = varExtras;
                varExtras++;
            }
            if (varArtificiales[r] != 0) {
                matriz[r][varExtras] = varArtificiales[r];
                matriz[PPL.numRestricciones][varExtras] = -1;
                base[r] = varExtras;
                posVarArt[i] = varExtras;
                i++;
                varExtras++;
            }
            matriz[r][PPL.numVariables + numVarHol + numVarArt] =
                    PPL.restricciones[r].restriccion;
        }
        base[PPL.numRestricciones] = -1;
    }

    public void ajustarTabla() {
        int posV = -1;
        double aux[] = matriz[PPL.numRestricciones];
        for (v = 0; v < matriz[PPL.numRestricciones].length; v++) {
            if (matriz[PPL.numRestricciones][v] == -1) {
                posV = v;
                for (r = 0; r < PPL.numRestricciones; r++) {
                    if (matriz[r][posV] == 1) {
                        for (int i = 0; i < aux.length; i++) {
                            aux[i] += matriz[r][i];
                        }
                    }
                }
            }
        }
        matriz[PPL.numRestricciones] = aux;
    }

    public int buscarColumnaPivote() {
        int colPvt = -1;
        double may = 0;
        for (v = 0; v < matriz[PPL.numRestricciones].length - 1; v++) {
            if (matriz[PPL.numRestricciones][v] > may) {
                may = matriz[PPL.numRestricciones][v];
                colPvt = v;
            }
        }
        return colPvt;
    }

    public int buscarFilaPivote(int colPvt) {
        int filPvt = -1;
        double men = 0;
        for (r = 0; r < PPL.numRestricciones; r++) {
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
                            nuevaMatriz[r][v] = matriz[r][v]
                                    - (coef * filaPivote[v]);
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

    public boolean tieneSolOptima() {
        boolean solOpt = true;
        for (int i = 0; i < base.length - 1; i++) {
            for (int j = 0; j < posVarArt.length; j++) {
                if (solOpt) {
                    solOpt = base[i] != posVarArt[j];
                }
            }
        }
        return solOpt;
    }

    public void mostrarTabla() {
        System.out.print("|Bs|\t");
        for (v = 0; v < matriz[0].length - 1; v++) {
            System.out.print("|X" + Math.rint((v + 1) * PPL.cantDecimales)
                    / PPL.cantDecimales + "|\t");
        }
        System.out.println();
        for (r = 0; r < matriz.length; r++) {
            System.out.print("|X" + (base[r] + 1) + "|\t");
            for (v = 0; v < matriz[r].length; v++) {
                System.out.print("|" + Math.rint(matriz[r][v]
                        * PPL.cantDecimales) / PPL.cantDecimales + "|\t");
            }
            System.out.println();
        }
    }

    private void problemaInfactible() {
        System.err.println("El problema es infactible\n"
                + "No se puede hallar una solucion optima");
        PPL.estado = Problema.INFACTIBLE;
    }

    private void problemaAcotado() {
        System.err.println("El problema no esta acotado\n"
                + "No se puede hallar una solucion optima");
        PPL.estado = Problema.NO_ACOTADO;
    }
}
