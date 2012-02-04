/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Objetos.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrador
 */
public class Servlet extends HttpServlet {

    BDControlador DriverBD = new BDControlador();
    Usuario usuarioActual;

    @Override
    public void init() {
        String ruta = getServletContext().getRealPath("index.jsp");
        ruta = ruta.substring(0, ruta.lastIndexOf("\\"));
        DriverBD.RUTA = ruta + "\\uploads";
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String out = request.getRequestURI();
        out = out.substring(out.lastIndexOf("/") + 1);

        try {
            if (out.equals("iniciosesion.do")) {
                iniciarSesion(request, response);
            }
            if (out.equals("registrar.do")) {
                registrarUsuario(request, response);
            }
            if (out.equals("recuperar.do")) {
                recuperarPasswd(request, response);
            }
            if (out.equals("cerrarsesion.do")) {
                cerrarSesion(request, response);
            }
            if (out.equals("eliminarperfil.do")) {
                eliminarPerfil(request, response);
            }
            if (out.equals("modificarperfil.do")) {
                modificarPerfil(request, response);
            }
            if (out.equals("cambiarCuenta.do")) {
                cambiarCuenta(request, response);
            }
            if (out.equals("listarfincas.do")) {
                listarFincas(request, response);
            }
            if (out.equals("agregarfinca.do")) {
                agregarFinca(request, response);
            }
            if (out.equals("buscarfinca.do")) {
                buscarFinca(request, response);
            }
            if (out.equals("detallesfinca.do")) {
                verFinca(request, response);
            }
            if (out.equals("modificarfinca.do")) {
                modificarFinca(request, response);
            }
            if (out.equals("eliminarfinca.do")) {
                eliminarFinca(request, response);
            }
            if (out.equals("listarreses.do")) {
                listarReses(request, response);
            }
            if (out.equals("nuevares.do")) {
                nuevaRes(request, response);
            }
            if (out.equals("agregarres.do")) {
                agregarRes(request, response);
            }
            if (out.equals("eliminarres.do")) {
                eliminarRes(request, response);
            }
            if (out.equals("buscarres.do")) {
                buscarRes(request, response);
            }
            if (out.equals("modificares.do")) {
                cargarRes(request, response);
            }
            if (out.equals("modificarres.do")) {
                modificarRes(request, response);
            }
            if (out.equals("detallesres.do")) {
                verRes(request, response);
            }
            if (out.equals("listaringredientes.do")) {
                listarIngredientes(request, response);
            }
            if (out.equals("agregaringrediente.do")) {
                agregarIngrediente(request, response);
            }
            if (out.equals("detallesingrediente.do")) {
                verIngrediente(request, response);
            }
            if (out.equals("eliminaringrediente.do")) {
                eliminarIngrediente(request, response);
            }
            if (out.equals("modificaringrediente.do")) {
                modificarIngrediente(request, response);
            }
            if (out.equals("buscaringrediente.do")) {
                buscarIngrediente(request, response);
            }
            if (out.equals("generardieta.do")) {
                generarDieta(request, response, 0);
            }
            if (out.equals("escogerfinca.do")) {
                generarDieta(request, response, 1);
            }
            if (out.equals("escogerres.do")) {
                generarDieta(request, response, 2);
            }
            if (out.equals("escogeringrediente.do")) {
                generarDieta(request, response, 3);
            }
            if (out.equals("quitaringrediente.do")) {
                generarDieta(request, response, 4);
            }
            if (out.equals("calculardieta.do")) {
                calcularDieta(request, response);
            }
            if (out.equals("publicardieta.do")) {
                publicarDieta(request, response);
            }
            if (out.equals("agregarvaloracion.do")) {
                agregarValoracion(request, response);
            }
            if (out.equals("agregarcomentario.do")) {
                agregarComentario(request, response);
            }
            if (out.equals("eliminardieta.do")) {
                eliminarDieta(request, response);
            }
            if (out.equals("listardietas.do")) {
                listarDietas(request, response);
            }
            if (out.equals("verdieta.do")) {
                verDieta(request, response);
            }
            if (out.equals("buscardieta.do")) {
                buscarDieta(request, response);
            }
            if (out.equals("cargarbanco.do")) {
                cargarBanco(request, response);
            }
            if (out.equals("buscarbanco.do")) {
                buscarBancoDieta(request, response);
            }
            if (out.equals("listarusuarios.do")) {
                this.listarUsuarios(request, response);
            }
            if (out.equals("buscarusuario.do")) {
                this.buscarUsuario(request, response);
            }
            if (out.equals("eliminarusuario.do")) {
                this.eliminarUsuario(request, response);
            }
            if (out.equals("agregarusuario.do")) {
                this.agregarUsuario(request, response);
            }
            if (out.equals("modificarusuario.do")) {
                this.modificarUsuario(request, response);
            }
            if (out.equals("cargarnecesidadescarne.do")) {
                this.cargarNecesidadesCarne(request, response);
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void iniciarSesion(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("passwd");
        usuarioActual = DriverBD.buscarUsuario(user, pass);

        request.getSession(true).setAttribute("usuario", usuarioActual);
        if (usuarioActual != null) {
            if (usuarioActual.getRol() == 'v'
                    || usuarioActual.getRol() == 'V') {
                response.sendRedirect("panelvet.jsp");
            } else if (usuarioActual.getRol() == 'a'
                    || usuarioActual.getRol() == 'A') {
                response.sendRedirect("paneladm.jsp");
            }
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
    }

    private void registrarUsuario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        DriverBD.subirImagen(request);
        response.sendRedirect("registro.jsp?aviso="
                + DriverBD.registrarUsuario(request));
    }

    private void recuperarPasswd(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, SQLException {
        if (request.getParameter("nrodoc") != null) {
            String tipodoc = request.getParameter("tipodoc");
            long nrodoc = Long.parseLong(request.getParameter("nrodoc"));

            String[] preg = DriverBD.buscarPregunta(tipodoc, nrodoc);
            if (preg != null) {
                request.getSession(true).setAttribute("pregunta", preg);
                request.getSession().setAttribute("tipodoc", tipodoc);
                request.getSession().setAttribute("nrodoc", nrodoc);
                response.sendRedirect("olvidoclave.jsp?etapa=1");
            } else {
                response.sendRedirect("olvidoclave.jsp?error=1");
            }
        } else if (request.getParameter("respuesta") != null) {
            String resp = request.getParameter("respuesta");
            String[] preg = (String[]) request.getSession().getAttribute("pregunta");

            if (preg[1].equalsIgnoreCase(resp)) {
                request.removeAttribute("pregunta");
                response.sendRedirect("olvidoclave.jsp?etapa=2");
            } else {
                response.sendRedirect("olvidoclave.jsp?etapa=1&error=2");
            }
        } else if (request.getParameter("user") != null) {
            String user = request.getParameter("user");
            String pass1 = request.getParameter("passwd");
            String pass2 = request.getParameter("passwd2");
            String tipodoc = request.getSession().getAttribute("tipodoc").toString();
            int nrodoc = Integer.parseInt(
                    request.getSession().getAttribute("nrodoc").toString());

            if (pass1.equals(pass2)) {
                DriverBD.cambiarConstraseña(tipodoc, nrodoc, user, pass2);
                request.getSession().removeAttribute("tipodoc");
                request.getSession().removeAttribute("nrodoc");
                String msg = "Constrase&ntilde;a cambiada.";
                response.sendRedirect("index.jsp?onload=onload="
                        + "'alert(\"" + msg + "\")'");
            } else {
                response.sendRedirect("olvidoclave.jsp?etapa=2&error=3");
            }
        }
    }

    private void cerrarSesion(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {
        request.getSession().removeAttribute("usuario");
        usuarioActual = null;
        String msg = "Hasta pronto.";
        response.sendRedirect("index.jsp?onload=onload='alert(\"" + msg + "\")'");
    }

    private void eliminarPerfil(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.eliminarUsuario(usuarioActual);
        usuarioActual = null;
        String msg = "Su cuenta se ha eliminado exitosamente.";
        response.sendRedirect("index.jsp?onload=onload='alert(\"" + msg + "\")'");
    }

    private void modificarPerfil(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        int state = DriverBD.modificarUsuario(request, usuarioActual);
        if (state == 0) {
            response.sendRedirect("perfil.jsp");
        } else {
            response.sendRedirect("modificarperfil.jsp?aviso=1");
        }
    }

    private void cambiarCuenta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String oldPass = request.getParameter("oldpass");
        String newPass = request.getParameter("newpass");
        String newPass2 = request.getParameter("newpass2");
        String preg = request.getParameter("newpreg");
        String resp = request.getParameter("newresp");
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");

        int aviso = -1;
        if (oldPass != null) {
            usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
            if (usuarioActual.getPassword().equals(oldPass)) {
                if ((newPass.equals(newPass2))) {
                    DriverBD.cambiarConstraseña(usuarioActual.getTipoDoc(),
                            usuarioActual.getNroDoc(),
                            usuarioActual.getUsuario(),
                            newPass);
                    usuarioActual.setPassword(newPass);
                    aviso = 0;
                } else {
                    aviso = 2;
                }
            } else {
                aviso = 3;
            }
        } else {
            DriverBD.cambiarPregunta(usuarioActual.getUsuario(), preg, resp);
            usuarioActual.setPregunta(preg, resp);
            aviso = 1;
        }
        response.sendRedirect("modificarcuenta.jsp?aviso=" + aviso);
    }

    /* Metodos de Fincas */
    private void listarFincas(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
        request.getSession().setAttribute("fincas", fincas);
        response.sendRedirect("listafincas.jsp");
    }

    private void agregarFinca(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, SQLException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        response.sendRedirect("agregafinca.jsp?aviso="
                + DriverBD.agregarFinca(usuarioActual, request));
    }

    private void eliminarFinca(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        // Se elimina la finca:
        long nit = Long.parseLong(request.getParameter("id"));
        DriverBD.eliminarFinca(nit);

        // Se vuelve a cargar la lista
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
        request.getSession().setAttribute("fincas", fincas);
        response.sendRedirect("listafincas.jsp?del=1");
    }

    private void buscarFinca(HttpServletRequest request,
            HttpServletResponse response) throws SQLException, IOException {
        String parametro = request.getParameter("parametrobusqueda");
        String tipo = request.getParameter("tipobusqueda");

        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual,
                parametro, tipo);
        request.getSession().setAttribute("resultadoFincas", fincas);
        response.sendRedirect("buscafinca.jsp");
    }

    private void verFinca(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        long nit = Long.parseLong(request.getParameter("id"));
        Finca F = DriverBD.buscarFinca(nit);
        ArrayList<Res> ganado = DriverBD.buscarReses(F);
        request.getSession().setAttribute("detallesF", F);
        request.getSession().setAttribute("ganadoF", ganado);
        response.sendRedirect("finca.jsp");
    }

    private void modificarFinca(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, SQLException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        int aviso = DriverBD.modificarFinca(usuarioActual, request);
        if (aviso == 0) {
            listarFincas(request, response);
        } else {
            String id = request.getSession().getAttribute("viejonit").toString();
            response.sendRedirect("modificarfinca.jsp?id=" + id + "&aviso=" + aviso);
        }
    }

    /* Metodos de Reses */
    private void listarReses(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Res> reses = DriverBD.buscarReses(usuarioActual);
        request.getSession().setAttribute("reses", reses);
        response.sendRedirect("listareses.jsp");
    }

    private void nuevaRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
        request.getSession().setAttribute("fincas", fincas);
        response.sendRedirect("agregares.jsp");
    }

    private void agregarRes(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, SQLException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        response.sendRedirect("agregares.jsp?aviso="
                + DriverBD.agregarRes(usuarioActual, request));
    }

    private void eliminarRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        // Se elimina la finca:
        long codigo = Long.parseLong(request.getParameter("id"));
        long nit = Long.parseLong(request.getParameter("idf"));
        DriverBD.eliminarRes(codigo, nit);

        // Se vuelve a cargar la lista
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Res> reses = DriverBD.buscarReses(usuarioActual);
        request.getSession().setAttribute("reses", reses);
        response.sendRedirect("listareses.jsp?del=1");
    }

    private void buscarRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String parametro = request.getParameter("parametrobusqueda");
        String tipo = request.getParameter("tipobusqueda");

        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Res> reses = DriverBD.buscarReses(usuarioActual,
                parametro, tipo);
        request.getSession().setAttribute("resultadoRes", reses);
        response.sendRedirect("buscares.jsp");
    }

