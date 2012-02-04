/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

/**
 *
 * @author Usuario
 */


public class TablasNutricionales {
    private int id;
    private String etapafisiologica;
    private char sexo;
    private double peso;
    private double ganancia;
    private double cantalimento;
    private double proteina;
    private double ndt;
    private double em;
    private double enmant;
    private double engan;
    private double calcio;
    private double fosforo;

    public TablasNutricionales(){
        this.id=0;
        this.etapafisiologica="";
        this.sexo=' ';
        this.peso=0;
        this.ganancia=0;
        this.cantalimento=0;
        this.proteina=0;
        this.ndt=0;
        this.em=0;
        this.enmant=0;
        this.engan=0;
        this.calcio=0;
        this.fosforo=0;
    }
    /**
     * @return the etapafisiologica
     */
    public String getEtapafisiologica() {
        return etapafisiologica;
    }

    /**
     * @param etapafisiologica the etapafisiologica to set
     */
    public void setEtapafisiologica(String etapafisiologica) {
        this.etapafisiologica = etapafisiologica;
    }

    /**
     * @return the sexo
     */
    public char getSexo() {
        return sexo;
    }

    /**
     * @param sexo the sexo to set
     */
    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    /**
     * @return the peso
     */
    public double getPeso() {
        return peso;
    }

    /**
     * @param peso the peso to set
     */
    public void setPeso(double peso) {
        this.peso = peso;
    }

    /**
     * @return the ganancia
     */
    public double getGanancia() {
        return ganancia;
    }

    /**
     * @param ganancia the ganancia to set
     */
    public void setGanancia(double ganancia) {
        this.ganancia = ganancia;
    }

    /**
     * @return the cantalimento
     */
    public double getCantalimento() {
        return cantalimento;
    }

    /**
     * @param cantalimento the cantalimento to set
     */
    public void setCantalimento(double cantalimento) {
        this.cantalimento = cantalimento;
    }

    /**
     * @return the proteina
     */
    public double getProteina() {
        return proteina;
    }

    /**
     * @param proteina the proteina to set
     */
    public void setProteina(double proteina) {
        this.proteina = proteina;
    }

    /**
     * @return the ndt
     */
    public double getNdt() {
        return ndt;
    }

    /**
     * @param ndt the ndt to set
     */
    public void setNdt(double ndt) {
        this.ndt = ndt;
    }

    /**
     * @return the em
     */
    public double getEm() {
        return em;
    }

    /**
     * @param em the em to set
     */
    public void setEm(double em) {
        this.em = em;
    }

    /**
     * @return the enmant
     */
    public double getEnmant() {
        return enmant;
    }

    /**
     * @param enmant the enmant to set
     */
    public void setEnmant(double enmant) {
        this.enmant = enmant;
    }

    /**
     * @return the engan
     */
    public double getEngan() {
        return engan;
    }

    /**
     * @param engan the engan to set
     */
    public void setEngan(double engan) {
        this.engan = engan;
    }

    /**
     * @return the calcio
     */
    public double getCalcio() {
        return calcio;
    }

    /**
     * @param calcio the calcio to set
     */
    public void setCalcio(double calcio) {
        this.calcio = calcio;
    }

    /**
     * @return the fosforo
     */
    public double getFosforo() {
        return fosforo;
    }

    /**
     * @param fosforo the fosforo to set
     */
    public void setFosforo(double fosforo) {
        this.fosforo = fosforo;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }
}
