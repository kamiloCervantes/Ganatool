package Objetos;

import java.sql.Date;
import java.util.ArrayList;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:02
 */
public class Dieta {

    private int codigo;
    private Date fecha;
    private String usuario;
    private long nitFinca;
    private long codigoRes;
    private ArrayList<IngSuministrado> ingredientes;
    private ArrayList<Comentario> comentarios;
    private ArrayList<Valoracion> valoraciones;
    private boolean publicada;

    public Dieta() {
        ingredientes = new ArrayList<IngSuministrado>();
        comentarios = new ArrayList<Comentario>();
        valoraciones = new ArrayList<Valoracion>();
        publicada = false;
    }

    public int getCodigo() {
        return codigo;
    }

    /**
     *
     * @param newVal
     */
    public void setCodigo(int newVal) {
        codigo = newVal;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public long getNitFinca() {
        return nitFinca;
    }

    /**
     *
     * @param newVal
     */
    public void setNitFinca(long newVal) {
        nitFinca = newVal;
    }

    public long getCodigoRes() {
        return codigoRes;
    }

    /**
     *
     * @param newVal
     */
    public void setCodigoRes(long newVal) {
        codigoRes = newVal;
    }

    public ArrayList<IngSuministrado> getIngredientes() {
        return ingredientes;
    }

    public ArrayList<Comentario> getComentarios() {
        return comentarios;
    }

    public boolean getPublicada() {
        return publicada;
    }

    public void setPublicada(boolean publicada) {
        this.publicada = publicada;
    }

    /**
     *
     * @param I
     */
    public void agregarIngrediente(IngSuministrado I) {
        ingredientes.add(I);
    }

    public void agregarComentario(Comentario C) {
        comentarios.add(C);
    }

    public void agregarValoracion(Valoracion V) {
        valoraciones.add(V);
    }

    public int valoracionTotal() {
        int tot = 0;
        for (int i = 0; i < valoraciones.size(); i++) {
            tot += valoraciones.get(i).getValor();
        }
        if (tot > 0) {
            return tot / valoraciones.size();
        } else {
            return 0;
        }
    }

    public int valoracionDe(String usuario) {
        for (int i = 0; i < valoraciones.size(); i++) {
            if (valoraciones.get(i).getUsuario().equals(usuario)) {
                return valoraciones.get(i).getValor();
            }
        }
        return 0;
    }

    public void reset() {
        comentarios = new ArrayList<Comentario>();
        valoraciones = new ArrayList<Valoracion>();
    }
}
