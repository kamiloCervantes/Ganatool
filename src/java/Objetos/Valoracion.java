/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Objetos;

/**
 *
 * @author Administrador
 */
public class Valoracion {

    private String usuario;
    private int valor;

    public Valoracion(String usuario, int valor) {
        this.usuario = usuario;
        this.valor = valor;
    }

    public String getUsuario() {
        return usuario;
    }

    public int getValor() {
        return valor;
    }
}
