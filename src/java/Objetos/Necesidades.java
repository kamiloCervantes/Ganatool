package Objetos;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:03
 */
public class Necesidades {

    // Necesidades comunes:
    private float calcio;
    private float fosforo;
    private float proteina;
    private float EM;
    private float ENgan;
    private float ENmant;
    private float NDT;
    // Necesidades Leche:
    private float ED;
    private float ENlact;
    private float vitaminaA;
    private float vitaminaD;
    // Necesidades Carne:
    private float forraje;

    public Necesidades() {
        calcio = 0;
        fosforo = 0;
        proteina = 0;
        EM = 0;
        ENgan = 0;
        ENmant = 0;
        NDT = 0;
        ED = 0;
        ENlact = 0;
        vitaminaA = 0;
        vitaminaD = 0;
        forraje = 0;
    }

    public float getCalcio() {
        return calcio;
    }

    public void setCalcio(float calcio) {
        this.calcio = calcio;
    }

    public float getED() {
        return ED;
    }

    public void setED(float ED) {
        this.ED = ED;
    }

    public float getEM() {
        return EM;
    }

    public void setEM(float EM) {
        this.EM = EM;
    }

    public float getENgan() {
        return ENgan;
    }

    public void setENgan(float ENgan) {
        this.ENgan = ENgan;
    }

    public float getENlact() {
        return ENlact;
    }

    public void setENlact(float ENlact) {
        this.ENlact = ENlact;
    }

    public float getENmant() {
        return ENmant;
    }

    public void setENmant(float ENmant) {
        this.ENmant = ENmant;
    }

    public float getForraje() {
        return forraje;
    }

    public void setForraje(float forraje) {
        this.forraje = forraje;
    }

    public float getFosforo() {
        return fosforo;
    }

    public void setFosforo(float fosforo) {
        this.fosforo = fosforo;
    }

    public float getNDT() {
        return NDT;
    }

    public void setNDT(float NDT) {
        this.NDT = NDT;
    }

    public float getProteina() {
        return proteina;
    }

    public void setProteina(float proteina) {
        this.proteina = proteina;
    }

    public float getVitaminaA() {
        return vitaminaA;
    }

    public void setVitaminaA(float vitaminaA) {
        this.vitaminaA = vitaminaA;
    }

    public float getVitaminaD() {
        return vitaminaD;
    }

    public void setVitaminaD(float vitaminaD) {
        this.vitaminaD = vitaminaD;
    }
}
