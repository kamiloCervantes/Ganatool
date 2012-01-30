package Objetos;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:02
 */
public class Finca {

    private String nombre;
    private long nit;
    private String municipio;
    private String departamento;
    private String direccion;
    private String foto;
    private String nombreProp;
    private String tipoDocProp;
    private long ccProp;
    private long telProp;

    public Finca() {
        nombre = "";
        nit = 0;
        municipio = "";
        departamento = "";
        direccion = "";
        foto = "";
        nombreProp = "";
        tipoDocProp = "";
        ccProp = 0;
        telProp = 0;
    }

    public String getNombre() {
        return nombre;
    }

    /**
     *
     * @param newVal
     */
    public void setNombre(String newVal) {
        nombre = newVal;
    }

    public long getNit() {
        return nit;
    }

    /**
     *
     * @param newVal
     */
    public void setNit(long newVal) {
        nit = newVal;
    }

    public String getMunicipio() {
        return municipio;
    }

    public String getDepartamento() {
        return departamento;
    }

    public String getDireccion() {
        return direccion;
    }

    /**
     *
     * @param newVal
     */
    public void setDireccion(String newVal) {
        direccion = newVal;
    }

    public String getFoto() {
        return foto;
    }

    /**
     *
     * @param newVal
     */
    public void setFoto(String newVal) {
        foto = newVal;
    }

    public String getNombreProp() {
        return nombreProp;
    }

    public long getCcProp() {
        return ccProp;
    }

    public long getTelProp() {
        return telProp;
    }

    /**
     *
     * @param departamento
     * @param municipio
     * @param ciudad
     */
    public void setUbicacion(String departamento, String municipio) {
        this.departamento = departamento;
        this.municipio = municipio;
    }

    /**
     *
     * @param telefono
     * @param cc
     * @param nombre
     */
    public void setPropietario(long telefono, String tipo,
            long cc, String nombre) {
        telProp = telefono;
        tipoDocProp = tipo;
        ccProp = cc;
        nombreProp = nombre;
    }

    public String getTipoDocProp() {
        return tipoDocProp;
    }
}
