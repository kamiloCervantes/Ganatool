package Objetos;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:03
 */
public class IngSuministrado {

    private Ingrediente ingrediente;
    private float cantidad;

    /**
     *
     * @param cantidad
     * @param ingrediente
     */
    public IngSuministrado(Ingrediente ingrediente, float cantidad) {
        this.ingrediente = ingrediente;
        this.cantidad = cantidad;
    }

    public Ingrediente getIngrediente() {
        return ingrediente;
    }

    public float getCantidad() {
        return cantidad;
    }
}
