package Controlador;

import Ganatool.*;
import Objetos.*;
import java.io.File;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

/**
 * @author Jesus Herazo
 * @version 1.0
 * @created 22-Nov-2010 09:31:46
 */
public class BDControlador {

    private ArrayList<String> valoresform;
    public String RUTA;
    //private final String RUTA = "/home/kamilo/NetBeansProjects/ganatool~ganatool-repository/ganatool~ganatool-repository/web/uploads";
    private PreparedStatement PS;
    private String SQL;
    private String direccionBD;
    private String nombreBD;
    private String usuarioBD;
    private String password;
    protected Connection conexion;
    protected Statement instruccion;
    // Administracion de Datos:
    private ControlDeAcceso CA;
    private AdministrarFincas AF;
    private AdministrarGanado AG;
    private AdministrarIngredientes AI;
    private AdministrarDieta AD;
    private AdministrarSistema ADM;

    public BDControlador() {
        try {
            direccionBD = "jdbc:postgresql://127.0.0.1:5432/";
            nombreBD = "bd_ganatool";
            usuarioBD = "postgres";
            password = "danger8931";

            CA = new ControlDeAcceso();
            AF = new AdministrarFincas();
            AG = new AdministrarGanado();
            AI = new AdministrarIngredientes();
            AD = new AdministrarDieta();
            ADM = new AdministrarSistema();

            ConectarBD();
        } catch (ClassNotFoundException ex) {
            System.err.println(ex);
        } catch (SQLException ex) {
            System.err.println(ex);
        }
    }

