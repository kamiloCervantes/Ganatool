package Objetos;

import java.sql.Date;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:20:02
 */
public class Comentario {

    private String usuario;
    private Date fecha;
    private String comentario;

    /**
     *
     * @param usuario
     * @param comentario
     */
    public Comentario(String usuario, Date fecha, String comentario) {
        this.usuario = usuario;
        this.fecha = fecha;
        this.comentario = comentario;
    }

    public String getComentario() {
        return comentario;
    }

    public Date getFecha() {
        return fecha;
    }

    public String getUsuario() {
        return usuario;
    }
}
