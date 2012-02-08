/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

/**
 *
 * @author Usuario
 */
public class TablasNutricionalesLeche extends TablasNutricionales{
    private double ed;
    private double enlact;
    private double vitaminaa;
    private double vitaminad;

    
    public TablasNutricionalesLeche(){
        super();
        ed=0;
        enlact=0;
        vitaminaa=0;
        vitaminad=0;
    }
    /**
     * @return the ed
     */
    public double getEd() {
        return ed;
    }

    /**
     * @param ed the ed to set
     */
    public void setEd(double ed) {
        this.ed = ed;
    }

    /**
     * @return the enlact
     */
    public double getEnlact() {
        return enlact;
    }

    /**
     * @param enlact the enlact to set
     */
    public void setEnlact(double enlact) {
        this.enlact = enlact;
    }

    /**
     * @return the vitaminaa
     */
    public double getVitaminaa() {
        return vitaminaa;
    }

    /**
     * @param vitaminaa the vitaminaa to set
     */
    public void setVitaminaa(double vitaminaa) {
        this.vitaminaa = vitaminaa;
    }

    /**
     * @return the vitaminad
     */
    public double getVitaminad() {
        return vitaminad;
    }

    /**
     * @param vitaminad the vitaminad to set
     */
    public void setVitaminad(double vitaminad) {
        this.vitaminad = vitaminad;
    }
}
