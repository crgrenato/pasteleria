<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CarritoBD" %>

<%
    String idCliente = request.getParameter("idCliente");
    CarritoBD carritoBD = new CarritoBD();
    boolean eliminado = carritoBD.eliminarClienteYRegistros(idCliente);
    // Si se elimina correctamente, establece un atributo en la solicitud para mostrar el mensaje en verClientes.jsp
    if (eliminado) {
        request.setAttribute("eliminacionExitosa", true);
    }
    // Redirige de vuelta a la página verClientes.jsp
    response.sendRedirect("verClientes.jsp");
%>
