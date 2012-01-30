package Ganatool;

import Objetos.Finca;
import Objetos.Registro;
import Objetos.Res;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:36:00
 */
public class AdministrarGanado {

    private ArrayList<Res> lista;

    public AdministrarGanado() {
    }

    public ArrayList<Res> buscarGanado(ResultSet consulta, Finca F)
            throws SQLException {
        lista = new ArrayList<Res>();
        while (consulta.next()) {
            Res R = new Res();
            R.setCantAlimentoDiario(consulta.getFloat("cantalimento"));
            R.setCodigo(consulta.getLong("codigo"));
            R.setEdad(consulta.getInt("edad"));
            R.setEtapaFisiologica(consulta.getString("etapafisiologica"));
            R.setLeche(consulta.getFloat("cantleche"),
                    consulta.getFloat("porcgrasaleche"));
            R.setFincaActual(consulta.getLong("nitfinca"), F.getNombre());
            R.setPeso(consulta.getFloat("peso"));
            R.setPropietario(consulta.getString("propietario"));
            R.setProposito(consulta.getString("proposito").charAt(0));
            R.setRaza(consulta.getString("raza"));
            R.setSexo(consulta.getString("sexo").charAt(0));
            R.setUltimoParto(consulta.getDate("ultimoparto"));
            lista.add(R);
        }
        return lista;
    }

    public ArrayList<Res> cargarReses(ResultSet consulta) throws SQLException {
        lista = new ArrayList<Res>();
        while (consulta.next()) {
            Res R = new Res();
            R.setCantAlimentoDiario(consulta.getFloat("cantalimento"));
            R.setCodigo(consulta.getLong("codigo"));
            R.setEdad(consulta.getInt("edad"));
            R.setEtapaFisiologica(consulta.getString("etapafisiologica"));
            R.setLeche(consulta.getFloat("cantleche"),
                    consulta.getFloat("porcgrasaleche"));
            R.setFincaActual(consulta.getLong("nitfinca"), consulta.getString("nombre"));
            R.setPeso(consulta.getFloat("peso"));
            R.setPropietario(consulta.getString("propietario"));
            R.setProposito(consulta.getString("proposito").charAt(0));
            R.setRaza(consulta.getString("raza"));
            R.setSexo(consulta.getString("sexo").charAt(0));
            R.setUltimoParto(consulta.getDate("ultimoparto"));
            lista.add(R);
        }
        return lista;
    }

    public boolean existeRes(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            consulta.close();
            return true;
        } else {
            consulta.close();
            return false;
        }
    }

    public Res cargarRes(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            Res R = new Res();
            R.setCantAlimentoDiario(consulta.getFloat("cantalimento"));
            R.setCodigo(consulta.getLong("codigo"));
            R.setEdad(consulta.getInt("edad"));
            R.setEtapaFisiologica(consulta.getString("etapafisiologica"));
            R.setLeche(consulta.getFloat("cantleche"),
                    consulta.getFloat("porcgrasaleche"));
            R.setFincaActual(consulta.getLong("nitfinca"), consulta.getString("nombre"));
            R.setPeso(consulta.getFloat("peso"));
            R.setPropietario(consulta.getString("propietario"));
            R.setProposito(consulta.getString("proposito").charAt(0));
            R.setRaza(consulta.getString("raza"));
            R.setSexo(consulta.getString("sexo").charAt(0));
            R.setUltimoParto(consulta.getDate("ultimoparto"));
            return R;
        } else {
            consulta.close();
            return null;
        }
    }

    public ArrayList<Registro> cargarRegistros(ResultSet consulta)
            throws SQLException {
        ArrayList<Registro> registros = new ArrayList<Registro>();
        while (consulta.next()) {
            Registro R = new Registro(consulta.getDate("fecha"),
                    consulta.getLong("codigores"),
                    consulta.getLong("codigofinca"),
                    consulta.getInt("edad"),
                    consulta.getString("etapa"),
                    consulta.getFloat("peso"),
                    consulta.getFloat("cantleche"));
            registros.add(R);
        }
        return registros;
    }
}
