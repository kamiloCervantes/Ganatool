package Ganatool;

import Ganatool.Simplex.Problema;
import Ganatool.Simplex.ProblemaDieta;
import Objetos.Comentario;
import Objetos.Dieta;
import Objetos.IngSuministrado;
import Objetos.Ingrediente;
import Objetos.Necesidades;
import Objetos.Res;
import Objetos.Valoracion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:36:00
 */
public class AdministrarDieta {

    private ArrayList<Dieta> lista;
    private ProblemaDieta PPLDieta;
    ArrayList<Ingrediente> ingredientesSuministrar;
    ArrayList<Double> cantidadSuministrar;

    public AdministrarDieta() {
        PPLDieta = null;
        ingredientesSuministrar = null;
        cantidadSuministrar = null;
    }

    public Necesidades cargarNecesidades(ResultSet consulta, char proposito)
            throws SQLException {
        int tot = 0;
        Necesidades N = new Necesidades();
        while (consulta.next()) {
            N.setCalcio(N.getCalcio() + consulta.getFloat("calcio"));
            N.setEM(N.getEM() + consulta.getFloat("em"));
            N.setENgan(N.getENgan() + consulta.getFloat("engan"));
            N.setENmant(N.getENmant() + consulta.getFloat("enmant"));
            N.setFosforo(N.getFosforo() + consulta.getFloat("fosforo"));
            N.setNDT(N.getNDT() + consulta.getFloat("ndt"));
            N.setProteina(N.getProteina() + consulta.getFloat("proteina"));
            if (proposito == 'L') {
                N.setED(N.getED() + consulta.getFloat("ed"));
                N.setENlact(N.getENlact() + consulta.getFloat("enlact"));
                N.setVitaminaA(N.getVitaminaA() + consulta.getFloat("vitaminaa"));
                N.setVitaminaD(N.getVitaminaD() + consulta.getFloat("vitaminad"));
            } else if (proposito == 'C') {
                N.setForraje(N.getForraje() + consulta.getFloat("forraje"));
            }
            tot++;
        }
        if (tot > 0) {
            N.setCalcio(N.getCalcio() / tot);
            N.setEM(N.getEM() / tot);
            N.setENgan(N.getENgan() / tot);
            N.setENmant(N.getENmant() / tot);
            N.setFosforo(N.getFosforo() / tot);
            N.setNDT(N.getNDT() / tot);
            N.setProteina(N.getProteina() / tot);
            if (proposito == 'L') {
                N.setED(N.getED() / tot);
                N.setENlact(N.getENlact() / tot);
                N.setVitaminaA(N.getVitaminaA() / tot);
                N.setVitaminaD(N.getVitaminaD() / tot);
            } else if (proposito == 'C') {
                N.setForraje(N.getForraje() / tot);
            }
        } else {
            N = null;
        }
        return N;
    }

    public Necesidades agregarNecesidadesGrasa(ResultSet consulta,
            Necesidades N) throws SQLException {
        if (consulta.next()) {
            N.setProteina(N.getProteina() + consulta.getFloat("proteina"));
            N.setNDT(N.getNDT() + consulta.getFloat("ndt"));
            N.setED(N.getED() + consulta.getFloat("ed"));
            N.setEM(N.getEM() + consulta.getFloat("em"));
            N.setENlact(N.getENlact() + consulta.getFloat("enlact"));
            N.setCalcio(N.getCalcio() + consulta.getFloat("calcio"));
            N.setProteina(N.getProteina() + consulta.getFloat("proteina"));
        }
        return N;
    }

    public void calcularDieta(ArrayList<Ingrediente> ingredientes,
            Res res, Necesidades necesidades)
            throws SQLException {
        PPLDieta = new ProblemaDieta(necesidades, ingredientes, res.getProposito());

        if (PPLDieta.estado == Problema.FORMULANDO) {
            PPLDieta.formulaProblema();
        }
        if (PPLDieta.estado == Problema.FASE1) {
            PPLDieta.resolverProblema();
        }
        if (PPLDieta.estado == Problema.OPTIMIZADO) {
            ingredientesSuministrar = PPLDieta.ingredientesASuministrar;
            cantidadSuministrar = PPLDieta.cantidadASuministrar;
        }
        if (PPLDieta.estado == Problema.INFACTIBLE
                || PPLDieta.estado == Problema.NO_ACOTADO) {
            System.err.println("UNA DIETA NO SE PUDO ELABORAR");
        }

    }

