/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

/**
 *
 * @author Usuario
 */
public class TablasNutricionalesCarne extends TablasNutricionales{
   
    private double forraje;
    
    public TablasNutricionalesCarne(){
        super();
        forraje = 0;
       
    }

    /**
     * @return the forraje
     */
    public double getForraje() {
        return forraje;
    }

    /**
     * @param forraje the forraje to set
     */
    public void setForraje(double forraje) {
        this.forraje = forraje;
    }


}
