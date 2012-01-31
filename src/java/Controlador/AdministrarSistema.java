package Controlador;
import java.util.ArrayList;
import Objetos.*;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * @author Administrador
 * @version 1.0
 * @created 07-Ene-2011 11:06:06
 */
public class AdministrarSistema {

    public AdministrarSistema() {
    }
    
    public ArrayList<Usuario> cargarUsuarios(ResultSet consulta) throws SQLException{
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        while(consulta.next()){
            Usuario u = new Usuario();
            u.setNombre(consulta.getString("nombre"));
            u.setApellidos(consulta.getString("apellidos"));
            u.setDocumento(consulta.getString("tipodoc"), consulta.getLong("nrodoc"));
            u.setFoto(consulta.getString("foto"));
            u.setEMail(consulta.getString("email"));
            u.setDireccion(consulta.getString("direccion"));
            u.setTelefono(consulta.getLong("telefono"));
            u.setRol(consulta.getString("rol").charAt(0));
            u.setFechaNac(consulta.getDate("fechanac"));
            u.setUsuario(consulta.getString("usuario"));
            u.setPassword(consulta.getString("password"));
            u.setPregunta(consulta.getString("pregunta"), consulta.getString("respuesta"));
            u.setSexo(consulta.getString("sexo").charAt(0));
            usuarios.add(u);
        }
        return usuarios;
    }
}
