package Objetos;

import java.sql.Date;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:03
 */
public class Usuario {

    private String nombre;
    private String apellidos;
    private String tipoDoc;
    private long nroDoc;
    private String foto;
    private String eMail;
    private String direccion;
    private long telefono;
    private char rol;
    private Date fechaNac;
    private String usuario;
    private String password;
    private String pregunta;
    private String respuesta;
    private char sexo;

    public Usuario() {
        nombre = "";
        apellidos = "";
        tipoDoc = "";
        nroDoc = 0;
        foto = "";
        eMail = "";
        direccion = "";
        telefono = 0;
        rol = 'v';
        fechaNac = null;
        usuario = "";
        password = "";
        pregunta = "";
        respuesta = "";
        sexo = 'm';
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

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String newVal) {
        apellidos = newVal;
    }

    public String getTipoDoc() {
        return tipoDoc;
    }

    public long getNroDoc() {
        return nroDoc;
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

    public String getEMail() {
        return eMail;
    }

    /**
     *
     * @param newVal
     */
    public void setEMail(String newVal) {
        eMail = newVal;
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

    public long getTelefono() {
        return telefono;
    }

    /**
     *
     * @param newVal
     */
    public void setTelefono(long newVal) {
        telefono = newVal;
    }

    public char getRol() {
        return rol;
    }

    /**
     *
     * @param newVal
     */
    public void setRol(char newVal) {
        rol = newVal;
    }

    public Date getFechaNac() {
        return fechaNac;
    }

    /**
     *
     * @param newVal
     */
    public void setFechaNac(Date newVal) {
        fechaNac = newVal;
    }

    public String getUsuario() {
        return usuario;
    }

    /**
     *
     * @param newVal
     */
    public void setUsuario(String newVal) {
        usuario = newVal;
    }

    public String getPassword() {
        return password;
    }

    /**
     *
     * @param newVal
     */
    public void setPassword(String newVal) {
        password = newVal;
    }

    public String getPregunta() {
        return pregunta;
    }

    public String getRespuesta() {
        return respuesta;
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

    /**
     *
     * @param tipo
     * @param nro
     */
    public void setDocumento(String tipo, long nro) {
        tipoDoc = tipo;
        nroDoc = nro;
    }

    /**
     *
     * @param preg
     * @param resp
     */
    public void setPregunta(String preg, String resp) {
        pregunta = preg;
        respuesta = resp;
    }
}
