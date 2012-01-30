package Objetos;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:03
 */
public class Ingrediente {

    private int codigo;
    private String nombre;
    private float precio;
    private String proveedor;
    private float calcio;
    private float fosforo;
    private float proteina;
    private float EM;
    private float ENgan;
    private float ENlact;
    private float ENmant;
    private float NDT;
    private float ED;
    private float vitaminaA;
    private float vitaminaD;
    private float KCal;
    private float humedad;
    private float extEtereo;
    private float ceniza;
    private float fibra;
    private float FDA;
    private float FDS;
    private float FDN;

    public Ingrediente() {
        nombre = "";
        proveedor = "";
        precio = 0;
        calcio = 0;
        fosforo = 0;
        proteina = 0;
        EM = 0;
        ENgan = 0;
        ENlact = 0;
        ENmant = 0;
        NDT = 0;
        ED = 0;
        vitaminaA = 0;
        vitaminaD = 0;
        KCal = 0;
        humedad = 0;
        extEtereo = 0;
        ceniza = 0;
        fibra = 0;
        FDA = 0;
        FDS = 0;
        FDN = 0;
    }

    public String getNombre() {
        return nombre;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setNombre(String newVal) {
        nombre = newVal;
    }

    public float getPrecio() {
        return precio;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setPrecio(float newVal) {
        precio = newVal;
    }

    public float getCalcio() {
        return calcio;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setCalcio(float newVal) {
        calcio = newVal;
    }

    public float getFosforo() {
        return fosforo;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setFosforo(float newVal) {
        fosforo = newVal;
    }

    public float getProteina() {
        return proteina;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setProteina(float newVal) {
        proteina = newVal;
    }

    public int getCodigo() {
        return codigo;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setCodigo(int newVal) {
        codigo = newVal;
    }

    public float getEM() {
        return EM;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setEM(float newVal) {
        EM = newVal;
    }

    public float getENgan() {
        return ENgan;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setENgan(float newVal) {
        ENgan = newVal;
    }

    public float getENlact() {
        return ENlact;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setENlact(float newVal) {
        ENlact = newVal;
    }

    public float getENmant() {
        return ENmant;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setENmant(float newVal) {
        ENmant = newVal;
    }

    public float getNDT() {
        return NDT;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setNDT(float newVal) {
        NDT = newVal;
    }

    public float getED() {
        return ED;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setED(float newVal) {
        ED = newVal;
    }

    public String getProveedor() {
        return proveedor;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setProveedor(String newVal) {
        proveedor = newVal;
    }

    public float getVitaminaA() {
        return vitaminaA;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setVitaminaA(float newVal) {
        vitaminaA = newVal;
    }

    public float getVitaminaD() {
        return vitaminaD;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setVitaminaD(float newVal) {
        vitaminaD = newVal;
    }

    public float getCeniza() {
        return ceniza;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setCeniza(float newVal) {
        this.ceniza = newVal;
    }

    public float getExtEtereo() {
        return extEtereo;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setExtEtereo(float newVal) {
        this.extEtereo = newVal;
    }

    public float getFDA() {
        return FDA;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setFDA(float newVal) {
        this.FDA = newVal;
    }

    public float getFDN() {
        return FDN;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setFDN(float newVal) {
        this.FDN = newVal;
    }

    public float getFDS() {
        return FDS;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setFDS(float newVal) {
        this.FDS = newVal;
    }

    public float getKCal() {
        return KCal;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setKCal(float newVal) {
        this.KCal = newVal;
    }

    public float getFibra() {
        return fibra;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setFibra(float newVal) {
        this.fibra = newVal;
    }

    public float getHumedad() {
        return humedad;
    }

    /**
     *
     * @param newVal    newVal
     */
    public void setHumedad(float newVal) {
        this.humedad = newVal;
    }
}
