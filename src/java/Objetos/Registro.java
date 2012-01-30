/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

import java.sql.Date;

/**
 *
 * @author Administrador
 */
public class Registro {

    private Date fecha;
    private long codigoRes;
    private long nitFinca;
    private int edad;
    private String etapa;
    private float peso;
    private float leche;

    public Registro() {
        fecha = null;
        etapa = "";
    }

    public Registro(Date fecha, long codigoRes, long nitFinca, int edad, String etapa, float peso, float leche) {
        this.fecha = fecha;
        this.codigoRes = codigoRes;
        this.nitFinca = nitFinca;
        this.edad = edad;
        this.etapa = etapa;
        this.peso = peso;
        this.leche = leche;
    }

    public long getCodigoRes() {
        return codigoRes;
    }

    public int getEdad() {
        return edad;
    }

    public String getEtapa() {
        return etapa;
    }

    public Date getFecha() {
        return fecha;
    }

    public float getLeche() {
        return leche;
    }

    public long getNitFinca() {
        return nitFinca;
    }

    public float getPeso() {
        return peso;
    }

    public void setCodigoRes(long codigoRes) {
        this.codigoRes = codigoRes;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setEtapa(String etapa) {
        this.etapa = etapa;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public void setLeche(float leche) {
        this.leche = leche;
    }

    public void setNitFinca(long nitFinca) {
        this.nitFinca = nitFinca;
    }

    public void setPeso(float peso) {
        this.peso = peso;
    }
}
