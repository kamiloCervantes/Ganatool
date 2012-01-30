package Ganatool;

import Objetos.Ingrediente;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author Administrador
 * @version 1.0
 * @created 22-Nov-2010 09:36:00
 */
public class AdministrarIngredientes {

    private ArrayList<Ingrediente> lista;

    public AdministrarIngredientes() {
    }

    public ArrayList<Ingrediente> cargarIngredientes(ResultSet consulta)
            throws SQLException {
        lista = new ArrayList<Ingrediente>();
        while (consulta.next()) {
            Ingrediente I = new Ingrediente();
            I.setCalcio(consulta.getFloat("calcio"));
            I.setCodigo(consulta.getInt("codigo"));
            I.setED(consulta.getFloat("ed"));
            I.setEM(consulta.getFloat("em"));
            I.setENgan(consulta.getFloat("engan"));
            I.setENlact(consulta.getFloat("enlact"));
            I.setENmant(consulta.getFloat("enmant"));
            I.setFosforo(consulta.getFloat("fosforo"));
            I.setNDT(consulta.getFloat("ndt"));
            I.setNombre(consulta.getString("nombre"));
            I.setPrecio(consulta.getFloat("precio"));
            I.setProteina(consulta.getFloat("proteina"));
            I.setProveedor(consulta.getString("proveedor"));
            I.setVitaminaA(consulta.getFloat("vitaminaa"));
            I.setVitaminaD(consulta.getFloat("vitaminad"));

            I.setKCal(consulta.getFloat("kcal"));
            I.setCeniza(consulta.getFloat("ceniza"));
            I.setExtEtereo(consulta.getFloat("extetereo"));
            I.setFDA(consulta.getFloat("fda"));
            I.setFDS(consulta.getFloat("fds"));
            I.setFDN(consulta.getFloat("fdn"));
            I.setFibra(consulta.getFloat("fibra"));
            I.setHumedad(consulta.getFloat("humedad"));
            lista.add(I);
        }
        return lista;
    }

    public boolean existeIngrediente(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            consulta.close();
            return true;
        } else {
            consulta.close();
            return false;
        }
    }

    public Ingrediente cargarIngrediente(ResultSet consulta) throws SQLException {
        if (consulta.next()) {
            Ingrediente I = new Ingrediente();
            I.setCalcio(consulta.getFloat("calcio"));
            I.setCodigo(consulta.getInt("codigo"));
            I.setED(consulta.getFloat("ed"));
            I.setEM(consulta.getFloat("em"));
            I.setENgan(consulta.getFloat("engan"));
            I.setENlact(consulta.getFloat("enlact"));
            I.setENmant(consulta.getFloat("enmant"));
            I.setFosforo(consulta.getFloat("fosforo"));
            I.setNDT(consulta.getFloat("ndt"));
            I.setNombre(consulta.getString("nombre"));
            I.setPrecio(consulta.getFloat("precio"));
            I.setProteina(consulta.getFloat("proteina"));
            I.setProveedor(consulta.getString("proveedor"));
            I.setVitaminaA(consulta.getFloat("vitaminaa"));
            I.setVitaminaD(consulta.getFloat("vitaminad"));

            I.setKCal(consulta.getFloat("kcal"));
            I.setCeniza(consulta.getFloat("ceniza"));
            I.setExtEtereo(consulta.getFloat("extetereo"));
            I.setFDA(consulta.getFloat("fda"));
            I.setFDS(consulta.getFloat("fds"));
            I.setFDN(consulta.getFloat("fdn"));
            I.setFibra(consulta.getFloat("fibra"));
            I.setHumedad(consulta.getFloat("humedad"));
            return I;
        } else {
            return null;
        }
    }
}
