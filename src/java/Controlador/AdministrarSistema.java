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
    
    public ArrayList<Usuario> buscarUsuario(ResultSet consulta, ArrayList<Usuario> usuarios) throws SQLException{
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
            boolean add = true;
            for(Usuario tmp: usuarios){
                if(tmp.getUsuario().equals(u.getUsuario())){
                    add = false;
                }
            }
            if(add){
                usuarios.add(u);
            }
                
        }
        return usuarios;
    }
  /*
 * etapafisiologica character varying(50),
  sexo character(1),
  peso real,
  ganancia real,
  cantalimento real,

  proteina real,
  ndt real,
  em real,
  enmant real,
  engan real,
  calcio real,
  fosforo real,
  * 




  ed,enlact,vitamina a,vitamina d



 */
    public ArrayList<TablasNutricionalesCarne> cargarNecesidadesCarne(ResultSet consulta) throws SQLException{
        ArrayList<TablasNutricionalesCarne> tablas = new ArrayList<TablasNutricionalesCarne>();
        while(consulta.next()){
        TablasNutricionalesCarne tabla = new TablasNutricionalesCarne();
        tabla.setId(consulta.getInt("id"));
        tabla.setEtapafisiologica(consulta.getString("etapafisiologica"));
        tabla.setSexo(consulta.getString("sexo").charAt(0));
        tabla.setPeso(consulta.getDouble("peso"));
        tabla.setGanancia(consulta.getDouble("ganancia"));
        tabla.setCantalimento(consulta.getDouble("cantalimento"));
        tabla.setProteina(consulta.getDouble("proteina"));
        tabla.setNdt(consulta.getDouble("ndt"));
        tabla.setEm(consulta.getDouble("em"));
        tabla.setEnmant(consulta.getDouble("enmant"));
        tabla.setEngan(consulta.getDouble("engan"));
        tabla.setCalcio(consulta.getDouble("calcio"));
        tabla.setFosforo(consulta.getDouble("fosforo"));
        /* específicos de carne */
        tabla.setForraje(consulta.getDouble("forraje"));
        tablas.add(tabla);
        }
        return tablas;
    }
    
    public TablasNutricionalesCarne buscarRegistroCarne(ResultSet consulta) throws SQLException{
        TablasNutricionalesCarne tabla = new TablasNutricionalesCarne();
        if(consulta.next()){
        tabla.setId(consulta.getInt("id"));
        tabla.setEtapafisiologica(consulta.getString("etapafisiologica"));
        tabla.setSexo(consulta.getString("sexo").charAt(0));
        tabla.setPeso(consulta.getDouble("peso"));
        tabla.setGanancia(consulta.getDouble("ganancia"));
        tabla.setCantalimento(consulta.getDouble("cantalimento"));
        tabla.setProteina(consulta.getDouble("proteina"));
        tabla.setNdt(consulta.getDouble("ndt"));
        tabla.setEm(consulta.getDouble("em"));
        tabla.setEnmant(consulta.getDouble("enmant"));
        tabla.setEngan(consulta.getDouble("engan"));
        tabla.setCalcio(consulta.getDouble("calcio"));
        tabla.setFosforo(consulta.getDouble("fosforo"));
        /* específicos de carne */
        tabla.setForraje(consulta.getDouble("forraje"));
        }
        return tabla;
    }
    
     public ArrayList<TablasNutricionalesLeche> cargarNecesidadesLeche(ResultSet consulta) throws SQLException{
         ArrayList<TablasNutricionalesLeche> tablas = new ArrayList<TablasNutricionalesLeche>();
        while(consulta.next()){
        TablasNutricionalesLeche tabla = new TablasNutricionalesLeche();
        tabla.setId(consulta.getInt("id"));
        tabla.setEtapafisiologica(consulta.getString("etapafisiologica"));
        tabla.setSexo(consulta.getString("sexo").charAt(0));
        tabla.setPeso(consulta.getDouble("peso"));
        tabla.setGanancia(consulta.getDouble("ganancia"));
        tabla.setCantalimento(consulta.getDouble("cantalimento"));
        tabla.setProteina(consulta.getDouble("proteina"));
        tabla.setNdt(consulta.getDouble("ndt"));
        tabla.setEm(consulta.getDouble("em"));
        tabla.setEnmant(consulta.getDouble("enmant"));
        tabla.setEngan(consulta.getDouble("engan"));
        tabla.setCalcio(consulta.getDouble("calcio"));
        tabla.setFosforo(consulta.getDouble("fosforo"));
        /* específicos de leche */
        tabla.setEd(consulta.getDouble("ed"));
        tabla.setEnlact(consulta.getDouble("enlact"));
        tabla.setVitaminaa(consulta.getDouble("vitaminaa"));
        tabla.setVitaminad(consulta.getDouble("vitaminad"));
        tablas.add(tabla);
        }
        return tablas;
     }
     
     public TablasNutricionalesLeche buscarRegistroLeche(ResultSet consulta) throws SQLException{
        TablasNutricionalesLeche tabla = new TablasNutricionalesLeche();
        if(consulta.next()){
        tabla.setId(consulta.getInt("id"));
        tabla.setEtapafisiologica(consulta.getString("etapafisiologica"));
        tabla.setSexo(consulta.getString("sexo").charAt(0));
        tabla.setPeso(consulta.getDouble("peso"));
        tabla.setGanancia(consulta.getDouble("ganancia"));
        tabla.setCantalimento(consulta.getDouble("cantalimento"));
        tabla.setProteina(consulta.getDouble("proteina"));
        tabla.setNdt(consulta.getDouble("ndt"));
        tabla.setEm(consulta.getDouble("em"));
        tabla.setEnmant(consulta.getDouble("enmant"));
        tabla.setEngan(consulta.getDouble("engan"));
        tabla.setCalcio(consulta.getDouble("calcio"));
        tabla.setFosforo(consulta.getDouble("fosforo"));
        /* específicos de leche */
        tabla.setEd(consulta.getDouble("ed"));
        tabla.setEnlact(consulta.getDouble("enlact"));
        tabla.setVitaminaa(consulta.getDouble("vitaminaa"));
        tabla.setVitaminad(consulta.getDouble("vitaminad"));
        }
        return tabla;
    }

}
