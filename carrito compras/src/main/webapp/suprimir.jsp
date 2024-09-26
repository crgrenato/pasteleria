<%@page import="modelo.carrito"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page session="true" %>
   <%@ page import= "modelo.carrito" %>
   
   
   
   <%
   String IdPro = request.getParameter("id");
   HttpSession sesion = request.getSession();
   ArrayList<carrito> Lista = new ArrayList<carrito>();
   Lista = (ArrayList<carrito>)sesion.getAttribute("cesto");
  
   if(Lista != null){
	   for(int i = 0; i<Lista.size(); i++){
		   if(Lista.get(i).getIdProducto().equalsIgnoreCase(IdPro)){
			   Lista.remove(i);
			   break;
		   }
	   }
	   
   }
   sesion.setAttribute("cesto", Lista);
   
   response.sendRedirect("carrito.jsp?txtid=&txtcan=0");
   %>