    private void modificarRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        int aviso = DriverBD.modificarRes(usuarioActual, request);
        if (aviso == 0) {
            listarReses(request, response);
        } else {
            String id = request.getSession().getAttribute("viejocodigo").toString();
            String idf = request.getSession().getAttribute("viejonit").toString();
            response.sendRedirect("modificarres.jsp?id=" + id + "&idf=" + idf
                    + "&aviso=" + aviso);
        }
    }

    private void cargarRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
        long codigo = Long.parseLong(request.getParameter("id"));
        long nit = Long.parseLong(request.getParameter("idf"));
        Res R = DriverBD.buscarRes(codigo, nit);
        request.getSession().setAttribute("fincas", fincas);
        request.getSession().setAttribute("res", R);
        response.sendRedirect("modificares.jsp");
    }

    private void verRes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        long codigo = Long.parseLong(request.getParameter("id"));
        long nit = Long.parseLong(request.getParameter("idf"));
        Res R = DriverBD.buscarRes(codigo, nit);
        ArrayList<Registro> registros = DriverBD.buscarRegistros(codigo, nit);
        request.getSession().setAttribute("detallesR", R);
        request.getSession().setAttribute("registrosR", registros);
        response.sendRedirect("res.jsp");
    }

    /* Metodos de Ingredientes */
    private void listarIngredientes(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Ingrediente> ingredientes = DriverBD.buscarIngredientes(usuarioActual);
        request.getSession().setAttribute("ingredientes", ingredientes);
        response.sendRedirect("listaingredientes.jsp");
    }

    private void agregarIngrediente(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, SQLException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        response.sendRedirect("agregaingrediente.jsp?aviso="
                + DriverBD.agregarIngrediente(usuarioActual, request));
    }

    private void verIngrediente(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        long codigo = Long.parseLong(request.getParameter("id"));
        Ingrediente I = DriverBD.buscarIngrediente(codigo);
        request.getSession().setAttribute("detallesI", I);
        response.sendRedirect("ingrediente.jsp");
    }

    private void eliminarIngrediente(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        long codigo = Long.parseLong(request.getParameter("id"));
        DriverBD.eliminarIngrediente(codigo);

        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Ingrediente> ingredientes = DriverBD.buscarIngredientes(usuarioActual);
        request.getSession().setAttribute("ingredientes", ingredientes);
        response.sendRedirect("listaingredientes.jsp?del=1");
    }

    private void modificarIngrediente(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        DriverBD.subirImagen(request);
        int aviso = DriverBD.modificarIngrediente(usuarioActual, request);
        if (aviso == 0) {
            listarIngredientes(request, response);
        } else {
            String id = request.getSession().getAttribute("viejoid").toString();
            response.sendRedirect("modificarfinca.jsp?id=" + id + "&aviso=" + aviso);
        }
    }

    private void buscarIngrediente(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String parametro = request.getParameter("parametrobusqueda");
        String tipo = request.getParameter("tipobusqueda");

        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Ingrediente> ingredientes = DriverBD.buscarIngredientes(usuarioActual,
                parametro, tipo);
        request.getSession().setAttribute("resultadoIngredientes", ingredientes);
        response.sendRedirect("buscaingrediente.jsp");
    }

    private void generarDieta(HttpServletRequest request,
            HttpServletResponse response, int etapa)
            throws SQLException, IOException {
        if (etapa > 0) {
            usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
            ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
            request.getSession().setAttribute("fincas", fincas);
            if (etapa == 1) {
                long nit = Long.parseLong(request.getParameter("finca"));
                Finca F = DriverBD.buscarFinca(nit);
                request.getSession().setAttribute("fincaesc", F);
                ArrayList<Res> reses = DriverBD.buscarReses(F);
                request.getSession().setAttribute("reses", reses);
            }
            if (etapa == 2) {
                long codigo = Long.parseLong(request.getParameter("res"));
                Finca F = (Finca) request.getSession().getAttribute("fincaesc");
                Res R = DriverBD.buscarRes(codigo, F.getNit());
                request.getSession().setAttribute("resesc", R);
                ArrayList<Ingrediente> ingredientes = DriverBD.buscarIngredientes(usuarioActual);
                request.getSession().setAttribute("ingredientes", ingredientes);
            }
            if (etapa == 3) {
                long codigo = Long.parseLong(request.getParameter("ingrediente"));
                ArrayList<Ingrediente> ingredientes = (ArrayList<Ingrediente>) request.getSession().getAttribute("ingredientes");
                Ingrediente I = DriverBD.buscarIngrediente(codigo);
                for (int i = 0; i < ingredientes.size(); i++) {
                    if (ingredientes.get(i).getCodigo() == codigo) {
                        ingredientes.remove(i);
                    }
                }
                request.getSession().setAttribute("ingredientes", ingredientes);
                ArrayList<Ingrediente> escogidos = new ArrayList<Ingrediente>();
                if (request.getSession().getAttribute("escogidos") != null) {
                    escogidos = (ArrayList<Ingrediente>) request.getSession().getAttribute("escogidos");
                }
                escogidos.add(I);
                request.getSession().setAttribute("escogidos", escogidos);
            }
            if (etapa == 4) {
                long codigo = Long.parseLong(request.getParameter("id"));
                ArrayList<Ingrediente> escogidos = (ArrayList<Ingrediente>) request.getSession().getAttribute("escogidos");
                Ingrediente I = DriverBD.buscarIngrediente(codigo);
                for (int i = 0; i < escogidos.size(); i++) {
                    if (escogidos.get(i).getCodigo() == codigo) {
                        escogidos.remove(i);
                    }
                }
                request.getSession().setAttribute("escogidos", escogidos);
                ArrayList<Ingrediente> ingredientes = (ArrayList<Ingrediente>) request.getSession().getAttribute("ingredientes");
                ingredientes.add(I);
                request.getSession().setAttribute("ingredientes", ingredientes);
            }
        } else {
            usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
            ArrayList<Finca> fincas = DriverBD.buscarFincas(usuarioActual);
            request.getSession().setAttribute("fincas", fincas);

            request.getSession().removeAttribute("escogidos");
            request.getSession().removeAttribute("ingredientes");
            request.getSession().removeAttribute("resesc");
            request.getSession().removeAttribute("reses");
            request.getSession().removeAttribute("fincaesc");
        }
        response.sendRedirect("generadordietas.jsp");
    }

    private void mostrarDieta(HttpServletRequest request,
            HttpServletResponse response, Dieta dieta)
            throws SQLException, IOException {
        // datos de la dieta:
        if (dieta.getPublicada()) {
            dieta = DriverBD.cargarDietaPublica(dieta);
        }
        request.getSession().setAttribute("dieta", dieta);

        // datos de la Res:
        Res R = DriverBD.buscarRes(dieta.getCodigoRes(),
                dieta.getNitFinca());
        request.getSession().setAttribute("resaplicada", R);

        // Registro de cambios de la Res:
        ArrayList<Registro> Reg = DriverBD.buscarRegistros(R.getCodigo(),
                R.getNitFincaActual());
        Registro registro = null;
        for (int i = 0; i < Reg.size(); i++) {
            if (Reg.get(i).getFecha().after(dieta.getFecha())
                    || Reg.get(i).getFecha().equals(dieta.getFecha())) {
                registro = Reg.get(i);
            }
        }
        request.getSession().setAttribute("registros", registro);
        response.sendRedirect("dieta.jsp");
    }

    private void calcularDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        Dieta dieta = DriverBD.elaborarDieta(request);
        if (dieta != null) {
            mostrarDieta(request, response, dieta);
        } else {
            response.sendRedirect("generadordietas.jsp?error=1");
        }
    }

    private void publicarDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        Dieta dieta = (Dieta) request.getSession().getAttribute("dieta");
        dieta = DriverBD.publicarDieta(dieta);
        mostrarDieta(request, response, dieta);
    }

    private void agregarValoracion(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        Dieta dieta = (Dieta) request.getSession().getAttribute("dieta");
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        int val = Integer.parseInt(request.getParameter("valoracion"));
        Valoracion V = new Valoracion(usuarioActual.getUsuario(), val);
        dieta = DriverBD.agregarValoracion(dieta, V);
        mostrarDieta(request, response, dieta);
    }

    private void agregarComentario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        Dieta dieta = (Dieta) request.getSession().getAttribute("dieta");
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        String comentario = request.getParameter("comentario");

        java.util.Date date = new java.util.Date();
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        String hoy = formato.format(date);

        Comentario C = new Comentario(usuarioActual.getUsuario(),
                Date.valueOf(hoy), comentario);
        dieta = DriverBD.agregarComentario(dieta, C);
        mostrarDieta(request, response, dieta);
    }

    private void listarDietas(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Dieta> dietas = DriverBD.buscarDietas(usuarioActual);
        for (int i = 0; i < dietas.size(); i++) {
            if (dietas.get(i).getPublicada()) {
                dietas.set(i, DriverBD.cargarDietaPublica(dietas.get(i)));
            }
        }
        request.getSession().setAttribute("misdietas", dietas);
        response.sendRedirect("listadietas.jsp");
    }

    private void eliminarDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        int codigo = Integer.parseInt(request.getParameter("id"));
        DriverBD.eliminarDieta(codigo);
        listarDietas(request, response);
    }

    private void verDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        int codigo = Integer.parseInt(request.getParameter("id"));
        Dieta dieta = DriverBD.buscarDieta(codigo);
        if (dieta != null) {
            mostrarDieta(request, response, dieta);
        } else {
            response.sendRedirect("panelvet.jsp");
        }
    }

    private void buscarDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String parametro = request.getParameter("parametrobusqueda");
        String tipo = request.getParameter("tipobusqueda");

        usuarioActual = (Usuario) request.getSession().getAttribute("usuario");
        ArrayList<Dieta> dietas = DriverBD.buscarDieta(usuarioActual,
                parametro, tipo);
        for (int i = 0; i < dietas.size(); i++) {
            if (dietas.get(i).getPublicada()) {
                dietas.set(i, DriverBD.cargarDietaPublica(dietas.get(i)));
            }
        }
        request.getSession().setAttribute("resultadoDietas", dietas);
        response.sendRedirect("buscadieta.jsp");
    }

    private void cargarBanco(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        ArrayList<Dieta> dietas = DriverBD.buscarBancoDietas();
        for (int i = 0; i < dietas.size(); i++) {
            if (dietas.get(i).getPublicada()) {
                dietas.set(i, DriverBD.cargarDietaPublica(dietas.get(i)));
            }
        }
        request.getSession(true).setAttribute("bancodietas", dietas);
        response.sendRedirect("bancodietas.jsp");
    }

    private void buscarBancoDieta(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
        String parametro = request.getParameter("parametrobusqueda");
        String tipo = request.getParameter("tipobusqueda");

        ArrayList<Dieta> dietas = DriverBD.buscarBancoDieta(parametro, tipo);
        for (int i = 0; i < dietas.size(); i++) {
            if (dietas.get(i).getPublicada()) {
                dietas.set(i, DriverBD.cargarDietaPublica(dietas.get(i)));
            }
        }
        request.getSession(true).setAttribute("resultadosBanco", dietas);
        response.sendRedirect("bancodietas.jsp");
    }
    
    /* metodos Administrador */
     private void listarUsuarios(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
         ArrayList<Usuario> usuarios = DriverBD.cargarUsuarios();
         request.getSession().setAttribute("users", usuarios);
         response.sendRedirect("adminusuarios.jsp");
     }
     
      private void buscarUsuario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
          String param = request.getParameter("busq_param");
           ArrayList<Usuario> u = new ArrayList<Usuario>();
           u = DriverBD.buscarUsuario(param, 1,u);
           u = DriverBD.buscarUsuario(param, 2,u);
           u = DriverBD.buscarUsuario(param, 3,u);
          
          if(u!=null){
             request.getSession().setAttribute("userbuscado", u); 
          }
          response.sendRedirect("buscarusuario.jsp");
      }
      
      private void eliminarUsuario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
          String param = request.getParameter("elim_user");
          DriverBD.eliminarUsuario(param);
          response.sendRedirect("listarusuarios.do");
      }
      
       private void agregarUsuario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
           DriverBD.agregarUsuario(request);
           response.sendRedirect("listarusuarios.do");
           
       }
       
       private void modificarUsuario(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException {
           int action = Integer.parseInt(request.getParameter("action"));
           if(action==1){
               Usuario u = DriverBD.buscarUsuario(request.getParameter("username"));
               request.getSession().setAttribute("user_mod", u);
               response.sendRedirect("modificarusuario.jsp");
           }
           if(action==2){
              DriverBD.modificarUsuario(request);
              response.sendRedirect("listarusuarios.do");    
           }
           
       }
       
       private void cargarNecesidadesCarne(HttpServletRequest request,
            HttpServletResponse response)
            throws SQLException, IOException { 
           ArrayList<TablasNutricionalesCarne> tablas = DriverBD.cargarNecesidadesCarne(request);
           request.getSession().setAttribute("tablas", tablas);
           response.sendRedirect("admintablascarne.jsp"); 
       }
}
