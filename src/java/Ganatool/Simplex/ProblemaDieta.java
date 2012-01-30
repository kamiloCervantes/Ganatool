/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Ganatool.Simplex;

import Objetos.Ingrediente;
import Objetos.Necesidades;
import java.util.ArrayList;

/**
 *
 * @author Jesus Herazo
 */
public class ProblemaDieta {

    Necesidades necesidades;
    ArrayList<Ingrediente> ingredientesDisponibles;
    public ArrayList<Ingrediente> ingredientesASuministrar;
    public ArrayList<Double> cantidadASuministrar;
    Problema problema;
    PrimeraFase Fase1;
    SegundaFase Fase2;
    public int estado;
    char proposito;

    public ProblemaDieta(Necesidades necesidades,
            ArrayList<Ingrediente> ingredientes, char proposito) {
        Fase1 = null;
        Fase2 = null;
        this.necesidades = necesidades;
        this.ingredientesDisponibles = ingredientes;
        this.proposito = proposito;
        ingredientesASuministrar = new ArrayList<Ingrediente>();
        cantidadASuministrar = new ArrayList<Double>();
        int var = ingredientesDisponibles.size();
        int rest = 0;
        if (this.proposito == 'L') {
            rest = 11;
        } else if (this.proposito == 'C') {
            rest = 8;
        }
        int t = Problema.MINIMIZACION;
        problema = new Problema(var, rest, t);
        estado = problema.estado;
    }

    public void formulaProblema() {
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            problema.funcionObjetivo[i] = ingredientesDisponibles.get(i).getPrecio();
        }
        if (formulaRestricciones() == problema.numRestricciones) {
            problema.estado = Problema.FASE1;
        } else {
            System.err.println("ERROR EN LAS NECESIDADES");
        }
        estado = problema.estado;
    }

    public int formulaRestricciones() {
        double[] val = null;
        int tipo = 0;
        double valor = 0;
        int r = 0;

        // CALCIO:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getCalcio();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getCalcio();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // FOSFORO:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getFosforo();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getFosforo();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // PROTEINAS:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getProteina();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getProteina();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // EM:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getEM();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getEM();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // ENgan:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getENgan();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getENgan();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // ENmant:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getENmant();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getENmant();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        // NDT:
        val = new double[problema.numVariables];
        for (int i = 0; i < ingredientesDisponibles.size(); i++) {
            val[i] = ingredientesDisponibles.get(i).getNDT();
        }
        tipo = Problema.MAYOR_IGUAL;
        valor = necesidades.getNDT();
        problema.restricciones[r] = new Restricciones(val, tipo, valor);
        r++;

        if (proposito == 'L') {
            // ED:
            val = new double[problema.numVariables];
            for (int i = 0; i < ingredientesDisponibles.size(); i++) {
                val[i] = ingredientesDisponibles.get(i).getED();
            }
            tipo = Problema.MAYOR_IGUAL;
            valor = necesidades.getED();
            problema.restricciones[r] = new Restricciones(val, tipo, valor);
            r++;

            // ENlact:
            val = new double[problema.numVariables];
            for (int i = 0; i < ingredientesDisponibles.size(); i++) {
                val[i] = ingredientesDisponibles.get(i).getENlact();
            }
            tipo = Problema.MAYOR_IGUAL;
            valor = necesidades.getENlact();
            problema.restricciones[r] = new Restricciones(val, tipo, valor);
            r++;

            // VITAMINA A:
            val = new double[problema.numVariables];
            for (int i = 0; i < ingredientesDisponibles.size(); i++) {
                val[i] = ingredientesDisponibles.get(i).getVitaminaA();
            }
            tipo = Problema.MAYOR_IGUAL;
            valor = necesidades.getVitaminaA();
            problema.restricciones[r] = new Restricciones(val, tipo, valor);
            r++;

            // VITAMINA D:
            val = new double[problema.numVariables];
            for (int i = 0; i < ingredientesDisponibles.size(); i++) {
                val[i] = ingredientesDisponibles.get(i).getVitaminaD();
            }
            tipo = Problema.MAYOR_IGUAL;
            valor = necesidades.getVitaminaD();
            problema.restricciones[r] = new Restricciones(val, tipo, valor);
            r++;
        } else if (proposito == 'C') {
            // FORRAJE:
            val = new double[problema.numVariables];
            val[problema.numVariables - 1] = 1;
            tipo = Problema.IGUAL;
            valor = necesidades.getForraje();
            problema.restricciones[r] = new Restricciones(val, tipo, valor);
            r++;
        }

        return r;
    }

    public void resolverProblema() {
        Fase1 = new PrimeraFase(problema);
        Fase1.pasarFormatoEstandar();
        Fase1.construirMatriz();
        Fase1.ajustarTabla();
        int i = 0;
        do {
            if (Fase1.tieneSolOptima()) {
                problema.estado = Problema.FASE2;
                Fase2 = new SegundaFase(Fase1);
                break;
            } else {
                Fase1.iterar();
                i++;
            }
        } while (problema.estado == Problema.FASE1);
        if (problema.estado == Problema.FASE2) {
            Fase2.construirMatriz();
            Fase2.ajustarTabla();
            i = 0;
            do {
                if (Fase2.esOptima()) {
                    Fase1.PPL.estado = Problema.OPTIMIZADO;
                    int[] base = Fase2.base;
                    double[] soluciones = Fase2.extraerSolucion();
                    cargarSolucion(base, soluciones);
                    break;
                } else {
                    Fase2.iterar();
                    i++;
                }
            } while (problema.estado == Problema.FASE2);
        }
        estado = problema.estado;
    }

    private void cargarSolucion(int[] base, double[] soluciones) {
        for (int i = 0; i < base.length - 1; i++) {
            if (base[i] < ingredientesDisponibles.size()
                    && (Math.rint(soluciones[i] * problema.cantDecimales) / problema.cantDecimales) > 0) {
                ingredientesASuministrar.add(ingredientesDisponibles.get(base[i]));
                cantidadASuministrar.add(Math.rint(soluciones[i] * problema.cantDecimales) / problema.cantDecimales);
            }
        }
    }
}
