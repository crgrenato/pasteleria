<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "true" %>

<%
HttpSession sesion = request.getSession();
sesion.setAttribute("numarticulos", 0);
sesion.setAttribute("total", 0.0);
sesion.setAttribute("cesto", null);
response.sendRedirect("index.jsp");
%>