    public Dieta elaborarDieta(String usuario,
            Res resEscogida,
            ArrayList<Ingrediente> listaIngredientes,
            Necesidades necedidades)
            throws SQLException {
        Dieta dietaElaborada = null;
        java.util.Date date = new java.util.Date();
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        String hoy = formato.format(date);

        calcularDieta(listaIngredientes, resEscogida, necedidades);
        if (ingredientesSuministrar.size() > 0) {
            dietaElaborada = new Dieta();
            dietaElaborada.setUsuario(usuario);
            dietaElaborada.setCodigoRes(resEscogida.getCodigo());
            dietaElaborada.setNitFinca(resEscogida.getNitFincaActual());
            dietaElaborada.setFecha(Date.valueOf(hoy));

            for (int i = 0; i < ingredientesSuministrar.size(); i++) {
                IngSuministrado IngSum = new IngSuministrado(ingredientesSuministrar.get(i),
                        cantidadSuministrar.get(i).floatValue());
                dietaElaborada.agregarIngrediente(IngSum);
            }
        } else {
            System.err.println("SOLO VARIABLES ARTIFICIALES EN LA SOLUCION");
        }

        return dietaElaborada;
    }

    public Dieta cargarComentarios(ResultSet consulta, Dieta dieta)
            throws SQLException {
        while (consulta.next()) {
            Comentario C = new Comentario(consulta.getString("usuario"),
                    consulta.getDate("fecha"), consulta.getString("comentario"));
            dieta.agregarComentario(C);
        }
        return dieta;
    }

    public Dieta cargarValoraciones(ResultSet consulta, Dieta dieta)
            throws SQLException {
        while (consulta.next()) {
            Valoracion V = new Valoracion(consulta.getString("usuario"),
                    consulta.getInt("valor"));
            dieta.agregarValoracion(V);
        }
        return dieta;
    }

    public ArrayList<Dieta> cargarDietas(ResultSet consulta) throws SQLException {
        lista = new ArrayList<Dieta>();
        while (consulta.next()) {
            Dieta D = new Dieta();
            D.setCodigo(consulta.getInt("codigo"));
            D.setCodigoRes(consulta.getLong("codigores"));
            D.setFecha(consulta.getDate("fecha"));
            D.setNitFinca(consulta.getLong("nitfinca"));
            D.setUsuario(consulta.getString("usuario"));
            D.setPublicada(consulta.getInt("coddieta") == D.getCodigo());
            lista.add(D);
        }
        return lista;
    }

    public Dieta cargarDieta(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            Dieta D = new Dieta();
            D.setCodigo(consulta.getInt("codigo"));
            D.setCodigoRes(consulta.getLong("codigores"));
            D.setFecha(consulta.getDate("fecha"));
            D.setNitFinca(consulta.getLong("nitfinca"));
            D.setUsuario(consulta.getString("usuario"));
            D.setPublicada(consulta.getInt("coddieta") == D.getCodigo());
            return D;
        } else {
            return null;
        }
    }

    public Dieta cargarIngredientes(ResultSet consulta, Dieta D)
            throws SQLException {
        while (consulta.next()) {
            Ingrediente I = new Ingrediente();
            I.setCalcio(consulta.getFloat("calcio"));
            I.setCodigo(consulta.getInt("codigo"));
            I.setED(consulta.getFloat("ed"));
            I.setEM(consulta.getFloat("em"));
            I.setENgan(consulta.getFloat("engan"));
            I.setENlact(consulta.getFloat("enlact"));
            I.setENmant(consulta.getFloat("enmant"));
            I.setFosforo(consulta.getFloat("fosforo"));
            I.setNDT(consulta.getFloat("ndt"));
            I.setNombre(consulta.getString("nombre"));
            I.setPrecio(consulta.getFloat("precio"));
            I.setProteina(consulta.getFloat("proteina"));
            I.setProveedor(consulta.getString("proveedor"));
            I.setVitaminaA(consulta.getFloat("vitaminaa"));
            I.setVitaminaD(consulta.getFloat("vitaminad"));

            I.setKCal(consulta.getFloat("kcal"));
            I.setCeniza(consulta.getFloat("ceniza"));
            I.setExtEtereo(consulta.getFloat("extetereo"));
            I.setFDA(consulta.getFloat("fda"));
            I.setFDS(consulta.getFloat("fds"));
            I.setFDN(consulta.getFloat("fdn"));
            I.setFibra(consulta.getFloat("fibra"));
            I.setHumedad(consulta.getFloat("humedad"));
            D.agregarIngrediente(new IngSuministrado(I, consulta.getFloat("cantidad")));
        }
        return D;
    }
}
