package Ganatool;

import Objetos.Usuario;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:36:00
 */
public class ControlDeAcceso {

    public ControlDeAcceso() {
    }

    public Usuario cargarUsuario(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            Usuario U = new Usuario();
            U.setDireccion(consulta.getString("direccion"));
            U.setDocumento(consulta.getString("tipodoc"),
                    consulta.getLong("nrodoc"));
            U.setEMail(consulta.getString("email"));
            U.setFechaNac(consulta.getDate("fechanac"));
            U.setFoto(consulta.getString("foto"));
            U.setNombre(consulta.getString("nombre"));
            U.setApellidos(consulta.getString("apellidos"));
            U.setPassword(consulta.getString("password"));
            U.setPregunta(consulta.getString("pregunta"),
                    consulta.getString("respuesta"));
            U.setRol(consulta.getString("rol").charAt(0));
            U.setSexo(consulta.getString("sexo").charAt(0));
            U.setTelefono(consulta.getLong("telefono"));
            U.setUsuario(consulta.getString("usuario"));
            consulta.close();
            return U;
        }
        consulta.close();
        return null;
    }

    public boolean existeUsuario(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            consulta.close();
            return true;
        } else {
            consulta.close();
            return false;
        }
    }

    public String[] cargarPregunta(ResultSet consulta) throws SQLException {
        String[] preg = null;
        if (consulta.next()) {
            preg = new String[2];
            preg[0] = consulta.getString("pregunta");
            preg[1] = consulta.getString("respuesta");
        }
        return preg;
    }
}
