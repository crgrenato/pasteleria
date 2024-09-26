<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>

<%
    // Obtener los parámetros del formulario
    String idCliente = request.getParameter("idCliente");
    String apellidos = request.getParameter("apellidos");
    String nombres = request.getParameter("nombres");
    String direccion = request.getParameter("direccion");
    String fechaNacimiento = request.getParameter("fechaNacimiento");
    String sexo = request.getParameter("sexo");
    String correo = request.getParameter("correo");
    String tipoUsuario = request.getParameter("tipoUsuario");

    // Crear un objeto Cliente con los nuevos datos
    Clientes clienteEditado = new Clientes();
    clienteEditado.setIdCliente(idCliente);
    clienteEditado.setApellidos(apellidos);
    clienteEditado.setNombres(nombres);
    clienteEditado.setDireccion(direccion);
    clienteEditado.setFechaNacimiento(fechaNacimiento);
    clienteEditado.setSexo(sexo.charAt(0));
    clienteEditado.setCorreo(correo);
    clienteEditado.setTipoUsuario(tipoUsuario);

    // Actualizar el cliente en la base de datos
    CarritoBD carritoBD = new CarritoBD();
    boolean exito = carritoBD.ActualizarCliente(clienteEditado);

    // Redirigir de regreso a la página de verClientes.jsp con un mensaje de éxito o error
    if (exito) {
        response.sendRedirect("verClientes.jsp?edicionExitosa=true");
    } else {
        response.sendRedirect("verClientes.jsp?edicionExitosa=false");
    }
%>