    private void ConectarBD() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");
        conexion = DriverManager.getConnection(direccionBD + nombreBD,
                usuarioBD, password);
        instruccion = conexion.createStatement();
    }

    public void subirImagen(HttpServletRequest request) {
        valoresform = new ArrayList<String>();
        File destino = new File(RUTA);
        ServletRequestContext src = new ServletRequestContext(request);
        boolean isMultipart = ServletFileUpload.isMultipartContent(src);
        if (isMultipart) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setRepository(destino);
            factory.setSizeThreshold((1024 * 1024));
            ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
            servletFileUpload.setSizeMax(-1);
            try {
                List items = servletFileUpload.parseRequest(src);
                Iterator iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        valoresform.add(item.getString());
                    } else {
                        valoresform.add(destino.getName() + "/" + item.getName());
                        File uploadedFile = new File(destino.getAbsolutePath() + "\\" + item.getName());
                        item.write(uploadedFile);
                    }
                }
            } catch (FileUploadException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    /* CONTROL DE ACCESO */
    public Usuario buscarUsuario(String user, String passwd) throws SQLException {
        SQL = "SELECT U.* FROM usuario as U WHERE U.usuario = ? AND U.password = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, user);
        PS.setString(2, passwd);

        ResultSet consulta = PS.executeQuery();
        return CA.cargarUsuario(consulta);
    }

    public int registrarUsuario(HttpServletRequest request) throws SQLException {
        Usuario U = new Usuario();
        U.setNombre(this.valoresform.get(2));
        U.setApellidos(this.valoresform.get(3));
        U.setDocumento(this.valoresform.get(0), Long.parseLong(this.valoresform.get(1)));
        U.setSexo(this.valoresform.get(4).charAt(0));
        U.setFechaNac(Date.valueOf(this.valoresform.get(5)));
        U.setUsuario(this.valoresform.get(6));
        U.setEMail(this.valoresform.get(11));
        if (!this.valoresform.get(12).equals("")) {
            U.setTelefono(Long.parseLong(this.valoresform.get(12)));
        }
        U.setDireccion(this.valoresform.get(13));
        U.setPassword(this.valoresform.get(7));
        U.setPregunta(this.valoresform.get(9), this.valoresform.get(10));
        String foto = this.valoresform.get(14);
        if (!foto.endsWith("s/")) {
            U.setFoto(foto);
        }
        request.getSession(true).setAttribute("datosUsuario", U);

        int state = 0;
        SQL = "SELECT U.* FROM usuario as U WHERE U.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, U.getUsuario());

        if (CA.existeUsuario(PS.executeQuery())) {
            state = 1;
        }

        SQL = "SELECT U.* FROM usuario as U WHERE U.email = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, U.getEMail());

        if (CA.existeUsuario(PS.executeQuery())) {
            state = 2;
        }

        if (state == 0) {
            SQL = "INSERT INTO usuario VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, U.getUsuario());
            PS.setString(2, U.getNombre());
            PS.setString(3, U.getApellidos());
            PS.setString(4, U.getTipoDoc());
            PS.setLong(5, U.getNroDoc());
            PS.setString(6, U.getPregunta());
            PS.setString(7, U.getFoto());
            PS.setString(8, U.getRespuesta());
            PS.setString(9, U.getEMail());
            PS.setString(10, U.getPassword());
            PS.setString(11, U.getRol() + "");
            PS.setString(12, U.getDireccion());
            PS.setLong(13, U.getTelefono());
            PS.setDate(14, U.getFechaNac());
            PS.setString(15, U.getSexo() + "");

            PS.executeUpdate();
        }

        return state;
    }

    public int modificarUsuario(HttpServletRequest request, Usuario usuarioActual) throws SQLException {
        Usuario U = new Usuario();
        int state = 0;
        String foto = this.valoresform.get(0);
        if (!foto.endsWith("s/")) {
            U.setFoto(foto);
        }
        U.setNombre(this.valoresform.get(1));
        U.setApellidos(this.valoresform.get(2));
        U.setDocumento(this.valoresform.get(4), Long.parseLong(this.valoresform.get(3)));
        U.setSexo(this.valoresform.get(5).charAt(0));
        U.setFechaNac(Date.valueOf(this.valoresform.get(6)));
        U.setEMail(this.valoresform.get(7));
        if (!this.valoresform.get(8).equals("")) {
            U.setTelefono(Long.parseLong(this.valoresform.get(8)));
        }
        U.setDireccion(this.valoresform.get(9));

        SQL = "SELECT U.* FROM usuario as U WHERE U.email = ? AND (NOT U.usuario = ?)";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, U.getEMail());
        PS.setString(2, usuarioActual.getUsuario());

        if (CA.existeUsuario(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "UPDATE usuario SET nombre = ?, apellidos = ?,"
                    + "tipodoc = ?, nrodoc = ?, sexo = ?, fechanac = ?, "
                    + "email = ?, telefono = ?, direccion = ?, foto = ? "
                    + "WHERE usuario = ?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, U.getNombre());
            PS.setString(2, U.getApellidos());
            PS.setString(3, U.getTipoDoc());
            PS.setLong(4, U.getNroDoc());
            PS.setString(5, U.getSexo() + "");
            PS.setDate(6, U.getFechaNac());
            PS.setString(7, U.getEMail());
            PS.setLong(8, U.getTelefono());
            PS.setString(9, U.getDireccion());
            PS.setString(10, U.getFoto());
            PS.setString(11, usuarioActual.getUsuario());

            PS.executeUpdate();

            usuarioActual.setNombre(U.getNombre());
            usuarioActual.setApellidos(U.getApellidos());
            usuarioActual.setDocumento(U.getTipoDoc(), U.getNroDoc());
            usuarioActual.setSexo(U.getSexo());
            usuarioActual.setFechaNac(U.getFechaNac());
            usuarioActual.setEMail(U.getEMail());
            usuarioActual.setTelefono(U.getTelefono());
            usuarioActual.setDireccion(U.getDireccion());
            usuarioActual.setFoto(U.getFoto());
            request.getSession().setAttribute("usuario", usuarioActual);
        }

        return state;
    }

    public String[] buscarPregunta(String tipodoc, long nrodoc)
            throws SQLException {
        String[] pregunta = null;
        SQL = "SELECT U.pregunta, U.respuesta FROM usuario as U WHERE "
                + "U.tipodoc = ? AND U.nrodoc = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, tipodoc);
        PS.setLong(2, nrodoc);

        pregunta = CA.cargarPregunta(PS.executeQuery());

        return pregunta;
    }

    public void cambiarConstraseña(String tipodoc, long nrodoc,
            String usuario, String pass)
            throws SQLException {
        SQL = "UPDATE usuario SET password = ?, usuario = ? WHERE"
                + " tipodoc = ? AND nrodoc = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, pass);
        PS.setString(2, usuario);
        PS.setString(3, tipodoc);
        PS.setLong(4, nrodoc);

        PS.executeUpdate();
    }

    public void cambiarPregunta(String user, String preg, String resp)
            throws SQLException {
        SQL = "UPDATE usuario SET pregunta = ? , respuesta = ? WHERE"
                + " usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, preg);
        PS.setString(2, resp);
        PS.setString(3, user);

        PS.executeUpdate();
    }

    public void eliminarUsuario(Usuario usuarioActual)
            throws SQLException {
        SQL = "DELETE FROM usuario as U WHERE U.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());

        PS.executeUpdate();
    }

    /* ADMINISTRACION DE FINCAS */
    public ArrayList<Finca> buscarFincas(Usuario usuarioActual)
            throws SQLException {
        SQL = "SELECT F.* FROM Finca as F, Maneja as M WHERE "
                + "F.nit = M.nitfinca AND M.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());

        return AF.cargarFincas(PS.executeQuery());
    }

    public ArrayList<Finca> buscarFincas(Usuario usuarioActual,
            String parametro, String tipo) throws SQLException {
        SQL = "SELECT F.* FROM Finca as F, Maneja as M WHERE "
                + "F.nit = M.nitfinca AND M.usuario = ? AND F."
                + tipo + " = ?";

        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());
        if (tipo.equals("nit")) {
            try {
                PS.setLong(2, Long.parseLong(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Finca>();
            }
        } else {
            PS.setString(2, parametro);
        }

        return AF.cargarFincas(PS.executeQuery());
    }

    public Finca buscarFinca(long nit)
            throws SQLException {
        Finca F = null;
        SQL = "SELECT F.* FROM finca as F WHERE F.nit = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, nit);

        F = AF.cargarFinca(PS.executeQuery());

        return F;
    }

    public int agregarFinca(Usuario usuarioActual, HttpServletRequest request)
            throws SQLException {
        Finca F = new Finca();
        F.setDireccion(this.valoresform.get(4));
        String foto = this.valoresform.get(9);
        if (!foto.endsWith("s/")) {
            F.setFoto(foto);
        }
        F.setNit(Long.parseLong(this.valoresform.get(1)));
        F.setNombre(this.valoresform.get(0));
        long telefono = 0;
        if (!this.valoresform.get(8).equals("")) {
            telefono = Long.parseLong(this.valoresform.get(8));
        }
        F.setPropietario(telefono,
                this.valoresform.get(6),
                Long.parseLong(this.valoresform.get(7)),
                this.valoresform.get(5));
        F.setUbicacion(this.valoresform.get(2),
                this.valoresform.get(3));
        request.getSession().setAttribute("datosFinca", F);

        int state = 0;
        SQL = "SELECT F.* FROM finca as F WHERE F.nit = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, F.getNit());

        if (AF.existeFinca(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "INSERT INTO finca VALUES (?,?,?,?,?,?,?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, F.getNombre());
            PS.setLong(2, F.getNit());
            PS.setString(3, F.getMunicipio());
            PS.setString(4, F.getDepartamento());
            PS.setString(5, F.getDireccion());
            PS.setString(6, F.getFoto());
            PS.setString(7, F.getNombreProp());
            PS.setLong(8, F.getCcProp());
            PS.setLong(9, F.getTelProp());
            PS.setString(10, F.getTipoDocProp());

            PS.executeUpdate();

            SQL = "INSERT INTO maneja VALUES (?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, usuarioActual.getUsuario());
            PS.setLong(2, F.getNit());

            PS.executeUpdate();
        }

        return state;
    }

    public void eliminarFinca(long nit)
            throws SQLException {
        SQL = "DELETE FROM finca as F WHERE F.nit = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, nit);

        PS.executeUpdate();
    }

    public int modificarFinca(Usuario usuarioActual,
            HttpServletRequest request)
            throws SQLException {
        Finca F = new Finca();
        F.setDireccion(this.valoresform.get(4));
        String foto = this.valoresform.get(9);
        if (!foto.endsWith("s/")) {
            F.setFoto(foto);
        }
        F.setNit(Long.parseLong(this.valoresform.get(1)));
        F.setNombre(this.valoresform.get(0));
        long telefono = 0;
        if (!this.valoresform.get(8).equals("")) {
            telefono = Long.parseLong(this.valoresform.get(8));
        }
        F.setPropietario(telefono,
                this.valoresform.get(6),
                Long.parseLong(this.valoresform.get(7)),
                this.valoresform.get(5));
        F.setUbicacion(this.valoresform.get(2),
                this.valoresform.get(3));
        request.getSession().setAttribute("datosFinca", F);
        long viejoNit = (Long) request.getSession().getAttribute("viejonit");

        int state = 0;
        SQL = "SELECT F.* FROM finca as F WHERE F.nit = ? AND NOT (F.nit = ?)";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, F.getNit());
        PS.setLong(2, viejoNit);

        if (AF.existeFinca(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "UPDATE finca SET nombre = ?, nit = ?, municipio = ?,"
                    + "departamento = ?, direccion = ?, foto = ?, nombreprop = ?,"
                    + "tipodocprop = ?, ccprop = ?, telprop = ? WHERE nit = ?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, F.getNombre());
            PS.setLong(2, F.getNit());
            PS.setString(3, F.getMunicipio());
            PS.setString(4, F.getDepartamento());
            PS.setString(5, F.getDireccion());
            PS.setString(6, F.getFoto());
            PS.setString(7, F.getNombreProp());
            PS.setString(8, F.getTipoDocProp());
            PS.setLong(9, F.getCcProp());
            PS.setLong(10, F.getTelProp());

            PS.setLong(11, viejoNit);

            PS.executeUpdate();
        }

        return state;
    }

    /* ADMINISTRACION DE RESES */
    public ArrayList<Res> buscarReses(Finca F)
            throws SQLException {
        SQL = "SELECT R.* FROM res as R WHERE R.nitfinca = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, F.getNit());

        return AG.buscarGanado(PS.executeQuery(), F);
    }

    public ArrayList<Res> buscarReses(Usuario usuarioActual)
            throws SQLException {
        SQL = "SELECT G.*,F.nombre FROM Finca as F, Maneja as M, Res as G WHERE "
                + "G.nitfinca = F.nit AND F.nit = M.nitfinca AND M.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());

        return AG.cargarReses(PS.executeQuery());
    }

    public ArrayList<Res> buscarReses(Usuario usuarioActual,
            String parametro, String tipo)
            throws SQLException {
        SQL = "SELECT G.*,F.nombre FROM Finca as F, Maneja as M, Res as G WHERE "
                + "G.nitfinca = F.nit AND F.nit = M.nitfinca AND M.usuario = ? "
                + "AND G." + tipo + " = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());
        if (tipo.equals("codigo")) {
            try {
                PS.setLong(2, Long.parseLong(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Res>();
            }
        } else {
            PS.setString(2, parametro);
        }

        return AG.cargarReses(PS.executeQuery());
    }

    public int agregarRes(Usuario usuarioActual,
            HttpServletRequest request)
            throws SQLException {
        Res R = new Res();
        R.setCantAlimentoDiario(Float.parseFloat(this.valoresform.get(4)));
        R.setCodigo(Long.parseLong(this.valoresform.get(1)));
        R.setEdad(Integer.parseInt(this.valoresform.get(5)));
        R.setEtapaFisiologica(this.valoresform.get(6));
        R.setFincaActual(Long.parseLong(this.valoresform.get(9)),
                this.valoresform.get(9));
        if (!this.valoresform.get(10).equals("")
                && !this.valoresform.get(11).equals("")) {
            R.setLeche(Float.parseFloat(this.valoresform.get(10)),
                    Float.parseFloat(this.valoresform.get(11)));
        }
        R.setPeso(Float.parseFloat(this.valoresform.get(3)));
        R.setPropietario(this.valoresform.get(8));
        R.setProposito(this.valoresform.get(0).charAt(0));
        R.setRaza(this.valoresform.get(7));
        R.setSexo(this.valoresform.get(2).charAt(0));
        if (!this.valoresform.get(12).equals("")) {
            R.setUltimoParto(Date.valueOf(this.valoresform.get(12)));
        }
        request.getSession().setAttribute("datosRes", R);

        int state = 0;
        SQL = "SELECT G.* FROM Res as G WHERE G.codigo = ? AND G.nitfinca = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, R.getCodigo());
        PS.setLong(2, R.getNitFincaActual());

        if (AG.existeRes(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "INSERT INTO Res VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setLong(1, R.getCodigo());
            PS.setString(2, R.getProposito() + "");
            PS.setString(3, R.getSexo() + "");
            PS.setFloat(4, R.getPeso());
            PS.setInt(5, R.getEdad());
            PS.setString(6, R.getEtapaFisiologica());
            PS.setFloat(7, R.getCantLecheDiaria());
            PS.setFloat(8, R.getPorcGrasaLeche());
            PS.setString(9, R.getRaza());
            PS.setString(10, R.getPropietario());
            PS.setDate(11, R.getUltimoParto());
            PS.setFloat(12, R.getCantAlimentoDiario());
            PS.setLong(13, R.getNitFincaActual());

            PS.executeUpdate();

            SQL = "INSERT INTO cambiosres(codigores, codigofinca, fecha, peso,"
                    + " cantleche, edad, etapa) VALUES (?,?,?,?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setLong(1, R.getCodigo());
            PS.setLong(2, R.getNitFincaActual());
            java.util.Date hoy = new java.util.Date();
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            PS.setDate(3, Date.valueOf(formato.format(hoy)));
            PS.setFloat(4, R.getPeso());
            PS.setFloat(5, R.getCantLecheDiaria());
            PS.setInt(6, R.getEdad());
            PS.setString(7, R.getEtapaFisiologica());

            PS.executeUpdate();
        }

        return state;
    }

    public void eliminarRes(long codigo, long nit)
            throws SQLException {
        SQL = "DELETE FROM res as G WHERE G.codigo = ? AND G.nitfinca = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, codigo);
        PS.setLong(2, nit);

        PS.executeUpdate();
    }

    public int modificarRes(Usuario usuarioActual,
            HttpServletRequest request)
            throws SQLException {
        Res R = new Res();
        R.setCantAlimentoDiario(Float.parseFloat(this.valoresform.get(4)));
        R.setCodigo(Long.parseLong(this.valoresform.get(1)));
        R.setEdad(Integer.parseInt(this.valoresform.get(5)));
        R.setEtapaFisiologica(this.valoresform.get(6));
        R.setFincaActual(Long.parseLong(this.valoresform.get(9)),
                this.valoresform.get(9));
        if (!this.valoresform.get(10).equals("")
                && !this.valoresform.get(11).equals("")) {
            R.setLeche(Float.parseFloat(this.valoresform.get(10)),
                    Float.parseFloat(this.valoresform.get(11)));
        }
        R.setPeso(Float.parseFloat(this.valoresform.get(3)));
        R.setPropietario(this.valoresform.get(8));
        R.setProposito(this.valoresform.get(0).charAt(0));
        R.setRaza(this.valoresform.get(7));
        R.setSexo(this.valoresform.get(2).charAt(0));
        if (!this.valoresform.get(12).equals("")) {
            R.setUltimoParto(Date.valueOf(this.valoresform.get(12)));
        }
        request.getSession().setAttribute("datosRes", R);
        String viejocodigo = request.getSession().getAttribute("viejocodigo").toString();
        String viejonit = request.getSession().getAttribute("viejonit").toString();

        int state = 0;
        SQL = "SELECT G.* FROM Res as G WHERE G.codigo = ? AND G.nitfinca = ?"
                + "AND NOT (G.codigo = ? AND G.nitfinca = ?)";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, R.getCodigo());
        PS.setLong(2, R.getNitFincaActual());
        PS.setLong(3, Long.parseLong(viejocodigo));
        PS.setLong(4, Long.parseLong(viejonit));

        if (AG.existeRes(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "UPDATE Res SET codigo = ?, proposito = ?, sexo = ?, peso = ?,"
                    + " edad = ?, etapafisiologica = ?, cantleche = ?, porcgrasaleche = ?,"
                    + " raza = ?, propietario = ?, ultimoparto = ?, cantalimento = ?,"
                    + " nitfinca = ? WHERE codigo = ? AND nitfinca = ?";
            PS = conexion.prepareStatement(SQL);
            PS.setLong(1, R.getCodigo());
            PS.setString(2, R.getProposito() + "");
            PS.setString(3, R.getSexo() + "");
            PS.setFloat(4, R.getPeso());
            PS.setInt(5, R.getEdad());
            PS.setString(6, R.getEtapaFisiologica());
            PS.setFloat(7, R.getCantLecheDiaria());
            PS.setFloat(8, R.getPorcGrasaLeche());
            PS.setString(9, R.getRaza());
            PS.setString(10, R.getPropietario());
            PS.setDate(11, R.getUltimoParto());
            PS.setFloat(12, R.getCantAlimentoDiario());
            PS.setLong(13, R.getNitFincaActual());
            PS.setLong(14, Long.parseLong(viejocodigo));
            PS.setLong(15, Long.parseLong(viejonit));

            PS.executeUpdate();

            SQL = "INSERT INTO cambiosres(codigores, codigofinca, fecha, peso,"
                    + " cantleche, edad, etapa) VALUES (?,?,?,?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setLong(1, R.getCodigo());
            PS.setLong(2, R.getNitFincaActual());
            java.util.Date hoy = new java.util.Date();
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            PS.setDate(3, Date.valueOf(formato.format(hoy)));
            PS.setFloat(4, R.getPeso());
            PS.setFloat(5, R.getCantLecheDiaria());
            PS.setInt(6, R.getEdad());
            PS.setString(7, R.getEtapaFisiologica());

            PS.executeUpdate();
        }

        return state;
    }

    public Res buscarRes(long codigo, long nit) throws SQLException {
        Res R = null;
        SQL = "SELECT G.*,F.nombre FROM Finca as F, Res as G WHERE "
                + "G.nitfinca = F.nit AND G.codigo = ? AND G.nitfinca = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, codigo);
        PS.setLong(2, nit);

        R = AG.cargarRes(PS.executeQuery());

        return R;
    }

    public ArrayList<Registro> buscarRegistros(long codigo, long nit)
            throws SQLException {
        SQL = "SELECT R.* FROM cambiosres as R WHERE R.codigores = ? AND "
                + "R.codigofinca = ? ORDER BY 4";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, codigo);
        PS.setLong(2, nit);

        return (AG.cargarRegistros(PS.executeQuery()));
    }

    /* ADMINISTRACION DE INGREDIENTES */
    public ArrayList<Ingrediente> buscarIngredientes(Usuario usuarioActual)
            throws SQLException {
        SQL = "SELECT I.* FROM ingrediente as I, dispone as D WHERE "
                + "I.codigo = D.codingrediente AND D.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());

        return AI.cargarIngredientes(PS.executeQuery());
    }

    public int agregarIngrediente(Usuario usuarioActual,
            HttpServletRequest request) throws SQLException {
        Ingrediente I = new Ingrediente();
        I.setNombre(this.valoresform.get(0));
        I.setPrecio(Float.parseFloat(this.valoresform.get(1)));
        I.setProveedor(this.valoresform.get(2));
        I.setKCal(Float.parseFloat(this.valoresform.get(3)));
        I.setCalcio(Float.parseFloat(this.valoresform.get(4)));
        I.setFosforo(Float.parseFloat(this.valoresform.get(5)));
        I.setProteina(Float.parseFloat(this.valoresform.get(6)));
        I.setED(Float.parseFloat(this.valoresform.get(7)));
        I.setEM(Float.parseFloat(this.valoresform.get(8)));
        I.setENgan(Float.parseFloat(this.valoresform.get(9)));
        I.setENlact(Float.parseFloat(this.valoresform.get(10)));
        I.setENmant(Float.parseFloat(this.valoresform.get(11)));
        I.setNDT(Float.parseFloat(this.valoresform.get(12)));
        I.setVitaminaA(Float.parseFloat(this.valoresform.get(13)));
        I.setVitaminaD(Float.parseFloat(this.valoresform.get(14)));
        if (!this.valoresform.get(15).equals("")) {
            I.setExtEtereo(Float.parseFloat(this.valoresform.get(15)));
        }
        if (!this.valoresform.get(16).equals("")) {
            I.setCeniza(Float.parseFloat(this.valoresform.get(16)));
        }
        if (!this.valoresform.get(17).equals("")) {
            I.setFibra(Float.parseFloat(this.valoresform.get(17)));
        }
        if (!this.valoresform.get(18).equals("")) {
            I.setFDA(Float.parseFloat(this.valoresform.get(18)));
        }
        if (!this.valoresform.get(19).equals("")) {
            I.setFDS(Float.parseFloat(this.valoresform.get(19)));
        }
        if (!this.valoresform.get(20).equals("")) {
            I.setFDN(Float.parseFloat(this.valoresform.get(20)));
        }
        if (!this.valoresform.get(21).equals("")) {
            I.setHumedad(Float.parseFloat(this.valoresform.get(21)));
        }
        request.getSession().setAttribute("datosIngrediente", I);

        int state = 0;
        SQL = "SELECT I.* FROM Ingrediente as I, Dispone as D WHERE I.nombre = ?"
                + "AND I.codigo = D.codingrediente AND D.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, I.getNombre());
        PS.setString(2, usuarioActual.getUsuario());

        if (AI.existeIngrediente(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "INSERT INTO ingrediente(nombre, precio, proveedor, kcal, calcio,"
                    + "fosforo, proteina, ed, em, engan, enlact, enmant, ndt,"
                    + "vitaminaa, vitaminad, fibra, ceniza, extetereo, fda, fdn,"
                    + "fds, humedad) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, I.getNombre());
            PS.setFloat(2, I.getPrecio());
            PS.setString(3, I.getProveedor());
            PS.setFloat(4, I.getKCal());
            PS.setFloat(5, I.getCalcio());
            PS.setFloat(6, I.getFosforo());
            PS.setFloat(7, I.getProteina());
            PS.setFloat(8, I.getED());
            PS.setFloat(9, I.getEM());
            PS.setFloat(10, I.getENgan());
            PS.setFloat(11, I.getENlact());
            PS.setFloat(12, I.getENmant());
            PS.setFloat(13, I.getNDT());
            PS.setFloat(14, I.getVitaminaA());
            PS.setFloat(15, I.getVitaminaD());
            PS.setFloat(16, I.getFibra());
            PS.setFloat(17, I.getCeniza());
            PS.setFloat(18, I.getExtEtereo());
            PS.setFloat(19, I.getFDA());
            PS.setFloat(20, I.getFDN());
            PS.setFloat(21, I.getFDS());
            PS.setFloat(22, I.getHumedad());

            PS.executeUpdate();

            SQL = "INSERT INTO dispone VALUES (?,"
                    + "(SELECT last_value FROM ingrediente_codigo_seq))";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, usuarioActual.getUsuario());

            PS.executeUpdate();
        }

        return state;
    }

    public Ingrediente buscarIngrediente(long codigo) throws SQLException {
        SQL = "SELECT I.* FROM ingrediente as I WHERE I.codigo = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, codigo);

        return AI.cargarIngrediente(PS.executeQuery());
    }

    public void eliminarIngrediente(long codigo) throws SQLException {
        SQL = "DELETE FROM ingrediente WHERE codigo = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setLong(1, codigo);

        PS.executeUpdate();
    }

    public int modificarIngrediente(Usuario usuarioActual,
            HttpServletRequest request) throws SQLException {
        Ingrediente I = new Ingrediente();
        I.setNombre(this.valoresform.get(0));
        I.setPrecio(Float.parseFloat(this.valoresform.get(1)));
        I.setProveedor(this.valoresform.get(2));
        I.setKCal(Float.parseFloat(this.valoresform.get(3)));
        I.setCalcio(Float.parseFloat(this.valoresform.get(4)));
        I.setFosforo(Float.parseFloat(this.valoresform.get(5)));
        I.setProteina(Float.parseFloat(this.valoresform.get(6)));
        I.setED(Float.parseFloat(this.valoresform.get(7)));
        I.setEM(Float.parseFloat(this.valoresform.get(8)));
        I.setENgan(Float.parseFloat(this.valoresform.get(9)));
        I.setENlact(Float.parseFloat(this.valoresform.get(10)));
        I.setENmant(Float.parseFloat(this.valoresform.get(11)));
        I.setNDT(Float.parseFloat(this.valoresform.get(12)));
        I.setVitaminaA(Float.parseFloat(this.valoresform.get(13)));
        I.setVitaminaD(Float.parseFloat(this.valoresform.get(14)));
        if (!this.valoresform.get(15).equals("")) {
            I.setExtEtereo(Float.parseFloat(this.valoresform.get(15)));
        }
        if (!this.valoresform.get(16).equals("")) {
            I.setCeniza(Float.parseFloat(this.valoresform.get(16)));
        }
        if (!this.valoresform.get(17).equals("")) {
            I.setFibra(Float.parseFloat(this.valoresform.get(17)));
        }
        if (!this.valoresform.get(18).equals("")) {
            I.setFDA(Float.parseFloat(this.valoresform.get(18)));
        }
        if (!this.valoresform.get(19).equals("")) {
            I.setFDS(Float.parseFloat(this.valoresform.get(19)));
        }
        if (!this.valoresform.get(20).equals("")) {
            I.setFDN(Float.parseFloat(this.valoresform.get(20)));
        }
        if (!this.valoresform.get(21).equals("")) {
            I.setHumedad(Float.parseFloat(this.valoresform.get(21)));
        }
        request.getSession().setAttribute("datosIngrediente", I);

        Long id = (Long) request.getSession().getAttribute("viejoid");
        String viejoNombre = request.getSession().getAttribute("viejonombre").toString();

        int state = 0;
        SQL = "SELECT I.* FROM Ingrediente as I, Dispone as D WHERE I.nombre = ?"
                + "AND I.codigo = D.codingrediente AND D.usuario = ? AND NOT ("
                + "I.nombre = ?)";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, I.getNombre());
        PS.setString(2, usuarioActual.getUsuario());
        PS.setString(3, viejoNombre);

        if (AI.existeIngrediente(PS.executeQuery())) {
            state = 1;
        }

        if (state == 0) {
            SQL = "UPDATE ingrediente SET nombre = ?, precio = ?, proveedor = ?,"
                    + " kcal = ?, calcio = ?, fosforo = ?, proteina = ?, ed = ?, em = ?,"
                    + " engan = ?, enlact = ?, enmant = ?, ndt = ?, vitaminaa = ?,"
                    + " vitaminad = ?, fibra = ?, ceniza = ?, extetereo = ?, fda = ?,"
                    + " fdn = ?, fds = ?, humedad = ? WHERE codigo = ?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, I.getNombre());
            PS.setFloat(2, I.getPrecio());
            PS.setString(3, I.getProveedor());
            PS.setFloat(4, I.getKCal());
            PS.setFloat(5, I.getCalcio());
            PS.setFloat(6, I.getFosforo());
            PS.setFloat(7, I.getProteina());
            PS.setFloat(8, I.getED());
            PS.setFloat(9, I.getEM());
            PS.setFloat(10, I.getENgan());
            PS.setFloat(11, I.getENlact());
            PS.setFloat(12, I.getENmant());
            PS.setFloat(13, I.getNDT());
            PS.setFloat(14, I.getVitaminaA());
            PS.setFloat(15, I.getVitaminaD());
            PS.setFloat(16, I.getFibra());
            PS.setFloat(17, I.getCeniza());
            PS.setFloat(18, I.getExtEtereo());
            PS.setFloat(19, I.getFDA());
            PS.setFloat(20, I.getFDN());
            PS.setFloat(21, I.getFDS());
            PS.setFloat(22, I.getHumedad());
            PS.setFloat(23, id);

            PS.executeUpdate();
        }

        return state;
    }

    public ArrayList<Ingrediente> buscarIngredientes(Usuario usuarioActual,
            String parametro, String tipo) throws SQLException {
        SQL = "SELECT I.* FROM Ingrediente as I, Dispone as D WHERE "
                + "I.codigo = D.codingrediente AND D.usuario = ? AND I."
                + tipo + " = ?";

        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());
        if (tipo.equals("codigo")) {
            try {
                PS.setLong(2, Long.parseLong(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Ingrediente>();
            }
        } else {
            PS.setString(2, parametro);
        }

        return AI.cargarIngredientes(PS.executeQuery());
    }

    public Dieta elaborarDieta(HttpServletRequest request) throws SQLException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        Res res = (Res) request.getSession().getAttribute("resesc");
        ArrayList<Ingrediente> ingredientes =
                (ArrayList<Ingrediente>) request.getSession().getAttribute("escogidos");

        if (res.getProposito() == 'L') {
            SQL = "SELECT * FROM buscarnecesidadleche(?,?,?)";
        } else {
            SQL = "SELECT * FROM buscarnecesidadcarne(?,?,?)";
        }
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, res.getSexo() + "");
        PS.setString(2, res.getEtapaFisiologica());
        PS.setFloat(3, res.getPeso());

        Necesidades necesidades = AD.cargarNecesidades(PS.executeQuery(),
                res.getProposito());

        if (res.getProposito() == 'L' && res.getPorcGrasaLeche() > 0) {
            SQL = "SELECT * FROM tablagrasaleche WHERE grasaleche = ?";
            PS = conexion.prepareStatement(SQL);
            if (res.getPorcGrasaLeche() < 5) {
                PS.setFloat(1, (int) res.getPorcGrasaLeche());
            } else if (res.getPorcGrasaLeche() >= 5) {
                PS.setFloat(1, 5);
            }
            necesidades = AD.agregarNecesidadesGrasa(PS.executeQuery(), necesidades);
        }

        if (res.getProposito() == 'C') {
            Ingrediente I = new Ingrediente();
            I.setNombre("Forraje");
            I.setCodigo(1);
            ingredientes.add(I);
        }

        Dieta dieta = AD.elaborarDieta(usuario.getUsuario(), res, ingredientes, necesidades);

        if (dieta != null) {
            SQL = "INSERT INTO dieta(fecha, nitfinca, codigores, usuario) "
                    + "VALUES (?,?,?,?) RETURNING codigo";
            PS = conexion.prepareStatement(SQL);
            PS.setDate(1, dieta.getFecha());
            PS.setLong(2, dieta.getNitFinca());
            PS.setLong(3, dieta.getCodigoRes());
            PS.setString(4, dieta.getUsuario());

            ResultSet codigo = PS.executeQuery();
            if (codigo.next()) {
                dieta.setCodigo(codigo.getInt("codigo"));
            }

            for (int i = 0; i < dieta.getIngredientes().size(); i++) {
                SQL = "INSERT INTO contiene VALUES (?,?,?)";
                PS = conexion.prepareStatement(SQL);
                PS.setInt(1, dieta.getCodigo());
                PS.setInt(2, dieta.getIngredientes().get(i).getIngrediente().getCodigo());
                PS.setFloat(3, dieta.getIngredientes().get(i).getCantidad());

                PS.executeUpdate();
            }
        }

        return dieta;
    }

    public Dieta publicarDieta(Dieta dieta) throws SQLException {
        SQL = "INSERT INTO bancodietas VALUES (?)";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, dieta.getCodigo());
        PS.executeUpdate();
        dieta.setPublicada(true);
        return dieta;
    }

    public Dieta cargarDietaPublica(Dieta dieta) throws SQLException {
        dieta.reset();
        SQL = "SELECT * FROM comentario WHERE coddieta = ? ORDER BY fecha";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, dieta.getCodigo());
        dieta = AD.cargarComentarios(PS.executeQuery(), dieta);

        SQL = "SELECT * FROM valoracion WHERE coddieta = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, dieta.getCodigo());
        dieta = AD.cargarValoraciones(PS.executeQuery(), dieta);

        return dieta;
    }

    public Dieta agregarValoracion(Dieta dieta, Valoracion V)
            throws SQLException {
        if (V.getValor() > 0) {
            SQL = "INSERT INTO valoracion VALUES (?,?,?)";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, V.getUsuario());
            PS.setInt(2, dieta.getCodigo());
            PS.setInt(3, V.getValor());
            PS.executeUpdate();

            dieta.agregarValoracion(V);
        }
        return dieta;
    }

    public Dieta agregarComentario(Dieta dieta, Comentario C)
            throws SQLException {
        SQL = "INSERT INTO comentario VALUES (?,?,?,?)";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, C.getUsuario());
        PS.setInt(2, dieta.getCodigo());
        PS.setDate(3, C.getFecha());
        PS.setString(4, C.getComentario());
        PS.executeUpdate();

        dieta.agregarComentario(C);
        return dieta;
    }

    public ArrayList<Dieta> buscarDietas(Usuario usuarioActual)
            throws SQLException {
        SQL = "SELECT * FROM dieta as D LEFT JOIN bancodietas as B "
                + "ON D.codigo = B.coddieta WHERE D.usuario = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());

        return AD.cargarDietas(PS.executeQuery());
    }

    public void eliminarDieta(int codigo) throws SQLException {
        SQL = "DELETE FROM dieta WHERE codigo = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, codigo);
        PS.executeUpdate();
    }

    public Dieta buscarDieta(int codigo) throws SQLException {
        Dieta D = null;
        SQL = "SELECT * FROM dieta as D LEFT JOIN bancodietas as B "
                + "ON D.codigo = B.coddieta WHERE D.codigo = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, codigo);
        D = AD.cargarDieta(PS.executeQuery());

        SQL = "SELECT I.*,C.cantidad FROM contiene as C, ingrediente as I "
                + "WHERE C.coddieta = ? AND I.codigo = C.codingrediente";
        PS = conexion.prepareStatement(SQL);
        PS.setInt(1, codigo);
        D = AD.cargarIngredientes(PS.executeQuery(), D);

        return D;
    }

    public ArrayList<Dieta> buscarDieta(Usuario usuarioActual,
            String parametro, String tipo)
            throws SQLException {
        SQL = "SELECT * FROM dieta as D LEFT JOIN bancodietas as B "
                + "ON D.codigo = B.coddieta WHERE D.usuario = ? AND "
                + "D." + tipo + " = ?";
        PS = conexion.prepareStatement(SQL);
        PS.setString(1, usuarioActual.getUsuario());
        if (tipo.equals("codigo")) {
            try {
                PS.setInt(2, Integer.parseInt(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Dieta>();
            }
        } else if (tipo.equals("codigores")) {
            try {
                PS.setLong(2, Long.parseLong(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Dieta>();
            }
        } else {
            PS.setString(2, parametro);
        }

        return AD.cargarDietas(PS.executeQuery());
    }

    public ArrayList<Dieta> buscarBancoDietas() throws SQLException {
        SQL = "SELECT * FROM dieta as D, bancodietas as B "
                + "WHERE D.codigo = B.coddieta";
        PS = conexion.prepareStatement(SQL);

        return AD.cargarDietas(PS.executeQuery());
    }

    ArrayList<Dieta> buscarBancoDieta(String parametro, String tipo)
            throws SQLException {
        SQL = "SELECT * FROM dieta as D, bancodietas as B "
                + "WHERE D.codigo = B.coddieta AND "
                + "D." + tipo + " = ?";
        PS = conexion.prepareStatement(SQL);
        if (tipo.equals("codigo")) {
            try {
                PS.setInt(1, Integer.parseInt(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Dieta>();
            }
        } else if (tipo.equals("codigores")) {
            try {
                PS.setLong(1, Long.parseLong(parametro));
            } catch (NumberFormatException ex) {
                return new ArrayList<Dieta>();
            }
        } else if (tipo.equals("fecha")) {
            try {
                PS.setDate(1, Date.valueOf(parametro));
            } catch (IllegalArgumentException ex) {
                return new ArrayList<Dieta>();
            }
        } else {
            PS.setString(1, parametro);
        }

        return AD.cargarDietas(PS.executeQuery());
    }
    
    public ArrayList<Usuario> cargarUsuarios() throws SQLException{
        SQL = "SELECT * FROM usuario";
        PS = conexion.prepareStatement(SQL);
        return ADM.cargarUsuarios(PS.executeQuery());
    }
    
    /* tipobusqueda:
     * 1 -> por nombre de usuario
     * 2 -> por nombre
     * 3 -> por apellido
     */
    public ArrayList<Usuario> buscarUsuario(String param, int tipobusqueda, ArrayList<Usuario> usuarios) throws SQLException{
        if(tipobusqueda==1){
            SQL = "SELECT * FROM usuario where usuario=?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, param);
        }
        if(tipobusqueda==2){
            SQL = "SELECT * FROM usuario where nombre=?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, param);
        }
        if(tipobusqueda==3){
            SQL = "SELECT * FROM usuario where apellidos=?";
            PS = conexion.prepareStatement(SQL);
            PS.setString(1, param);
        }
        return ADM.buscarUsuario(PS.executeQuery(),usuarios);
    }
}
