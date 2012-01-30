package Objetos;

import java.sql.Date;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:03
 */
public class Res {

    private long codigo;
    private char proposito;
    private char sexo;
    private float peso;
    private int edad;
    private String etapaFisiologica;
    private float cantLecheDiaria;
    private float porcGrasaLeche;
    private String raza;
    private String propietario;
    private long nitFincaActual;
    private String nombreFincaActual;
    private Date ultimoParto;
    private float cantAlimentoDiario;

    public Res() {
        codigo = 0;
        proposito = '\0';
        sexo = '\0';
        peso = 0;
        edad = 0;
        etapaFisiologica = "";
        cantLecheDiaria = 0;
        porcGrasaLeche = 0;
        raza = "";
        propietario = "";
        nitFincaActual = 0;
        ultimoParto = null;
        cantAlimentoDiario = 0;
    }

    public long getCodigo() {
        return codigo;
    }

    /**
     *
     * @param newVal
     */
    public void setCodigo(long newVal) {
        codigo = newVal;
    }

    public char getProposito() {
        return proposito;
    }

    /**
     *
     * @param newVal
     */
    public void setProposito(char newVal) {
        this.proposito = newVal;
    }

    public char getSexo() {
        return sexo;
    }

    /**
     *
     * @param newVal
     */
    public void setSexo(char newVal) {
        sexo = newVal;
    }

    public float getPeso() {
        return peso;
    }

    /**
     *
     * @param newVal
     */
    public void setPeso(float newVal) {
        peso = newVal;
    }

    public int getEdad() {
        return edad;
    }

    /**
     *
     * @param newVal
     */
    public void setEdad(int newVal) {
        edad = newVal;
    }

    public String getEtapaFisiologica() {
        return etapaFisiologica;
    }

    /**
     *
     * @param newVal
     */
    public void setEtapaFisiologica(String newVal) {
        etapaFisiologica = newVal;
    }

    public float getCantLecheDiaria() {
        return cantLecheDiaria;
    }

    public float getPorcGrasaLeche() {
        return porcGrasaLeche;
    }

    public String getRaza() {
        return raza;
    }

    /**
     *
     * @param newVal
     */
    public void setRaza(String newVal) {
        raza = newVal;
    }

    public String getPropietario() {
        return propietario;
    }

    /**
     *
     * @param newVal
     */
    public void setPropietario(String newVal) {
        propietario = newVal;
    }

    public long getNitFincaActual() {
        return nitFincaActual;
    }

    public String getNombreFincaActual() {
        return nombreFincaActual;
    }

    /**
     *
     * @param nit
     */
    public void setFincaActual(long nit, String name) {
        nitFincaActual = nit;
        nombreFincaActual = name;
    }

    public Date getUltimoParto() {
        return ultimoParto;
    }

    /**
     *
     * @param newVal
     */
    public void setUltimoParto(Date newVal) {
        ultimoParto = newVal;
    }

    /**
     *
     * @param cantDiaria
     * @param porc
     */
    public void setLeche(float cantDiaria, float porc) {
        cantLecheDiaria = cantDiaria;
        porcGrasaLeche = porc;
    }

    public float getCantAlimentoDiario() {
        return cantAlimentoDiario;
    }

    /**
     *
     * @param newVal
     */
    public void setCantAlimentoDiario(float newVal) {
        cantAlimentoDiario = newVal;
    }
}
