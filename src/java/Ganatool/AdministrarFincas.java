package Ganatool;

import Objetos.Finca;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:36:00
 */
public class AdministrarFincas {

    private ArrayList<Finca> lista;

    public AdministrarFincas() {
    }

    public ArrayList<Finca> cargarFincas(ResultSet consulta)
            throws SQLException {
        lista = new ArrayList<Finca>();
        while (consulta.next()) {
            Finca F = new Finca();
            F.setDireccion(consulta.getString("direccion"));
            F.setFoto(consulta.getString("foto"));
            F.setNit(consulta.getLong("nit"));
            F.setNombre(consulta.getString("nombre"));
            F.setPropietario(consulta.getLong("telprop"),
                    consulta.getString("tipodocprop"),
                    consulta.getLong("ccprop"),
                    consulta.getString("nombreprop"));
            F.setUbicacion(consulta.getString("departamento"),
                    consulta.getString("municipio"));
            lista.add(F);
        }
        return lista;
    }

    public boolean existeFinca(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            consulta.close();
            return true;
        } else {
            consulta.close();
            return false;
        }
    }

    public Finca cargarFinca(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            Finca F = new Finca();
            F.setDireccion(consulta.getString("direccion"));
            F.setFoto(consulta.getString("foto"));
            F.setNit(consulta.getLong("nit"));
            F.setNombre(consulta.getString("nombre"));
            F.setPropietario(consulta.getLong("telprop"),
                    consulta.getString("tipodocprop"),
                    consulta.getLong("ccprop"),
                    consulta.getString("nombreprop"));
            F.setUbicacion(consulta.getString("departamento"),
                    consulta.getString("municipio"));
            consulta.close();
            return F;
        } else {
            consulta.close();
            return null;
        }
    }
}
