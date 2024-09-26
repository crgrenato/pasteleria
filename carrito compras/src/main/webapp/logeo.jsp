<%@page import="modelo.Productos"%>
<%@page import="modelo.carrito"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Finalizar compra</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<style>
		/* Estilos para el cuerpo de la página */
		body {
			background-color: #fce4ec; /* Color rosa suave */
			font-family: Arial, sans-serif; /* Fuente */
			padding-top: 20px; /* Espaciado superior */
		}

		.pastel-table {
			border-radius: 20px;
			overflow: hidden;
			box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
			margin: 20px auto;
		}

		.pastel-table th, .pastel-table td {
			border-width: 5px;
			border-style: solid;
			padding: 10px;
			text-align: center;
		}

		.pastel-table thead {
			background-color: #343a40;
			color: white;
		}

		.pastel-table tfoot {
			background-color: #ffc107;
		}

		.pastel-table tbody tr:nth-child(even) {
			background-color: #f8bbd0;
		}

		.pastel-table tbody tr:nth-child(odd) {
			background-color: #f48fb1;
		}

		/* Estilo para el botón de confirmar compra */
		.confirm-btn {
			background-color: #dc3545; /* Color del botón de confirmar compra */
			border-color: #dc3545; /* Color del borde del botón de confirmar compra */
		}

		.title {
            text-align: center;
            font-size: 48px; /* Tamaño de fuente */
            color: #dc3545; /* Color rojo */
            font-weight: bold; /* Negrita */
            text-transform: uppercase; /* Mayúsculas */
            letter-spacing: 2px; /* Espaciado entre letras */
            margin-bottom: 20px; /* Espaciado inferior */
        }
	</style> 
</head>
<body>

<%
String idCliente = (String) session.getAttribute("idCliente");
CarritoBD ObjBD = new CarritoBD();
Clientes ObjP = new Clientes();
ObjP = ObjBD.InfoCliente(idCliente);

%>

<h1 class="title" text align="center">FINALIZAR COMPRA</h1>
	<%
        try {
            // Enlaces del carrito
            String enlace1 = "<a href=confcompra.jsp?username="+idCliente+" class=\"btn btn-danger confirm-btn\">Confirmar compra</a>";            
            // Variable de la clase BD

            
            // Recuperando los valores del formulario
            String IdPro = "";
            int Cant = 0;
            // Variable para acceder a la sesion del proyecto web
            HttpSession MiSesion = request.getSession();
            // Declarar un ArrayList de tipo carrito
            ArrayList<carrito> Lista = null;
            // Recuperando los elementos almacenados en la sesion
            Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");

            // Actualizar el valor de la sesion
            if (Cant != 0) MiSesion.setAttribute("cesto", Lista);
            // Construir la factura
            String tabla = "<table class='table table-bordered rounded shadow pastel-table'>";
            tabla += "<thead>";
            tabla += "<tr>";
            tabla += "<th>Item</th>";
            tabla += "<th>IdProducto</th>";
            tabla += "<th>Descripcion</th>";
            tabla += "<th>Imagen</th>";
            tabla += "<th>Precio</th>";
            tabla += "<th>Cantidad</th>";
            tabla += "<th>Sub-Total</th>";
            tabla += "</tr>";
            tabla += "</thead>";
            tabla += "<tbody>";
            double Total = 0;
            int i;
            // Recorrer todos los productos de Lista
            for (i = 0; i < Lista.size(); i++) {
                Productos Obj = new Productos();
                // Recuperar la informacion de cada producto del cesto
                Obj = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
                double Precio = Obj.getPrecioUnidad();
                int Cantidad = Lista.get(i).getCantidad();
                double SubTotal = Precio * Cantidad;
                Total += SubTotal;
                tabla += "<tr>";
                tabla += "<td>" + (i + 1) + "</td>";
                tabla += "<td>" + Obj.getIdProducto() + "</td>";
                tabla += "<td>" + Obj.getDescripcion() + "</td>";
                tabla += "<td><img src=img/" + Obj.getImagen() + " width=50 heigth=50></td>";
                tabla += "<td>" + Precio + "</td>";
                tabla += "<td>" + Cantidad + "</td>";
                tabla += "<td>" + SubTotal + "</td>";
                tabla += "</tr>";
            }
            tabla += "</tbody>";
            
            tabla += "<tfoot>";
            tabla += "<tr>";
            tabla += "<th colspan=6>TOTAL GENERAL</th>";
            tabla += "<th>" + Total + "</th>";
            tabla += "</tr>";
            tabla += "<tr>";
            tabla += "<td colspan=7 align=center>"+ enlace1 + "</td>";
            tabla += "</tr>";
            tabla += "</tfoot>";           
            tabla += "</table>";
            out.print(tabla);
        } finally {
            out.close();
        }
        %>
	
</body>
</html>
